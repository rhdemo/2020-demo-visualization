extends Node2D

enum STATE{ Resting, Happy, Sad }
enum COLOR_SET{ HotPink, Gold, Orange, Purple, LightGreen, Green, Pink, Aqua, Red, Blue }

export var Key = 0;
export var Eyes = 0;
export var Mouth = 0;
export var Ears = 0;
export var Nose = 0;
export var Body = 0;
export var Rank = 24;
export var NumCorrect = 0;
export var NumIncorrect = 0;
export var NumScore = 0;
export var NameTxt = "Lando Calrissian";

export (STATE) var State = STATE.Resting;
export (COLOR_SET) var Colors = COLOR_SET.Blue;

var color_set = [
	PoolColorArray([Color('e800e8'),Color('600068')]),
	PoolColorArray([Color('00cc99'),Color('000000')]),
	PoolColorArray([Color('ff7c1a'),Color('5b2900')]),
	PoolColorArray([Color('9755ff'),Color('330066')]),
	PoolColorArray([Color('b1e200'),Color('384211')]),
	PoolColorArray([Color('11e500'),Color('01490b')]),
	PoolColorArray([Color('ff1d6f'),Color('5b0d2d')]),
	PoolColorArray([Color('00ffec'),Color('03373a')]),
	PoolColorArray([Color('f90808'),Color('470606')]),
	PoolColorArray([Color('7be6ff'),Color('274b4f')])
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$RankImg/Rank.text = String(Rank)
	$Eyes.frame = State
	$Mouth.frame = State
	$Eyes.animation = String(Eyes)
	$Mouth.animation = String(Mouth)
	$Ears.frame = Ears
	$Nose.frame = Nose
	$Body.frame = Body
	$Background.material.set_shader_param("light_color", color_set[Colors][0]);
	$Background.material.set_shader_param("dark_color", color_set[Colors][1]);
	$AvatarUIContainer/AvatarGuessContainer/CorrectContainer/CorrectPanel/CorrectMargins/Correct.text = NumCorrect
	$AvatarUIContainer/AvatarGuessContainer/IncorrectContainer/IncorrectPanel/IncorrectMargins/Incorrect.text = NumIncorrect
	$AvatarUIContainer/ScoreContainer/ScorePanel/Score.text = NumScore
	$AvatarUIContainer/NameContainer/Name.text = NameTxt

func _process(delta):
	if Rank == 1:
		$RankImg.visible = false
		$Crown.visible = true
		State = STATE.Happy
	else:
		$RankImg.visible = true
		$Crown.visible = false
	$RankImg/Rank.text = String(Rank)
	$Eyes.frame = State
	$Mouth.frame = State
	$Eyes.animation = String(Eyes)
	$Mouth.animation = String(Mouth)
	$Ears.frame = Ears
	$Nose.frame = Nose
	$Body.frame = Body
	$Background.material.set_shader_param("light_color", color_set[Colors][0]);
	$Background.material.set_shader_param("dark_color", color_set[Colors][1]);
	$AvatarUIContainer/AvatarGuessContainer/CorrectContainer/CorrectPanel/CorrectMargins/Correct.text = NumCorrect
	$AvatarUIContainer/AvatarGuessContainer/IncorrectContainer/IncorrectPanel/IncorrectMargins/Incorrect.text = NumIncorrect
	$AvatarUIContainer/ScoreContainer/ScorePanel/Score.text = NumScore
	$AvatarUIContainer/NameContainer/Name.text = NameTxt

func offBoard():
	$Tween.interpolate_property($Background, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Nose, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Eyes, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Body, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Ears, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Mouth, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($RankImg, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AvatarUIContainer, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Crown, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$Smoke.visible = true
	$Smoke.play()

func _on_Smoke_animation_finished():
	get_parent().remove_child(self)
	queue_free()
