extends Node2D
# Card factory
# Will generate the cards
func _ready() -> void:
	load_card_models();
	PopulatePlayerDeck();

enum CARD_TYPE{
	DRAW_EFFECT,
	SUBMIT_EFFECT
}

enum CARD_STATUS {
	IN_HAND,
	IN_SHOP
}

var cardModelsUniverse : Array[CardModel]; #All the possible cards in the universe

# Will load all the card models in the universe
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
					cardModelsUniverse.append(res)
		file_name = dir.get_next()

# Populate the player's deck at game start
func PopulatePlayerDeck()->void:
	if(UserData.card_deck.size()>=1): # if the deck is already populated, we do NOT populate it again since that means that we're no longer at game start
		return;
	for i in range(0, Constants.DECK_START_SIZE):
		var model = cardModelsUniverse.get(randi() % cardModelsUniverse.size());
		UserData.AddCardToPlayerDeck(model); #TODO : do we want to have multiple examples of the same card ?

func AddRandomCardToPlayerDiscard()->CardModel:
	var model = cardModelsUniverse.get(randi() % cardModelsUniverse.size());
	UserData.AddCardToPlayerDeck(model);
	CardHandManager.instance.AddCardToDiscardPile(model);
	return model;

func AddRandomCardToPlayerStack()->CardModel:
	var model = cardModelsUniverse.get(randi() % cardModelsUniverse.size());
	UserData.AddCardToPlayerDeck(model);
	CardHandManager.instance.AddCardToStackPile(model);
	return model;

func AddCardToPlayerStack(model:CardModel)->CardModel:
	UserData.AddCardToPlayerDeck(model);
	CardHandManager.instance.AddCardToStackPile(model);
	return model;

func AddCardToPlayerDiscard(model:CardModel)->CardModel:
	UserData.AddCardToPlayerDeck(model);
	CardHandManager.instance.AddCardToDiscardPile(model);
	return model;

# Generates a random card based on the universe
func generate_random_card() -> CardController:
	var card_model = cardModelsUniverse.get(randi() % cardModelsUniverse.size());
	return CardController.Create(card_model);
