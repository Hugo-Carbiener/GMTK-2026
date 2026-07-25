class_name Card_MultiplyXByY extends CardModelSubmit
# Card that will multiply all the Xs in the number tiles by Y

@export var NumToMultiply : int = 0;
@export var NumToMultiplyBy : int = 0;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	print("Card : Multiply "+str(NumToMultiply)+" by "+str(NumToMultiplyBy)+" triggered !");
	var res = NumToMultiply*NumToMultiplyBy;
	for couple in tileCouples:
		if couple==null or couple.number==null:continue;
		if(couple.number.number==NumToMultiply):
			couple.number.UpdateTile(res);
	return 0;
