class_name CardHandManager extends Control

static var instance : CardHandManager;

var cards : Array[CardController];

func _ready() -> void:
	if instance == null:
		instance = self;

func on_turn_start():
	for i in range(Constants.MAX_NUMBER_CARDS):
		draw_random_card();

func draw_random_card():
	var card = CardFactory.generate_random_card();
	cards.append(card);
	add_child(card);
