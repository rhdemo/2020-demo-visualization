extends CenterContainer

export var checkTotals = false

var API_URL = JavaScript.eval("window.location.origin+'/api/leaderboard'") if OS.has_feature('JavaScript') else "http://ui-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard"
#var API_URL = "http://ui-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard"

var leaders = []
var board = {}
var correct = 0
var incorrect = 0
var players = 0
var dollars = 0


func _ready():
	$HTTPRequest.request(API_URL)

func _process(delta):
	if checkTotals:
		checkTotals = false
		$HTTPRequest.request(API_URL)
	$Content/TotalContainer/TotalTypesContainer/TotalTypes/Players/Label.text = formatNumber(players)
	$Content/TotalContainer/TotalTypesContainer/TotalTypes/Guesses/Label.text = formatNumber(correct + incorrect)
	$Content/TotalContainer/TotalTypesContainer/TotalTypes/Dollars/Label.text = formatNumber(dollars)

func formatNumber(num):
	var strNum = String(num)
	var delimited = ""
	var idx = len(strNum)
	for i in range(idx):
		if i%3 == 0 and i != 0:
			delimited = "," + delimited
		delimited = strNum[idx-i-1] + delimited
	#print(delimited)
	return String(delimited)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if json.result:
		if "total_players" in json.result:
			players = json.result.total_players
		if "total_rights" in json.result:
			correct = json.result.total_rights
		if "total_wrongs" in json.result:
			incorrect = json.result.total_wrongs
		if "total_dollars" in json.result:
			dollars = json.result.total_dollars
#		if "leaders" in json.result:
#			leaders = json.result.leaders
#		if len(leaders) > 0:
#			var exists = false
#			for current in $Leaders.get_children():
#				exists = false
#				for j in leaders.size():
#					#print(current.Key, " | ", leaders[j].pk)
#					exists = true if current.Key == int(leaders[j].pk) else exists
#				if !exists:
#					board.erase(current.Key)
#					current.offBoard()
#
#			for i in leaders.size():
#				var leader = leaders[i]
#				var av
#				var emote = 0
#				var newRank = i+1
#				if leader.pk in board:
#					av = board[leader.pk]
#					emote = 0 if newRank == av.Rank else 1
#					emote = 2 if newRank > av.Rank else emote
#					av.State = emote
#					av.Rank = newRank
#					av.Eyes = leader.avatar.eyes
#					av.Mouth = leader.avatar.mouth
#					av.Ears = leader.avatar.ears
#					av.Nose = leader.avatar.nose
#					av.Body = leader.avatar.body
#					av.Colors = leader.avatar.color
#					av.NameTxt = leader.username
#					av.NumCorrect = String(leader.right)
#					av.NumIncorrect = String(leader.wrong)
#					av.NumScore = String(leader.score)
#					$Tween.interpolate_property(av, "position", av.position, $Ladder.get_child(i).position, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#					$Tween.start()
#				else:
#					#print("Creating ",leader.id)
#					av = Avatar.instance()
#					#var aui = AvatarUI.instance()
#					emote = 0 if newRank == av.Rank else 1
#					emote = 2 if newRank > av.Rank else emote
#					av.Key = leader.pk
#					av.State = emote
#					av.Eyes = leader.avatar.eyes
#					av.Mouth = leader.avatar.mouth
#					av.Ears = leader.avatar.ears
#					av.Nose = leader.avatar.nose
#					av.Body = leader.avatar.body
#					av.Colors = leader.avatar.color
#					av.Rank = newRank
#					av.NameTxt = leader.username
#					av.NumCorrect = String(leader.right)
#					av.NumIncorrect = String(leader.wrong)
#					av.NumScore = String(leader.score)
#					av.position = $Ladder.get_child(i).position
#					board[leader.pk] = av
#					$Leaders.add_child(av)
#	#				$Leaders.add_child(aui)
#		else:
#			for n in $Leaders.get_children():
#				$Leaders.remove_child(n)
#				n.queue_free()

func parseData(data):
	pass
	
func getData():
	pass
