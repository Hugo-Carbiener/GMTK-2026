@abstract class_name Tile extends Control

var type : TileFactory.TileType;
var value : String;
var status : TileFactory.TileStatus = TileFactory.TileStatus.NOT_SELECTED;

@export_group("Components")
@export var label : Label;
@export var button : Button;

func _ready() -> void:
	pivot_offset = size/2;
	mouse_entered.connect(on_mouse_enter);
	mouse_exited.connect(on_mouse_exit);
	button.button_up.connect(on_click);

@abstract func on_click();
@abstract func consume();

func on_mouse_enter():
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", Constants.DEFAULT_GROW_FACTOR * Vector2.ONE, Constants.SHORT_TRANSITION_DURATION);

func on_mouse_exit():
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", Vector2.ONE, Constants.SHORT_TRANSITION_DURATION);

func on_selection():
	status = TileFactory.TileStatus.SELECTED;

func on_unselection():
	status = TileFactory.TileStatus.NOT_SELECTED;

func on_consumption():
	status = TileFactory.TileStatus.NOT_SELECTED;
	await AnimationUtils.animate_scale(self, scale, Vector2i.ZERO, Constants.DEFAULT_TRANSITION_DURATION);

func on_selection_fail():
	AnimationUtils.hshake(self, 50, Constants.SHORT_TRANSITION_DURATION);
