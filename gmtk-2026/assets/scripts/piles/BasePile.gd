@abstract class_name BasePile extends TextureButton

var number_tiles : Array[NumberTile];
var operator_tiles : Array[OperatorTile]; 
var number_tile_amounts : Dictionary[int, int];
var operator_tile_amounts : Dictionary[TileFactory.OperatorTileType, int];

func draw_number_tile() -> NumberTile:
	var drawn_number_tile = number_tiles[randi() % number_tiles.size()];
	var drawn_tile_key = drawn_number_tile.get_number();
	if number_tile_amounts.get(drawn_tile_key) > 1:
		number_tile_amounts.set(drawn_tile_key, number_tile_amounts.get(drawn_tile_key) - 1);
	else: 
		number_tile_amounts.erase(drawn_tile_key);
	number_tiles.erase(drawn_number_tile);
	return drawn_number_tile

func draw_operator_tile() -> OperatorTile:
	var drawn_operator_tile = operator_tiles[randi() % operator_tiles.size()];
	var drawn_tile_key = drawn_operator_tile.operator_type;
	if operator_tile_amounts.get(drawn_tile_key) > 1:
		operator_tile_amounts.set(drawn_tile_key, operator_tile_amounts.get(drawn_tile_key) - 1);
	else: 
		operator_tile_amounts.erase(drawn_tile_key);
	operator_tiles.erase(drawn_operator_tile);
	return drawn_operator_tile

func add_number_tile(number_tile : NumberTile):
	var number_tile_key = number_tile.get_number();
	number_tiles.append(number_tile);
	if number_tile_amounts.has(number_tile_key):
		number_tile_amounts.set(number_tile_key, number_tile_amounts.get(number_tile_key) + 1);
	else:
		number_tile_amounts.set(number_tile_key, 1);

func add_operator_tile(operator_tile : OperatorTile):
	var operator_tile_key = operator_tile.operator_type;
	operator_tiles.append(operator_tile);
	if operator_tile_amounts.has(operator_tile_key):
		operator_tile_amounts.set(operator_tile_key, operator_tile_amounts.get(operator_tile_key) + 1);
	else:
		operator_tile_amounts.set(operator_tile_key, 1);
