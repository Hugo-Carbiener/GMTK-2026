class_name AlienController extends TextureRect
# Controls the alien

enum ALIEN_MOOD{
	IDLE,
	VICTORY,
	DEFEAT	
};

func ChangeAlienAnimation(mood:ALIEN_MOOD)->void:
	match(mood):
		ALIEN_MOOD.IDLE:
			print("idle");
		ALIEN_MOOD.VICTORY:
			print("vic");
		ALIEN_MOOD.DEFEAT:
			print("defeat");
		
