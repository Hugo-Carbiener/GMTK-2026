class_name CardFactory extends Node2D
# Card factory
# Self-explanatory

enum CARD_TYPE{
	DRAW_EFFECT,
	SUBMIT_EFFECT
}

@export var cardModels : Array[CardModel];
var cardDeck : Array[CardController];

static var instance : CardFactory;

func _ready() -> void:
	if instance == null:
		instance = self;

func init():
	GenerateCardDeck();

func GenerateCardDeck():
	for genCard in cardModels:
		var newCard = CardController.Create(genCard); #TODO : here we can 
		cardDeck.append(newCard);
