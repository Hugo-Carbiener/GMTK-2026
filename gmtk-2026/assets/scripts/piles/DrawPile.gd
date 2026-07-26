class_name DrawPile extends BasePile

static var instance : DrawPile;

@export var UI_parent : Control;

func _ready() -> void:
	if instance == null:
		instance = self;
	pivot_offset = size / 2;
	button_up.connect(on_click);

func init():
	populate_deck();

func populate_deck():
	for number in UserData.number_deck:
		var number_tile = NumberTile.create_tile(number);
		add_number_tile(number_tile);
	for operator_type in UserData.operator_deck:
		var operator_tile = OperatorTile.create_tile(TileFactory.operator_tile_models_by_types.get(operator_type));
		add_operator_tile(operator_tile);

func draw_number_tile() -> NumberTile:
	if number_tiles.size() == 0:
		refill_number_tiles();
	return super();

func draw_operator_tile() -> OperatorTile:
	if operator_tiles.size() == 0:
		refill_operator_tiles();
	return super();

func refill_number_tiles():
	number_tiles = DiscardPile.instance.number_tiles.duplicate();
	number_tile_amounts = DiscardPile.instance.number_tile_amounts.duplicate();
	DiscardPile.instance.number_tiles.clear();
	DiscardPile.instance.number_tile_amounts.clear();

func refill_operator_tiles():
	operator_tiles = DiscardPile.instance.operator_tiles.duplicate();
	operator_tile_amounts = DiscardPile.instance.operator_tile_amounts.duplicate();
	DiscardPile.instance.operator_tiles.clear();
	DiscardPile.instance.operator_tile_amounts.clear();

func on_click():
	var deck_details = DeckDetails.create();
	UI_parent.add_child(deck_details);
