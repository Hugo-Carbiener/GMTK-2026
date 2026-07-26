extends Node2D

# The real collection of tiles of the player. This is to be put in the draw pile at the start of a level.
var number_deck : Array[int];
var operator_deck : Array[TileFactory.OperatorTileType];
var card_deck : Array[CardModel];
var currency : int;

func pay(amount : int):
	if amount == 0: return;
	
	var new_value = max(0, currency - amount);
	AnimationUtils.animate_integer(
		func(x): set_currency(x),
		currency,
		new_value
	);

func gain(amount : int):
	if amount == 0: return;
		
	var new_value = max(0, currency + amount);
	AnimationUtils.animate_integer(
		func(x): set_currency(x),
		currency,
		new_value
	);

func set_currency(amount : int):
	currency = amount;
	SignalBus.on_money_update.emit(currency);

func FillPlayerCardInventory(cards:Array[CardModel])->void:
	card_deck = cards.duplicate();
	return;

func AddCardToPlayerDeck(card:CardModel)->void:
	card_deck.append(card);
	return;

func RemoveCardFromPlayerDeck(card:CardModel)->void:
	card_deck.erase(card);
	return;
