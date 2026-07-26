class_name Countdown extends Label

static var instance : Countdown;

@export var countdown_modification_label : Label;

var initial_countdown_value : int = 0;
var countdown : int = 0;

func _ready() -> void:
	if instance == null:
		instance = self;

func init():
	initial_countdown_value = round(Constants.BASE_COUNTDOWN_VALUE * pow(Constants.ENCOUNTER_FACTOR, UserData.encounter_cleared) + (randi() % Constants.COUNTDOWN_RANDOM_RANGE));
	set_countdown_value(initial_countdown_value);

func display_modification(operator_tile : OperatorTile, number_tile : NumberTile):
	countdown_modification_label.text = operator_tile.model.text + "0";
	countdown_modification_label.modulate.a = 0;
	countdown_modification_label.visible = true;
	AnimationUtils.fade(countdown_modification_label, 1., Constants.SHORT_TRANSITION_DURATION);
	await AnimationUtils.animate_integer(
		func(x): countdown_modification_label.text = operator_tile.model.text + str(x),
		0,
		number_tile.get_number()
	);

func consume_modification(operator_tile : OperatorTile, number_tile : NumberTile):
	#AnimationUtils.camera_shake(MainCamera.get_camera(), 50, Constants.SHORT_TRANSITION_DURATION);
	await AnimationUtils.animate_integer(
		func(x): countdown_modification_label.text = operator_tile.model.text + str(x),
		number_tile.get_number(),
		0
	);
	await AnimationUtils.fade(countdown_modification_label, 0., Constants.SHORT_TRANSITION_DURATION);

func set_countdown_value(value : int):
	await AnimationUtils.animate_integer(
		func(x): text = str(x),
		countdown,
		value
	);
	countdown = value;
