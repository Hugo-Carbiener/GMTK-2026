class_name Stats extends Node2D

static var instance : Stats;

var total_countdown_decrease : int;
var countdown_decrease_overhead : int;
var turns_remaining: int;
var operations_applied : int;
var operator_used : Dictionary[TileFactory.OperatorTileType, int];
var numbers_used : Dictionary[int, int];

func _ready() -> void:
	if instance == null:
		instance = self;
	SignalBus.on_loss.connect(on_level_end);
	SignalBus.on_win.connect(on_level_end);
	SignalBus.on_tile_couple_executed.connect(on_tile_couple_executed);

func on_level_end():
	var raw_total_countdown_decrease = Countdown.instance.initial_countdown_value - Countdown.instance.countdown;
	total_countdown_decrease = min(raw_total_countdown_decrease, Countdown.instance.initial_countdown_value);
	countdown_decrease_overhead = raw_total_countdown_decrease - Countdown.instance.initial_countdown_value;
	turns_remaining = GameLoop.turns_left;

func on_tile_couple_executed(operator : OperatorTile, number : NumberTile):
	operations_applied +=1;
	if operator_used.has(operator.operator_type):
		operator_used.set(operator.operator_type, operator_used.get(operator.operator_type) + 1);
	else:
		operator_used.set(operator.operator_type, 1);
	
	if numbers_used.has(number.get_number()):
		numbers_used.set(number.get_number(), numbers_used.get(number.get_number()) + 1);
	else:
		numbers_used.set(number.get_number(), 1);

func get_most_used_operator() -> TileFactory.OperatorTileType:
	var uses = 0;
	var most_used_operator : TileFactory.OperatorTileType;
	for operator in operator_used.keys():
		if operator_used.get(operator) > uses:
			uses = operator_used.get(operator);
			most_used_operator = operator;
	return most_used_operator;

func get_most_used_number() -> int:
	var uses = 0;
	var most_used_number : int;
	for number in numbers_used.keys():
		if numbers_used.get(number) > uses:
			uses = numbers_used.get(number);
			most_used_number = number;
	return most_used_number;
