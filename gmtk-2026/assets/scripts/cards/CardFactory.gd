class_name CardFactory extends Node2D
# Card factory
# Will generate the cards

static var instance : CardFactory;

@export var uiCardContainer : HBoxContainer;

func _ready() -> void:
	if instance == null:
		instance = self;

enum CARD_TYPE{
	DRAW_EFFECT,
	SUBMIT_EFFECT
}

@export var cardModels : Array[CardModel]; #All the possible cards based on the card model
var cardDeck : Array[CardController]; #The in-game drawn cards 


func init():
	GenerateCardDeck();

func GenerateCardDeck():
	# TODO : Change this function so that only three cards spawn rather than everything contained in the models database
	for genCard in cardModels:
		var newCard = CardController.Create(genCard);
		cardDeck.append(newCard);
		uiCardContainer.add_child(newCard);
