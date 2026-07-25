class_name PriceTag extends Control

const price_tag_scene : PackedScene = preload("res://assets/scenes/components/shop/price-tag.tscn");

var price : int;

@export_group("Fonts")
@export var valid_price_font : LabelSettings;
@export var invalid_price_font : LabelSettings;
@export_group("Components")
@export var label : Label;

func _ready() -> void:
	SignalBus.on_money_update.connect(update);

static func create_price_tag(_price : int) -> PriceTag:
	var price_tag = price_tag_scene.instantiate();
	price_tag.set_price(_price);
	return price_tag;

func set_price(_price : int):
	price = _price;
	label.text = str(_price);
	update(UserData.currency);

func update(value : int):
	label.label_settings = valid_price_font if price <= value else invalid_price_font;
