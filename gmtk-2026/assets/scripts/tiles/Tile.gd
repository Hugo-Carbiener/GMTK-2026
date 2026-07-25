@abstract class_name Tile extends HoverableElement

var type : TileFactory.TileType;
var value : String;
var status : TileFactory.TileStatus = TileFactory.TileStatus.NOT_SELECTED;

@export_group("Components")
@export var label : Label;
@export var button : Button;

func _ready() -> void:
	super();
	button.button_up.connect(on_click);

@abstract func on_click();
@abstract func consume();

func on_selection():
	status = TileFactory.TileStatus.SELECTED;

func on_unselection():
	status = TileFactory.TileStatus.NOT_SELECTED;

func on_consumption():
	status = TileFactory.TileStatus.NOT_SELECTED;
	await AnimationUtils.animate_scale(self, scale, Vector2i.ZERO, Constants.DEFAULT_TRANSITION_DURATION);

func on_selection_fail():
	AnimationUtils.hshake(self, 50, Constants.SHORT_TRANSITION_DURATION);
