class_name Card_ChangeOperator extends CardModelSubmit
# Card that will change the operator to another

@export var OperatorToChange : TileFactory.OperatorTileType;
@export var OperatorToChangeTo : TileFactory.OperatorTileType;

func TriggerCardEffect(tileCouples : Array[TileCouple])->bool:
	var hasBeenTriggered=false;
	print("Attempting to trigger card Change Operator "+str(OperatorToChange)+" to "+str(OperatorToChangeTo));
	for couple in tileCouples:
		if couple==null or couple.operator==null:continue;
		if(couple.operator.model.operator_type==OperatorToChange):
			couple.operator.UpdateTile(OperatorToChangeTo);
			hasBeenTriggered=true;
			print("Card : Change operator "+str(OperatorToChange)+" to "+str(OperatorToChangeTo)+" triggered !");
	return hasBeenTriggered;
