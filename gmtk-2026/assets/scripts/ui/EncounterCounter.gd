class_name EncounterCounter extends Label

func _ready() -> void:
	pivot_offset = size/2;
	SignalBus.play_phase_started.connect(on_play_phase_started);

func on_play_phase_started():
	AnimationUtils.bounce(self, 1.5);
	text = str(UserData.encounter_cleared);
