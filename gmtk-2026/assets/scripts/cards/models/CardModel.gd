@abstract class_name CardModel extends Resource
# Abstract Class of the models for the card
# Each child of this class will represent a model of a card, including its effect

@export var Name : String; # Name of the card
@export var Description : String; # Description of the card
@export var Type : CardFactory.CARD_TYPE; # Effect type of the card

@abstract func TriggerCardEffect() -> bool;
