class_name CardController extends HoverableElement
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
@export var card_content_container : Control;
@export var card_flipped_container : Control;
@export var can_be_flipped : bool;

func _ready() -> void:
	super();
	grow_factor = 1.1;
	button.button_up.connect(on_click);

static func Create(card:CardModel)->CardController:
	var newCard = CardScene.instantiate();
	newCard.Name=card.Name;
	newCard.Description=card.Description;
	newCard.Type=card.Type;
	newCard.Model=card;
	newCard.ChangeCardVisuals();
	newCard.MarkedForDeath=false;
	newCard.CardIsFlipped=false;
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

func on_execution():
	await AnimationUtils.bounce(self, grow_factor);

func FlipCard()->void:
	if !can_be_flipped: return;
	
	is_hover_blocked = true;
	CardIsFlipped=!CardIsFlipped;
	await AnimationUtils.animate_scale(self, Vector2i.ONE, Vector2.DOWN, Constants.SHORT_TRANSITION_DURATION * 2);
	card_content_container.visible = !CardIsFlipped;
	card_flipped_container.visible = CardIsFlipped;
	await AnimationUtils.animate_scale(self, Vector2.DOWN, Vector2i.ONE, Constants.SHORT_TRANSITION_DURATION * 2);
	is_hover_blocked = false;

func Destroy()->void:
	#TODO : add visual bullshittery
	queue_free();
