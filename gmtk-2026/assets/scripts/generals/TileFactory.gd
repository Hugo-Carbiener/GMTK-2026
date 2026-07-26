extends Node2D

var operator_tile_models_by_types : Dictionary[OperatorTileType, OperatorTileModel];
var bundle_tile_models : Array[OperatorTileModel];
var paid_tile_models : Array[OperatorTileModel];

enum TileStatus {
	SELECTED,
	NOT_SELECTED,
	NOT_SELECTABLE
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
	load_operator_tile_models_by_types();
	generate_decks();

func load_operator_tile_models_by_types():
	var path = "res://assets/resources/tile-models/operator-tile-models";
	var dir = DirAccess.open(path)

	if !dir:
		printerr("Could not find directory " + path);
		return;

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if not dir.current_is_dir():
			# Remove .remap or .import suffixes if present in exported builds
			var clean_name = file_name.trim_suffix(".remap").trim_suffix(".import")
			var file_path = path.path_join(clean_name)

			if ResourceLoader.exists(file_path):
				var res = load(file_path)
				# Check if the resource matches or inherits from target_type
				if res and res is OperatorTileModel:
					operator_tile_models_by_types.set(res.operator_type, res);

		file_name = dir.get_next()

func generate_decks():
	generate_number_deck(get_base_number_repartition());
	generate_operator_deck();
	generate_shop_lists();

func get_base_number_repartition() -> Dictionary[int, int]:
	var dict : Dictionary[int, int];
	for i in range(Constants.MIN_NUMBER_TILE, Constants.MAX_NUMBER_TILE + 1):
		for y in range(Constants.MIN_NUMBER_TILE, Constants.MAX_NUMBER_TILE + 1):
			var number = int(round((i + y) /2.));
			if dict.has(number):
				dict.set(number, dict.get(number) + 1);
			else:
				dict.set(number, 1);
	for key in dict:
		dict.set(key, round(dict.get(key) / 4));
	return dict;

func generate_number_deck(tile_repartition : Dictionary[int, int]):
	for number in tile_repartition:
		for i in range(tile_repartition.get(number)):
			UserData.number_deck.append(number);

func generate_operator_deck():
	if operator_tile_models_by_types.is_empty():
		printerr("Empty operator tile model in tile factory");
		return;
	for operator_tile_model in operator_tile_models_by_types.values():
		if operator_tile_model == null: continue;
		if !operator_tile_model.is_in_base_deck: continue;
		
		for i in range(operator_tile_model.amount_in_base_deck):
			UserData.operator_deck.append(operator_tile_model.operator_type);

func generate_shop_lists():
	for tile_model in operator_tile_models_by_types.values():
		if tile_model.is_in_bundle:
			bundle_tile_models.append(tile_model);
		else:
			paid_tile_models.append(tile_model);

func get_random_operator_tile() -> OperatorTile:
	return OperatorTile.create_tile(operator_tile_models_by_types.get(randi() % operator_tile_models_by_types.size()));

func get_random_paid_operator_tile():
	return OperatorTile.create_tile(paid_tile_models.get(randi() % paid_tile_models.size()));

func get_random_bundle_operator_tile():
	return OperatorTile.create_tile(bundle_tile_models.get(randi() % bundle_tile_models.size()));

func get_random_number_tile() -> NumberTile:
	return NumberTile.create_tile(randi_range(Constants.MIN_NUMBER_TILE, Constants.MAX_NUMBER_TILE));
