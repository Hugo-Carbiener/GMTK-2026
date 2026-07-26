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
	var tween = get_tree().create_tween();
	tween.tween_callback(animate_gain_container.bind(Constants.BASE_MONEY_REWARD, base_gain_container));
	tween.tween_interval(Constants.DEFAULT_TRANSITION_DURATION);
	tween.tween_callback(animate_gain_container.bind(GameLoop.get_turn_remaining_gain(), turn_remaining_container));
	tween.tween_interval(Constants.DEFAULT_TRANSITION_DURATION);
	tween.tween_callback(animate_gain_container.bind(GameLoop.get_bounty_gains(), bounty_container));
	tween.tween_interval(Constants.DEFAULT_TRANSITION_DURATION);
	tween.tween_callback(animate_gain_container.bind(GameLoop.compute_gains(), total_container));
	tween.tween_interval(Constants.DEFAULT_TRANSITION_DURATION);

func animate_gain_container(amount : int, container : Control):
	if amount == 0:
		await AnimationUtils.add_child_fade_in(container, no_reward_scene.instantiate(), Constants.SHORT_TRANSITION_DURATION * 2);
	else:
		for i in range(amount):
			await AnimationUtils.add_child_fade_in(container, shell_scene.instantiate(), Constants.SHORT_TRANSITION_DURATION * 2);
	

func open_confirmation_modal():
	next_level_pop_up.modulate.a = 0;
	next_level_pop_up.visible = true;
	AnimationUtils.fade(next_level_pop_up, 1., Constants.SHORT_TRANSITION_DURATION);
