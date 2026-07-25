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
var cardDeck : Dictionary[CardModel,CardController]; #The in-game drawn cards 

func init()->void:
	GenerateCardDeck();

var rng = RandomNumberGenerator.new();
func GenerateCardDeck()->void:
	for i in range(0, Constants.MAX_NUMBER_CARDS):
		var randNum = rng.randi_range(0, cardModels.size()-1);
		var newCardModel = cardModels.get(randNum);
		while(newCardModel!=null and cardDeck.has(newCardModel)==false):
			#TODO : in some rare edgecases we might be here for a while -> maybe put a forced limiter ?
			var newCard = CardController.Create(newCardModel);
			cardDeck[newCardModel]= newCard;
			uiCardContainer.add_child(newCard);
			break;

#Function called when submitting
func ExecuteCardSubmit(tileCouples : Array[TileCouple])->void:
	print("Triggering cards !");
	for model in cardDeck:
		if(model.Type==CARD_TYPE.SUBMIT_EFFECT):
			cardDeck[model].Model.TriggerCardEffect(tileCouples);
			#TODO : add some visual bullshittery here 
	return;
