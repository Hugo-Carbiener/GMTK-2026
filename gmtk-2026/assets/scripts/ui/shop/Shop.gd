class_name Shop extends Control

@export_group("Components")
@export var tile_shop_number_tile_container : Control;
@export var tile_shop_operator_tile_container : Control;
@export var tile_bundle_operator_tile_container : Control;
@export var card_reward_container : Control;
@export var reroll_button : BaseTextureButton;
@export var reroll_price_tag : PriceTag;
@export var next_level_button : BaseTextureButton;

var reroll_amount : int = 0;
var number_tiles : Array[NumberTile];
var operator_tiles : Array[OperatorTile];
var card_rewards : Array[CardController];

var card_reward_selected : bool = false;

func _ready() -> void:
	init_signals();
	await populate_shop();

func init_signals():
	reroll_button.button_up.connect(reroll);
	next_level_button.button_up.connect(SceneManager.start_encounter);
	SignalBus.card_reward_selected.connect(select_card_reward);
	SignalBus.number_tile_bought.connect(on_number_tile_bought);
	SignalBus.operator_tile_bought.connect(on_operator_tile_bought);

func populate_shop():
	await generate_number_tile_shop();
	await generate_operator_tile_shop();
	generate_card_rewards();
	set_reroll_price();
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
		card_reward.status = CardFactory.CARD_STATUS.IN_SHOP;
		card_reward_container.add_child(card_reward);
		card_rewards.append(card_reward);

func set_reroll_price():
	var price = number_tiles.size() + operator_tiles.size() + reroll_amount + 5 if !card_rewards.is_empty() else 0;
	reroll_price_tag.set_price(price);

func reroll():
	if reroll_price_tag.price <= UserData.currency:
		UserData.pay(reroll_price_tag.price);
	else: 
		AnimationUtils.hshake(reroll_button, 50, Constants.SHORT_TRANSITION_DURATION);
		return;
	reroll_amount +=1;
	reset_shop();
	populate_shop();
	set_reroll_price();

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

func select_card_reward(card : CardController):
	if card_reward_selected: return;
	if card_rewards.find(card) == -1:
		printerr("Selected a card reward that was not found in the shop stocks.");
		return;

	card_reward_selected = true;
	# TODO card - add it to card deck
	await AnimationUtils.delete_child_fade_out(card, Constants.DEFAULT_TRANSITION_DURATION);
	card_rewards.erase(card)
	for other_cards in card_rewards:
		await AnimationUtils.delete_child_fade_out(other_cards, Constants.SHORT_TRANSITION_DURATION);
	card_rewards.clear();

func on_number_tile_bought(buyable_element : BuyableElement, tile : NumberTile, price : int):
	if number_tiles.find(tile) == -1:
		printerr("Attempted to buy a number tile not found in the shop stocks.");
		return;
	if UserData.currency < price:
		return;
	UserData.pay(price);
	UserData.number_deck.append(tile);
	number_tiles.erase(tile);
	tile_shop_number_tile_container.remove_child(buyable_element);

func on_operator_tile_bought(buyable_element : BuyableElement, tile : OperatorTile, price : int):
	if operator_tiles.find(tile) == -1:
		printerr("Attempted to buy an operator tile not found in the shop stocks.");
		return;
	if UserData.currency < price:
		return;
	UserData.pay(price);
	UserData.operator_deck.append(tile);
	operator_tiles.erase(tile);
	tile_shop_operator_tile_container.remove_child(buyable_element);
	
