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
		var new_card = generate_random_card();
		cardDeck[new_card.Model]= new_card;
		uiCardContainer.add_child(new_card);

func generate_random_card() -> CardController:
	var randNum = rng.randi_range(0, cardModels.size()-1);
	var newCardModel = cardModels.get(randNum);
	while(newCardModel!=null and cardDeck.has(newCardModel)==true):
		randNum = rng.randi_range(0, cardModels.size()-1);
		newCardModel = cardModels.get(randNum);
	return CardController.Create(newCardModel);

#Function called when submitting
func ExecuteCardSubmit(tileCouples : Array[TileCouple])->void:
	print("Triggering submit cards !");
	for model in cardDeck:
		if(model.Type==CARD_TYPE.SUBMIT_EFFECT):
			if(cardDeck[model].Model.TriggerCardEffect(tileCouples)):
				cardDeck[model].MarkedForDeath=true;
				#TODO : add some visual bullshittery here 
	# Now we clean the cards
	ClearCardsFromDeck()
	return;

func ExecuteCardDraw()->void:
	print("Triggering draw cards !");
	for model in cardDeck:
		if(model.Type==CARD_TYPE.DRAW_EFFECT):
			if(cardDeck[model].Model.TriggerCardEffect()):
				cardDeck[model].MarkedForDeath=true;
				#TODO : add some visual bullshittery here 
	# Now we clean the cards
	ClearCardsFromDeck();
	return;

func ClearCardsFromDeck()->void:
	#TODO : clean this to avoid performing multiple useless loops -> put the cards marked for death in specific dict to clean during the triggers (see above)
	for model in cardDeck:
		if(cardDeck[model].MarkedForDeath):
			#TODO : add some visual bullshittery here 
			cardDeck[model].Destroy();
			cardDeck[model] = null;
			cardDeck.erase(model);
	
