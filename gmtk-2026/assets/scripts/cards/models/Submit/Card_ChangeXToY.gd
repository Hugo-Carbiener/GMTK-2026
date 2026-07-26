class_name Card_ChangeXToY extends CardModelSubmit
# Card that will change a number to another

@export var NumToChange : int = 0;
@export var NumToChangeTo : int = 0;

func TriggerCardEffect(tileCouples : Array[TileCouple])->bool:
	print("Attempting to trigger card Change Number "+str(NumToChange)+" to "+str(NumToChangeTo));
	return CardEffects.ChangeNumber(tileCouples, NumToChange, NumToChangeTo);
