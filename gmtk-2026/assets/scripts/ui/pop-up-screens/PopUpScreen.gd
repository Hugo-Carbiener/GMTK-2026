@abstract class_name PopUpScreen extends Control

@export var launch_signal : String;

func _ready() -> void:
	visible = false;
	if SignalBus and SignalBus.has_signal(launch_signal):
		SignalBus.connect(launch_signal, launch);

@abstract func launch();
