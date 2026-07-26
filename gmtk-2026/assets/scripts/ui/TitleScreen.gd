class_name TitleScreen extends Control

@export var start_game_button : TextureButton;
@export var quit_button : TextureButton;

func _ready() -> void:
	start_game_button.button_up.connect(start_game);
	quit_button.button_up.connect(quit);

func start_game():
	SceneManager.start_encounter();

func quit():
	get_tree().quit();
