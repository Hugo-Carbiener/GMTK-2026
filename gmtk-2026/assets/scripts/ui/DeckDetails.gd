class_name DeckDetails extends Control

@export_group("Components")
@export var card_container : Control;
@export var operator_container : Control;
@export var number_container : Control;

func open():
	for card_model in UserData.card_deck:
		var card = CardController.Create(card_model);
		card_container.add_child(card);
	for operator_type in UserData.operator_deck:
		var operator_tile = OperatorTile.create_tile(TileFactory.operator_tile_models_by_types.get(operator_type));
		operator_tile.status = TileFactory.TileStatus.NOT_SELECTABLE;
		operator_container.add_child(operator_tile);
		operator_tile.position = Vector2i(randi() % int((operator_container.size.x - operator_tile.size.x)), randi() % int((operator_container.size.y - operator_tile.size.y)));
	for number in UserData.number_deck:
		var number_tile = NumberTile.create_tile(number);
		number_tile.status = TileFactory.TileStatus.NOT_SELECTABLE;
		number_container.add_child(number_tile);
		number_tile.position = Vector2i(randi() % int((number_container.size.x - number_tile.size.x)), randi() % int((number_container.size.y - number_tile.size.y)));
	visible = true;

func close():
	visible = false;
	for child in card_container.get_children():
		child.queue_free();
	for child in operator_container.get_children():
		child.queue_free();
	for child in number_container.get_children():
		child.queue_free();

func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_released():
		close();
