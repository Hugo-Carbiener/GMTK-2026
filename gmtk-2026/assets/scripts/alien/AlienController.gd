class_name AlienController extends Node2D
# Controls the alien

@export var Aliens : Dictionary[int, AnimatedSprite2D];
var _currentAlien : AnimatedSprite2D;
var _randomNumberGenerator = RandomNumberGenerator.new();

enum ALIEN_MOOD{
	IDLE,
	VICTORY,
	DEFEAT	
};

func _ready()->void:
	var rng = _randomNumberGenerator.randi_range(0, Aliens.size()-1);
	SignalBus.on_win.connect(ChangeAlienAnimation.bind(ALIEN_MOOD.DEFEAT));
	SignalBus.on_loss.connect(ChangeAlienAnimation.bind(ALIEN_MOOD.VICTORY));
	DeactivateAllAliens();
	ActivateAlien(Aliens.keys()[rng]);

func DeactivateAllAliens()->void:
	for alien in Aliens:
		Aliens[alien].visible = false;
	return;

func ActivateAlien(alienKey:int)->void:
	Aliens[alienKey].visible=true;
	_currentAlien=Aliens[alienKey];
	ChangeAlienAnimation(ALIEN_MOOD.IDLE);
	return;

func ChangeAlienAnimation(mood:ALIEN_MOOD)->void:
	match(mood):
		ALIEN_MOOD.IDLE:
			_currentAlien.play("idle");
		ALIEN_MOOD.VICTORY:
			_currentAlien.play("victory");
		ALIEN_MOOD.DEFEAT:
			_currentAlien.play("defeat");
