extends Node2D
# http://leaderboard-aggregator-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard

#const API_URL = 'http://127.0.0.1:8080'
const API_URL = 'http://ui-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard';

#light #ffcc00
#Dark #000000
var Avatar = load("res://avatars/Avatar.tscn")
var AvatarUI = load("res://avatars/AvatarUI.tscn")
var color_set = [
	PoolColorArray([Color('e800e8'),Color('600068')]),
	PoolColorArray([Color('ffcc00'),Color('000000')]),
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
	#$HTTPRequest.request("http://127.0.0.1:8080")
	$HTTPRequest.request(API_URL)
	

func _on_Data_timeout():
	#$HTTPRequest.request("http://127.0.0.1:8080")
	$HTTPRequest.request(API_URL)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	if len(json.result) > 0:
		for n in $Leaders.get_children():
			$Leaders.remove_child(n)
			n.queue_free()
		var idx = 0
		for pnt in $Ladder.get_children():
			if idx < json.result.size():
				var a = Avatar.instance()
				var aui = AvatarUI.instance()
				var data = json.result[idx]
				var emote = 0 if idx > 2 else 1
				emote = 2 if idx > 5 else emote
				a.get_node('Eyes').animation = String(data.avatar.eyes);
				a.get_node('Eyes').frame = emote;
				a.get_node('Mouth').animation = String(data.avatar.mouth);
				a.get_node('Mouth').frame = emote;
				a.get_node('Ears').frame = int(data.avatar.ears);
				a.get_node('Nose').frame = int(data.avatar.nose);
				a.get_node('Body').frame = int(data.avatar.body);
				a.get_node('Background').material.set_shader_param("light_color", color_set[data.avatar.color][0]);
				a.get_node('Background').material.set_shader_param("dark_color", color_set[data.avatar.color][1]);
				aui.get_node('AvatarUIContainer/NameContainer/Name').text = data.username
				aui.get_node('AvatarUIContainer/AvatarGuessContainer/CorrectContainer/CorrectPanel/CorrectMargins/Correct').text = String(data.right)
				aui.get_node('AvatarUIContainer/AvatarGuessContainer/IncorrectContainer/IncorrectPanel/IncorrectMargins/Incorrect').text = String(data.wrong)
				aui.get_node('AvatarUIContainer/ScoreContainer/ScorePanel/Score').text = String(data.score)
				aui.position = pnt.position
				a.position.x = pnt.position.x + 200
				a.position.y = pnt.position.y + 35
				a.scale.x = 0.18
				a.scale.y = 0.18
				aui.scale.x = 0.25
				aui.scale.y = 0.25
				aui.z_index = 1
				$Leaders.add_child(a)
				$Leaders.add_child(aui)
				idx = idx + 1
	else:
		for n in $Leaders.get_children():
			$Leaders.remove_child(n)
			n.queue_free()


func parseData(data):
	pass
	
func getData():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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

