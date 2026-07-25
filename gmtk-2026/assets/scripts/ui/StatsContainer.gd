class_name StatsContainer extends Control

const stats_scene : PackedScene = preload("res://assets/scenes/components/stats-container.tscn");

@export_group("Components")
@export var total_decrease_value : Label;
@export var decrease_surplus_value : Label;
@export var turns_remaining_value : Label;
@export var operation_used_value : Label;
@export var most_used_operator_value : Label;
@export var most_used_number_value : Label;

static func create_stats() -> StatsContainer:
	var stats_container = stats_scene.instantiate();
	stats_container.setup();
	return stats_container;

func setup():
	total_decrease_value.text = str(Stats.instance.total_countdown_decrease);
	decrease_surplus_value.text = str(max(0, Stats.instance.countdown_decrease_overhead));
	turns_remaining_value.text = str(Stats.instance.turns_remaining);
	operation_used_value.text = str(Stats.instance.operations_applied);
	var most_used_operator = Stats.instance.get_most_used_operator();
	most_used_operator_value.text = TileFactory.operatorTileTypeToChar.get(most_used_operator) + " (" + str(Stats.instance.operator_used.get(most_used_operator)) + "times)";
	var most_used_number = Stats.instance.get_most_used_number();
	most_used_number_value.text = str(most_used_number) + " (" + str(Stats.instance.numbers_used.get(most_used_number)) + "times)";

func fade_in():
	total_decrease_value.modulate.a = 0;
	decrease_surplus_value.modulate.a = 0;
	turns_remaining_value.modulate.a = 0;
	operation_used_value.modulate.a = 0;
	most_used_operator_value.modulate.a = 0;
	most_used_number_value.modulate.a = 0;
	AnimationUtils.fade(total_decrease_value, 1., Constants.DEFAULT_TRANSITION_DURATION);
	AnimationUtils.fade(decrease_surplus_value, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION);
	AnimationUtils.fade(turns_remaining_value, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION * 2);
	AnimationUtils.fade(operation_used_value, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION * 3);
	AnimationUtils.fade(most_used_operator_value, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION * 4);
	await AnimationUtils.fade(most_used_number_value, 1., Constants.DEFAULT_TRANSITION_DURATION, Constants.SHORT_TRANSITION_DURATION * 5);
