class_name HoverableElement extends Control

func _ready() -> void:
	pivot_offset = size/2;
	mouse_entered.connect(on_mouse_enter);
	mouse_exited.connect(on_mouse_exit);

func on_mouse_enter():
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", Constants.DEFAULT_GROW_FACTOR * Vector2.ONE, Constants.SHORT_TRANSITION_DURATION);

func on_mouse_exit():
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", Vector2.ONE, Constants.SHORT_TRANSITION_DURATION);
