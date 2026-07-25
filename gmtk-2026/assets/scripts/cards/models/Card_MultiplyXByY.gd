class_name Card_MultiplyXByY extends CardModelSubmit
# Card that will multiply all the Xs in the number tiles by Y

@export var NumToMultiply : int = 0;
@export var NumToMultiplyBy : int = 0;

func TriggerCardEffect(tileCouples : Array[TileCouple]) -> bool:
	print("Attempting to trigger card Multiply "+str(NumToMultiply)+" by "+str(NumToMultiplyBy));
	var res = NumToMultiply*NumToMultiplyBy;
	var hasBeenTriggered=false;
	for couple in tileCouples:
		if couple==null or couple.number==null:continue;
		if(couple.number.number==NumToMultiply):
			couple.number.UpdateTile(res);
			hasBeenTriggered=true;
			print("Card : Multiply "+str(NumToMultiply)+" by "+str(NumToMultiplyBy)+" triggered !");
	return hasBeenTriggered;
