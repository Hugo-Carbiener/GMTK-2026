class_name GameLoop extends Node2D

static var current_phase : Phases;

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
	CardFactory.instance.init();
	TileFactory.instance.init();
	DrawPile.instance.init();
	start_phase(current_phase);

static func get_next_phase() -> int:
	return Phases.values()[(current_phase + 1) % Phases.size()];

static func start_phase(phase: Phases):
	current_phase = phase;
	phase_start_sequences.get(phase).call();

static func play_phase():
	print("PLAY PHASE STARTED");
	HandManager.instance.on_turn_start();

static func execution_phase():
	print("EXECUTION PHASE STARTED");
	start_phase(get_next_phase());

static func end_turn():
	HandManager.instance.discard_hands();
	start_phase(get_next_phase());
