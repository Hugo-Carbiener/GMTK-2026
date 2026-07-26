class_name Card_GainIfOnlyAValue extends CardModelSubmit
# gain shells only if a certain value is present in the tiles

@export var Num : int;
@export var ShellGains: int;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	if(CardEffects.CheckIfAllValuesAreAValue(tileCouples, Num)):
		GameLoop.bonus_shells+=ShellGains;
		return true;
	return false;
