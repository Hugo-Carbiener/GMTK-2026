class_name ConfirmationPopUp extends Control

@export var cancel_button : BaseTextureButton;

func _ready() -> void:
	cancel_button.button_up.connect(func(): visible = false);
