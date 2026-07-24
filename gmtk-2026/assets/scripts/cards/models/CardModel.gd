class_name CardModel extends Resource
# Class of the models for the card

@export var Name : String; # Name of the card
@export var Description : String; # Description of the card
@export var Type : CardFactory.CARD_TYPE; # Effect type of the card
#TODO : Here, we will put a script that contains the effect of the card
# Ideally, the effect must derive from CardEffect and be somhow modular
