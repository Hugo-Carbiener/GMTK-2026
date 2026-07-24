class_name TileFactory extends Node2D

@export var operator_tile_models : Array[OperatorTileModel];

static var instance : TileFactory;

# The real collection of tiles of the player. This is to be put in the draw pile at the start of a level.
var number_deck : Array[NumberTile];
var operator_deck : Array[OperatorTile];

enum TileStatus {
	SELECTED,
	NOT_SELECTED
}

enum TileType {
	OPERATOR,
	NUMBER
}

enum OperatorTileType {
	PLUS,
	MINUS,
	MULT,
	DIV
}

var operatorTileTypeToChar = {
	OperatorTileType.PLUS : "+",
	OperatorTileType.MINUS : "-",
	OperatorTileType.MULT : "*",
	OperatorTileType.DIV : "/",
}

func _ready() -> void:
	if instance == null:
		instance = self;

func init():
	generate_decks();

func generate_decks():
	generate_number_deck();
	generate_operator_deck();

func generate_number_deck():
	for tile_number in range(Constants.MIN_NUMBER_TILE, Constants.MAX_NUMBER_TILE + 1):
		var number_tile = NumberTile.create_tile(tile_number);
		number_deck.append(number_tile);

func generate_operator_deck():
	if operator_tile_models.is_empty():
		printerr("Empty operator tile model in tile factory");
		return;
	for operator_tile_model in operator_tile_models:
		if operator_tile_model == null: continue;
		if !operator_tile_model.is_in_base_deck: continue;
		
		for i in range(operator_tile_model.amount_in_base_deck):
			var operator_tile = OperatorTile.create_tile(operator_tile_model);
			operator_deck.append(operator_tile);
