extends Node2D
# Card factory
# Will generate the cards
func _ready() -> void:
	load_card_models();

enum CARD_TYPE{
	DRAW_EFFECT,
	SUBMIT_EFFECT
}

var cardModels : Array[CardModel]; #All the possible cards based on the card model
var cardDeck : Dictionary[CardModel,CardController]; #The in-game drawn cards 

func init()->void:
	GenerateCardDeck();

func load_card_models():
	var path = "res://assets/resources/cards/";
	var dir = DirAccess.open(path)

	if !dir:
		printerr("Could not find directory " + path);
		return;

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if not dir.current_is_dir():
			# Remove .remap or .import suffixes if present in exported builds
			var clean_name = file_name.trim_suffix(".remap").trim_suffix(".import")
			var file_path = path.path_join(clean_name)

			if ResourceLoader.exists(file_path):
				var res = load(file_path)
				# Check if the resource matches or inherits from target_type
				if res and res is CardModel:	
					cardModels.append(res)

		file_name = dir.get_next()

var rng = RandomNumberGenerator.new();
func GenerateCardDeck()->void:
	for i in range(0, Constants.MAX_NUMBER_CARDS):
		var new_card = generate_random_card();
		cardDeck[new_card.Model]= new_card;

func generate_random_card() -> CardController:
	var card_model = cardModels.get(randi() % cardModels.size());
	return CardController.Create(card_model);

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
	
