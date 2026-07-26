class_name Card_AddCardForCouple extends CardModelSubmit
# Card that will reward a random card if a certain couple is found
# Can choose between the stack and the discard AND if the card is random or not

@export var Num : int;
@export var Op : TileFactory.OperatorTileType;
@export var RewardType : CardEffects.CARD_REWARD_TYPE;
@export var RewardTarget : CardEffects.CARD_REWARD_TARGET;
@export var CardReward : CardModel=null;

func TriggerCardEffect(tileCouples : Array[TileCouple])->bool:
	print("Attempting to trigger card reward ");
	return CardEffects.RewardCardForCouple(tileCouples, Num, Op, RewardTarget, RewardType, CardReward);
