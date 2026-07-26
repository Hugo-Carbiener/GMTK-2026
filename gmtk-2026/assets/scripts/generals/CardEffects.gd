extends Node
# This script will contain all the basic effects so that the card effects can be built using them like building blocks

enum CARD_REWARD_TYPE{
	RANDOM,
	CHOSEN
}

enum CARD_REWARD_TARGET{
	STACK,
	DISCARD
}

# Change all tiles of a number in tile couples
func ChangeNumber(tileCouples:Array[TileCouple], numberToChange:int, numberToChangeTo:int)->bool:
	var ret = false;
	for couple in tileCouples:
		if couple==null or couple.number==null:continue;
		if(couple.number.number==numberToChange):
			couple.number.UpdateTile(numberToChangeTo);
			ret=true;
			print("Card effect Change Number triggered");
	return ret;

# Change all tiles of an operator in tile couples
func ChangeOperator(tileCouples:Array[TileCouple], opToChange:TileFactory.OperatorTileType, opToChangeTo:TileFactory.OperatorTileType)->bool:
	var ret = false;
	for couple in tileCouples:
		if couple==null or couple.operator==null:continue;
		if(couple.operator.model.operator_type==opToChange):
			couple.operator.UpdateTile(opToChangeTo);
			ret=true;
			print("Card effect Change Number triggered");
	return ret;

func RewardCardForCouple(tileCouples:Array[TileCouple], num:int, op:TileFactory.OperatorTileType, rewardTarget:CARD_REWARD_TARGET, rewardType:CARD_REWARD_TYPE, cardModel:CardModel=null)->bool:
	for couple in tileCouples:
		if couple==null or couple.number==null or couple.operator==null:continue;
		if(couple.operator.model.operator_type==op and couple.number.number==num):
			match(rewardTarget):
				CARD_REWARD_TARGET.STACK:
					if(rewardType==CARD_REWARD_TYPE.RANDOM):
						var modelAdded = CardFactory.AddRandomCardToPlayerStack();
						print("Card effect Reward random card to stack triggered. Added card : "+str(modelAdded.Name));
						return true;
					elif(cardModel!=null):
						CardFactory.AddCardToPlayerStack(cardModel);
						print("Card effect Reward card to stack triggered. Added card : "+str(cardModel.Name));
						return true;
				CARD_REWARD_TARGET.DISCARD:
					if(rewardType==CARD_REWARD_TYPE.RANDOM):
						var modelAdded = CardFactory.AddRandomCardToPlayerDiscard();
						print("Card effect Reward random card to discard triggered. Added card : "+str(modelAdded.Name));
						return true;
					elif(cardModel!=null):
						CardFactory.AddCardToPlayerDiscard(cardModel);
						print("Card effect Reward random card to discard triggered. Added card : "+str(cardModel.Name));
						return true;
	return false;
