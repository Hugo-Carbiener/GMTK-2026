class_name NumberTile extends Tile

const number_tile_scene : PackedScene = preload("res://assets/scenes/components/operator-tile.tscn");

var number : int;

func get_number() -> int:
	return number;

static func create_tile(tile_number : int) -> NumberTile:
	var number_tile = number_tile_scene.instantiate();
	number_tile.setup(tile_number);
	return number_tile;

func setup(tile_number : int):
	self.type = TileFactory.TileType.NUMBER;
	self.number = tile_number;
	self.value = str(tile_number);
	self.label.text = str(tile_number);
