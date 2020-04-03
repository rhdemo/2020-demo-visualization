extends Node2D

enum BLDG {Headquarters, Bank, Edge};
onready var routed = preload("res://Bank/on.png")
onready var unrouted = preload("res://Bank/off.png")

const MAX = 10;
var rng = RandomNumberGenerator.new()
var built = false
export(SpriteFrames) var BldgAnimation
export var BankName = "Bank Name"
export var Network = false
export(BLDG) var Building = BLDG.Bank;
export(Color) var BldgColor = Color('cccccc')
var glblPos = Vector2()

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


func _ready():
	glblPos = self.global_position
	$Label.find_node('Name').text = BankName
	$Sprite.frames = BldgAnimation
	match Building:
		0:
			$Label.margin_top = -240
			$Label.margin_bottom = -130
			$Sprite.modulate = BldgColor
			$Link.visible = false
		1:
			$Sprite.modulate = BldgColor
			$Link.add_point(get_parent().position)
			$Link.add_point(-self.position)
			#$Link.default_color = Color('f90808')
			#$Link.width = 20
		2:
			$Sprite.scale = Vector2(1.0,1.0)
			$Link.add_point(get_parent().position+Vector2(0,-10.0))
			$Link.add_point(-self.position)
			#$Link.default_color = Color('7be6ff')
			$Orbit.scale = Vector2(0.25,0.25)
			$Orbit.position = Vector2(-4, -7)
	
	
#	connect("input_event", self, "on_input_event")

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
	match Building:
		0:
			$Label.find_node('Connect').texture = routed
		1:
			$Link.points[0] = get_parent().position
			$Link.points[1] = -self.position
			if Network:
				$Link.visible = true
				$Orbit.visible = true
				$Label.find_node('Connect').texture = routed
			else:
				$Link.visible = false
				$Orbit.visible = false
				$Label.find_node('Connect').texture = unrouted
		2:
			$Link.points[0] = get_parent().position+Vector2(0,-10.0)
			$Link.points[1] = -self.position
			if Network:
				$Link.visible = true
				$Orbit.visible = true
				$Label.find_node('Connect').texture = routed
			else:
				$Link.visible = false
				$Orbit.visible = false
				$Label.find_node('Connect').texture = unrouted

		

func build(rev=false):
	$Sprite.play("build", rev)
	if Building != BLDG.Edge:
		buildEdges(rev)
	if rev:
		if Building != BLDG.Edge:
			$Tween.interpolate_property($Label, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.interpolate_property($Link, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.interpolate_property($Orbit, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	else:
		if Building != BLDG.Edge:
			$Tween.interpolate_property($Label, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.interpolate_property($Link, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.interpolate_property($Orbit, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

func _on_Sprite_animation_finished():
	if Building == BLDG.Edge:
		Network = true
