class_name GameLoop extends Node2D

static var current_phase : Phases;
static var turns_left : int;

static var phase_start_sequences = {
	Phases.PLAY_PHASE : Callable(play_phase),
	Phases.EXECUTION_PHASE : Callable(execution_phase)
}

enum Phases {
	PLAY_PHASE,
	EXECUTION_PHASE
}

func _ready() -> void:
	ready.connect(start_level);
	init_signals();

func init_signals():
	SignalBus.play_phase_submitted.connect(end_turn);

func start_level():
	current_phase = Phases.PLAY_PHASE;
	turns_left = Constants.BASE_TURN_NUMBER;
	CardFactory.instance.init();
	Executor.instance.init();
	Countdown.instance.init();
	TileFactory.instance.init();
	DrawPile.instance.init();
	start_phase(current_phase);

static func get_next_phase() -> int:
	return Phases.values()[(current_phase + 1) % Phases.size()];

static func start_phase(phase: Phases):
	current_phase = phase;
	phase_start_sequences.get(phase).call();

static func play_phase():
	turns_left -= 1;
	SignalBus.play_phase_started.emit();
	HandManager.instance.on_turn_start();

static func execution_phase():
	SignalBus.execution_phase_started.emit();
	await Executor.instance.execute();
	check_win_loose_conditions();
	start_phase(get_next_phase());

static func end_turn():
	var can_end_turn = await Executor.instance.on_turn_end();
	if !can_end_turn: return;
	
	HandManager.instance.discard_hands();
	start_phase(get_next_phase());

static func check_win_loose_conditions():
	if Countdown.instance.countdown <= 0:
		win_level();
		return;
	
	if turns_left == 0:
		lose_level();

static func win_level():
	print("YOU WIN");
	SignalBus.on_win.emit();

static func lose_level():
	SignalBus.on_loss.emit();
