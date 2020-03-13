extends Node2D
# http://leaderboard-aggregator-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Avatar = load("res://avatars/Avatar.tscn")
var color_set = [
	PoolColorArray([Color('e800e8'),Color('600068')]),
	PoolColorArray([Color('ff7c1a'),Color('5b2900')]),
	PoolColorArray([Color('9755ff'),Color('330066')]),
	PoolColorArray([Color('11e500'),Color('01490b')]),
	PoolColorArray([Color('7be6ff'),Color('274b4f')])
]


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request("http://127.0.0.1:8080/")

func _on_Data_timeout():
	$HTTPRequest.request("http://127.0.0.1:8080/")
	#$HTTPRequest.request("http://leaderboard-aggregator-leaderboard.apps.summit-hq1.openshift.redhatkeynote.com/api/leaderboard")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	for n in $Leaders.get_children():
		$Leaders.remove_child(n)
		n.queue_free()
	var idx = 0
	for pnt in $Ladder.get_children():
		if idx < json.result.size():
			var a = Avatar.instance()
			var data = json.result[idx]
			a.get_node('Eyes').animation = String(data.avatar.eyes);
			a.get_node('Eyes').frame = 0;
			a.get_node('Mouth').animation = String(data.avatar.mouth);
			a.get_node('Mouth').frame = 0;
			a.get_node('Ears').frame = int(data.avatar.ears);
			a.get_node('Nose').frame = int(data.avatar.nose);
			a.get_node('Body').frame = int(data.avatar.body);
			a.get_node('Background').material.set_shader_param("light_color", color_set[data.avatar.color][0]);
			a.get_node('Background').material.set_shader_param("dark_color", color_set[data.avatar.color][1]);
			print("Position: ", pnt)
			a.position = pnt.position
			$Leaders.add_child(a)
			idx = idx + 1


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

