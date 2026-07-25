class_name Shop extends Control

@export_group("Components")
@export var tile_shop_number_tile_container : Control;
@export var tile_shop_operator_tile_container : Control;
@export var tile_bundle_operator_tile_container : Control;
@export var card_reward_container : Control;
@export var reroll_button : BaseTextureButton;
@export var next_level_button : BaseTextureButton;

var reroll_amount : int = 0;
var number_tiles : Array[NumberTile];
var operator_tiles : Array[OperatorTile];
var card_rewards : Array[CardController];

func _ready() -> void:
	init_buttons();
	await populate_shop();

func init_buttons():
	reroll_button.button_up.connect(reroll);
	next_level_button.button_up.connect(SceneManager.start_encounter);

func populate_shop():
	await generate_number_tile_shop();
	await generate_operator_tile_shop();
	generate_card_rewards();
	SignalBus.on_money_update.emit(UserData.currency);

func generate_number_tile_shop():
	for i in range(Constants.DEFAULT_TILE_AMOUNT_IN_SHOP):
		var number_tile = TileFactory.get_random_number_tile();
		var buyable_tile = BuyableElement.create_buyable_element(Constants.NUMBER_TILE_BASE_PRICE, number_tile);
		number_tiles.append(number_tile);
		tile_shop_number_tile_container.add_child(buyable_tile);

func generate_operator_tile_shop():
	for i in range(Constants.DEFAULT_TILE_AMOUNT_IN_SHOP):
		var operator_tile = TileFactory.get_random_paid_operator_tile();
		var buyable_tile = BuyableElement.create_buyable_element(operator_tile.model.price, operator_tile);
		operator_tiles.append(operator_tile);
		tile_shop_operator_tile_container.add_child(buyable_tile);

func generate_card_rewards():
	for i in range(Constants.DEFAULT_CARD_AMOUNT_IN_SHOP):
		var card_reward = CardFactory.generate_random_card();
		card_reward_container.add_child(card_reward);
		card_rewards.append(card_reward);

func reroll():
	reroll_amount +=1;
	reset_shop();
	populate_shop();

func reset_shop():
	for child in tile_shop_number_tile_container.get_children():
		child.queue_free();
	for child in tile_shop_operator_tile_container.get_children():
		child.queue_free();
	for child in card_reward_container.get_children():
		child.queue_free();
	number_tiles.clear();
	operator_tiles.clear();
	card_rewards.clear();
