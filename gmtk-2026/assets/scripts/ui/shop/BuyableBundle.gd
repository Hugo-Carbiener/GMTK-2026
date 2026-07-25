class_name BuyableBundle extends BuyableElement

const buyable_bundle_scene : PackedScene = preload("res://assets/scenes/components/shop/buyable-bundle.tscn");

@export var bonus_currency_label : Label;
@export var bonus_currency_container : Control;

var bonus : int;

static func create_buyable_element(_bonus : int, _content : Control) -> BuyableElement:
	var element = buyable_bundle_scene.instantiate();
	element.setup(_bonus, _content);
	return element;

func setup(_bonus : int, _content : Control):
	self.content = _content;
	self.bonus = _bonus;
	bonus_currency_label.text = str(bonus);
	content_container.add_child(_content);

func on_click():
	if bought: return;
	
	if content is OperatorTile:
		var number_tile_content : OperatorTile = content;
		SignalBus.operator_tile_bundle_bought.emit(self, number_tile_content);
	else: 
		printerr("Bundle with content of wrong type: " + content.get_class());
		return;
	UserData.gain(bonus)

func mark_as_bought():
	bought = true;
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	content_container.visible = false;
	bonus_currency_container.visible = false;
	bought_visual.visible = true;
