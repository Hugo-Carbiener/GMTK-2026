class_name HoverableElement extends Control

var grow_factor : float;
var is_hover_blocked = false;

func _ready() -> void:
	grow_factor = Constants.DEFAULT_GROW_FACTOR;
	pivot_offset = size/2;
	mouse_entered.connect(on_mouse_enter);
	mouse_exited.connect(on_mouse_exit);

func on_mouse_enter():
	if is_hover_blocked: return;
	
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", grow_factor * Vector2.ONE, Constants.SHORT_TRANSITION_DURATION);

func on_mouse_exit():
	if is_hover_blocked: return;
	
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", Vector2.ONE, Constants.SHORT_TRANSITION_DURATION);
