class_name Card_GainIfCouplePresent extends CardModelSubmit
# Gain the number of shells if couple present
# TODO : right now num of shells = num of tiles => change to be modular

@export var Num:int;
@export var Op:TileFactory.OperatorTileType;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	if(CardEffects.TestIfCouplePresent(tileCouples, Num, Op)):
		GameLoop.bonus_shells+=CardEffects.CountNumberOfTiles(tileCouples);
		return true;
	return false;
