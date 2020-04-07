extends Node2D

export var NumCorrect = 0;
export var NumIncorrect = 0;
export var NumScore = 0;
export var NameTxt = "Lando Calrissian";

# Called when the node enters the scene tree for the first time.
func _ready():
	$AvatarUIContainer/AvatarGuessContainer/CorrectContainer/CorrectPanel/CorrectMargins/Correct.text = NumCorrect
	$AvatarUIContainer/AvatarGuessContainer/IncorrectContainer/IncorrectPanel/IncorrectMargins/Incorrect.text = NumIncorrect
	$AvatarUIContainer/ScoreContainer/ScorePanel/Score.text = NumScore
	$AvatarUIContainer/NameContainer/Name.text = NameTxt

func _process(delta):
	$AvatarUIContainer/AvatarGuessContainer/CorrectContainer/CorrectPanel/CorrectMargins/Correct.text = NumCorrect
	$AvatarUIContainer/AvatarGuessContainer/IncorrectContainer/IncorrectPanel/IncorrectMargins/Incorrect.text = NumIncorrect
	$AvatarUIContainer/ScoreContainer/ScorePanel/Score.text = NumScore
	$AvatarUIContainer/NameContainer/Name.text = NameTxt
