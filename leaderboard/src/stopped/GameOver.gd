extends CenterContainer

export var checkTotals = false
# Replace {YOUR_SERVER_URL} for local dev
var API_URL = JavaScript.eval("window.location.origin+'/api/leaderboard'") if OS.has_feature('JavaScript') else "http://{YOUR_SERVER_URL}/api/leaderboard"

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
