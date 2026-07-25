class_name CardHandManager extends Control

static var instance : CardHandManager;

var cards : Array[CardController];

func _ready() -> void:
	if instance == null:
		instance = self;

func on_turn_start():
	var numCardsToDraw = Constants.MAX_NUMBER_CARDS_DRAWN;
	if(cards.size()+numCardsToDraw>Constants.MAX_NUMBER_CARDS_IN_HAND):numCardsToDraw=Constants.MAX_NUMBER_CARDS_IN_HAND-cards.size();
	for i in range(numCardsToDraw):
		draw_random_card();

func draw_random_card():
	var card = CardFactory.generate_random_card();
	cards.append(card);
	add_child(card);


#Function called when submitting
func ExecuteCardSubmit(tileCouples : Array[TileCouple])->void:
	print("Triggering submit cards !");
	for card in cards:
		if card.CardIsFlipped:continue;
		if(card.Type==CardFactory.CARD_TYPE.SUBMIT_EFFECT):
			if(card.Model.TriggerCardEffect(tileCouples)):
				card.MarkedForDeath=true;
				#TODO : add some visual bullshittery here 
	# Now we clean the cards
	ClearCardsFromDeck()
	return;

func ExecuteCardDraw()->void:
	print("Triggering draw cards !");
	for card in cards:
		if card.CardIsFlipped:continue;
		if(card.Type==CardFactory.CARD_TYPE.DRAW_EFFECT):
			if(card.Model.TriggerCardEffect()):
				card.MarkedForDeath=true;
				#TODO : add some visual bullshittery here 
	# Now we clean the cards
	ClearCardsFromDeck();
	return;

func ClearCardsFromDeck()->void:
	#TODO : clean this to avoid performing multiple useless loops -> put the cards marked for death in specific dict to clean during the triggers (see above)
	for card in cards:
		if(card.MarkedForDeath):
			#TODO : add some visual bullshittery here 
			card.Destroy();
			cards.erase(card);
