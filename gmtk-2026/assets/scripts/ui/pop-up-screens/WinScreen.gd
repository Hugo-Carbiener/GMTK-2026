class_name WinScreen extends PopUpScreen

const shell_scene : PackedScene = preload("res://assets/scenes/ui/shell.tscn");
const no_reward_scene : PackedScene = preload("res://assets/scenes/ui/no-reward.tscn");

@export var title : Label;
@export var stats_container : Control;
@export var next_level_pop_up : Control;
@export var next_level_button : BaseTextureButton;
@export_group("Gains containers")
@export var base_gain_container : Control;
@export var turn_remaining_container : Control;
@export var bounty_container : Control;
@export var total_container : Control;

func _ready() -> void:
	next_level_button.button_up.connect(open_confirmation_modal);
	super();

func launch():
	next_level_pop_up.visible = false;
	modulate.a = 0;
	title.modulate.a = 0;
	visible = true;
	AnimationUtils.fade(self, 1., Constants.DEFAULT_TRANSITION_DURATION);
	await AnimationUtils.fade(title, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION);
	var stats = StatsContainer.create_stats();
	stats_container.add_child(stats);
	stats.fade_in();
	await gain_animation();

func gain_animation():
	for i in range(Constants.BASE_MONEY_REWARD):
		await AnimationUtils.add_child_fade_in(base_gain_container, shell_scene.instantiate(), Constants.DEFAULT_TRANSITION_DURATION);

	var turn_remaining_gains = GameLoop.get_turn_remaining_gain();
	if turn_remaining_gains == 0:
		await AnimationUtils.add_child_fade_in(turn_remaining_container, no_reward_scene.instantiate(), Constants.DEFAULT_TRANSITION_DURATION);
	else:
		for i in range(turn_remaining_gains):
			await AnimationUtils.add_child_fade_in(turn_remaining_container, shell_scene.instantiate(), Constants.DEFAULT_TRANSITION_DURATION);
	
	var bounty_gains = GameLoop.get_bounty_gains();
	if bounty_gains == 0:
		await AnimationUtils.add_child_fade_in(bounty_container, no_reward_scene.instantiate(), Constants.DEFAULT_TRANSITION_DURATION);
	else:
		for i in range(bounty_gains):
			await AnimationUtils.add_child_fade_in(bounty_container, shell_scene.instantiate(), Constants.DEFAULT_TRANSITION_DURATION);

	for i in range(GameLoop.compute_gains()):
		await AnimationUtils.add_child_fade_in(total_container, shell_scene.instantiate(), Constants.DEFAULT_TRANSITION_DURATION);

func open_confirmation_modal():
	next_level_pop_up.modulate.a = 0;
	next_level_pop_up.visible = true;
	AnimationUtils.fade(next_level_pop_up, 1., Constants.SHORT_TRANSITION_DURATION);
