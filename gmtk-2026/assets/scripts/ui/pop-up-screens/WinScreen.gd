class_name WinScreen extends PopUpScreen

@export var title : Label;
@export var stats_container : Control;
@export var next_level_pop_up : Control;
@export var next_level_button : BaseTextureButton;

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

func open_confirmation_modal():
	next_level_pop_up.modulate.a = 0;
	next_level_pop_up.visible = true;
	AnimationUtils.fade(next_level_pop_up, 1., Constants.SHORT_TRANSITION_DURATION);
