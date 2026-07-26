class_name NumberTile extends Tile

const number_tile_scene : PackedScene = preload("res://assets/scenes/components/number-tile.tscn");

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

func consume():
	DiscardPile.instance.add_number_tile(self);
	await on_consumption();

func on_click():
	if status == TileFactory.TileStatus.NOT_SELECTED:
		SignalBus.number_tile_selected.emit(self);
	elif status == TileFactory.TileStatus.SELECTED:
		SignalBus.number_tile_unselected.emit(self);
	elif status == TileFactory.TileStatus.NOT_SELECTABLE:
		return;

func UpdateTile(newValue:int)->void:
	#TODO : add visual effect for update (shimer ?)
	self.number = newValue;
	self.value = str(newValue);
	self.label.text = str(newValue);
	return;
