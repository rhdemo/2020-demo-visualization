extends Node2D
# http://leaderboard-aggregator-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard

var API_URL = JavaScript.eval("window.location.hostname+'/api/leaderboard'") if OS.has_feature('JavaScript') else "http://127.0.0.1:8080/api/leaderboard"

#light #ffcc00
#Dark #000000
var Avatar = preload("res://avatars/Avatar.tscn");
#var AvatarUI = preload("res://avatars/AvatarUI.tscn");

var leaders = []
var board = {}
var correct = 0
var incorrect = 0
#var guesses = 0
var players = 0
var dollars = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request(API_URL)
	

func _on_Data_timeout():
	$HTTPRequest.request(API_URL)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)
	if "total_players" in json.result:
		players = json.result.total_players
	if "total_rights" in json.result:
		correct = json.result.total_rights
	if "total_wrongs" in json.result:
		incorrect = json.result.total_wrongs
	if "total_dollars" in json.result:
		dollars = json.result.total_dollars
	if "leaders" in json.result:
		leaders = json.result.leaders
	if len(leaders) > 0:
		var exists = false
		for current in $Leaders.get_children():
			exists = false
			for j in leaders.size():
				#print(current.Key, " | ", leaders[j].pk)
				exists = true if current.Key == int(leaders[j].pk) else exists
			if !exists:
				board.erase(current.Key)
				current.offBoard()
		
		for i in leaders.size():
			var leader = leaders[i]
			var av
			var emote = 0
			var newRank = i+1
			if leader.pk in board:
				#print(leader.id, " exists!")
				av = board[leader.pk]
				emote = 0 if newRank == av.Rank else 1
				emote = 2 if newRank > av.Rank else emote
				av.State = emote
				av.Rank = newRank
				av.Eyes = leader.avatar.eyes
				av.Mouth = leader.avatar.mouth
				av.Ears = leader.avatar.ears
				av.Nose = leader.avatar.nose
				av.Body = leader.avatar.body
				av.Colors = leader.avatar.color
				av.NameTxt = leader.username
				av.NumCorrect = String(leader.right)
				av.NumIncorrect = String(leader.wrong)
				av.NumScore = String(leader.score)
				$Tween.interpolate_property(av, "position", av.position, $Ladder.get_child(i).position, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
			else:
				#print("Creating ",leader.id)
				av = Avatar.instance()
				#var aui = AvatarUI.instance()
				emote = 0 if newRank == av.Rank else 1
				emote = 2 if newRank > av.Rank else emote
				av.Key = leader.pk
				av.State = emote
				av.Eyes = leader.avatar.eyes
				av.Mouth = leader.avatar.mouth
				av.Ears = leader.avatar.ears
				av.Nose = leader.avatar.nose
				av.Body = leader.avatar.body
				av.Colors = leader.avatar.color
				av.Rank = newRank
				av.NameTxt = leader.username
				av.NumCorrect = String(leader.right)
				av.NumIncorrect = String(leader.wrong)
				av.NumScore = String(leader.score)
				av.position = $Ladder.get_child(i).position
				board[leader.pk] = av
				$Leaders.add_child(av)
#				$Leaders.add_child(aui)
	else:
		for n in $Leaders.get_children():
			$Leaders.remove_child(n)
			n.queue_free()

func parseData(data):
	pass
	
func getData():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UICont/UIBox/UI/PlayerBox/Guessers.text = String(players)
	$UICont/UIBox/UI/GuessBox/Guesses.text = String(correct + incorrect)
	$UICont/UIBox/UI/DollarBox/Dollars.text = String(dollars)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

#[
#  {
#    "avatar": {
#      "body": 1,
#      "color": 2,
#      "ears": 0,
#      "eyes": 1,
#      "mouth": 1,
#      "nose": 0
#    },
#    "creationServer": "SFO",
#    "gameId": "63efa6c6-6b58-4737-9718-80c1d0aaf8ae",
#    "gameServer": "SFO",
#    "id": "Navy Touch",
#    "right": 15,
#    "score": 360,
#    "scoringServer": "UNKN",
#    "username": "Navy Touch",
#    "wrong": 22
#  },
#  {
#    "avatar": {
#      "body": 1,
#      "color": 2,
#      "ears": 1,
#      "eyes": 1,
#      "mouth": 3,
#      "nose": 1
#    },
#    "creationServer": "SFO",
#    "gameId": "63efa6c6-6b58-4737-9718-80c1d0aaf8ae",
#    "gameServer": "SFO",
#    "id": "Beryl Shield",
#    "right": 6,
#    "score": 100,
#    "scoringServer": "UNKN",
#    "username": "Beryl Shield",
#    "wrong": 0
#  }
#]

