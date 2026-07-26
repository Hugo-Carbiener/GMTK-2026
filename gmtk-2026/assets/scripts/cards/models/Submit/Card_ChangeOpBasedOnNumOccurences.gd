class_name Card_ChangeOpBasedOnNumOccurences extends CardModelSubmit
# Card that will change a num based on the number of occurences of this num

@export var Num : int;
@export var OccurencesThresh : int = 1;
@export var OpToChange : TileFactory.OperatorTileType;
@export var OpToChangeTo : TileFactory.OperatorTileType;

func TriggerCardEffect(tileCouples : Array[TileCouple])->bool:
	if(CardEffects.CountNumberOfTilesOfNumber(tileCouples, Num)>=OccurencesThresh):
		return CardEffects.ChangeOperator(tileCouples, OpToChange, OpToChangeTo);
	return false;
