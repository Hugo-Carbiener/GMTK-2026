class_name CardController extends Control
# Card controller
# Controls the card
# Yeah
const CardScene : PackedScene = preload("res://assets/scenes/cards/card.tscn");

# Card elements
var Name : String;
var Description : String;
var Type : CardFactory.CARD_TYPE;
var Model : CardModel;
var MarkedForDeath : bool = false;

# Card visual elements
@export var LabelCardName : Label;
@export var LabelCardDescription : Label;

func _ready() -> void:
	print("I am a card !");
	pass 

static func Create(card:CardModel)->CardController:
	print("Creating card");
	var newCard = CardScene.instantiate();
	newCard.Name=card.Name;
	newCard.Description=card.Description;
	newCard.Type=card.Type;
	newCard.Model=card;
	newCard.ChangeCardVisuals();
	newCard.MarkedForDeath=false;
	return newCard;

func ChangeCardVisuals()->void:
	LabelCardName.text = self.Name;
	LabelCardDescription.text = self.Description;
	return;

func Destroy()->void:
	#TODO : add visual bullshittery
	queue_free();
