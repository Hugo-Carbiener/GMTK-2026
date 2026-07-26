class_name Card_ChangeNumBasedOnNumOccurences extends CardModelSubmit
# Card that will change a num based on the number of occurences of this num

@export var Num : int;
@export var OccurencesThresh : int = 1;
@export var NumToChangeTo : int;

func TriggerCardEffect(tileCouples : Array[TileCouple])->bool:
	if(CardEffects.CountNumberOfTilesOfNumber(tileCouples, Num)>=OccurencesThresh):
		return CardEffects.ChangeNumber(tileCouples, Num, NumToChangeTo);
	return false;
