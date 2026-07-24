class_name DiscardPile extends BasePile

static var instance : DiscardPile;

func _ready() -> void:
	if instance == null:
		instance = self;
	pivot_offset = size / 2;
	button_down.connect(on_click);

func on_click():
	pass;
