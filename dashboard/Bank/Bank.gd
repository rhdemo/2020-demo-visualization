extends Area2D

enum BLDG {Headquarters, Bank, Edge};
onready var routed = preload("res://Bank/on.png")
onready var unrouted = preload("res://Bank/off.png")
onready var bankAnimation = preload("res://Bank/BankAnimation.tres")
onready var hqAnimation = preload("res://Bank/HQAnimation.tres")

const MAX = 10;
var rng = RandomNumberGenerator.new()
var built = false
export var BankName = "Bank Name"
export var Network = false
export(BLDG) var Building = BLDG.Bank;


func _ready():
	$Label/LabelBG/Name.text = BankName
	match Building:
		0:
			$Sprite.frames = hqAnimation
			$Label.margin_top = -227
			$Label.margin_bottom = -144
		1:
			$Sprite.frames = bankAnimation
			$Label.margin_top = -185
			$Label.margin_bottom = -103
	
#	connect("input_event", self, "on_input_event")

#func on_input_event(camera, event, click_position, click_normal, shape_idx):
#	var mouse_click = event as InputEventMouseButton
#	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
#		toggle_Data()
		#for i in range(5):
		#self.Locale = rng.randi_range(0,2)

func _physics_process(delta):
	if Network:
		$Label/LabelBG/Connect.texture = routed
	else:
		$Label/LabelBG/Connect.texture = unrouted

func build():
	if $Sprite.frame < 24:
		$Sprite.play("build")
	else:
		$Sprite.play("build", true)

func toggle_Data():
	pass
#	if $Data.is_stopped():
#		$Data.start()
#		$OmniLight.visible = true
#		$DataBits.emitting = true
#		$DataPipe.visible = true
#		$DataBits.draw_pass_1.material.emission = light_color
#	else:
#		$Data.stop()
#		$OmniLight.visible = false
#		$DataBits.emitting = false
#		$DataPipe.visible = false
#

func spawn_packet(dest):
	pass
#	var destination = get_parent().find_node(dest)
#	if destination != self:
#		var bit = packet.instance()
#		bit.transform.origin = SpawnPos
#		rng.randomize()
##		bit.light_color = Color(rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0))
#		bit.light_color = Color('13d3d7')
#		nav.add_child(bit)
#		bit.move_to(destination.SpawnPos)


func _on_Data_timeout():
	#rng.randomize()
	#$OmniLight.light_color = Color(rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0))
	spawn_packet("HQ")
	#spawn_packet(locales[rng.randi_range(0,4)])


func _on_Sprite_animation_finished():
	$Label.visible = !$Label.visible
	if $Label.visible:
		$Label/LabelBG/Connect.texture = routed
	else:
		$Label/LabelBG/Connect.texture = unrouted
