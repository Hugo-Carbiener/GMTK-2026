class_name BuyableElement extends Control

const buyable_element_scene : PackedScene = preload("res://assets/scenes/components/shop/buyable-element.tscn");

@export_group("Fonts")
@export var valid_price_font : LabelSettings;
@export var invalid_price_font : LabelSettings;
@export_group("Components")
@export var price_label : Label;
@export var content_container : Control;

var content : Control;
var price : int;

static func create_buyable_element(_price : int, _content : Control) -> BuyableElement:
	var element = buyable_element_scene.instantiate();
	element.setup(_price, _content);
	return element;

func setup(_price : int, _content : Control):
	self.price = _price;
	price_label.text = str(price);
	self.content = _content;
	content_container.add_child(_content);
	update_status(UserData.currency);

func _ready() -> void:
	SignalBus.on_money_update.connect(update_status);

func update_status(value : int):
	price_label.label_settings = valid_price_font if price >= value else invalid_price_font;
