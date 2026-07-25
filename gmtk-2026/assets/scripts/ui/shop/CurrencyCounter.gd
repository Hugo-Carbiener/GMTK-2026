class_name CurrencyCounter extends Label

func _ready() -> void:
	SignalBus.on_money_update.connect(set_currency_value);

func set_currency_value(value : int):
	text = str(value);
