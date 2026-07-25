class_name BuyableElement extends HoverableElement

const buyable_element_scene : PackedScene = preload("res://assets/scenes/components/shop/buyable-element.tscn");

@export_group("Components")
@export var content_container : Control;
@export var price_tag_container : Control;
@export var button : Button;
@export var bought_visual : Control;

var price_tag : PriceTag;
var content : Control;
var bought : bool = false;

static func create_buyable_element(_price : int, _content : Control) -> BuyableElement:
	var element = buyable_element_scene.instantiate();
	element.setup(_price, _content);
	return element;

func setup(_price : int, _content : Control):
	self.content = _content;
	price_tag = PriceTag.create_price_tag(_price);
	price_tag_container.add_child(price_tag);
	content_container.add_child(_content);

func _ready() -> void:
	super();
	button.button_up.connect(on_click);

func on_click():
	if bought: return;
	
	if price_tag.price > UserData.currency:
		AnimationUtils.hshake(self, 50, Constants.SHORT_TRANSITION_DURATION);
		AnimationUtils.blink_sprite(self, Color.RED);

	if content is NumberTile:
		var number_tile_content : NumberTile = content;
		SignalBus.number_tile_bought.emit(self, number_tile_content, price_tag.price);
	elif content is OperatorTile:
		var operator_tile_content : OperatorTile = content;
		SignalBus.operator_tile_bought.emit(self, operator_tile_content, price_tag.price);

func mark_as_bought():
	bought = true;
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	content_container.visible = false;
	price_tag_container.visible = false;
	bought_visual.visible = true;
