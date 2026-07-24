class_name CardController extends Node2D
# Card controller
# Controls the card
# Yeah
const CardScene : PackedScene = preload("res://assets/scenes/cards/card.tscn");

# Card elements
@export var Name = "DEFAULT_CARD";
@export var Description = "DEFAULT_DESCRIPTION"
@export var Type = CardFactory.CARD_TYPE.SUBMIT_EFFECT; #By default submit effect

func _ready() -> void:
	print("I am a card !");
	pass 

static func Create(card:CardModel)->CardController:
	print("Creating card");
	var newCard = CardScene.instantiate();
	newCard.CardController.Name=card.Name;
	newCard.CardController.Description=card.Description;
	newCard.CardController.Type=card.Type;
	return newCard;

func TriggerCardEffect() -> bool:
	print("HELLO, I AM A CARD EFFECT ! RIVETING !!!");
	# Returns 0 when effect is triggered, 1 otherwise, I dunno could be useful down the line
	#TODO : THIS SHOULD CALL A SCRIPT LOADED IN THE CARD MODEL which will contain the card's effect
	return 0;
