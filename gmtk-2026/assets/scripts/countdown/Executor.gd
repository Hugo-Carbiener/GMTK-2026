class_name Executor extends Control

static var instance : Executor;

var tile_couples : Array[TileCouple];

func _ready() -> void:
	if instance == null:
		instance = self;
	init_signals();

func init_signals():
	SignalBus.operator_tile_selected.connect(add_operator_tile);
	SignalBus.number_tile_selected.connect(add_number_tile);
	SignalBus.operator_tile_unselected.connect(remove_operator_tile);
	SignalBus.number_tile_unselected.connect(remove_number_tile);

func init():
	for i in range(Constants.DEFAULT_TILE_COUPLE_SLOTS):
		var tile_couple = TileCouple.create_tile_couple();
		tile_couples.append(tile_couple);
		add_child(tile_couple);

func add_operator_tile(tile : OperatorTile):
	for tile_couple in tile_couples:
		if !tile_couple.has_operator(): 
			tile_couple.add_operator(tile);
			tile.on_selection();
			return;
	
	tile.on_selection_fail();

func remove_operator_tile(tile : OperatorTile):
	for tile_couple in tile_couples:
		if tile_couple.has_specific_operator(tile):
			tile_couple.remove_operator();
			tile.on_unselection();
			clear_empty_tile_couple();
			return;
	
	printerr("Tried to remove non existant selected operator tile.");

func add_number_tile(tile : NumberTile):
	for tile_couple in tile_couples:
		if !tile_couple.has_number(): 
			tile_couple.add_number(tile);
			tile.on_selection();
			return;
	
	tile.on_selection_fail();

func remove_number_tile(tile : NumberTile):
	for tile_couple in tile_couples:
		if tile_couple.has_specific_number(tile):
			tile_couple.remove_number();
			tile.on_unselection();
			clear_empty_tile_couple();
			return;
	
	printerr("Tried to remove non existant selected number tile.");

# Goes through tile couples to find empty ones. If they are non empty couples in lower slots, non empty couples bubble to the top 
func clear_empty_tile_couple():
	var empty_tile_couple_indexes : Array[int];
	var store_empty_couples = false;
	for i in range(tile_couples.size() - 1, -1, -1):
		var tile_couple = tile_couples[i];
		if !tile_couple.is_empty():
			store_empty_couples = true;
		if store_empty_couples and tile_couple.is_empty():
			empty_tile_couple_indexes.append(i);
	
	if empty_tile_couple_indexes.size() == tile_couples.size() or empty_tile_couple_indexes.size() == 0:
		return;
	
	for tile_couple_index in empty_tile_couple_indexes:
		var empty_tile_couple = tile_couples.pop_at(tile_couple_index);
		tile_couples.append(empty_tile_couple);
		move_child(empty_tile_couple, get_child_count() - 1);

func execute():
	for tile_couple in tile_couples:
		if tile_couple.is_empty(): return;
		
		await tile_couple.execute();
