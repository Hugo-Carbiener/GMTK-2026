class_name Card_MultiplyXByY extends CardModelSubmit
# Card that will multiply all the Xs in the number tiles by Y

@export var NumToMultiply : int = 0;
@export var NumToMultiplyBy : int = 0;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	print("Attempting to trigger card Multiply "+str(NumToMultiply)+" by "+str(NumToMultiplyBy));
	var res = NumToMultiply*NumToMultiplyBy;
	return CardEffects.ChangeNumber(tileCouples, NumToMultiply, res);
