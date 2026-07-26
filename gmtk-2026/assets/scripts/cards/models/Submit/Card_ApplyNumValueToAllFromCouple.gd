class_name Card_ApplyNumValueToAllFromCouple extends CardModelSubmit
# If a certain couple is found, we apply a value to all other numbers

@export var Num : int;
@export var Op : TileFactory.OperatorTileType;
@export var NumToApply : int;
@export var OpToApply : TileFactory.OperatorTileType;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	if(CardEffects.TestIfCouplePresent(tileCouples, Num, Op)):
		return CardEffects.ApplyCoupleToAllNum(tileCouples, NumToApply, OpToApply);
	return false;
