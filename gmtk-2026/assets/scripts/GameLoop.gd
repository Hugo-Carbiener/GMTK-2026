class_name GameLoop extends Node2D

static var current_phase : PHASES;

static var phase_start_sequences = {
	PHASES.PLAY_PHASE : Callable(play_phase),
	PHASES.EXECUTION_PHASE : Callable(execution_phase)
}

enum PHASES {
	PLAY_PHASE,
	EXECUTION_PHASE
}

func _ready() -> void:
	ready.connect(start_level);
	init_signals();

func init_signals():
	SignalBus.play_phase_submitted.connect(end_turn);

func start_level():
	current_phase = PHASES.PLAY_PHASE;
	start_phase(current_phase);

static func get_next_phase() -> int:
	return PHASES.values()[(current_phase + 1) % PHASES.size()];

static func start_phase(phase: PHASES):
	current_phase = phase;
	phase_start_sequences.get(phase).call();

static func play_phase():
	print("PLAY PHASE STARTED");

static func execution_phase():
	print("EXECUTION PHASE STARTED");
	start_phase(get_next_phase());

static func end_turn():
	start_phase(get_next_phase());
