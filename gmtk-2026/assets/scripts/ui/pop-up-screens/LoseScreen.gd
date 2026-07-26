class_name LoseScreen extends PopUpScreen

@export var title : Label;
@export var stats_container : Control;
@export var menu_button : BaseTextureButton;

func _ready() -> void:
	super();
	menu_button.button_up.connect(restart);

func launch():
	modulate.a = 0;
	title.modulate.a = 0;
	visible = true;
	AnimationUtils.fade(self, 1., Constants.DEFAULT_TRANSITION_DURATION);
	await AnimationUtils.fade(title, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION);
	var stats = StatsContainer.create_stats();
	stats_container.add_child(stats);
	stats.fade_in();

func restart():
	SceneManager.menu();
