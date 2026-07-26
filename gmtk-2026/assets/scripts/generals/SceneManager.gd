extends Node2D

var titlescreen : PackedScene = preload("res://assets/scenes/title-screen.tscn");
var encounter : PackedScene = preload("res://assets/scenes/level.tscn");
var shop : PackedScene = preload("res://assets/scenes/shop.tscn");

func _ready() -> void:
	SignalBus.shop_clicked.connect(open_shop);
	SignalBus.next_encounter_clicked.connect(start_encounter);

func menu():
	get_tree().change_scene_to_packed(titlescreen);

func open_shop():
	get_tree().change_scene_to_packed(shop);

func start_encounter():
	get_tree().change_scene_to_packed(encounter);
