extends Node2D

enum BLDG {Headquarters, Bank, Edge};
onready var routed = preload("res://assets/textures/on.png")
onready var unrouted = preload("res://assets/textures/off.png")

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
