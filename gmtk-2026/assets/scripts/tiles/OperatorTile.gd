class_name OperatorTile extends Tile

const operator_tile_scene : PackedScene = preload("res://assets/scenes/components/operator-tile.tscn");

var operator_type : TileFactory.OperatorTileType;

static func create_tile(tile_model : OperatorTileModel) -> OperatorTile:
	var operator_tile = operator_tile_scene.instantiate();
	operator_tile.setup(tile_model);
	return operator_tile;

func setup(tile_model : OperatorTileModel):
	self.type = TileFactory.TileType.NUMBER;
	self.operator_type = tile_model.operator_type;
	self.value = tile_model.text;
	self.label.text = tile_model.text;

func execute(number_tile : NumberTile, current_count : int) -> int:
	match(operator_type):
		TileFactory.OperatorTileType.PLUS:
			return current_count + number_tile.get_number();
		TileFactory.OperatorTileType.MINUS:
			return current_count - number_tile.get_number();
		TileFactory.OperatorTileType.MULT:
				return current_count * number_tile.get_number();
		TileFactory.OperatorTileType.DIV:
			return round(current_count / float(number_tile.get_number())) if number_tile.get_number() > 0 else 1;
		_:
			printerr("Invalid operator type on tile: " + str(operator_type));
			return 0;

func on_click():
	if status == TileFactory.TileStatus.NOT_SELECTED:
		SignalBus.operator_tile_selected.emit(self);
	else:
		SignalBus.operator_tile_unselected.emit(self);
