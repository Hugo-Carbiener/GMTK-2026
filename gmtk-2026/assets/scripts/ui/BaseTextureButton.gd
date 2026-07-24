class_name BaseTextureButton extends TextureButton

@export var text_margin : MarginContainer;
@export var top_margin_default : int;
@export var top_margin_pressed : int;
@export var signal_on_button_pressed : String;

func _ready() -> void:
	button_down.connect(on_pressed);
	button_up.connect(on_released);

func on_pressed():
	text_margin.add_theme_constant_override("margin_top", top_margin_pressed);
	if SignalBus and SignalBus.has_signal(signal_on_button_pressed):
		SignalBus.emit_signal(signal_on_button_pressed);

func on_released():
	text_margin.add_theme_constant_override("margin_top", top_margin_default);
