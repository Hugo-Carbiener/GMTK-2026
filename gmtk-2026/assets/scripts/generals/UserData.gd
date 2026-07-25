extends Node2D

# The real collection of tiles of the player. This is to be put in the draw pile at the start of a level.
var number_deck : Array[NumberTile];
var operator_deck : Array[OperatorTile];
var currency : int;

func pay(amount : int):
	var new_value = max(0, currency - amount);
	AnimationUtils.animate_integer(
		func(x): set_currency(x),
		currency,
		new_value
	);

func gain(amount : int):
	var new_value = max(0, currency + amount);
	AnimationUtils.animate_integer(
		func(x): set_currency(x),
		currency,
		new_value
	);

func set_currency(amount : int):
	currency = amount;
	SignalBus.on_money_update.emit(currency);
