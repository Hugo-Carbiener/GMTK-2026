class_name Countdown extends Label

static var instance : Countdown;

var initial_countdown_value : int = 0;
var countdown : int = 0;

func _ready() -> void:
	if instance == null:
		instance = self;

func init():
	initial_countdown_value = randi() % (Constants.MAX_COUNTDOWN_VALUE - Constants.MIN_COUNTDOWN_VALUE) + Constants.MIN_COUNTDOWN_VALUE;
	set_countdown_value(initial_countdown_value);

func set_countdown_value(value : int):
	await AnimationUtils.animate_integer(
		func(x): text = str(x),
		countdown,
		value
	);
	countdown = value;
