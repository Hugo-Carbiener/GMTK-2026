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
var CardIsFlipped : bool = false;
var status : CardFactory.CARD_STATUS;

# Card visual elements
@export var LabelCardName : Label;
@export var LabelCardDescription : Label;
@export var button : Button;
@export var CardPadding : MarginContainer;

func _ready() -> void:
	button.button_up.connect(on_click);

static func Create(card:CardModel)->CardController:
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

func on_click():
	match status:
		CardFactory.CARD_STATUS.IN_SHOP:
			SignalBus.card_reward_selected.emit(self);
		CardFactory.CARD_STATUS.IN_HAND:
			FlipCard();

func FlipCard()->void:
	CardPadding.visible=CardIsFlipped;
	CardIsFlipped=!CardIsFlipped;


func Destroy()->void:
	#TODO : add visual bullshittery
	queue_free();
