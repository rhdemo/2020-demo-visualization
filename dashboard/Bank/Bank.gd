extends Node2D

enum BLDG {Headquarters, Bank, Edge};
onready var routed = preload("res://Bank/on.png")
onready var unrouted = preload("res://Bank/off.png")

export(Vector2) var RADII = Vector2(60, 40)
var topRadii = RADII
export(SpriteFrames) var BldgAnimation
export var BankName = "Bank Name"
export var Network = false
export(BLDG) var Building = BLDG.Bank;
var destination = Vector2()

func _ready():
	$Label.find_node('Name').text = BankName
	$Sprite.frames = BldgAnimation
	match Building:
		0:
			$Label.margin_top = -225
		2:
			$Sprite.scale = Vector2(0.35,0.35)
			RADII = Vector2(40, 25)
	destination = get_parent().position
	$Link.setLinkPoints(self.position, destination, 48, RADII, topRadii, Building != BLDG.Headquarters)
	
#func setLinkPoints():
#	var segments = 20
#	var angle = atan2(destination.y-origin.y, destination.x-origin.x)
#	var pts = PoolVector2Array([])
#	for seg in range(segments):
#		pts.append(Vector2(destination.x+(RADII.x*cos(angle + (2*PI*((1.0+seg)/segments)))), destination.y+(RADII.y*sin(angle + (2*PI*((1.0+seg)/segments))))))
#	if Building != BLDG.Headquarters:
#		pts.append(-Vector2(self.position.x+(topRadii.x*cos(angle)), self.position.y+(topRadii.y*sin(angle))))
#	$Link.clear_points()
#	for pt in pts:
#		$Link.add_point(pt)
#		$Link/DataPath.curve.add_point(pt)

#func on_input_event(camera, event, click_position, click_normal, shape_idx):
#	var mouse_click = event as InputEventMouseButton
#	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
#		toggle_Data()
		#for i in range(5):
		#self.Locale = rng.randi_range(0,2)

func buildEdges(rev=false):
	var edgeCont = find_node('Edges')
	if edgeCont:
		var edges = edgeCont.get_children()
		for edge in edges:
			edge.build(rev)

func _physics_process(delta):
	destination = get_parent().position
	$Link.setLinkPoints(self.position, destination, 48, RADII, topRadii, Building != BLDG.Headquarters)
	if Network:
		$Link.linked = true
		$Label.find_node('Connect').texture = routed
		if Building == BLDG.Edge:
			if $Sprite.animation != "sync" and $Sprite.frame == 42:
				$Sprite.play("sync")
	else:
		$Link.linked = false
		$Label.find_node('Connect').texture = unrouted

func build(rev=false):
	if rev:
		if Building != BLDG.Edge:
			$Tween.interpolate_property($Label, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			buildEdges(rev)
		$Link.linked = false
		Network = false
	else:
		if Building != BLDG.Edge:
			$Tween.interpolate_property($Label, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
			buildEdges()
		else:
			Network = true
		$Link.linked = true
	$Sprite.play("build", rev)
	$Tween.start()
