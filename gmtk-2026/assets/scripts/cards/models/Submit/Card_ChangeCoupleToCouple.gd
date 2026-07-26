class_name Card_ChangeCoupleToCouple extends CardModelSubmit
# Will change a couple to another couple

@export var NumToChange : int;
@export var OpToChange : TileFactory.OperatorTileType;
@export var NumToChangeTo : int;
@export var OpToChangeTo : TileFactory.OperatorTileType;

func TriggerCardEffect(tileCouples : Array[TileCouple])->bool:
	return CardEffects.ChangeCoupleToCouple(tileCouples, NumToChange, OpToChange, NumToChangeTo, OpToChangeTo);
