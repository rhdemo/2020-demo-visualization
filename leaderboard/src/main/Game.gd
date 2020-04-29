extends Node2D

var ws = WebSocketClient.new()
var _write_mode = WebSocketPeer.WRITE_MODE_TEXT
var retryTimeout = 5 # seconds
# Replace {YOUR_SERVER_URL} for local dev
var wsUrlStr: String = JavaScript.eval("window.location.hostname+'/socket'") if OS.has_feature('JavaScript') else "ws://{YOUR_SERVER_URL}/socket"
var Lobby = preload("res://src/lobby/Lobby.tscn");
var Leaderboard = preload("res://src/leaderboard/LeaderBoard.tscn");
var Paused = preload("res://src/paused/Paused.tscn");
var Stopped = preload("res://src/stopped/Stopped.tscn");

# Replace {YOUR_SERVER_URL} for local dev
var WS_URL = wsUrlStr if wsUrlStr.length() > 0 else "ws://{YOUR_SERVER_URL}/socket"

func _init():
	self._connect()

func _ready():
	pass # Replace with function body.

func _process(delta):
	if ws.get_connection_status() == ws.CONNECTION_CONNECTING || ws.get_connection_status() == ws.CONNECTION_CONNECTED:
		ws.poll()

func _connect():
	ws.connect("connection_established", self, "_connection_established")
	ws.connect("connection_closed", self, "_connection_closed")
	ws.connect("connection_error", self, "_connection_error")
	ws.connect("data_received", self, "_handle_data_received")

	print("Connecting to " + WS_URL)
	ws.connect_to_url(WS_URL)

func decode_data(data):
	return data.get_string_from_utf8()

func _handle_data_received():
	var res = JSON.parse(decode_data(ws.get_peer(1).get_packet())).result
	if 'game' in res:
		if 'state' in res.game:
			showScene(res.game.state)

func _connection_established(protocol):
	ws.get_peer(1).set_write_mode(_write_mode)
	send('{"type":"init"}')
	print("Connection established with protocol: ", protocol)

func _connection_closed(clean):
	print("Connection closed, retrying in %ds" % retryTimeout)
	$connection.start()

func _connection_error():
	print("Connection error, retrying in %ds" % retryTimeout)
	$connection.start()

func send(data):
	ws.get_peer(1).set_write_mode(_write_mode)
	ws.get_peer(1).put_packet(data.to_utf8())

func _on_connection_timeout():
	$connection.wait_time *= 2
	self._connect()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func showScene(sceneName="lobby"):
	if sceneName in ["lobby","active","paused","stopped"]:
		pass
	else:
		sceneName = "active"
	if sceneName == "stopped":
		$Scenes/stopped/Viewport/Stopped.checkTotals = true
	for sc in $Scenes.get_children():
		if sc.name != sceneName:
			sc.visible = false
		else:
			sc.visible = true

func _on_Lobby_pressed():
	showScene("lobby")

func _on_Game_pressed():
	showScene("active")

func _on_Pause_pressed():
	showScene("paused")

func _on_Stop_pressed():
	$Scenes/stopped/Viewport/Stopped.checkTotals = true
	showScene("stopped")
