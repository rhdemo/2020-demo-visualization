extends StaticBody

onready var nav = get_node("/root/Dashboard/Nav")
onready var packet = preload("res://Packet/Packet.tscn")

export var SpawnPos:Vector3;
const MAX = 10;
var locales = ["HQ","EN","ES","JP","FR"]
var rng = RandomNumberGenerator.new()

func _ready():
	connect("input_event", self, "on_input_event")
	SpawnPos = to_global($Spawn.transform.origin)

func on_input_event(camera, event, click_position, click_normal, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		toggle_Data()
		#for i in range(5):
		#self.Locale = rng.randi_range(0,2)

func toggle_Data():
	if $Data.is_stopped():
		$Data.start()
		$OmniLight.visible = true
	else:
		$Data.stop()
		$OmniLight.visible = false

func _physics_process(delta):
	pass

func spawn_packet(dest, light_color):
	var destination = get_parent().find_node(dest)
	if destination != self:
		var bit = packet.instance()
		bit.transform.origin = SpawnPos
		bit.light_color = light_color
		nav.add_child(bit)
		bit.move_to(destination.SpawnPos)


func _on_Data_timeout():
	rng.randomize()
	#var light_color = Color(rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0))
	var light_color = Color("99CCFF")
	#$OmniLight.light_color = light_color
	#spawn_packet("HQ", light_color)
	spawn_packet(locales[rng.randi_range(0,4)], light_color)
