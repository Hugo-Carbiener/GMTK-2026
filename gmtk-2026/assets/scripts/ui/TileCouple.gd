class_name TileCouple extends Control

const tile_couple_scene : PackedScene = preload("res://assets/scenes/components/tile-couple.tscn");

@export var operator_slot_container : Control;
@export var number_slot_container : Control;
var operator : OperatorTile;
var number : NumberTile;

static func create_tile_couple() -> TileCouple:
	var tile_couple = tile_couple_scene.instantiate();
	return tile_couple;

func add_operator(tile : OperatorTile):
	tile.reparent(operator_slot_container, false);
	operator = tile;

func add_number(tile : NumberTile):
	tile.reparent(number_slot_container, false);
	number = tile;

func remove_operator():
	operator = null;

func remove_number():
	number = null;

func has_operator() -> bool:
	return operator != null;

func has_specific_operator(tile : OperatorTile):
	return operator == tile;

func has_number() -> bool:
	return number != null;

func has_specific_number(tile : NumberTile):
	return number == tile;

func is_filled() -> bool:
	return has_number() and has_operator();

func is_empty() -> bool:
	return !has_number() and !has_operator();
