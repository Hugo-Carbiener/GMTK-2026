class_name CardHandManager extends Control

static var instance : CardHandManager;

var cards : Array[CardController]; # The cards currently in front of the player (their hand)

var _discardPileCards : Array[CardModel];
var _stackPileCards : Array[CardModel];

func _ready() -> void:
	if instance == null:
		instance = self;

# At level start, we populate the stack from the cards in the player's inventory
func init():
	for card in UserData.card_deck:
		_stackPileCards.append(card);
	print("Card stack :");
	for i in _stackPileCards:
		print(str(i)+" : "+i.Name);

func on_turn_start():
	var numCardsToDraw = Constants.MAX_NUMBER_CARDS_DRAWN;
	if(cards.size()+numCardsToDraw>Constants.MAX_NUMBER_CARDS_IN_HAND):numCardsToDraw=Constants.MAX_NUMBER_CARDS_IN_HAND-cards.size();
	for i in range(numCardsToDraw):
		DrawCard();

# Draws a card from the stack
func DrawCard()->bool:
	if(_stackPileCards.size()<1):
		if(!ShuffleDiscardPileInStack()):return false; #if the stack and the discard are empty, no card is drawn 
	var card = CardController.Create(_stackPileCards.get(0));
	_stackPileCards.erase(_stackPileCards.get(0));
	cards.append(card);
	add_child(card);
	#TODO : add visual shenanigans ?
	return true;

# Adds a card at runtime to the discard pile
func AddCardToDiscardPile(card:CardModel)->bool:
	_discardPileCards.append(card);
	return true;

# Adds a card at runtime to the stack pile
func AddCardToStackPile(card:CardModel)->bool:
	_stackPileCards.append(card);
	return true;

# Will shuffle the discard in the stack -> if no cards in the discard, returns false
func ShuffleDiscardPileInStack()->bool:
	if(_discardPileCards.size()<1):return false;
	_stackPileCards = _discardPileCards.duplicate();
	_stackPileCards.shuffle();
	_discardPileCards.clear();
	#TODO : add visual shenanigans ?
	return true;

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
	DiscardCardsFromHand()
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
	DiscardCardsFromHand();
	return;

# Discard all cards from the hand that need to be discarded (used)
func DiscardCardsFromHand()->void:
	for card in cards:
		if(card.MarkedForDeath):
			var model = card.Model;
			card.Destroy();
			cards.erase(card);
			_discardPileCards.append(model);
