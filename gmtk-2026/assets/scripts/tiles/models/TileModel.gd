@abstract class_name TileModel extends Resource

var type : TileFactory.TileType;
@export var text : String;
@export_group("Deck management")
@export var is_in_base_deck : bool;
@export var amount_in_base_deck : int;
@export_group("Shop")
@export var is_in_bundle : bool;
@export var price : int;
