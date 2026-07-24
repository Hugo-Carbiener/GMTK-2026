class_name HandManager extends Control

static var instance : HandManager;

var number_tiles : Array[NumberTile];
var operator_tiles : Array[OperatorTile];

@export var number_tiles_container : Control;
@export var operator_tiles_container : Control;

func _ready() -> void:
	if instance == null:
		instance = self;
	init_signals();

func init_signals():
	SignalBus.operator_tile_unselected.connect(on_operator_tile_unselected);
	SignalBus.number_tile_unselected.connect(on_number_tile_unselected);

func on_turn_start():
	for i in range(Constants.DEFAULT_TILE_DRAWN):
		var drawn_tile = DrawPile.instance.draw_number_tile();
		number_tiles.append(drawn_tile);
		number_tiles_container.add_child(drawn_tile);
	for i in range(Constants.DEFAULT_TILE_DRAWN):
		var drawn_tile = DrawPile.instance.draw_operator_tile();
		operator_tiles.append(drawn_tile);
		operator_tiles_container.add_child(drawn_tile);

func discard_hands():
	for operator_tile in operator_tiles:
		DiscardPile.instance.add_operator_tile(operator_tile);
	operator_tiles.clear();
	for number_tile in number_tiles:
		DiscardPile.instance.add_number_tile(number_tile);
	number_tiles.clear();
	for number_tile in number_tiles_container.get_children():
		number_tiles_container.remove_child(number_tile);
	for operator_tile in operator_tiles_container.get_children():
		operator_tiles_container.remove_child(operator_tile);

func on_number_tile_unselected(tile : NumberTile):
	tile.reparent(number_tiles_container);

func on_operator_tile_unselected(tile : OperatorTile):
	tile.reparent(operator_tiles_container);
