extends Node
# This script will contain all the basic effects so that the card effects can be built using them like building blocks

func ChangeNumber(tileCouples:Array[TileCouple], numberToChange:int, numberToChangeTo:int)->bool:
	var ret = false;
	for couple in tileCouples:
		if couple==null or couple.number==null:continue;
		if(couple.number.number==numberToChange):
			couple.number.UpdateTile(numberToChangeTo);
			ret=true;
			print("Card effect Change Number triggered");
	return ret;
