class_name Card_ChangeValueIfAllTilesAreValue extends CardModelSubmit
# If all tiles are a certain num, apply a value to each of them

@export var Num : int;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	if(CardEffects.CheckIfAllValuesAreAValue(tileCouples, Num)):
		return CardEffects.ChangeNumber(tileCouples, Num, CardEffects.CountNumberOfTiles(tileCouples));
	return false;
