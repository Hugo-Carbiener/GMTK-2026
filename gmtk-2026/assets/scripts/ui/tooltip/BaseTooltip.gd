class_name BaseTooltip extends Control

static var base_tooltip_scene : PackedScene = preload("res://assets/scenes/ui/base-tooltip.tscn");

@export var label : Label;
@export var fade_in_duration : float = 0.2;

static func create_base_tooltip(content : String) -> BaseTooltip:
	var tooltip = base_tooltip_scene.instantiate();
	tooltip.setup(content);
	return tooltip;

func setup(content : String):
	label.text = content;

func _ready() -> void:
	self.modulate.a = 0;
	AnimationUtils.fade(self, 1, fade_in_duration);
