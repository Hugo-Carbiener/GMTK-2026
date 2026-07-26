class_name DeckDetails extends Control

const scene : PackedScene = preload("res://assets/scenes/ui/deck_detail_screen.tscn");

@export_group("Components")
@export var card_container : Control;
@export var operator_container : Control;
@export var number_container : Control;

static func create() -> DeckDetails:
	var this = scene.instantiate();
	this.setup();
	return this;

func setup():
	for card_model in UserData.card_deck:
		var card = CardController.Create(card_model);
		card_container.add_child(card);
	for operator_type in UserData.operator_deck:
		var operator_tile = OperatorTile.create_tile(TileFactory.operator_tile_models_by_types.get(operator_type));
		operator_tile.status = TileFactory.TileStatus.NOT_SELECTABLE;
		operator_container.add_child(operator_tile);
	for number in UserData.number_deck:
		var number_tile = NumberTile.create_tile(number);
		number_tile.status = TileFactory.TileStatus.NOT_SELECTABLE;
		number_container.add_child(number_tile);
	visible = true;

func close():
	queue_free();

func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_released():
		close();
