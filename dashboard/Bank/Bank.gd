extends StaticBody

enum LANG {English, Spanish, Japanese};

onready var nav = get_parent().get_parent()
onready var packet = preload("res://Packet/Packet.tscn")
onready var bldg_en = preload("res://Bank/bldg_en.tres")
onready var bldg_es = preload("res://Bank/bldg_es.tres")
onready var bldg_jp = preload("res://Bank/bldg_jp.tres")

export(LANG) var Locale = LANG.English;
export var SpawnPos:Vector3;
const MAX = 10;
var rot = 0.0;
var t = 0.0;
var locales = ["EN","ES","JP","FR","SR"]
var buildings = [];
var rng = RandomNumberGenerator.new()

func _ready():
	connect("input_event", self, "on_input_event")
	SpawnPos = to_global($Spawn.transform.origin)
	buildings = [bldg_en, bldg_es, bldg_jp]
	$Building.mesh = self.buildings[self.Locale];

func on_input_event(camera, event, click_position, click_normal, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		if $Data.is_stopped():
			$Data.start()
		else:
			$Data.stop()
		#$OmniLight.visible = !$OmniLight.visible
		#for i in range(5):
		#self.Locale = rng.randi_range(0,2)

func _physics_process(delta):
	pass

func spawn_packet(dest):
	var destination = get_parent().find_node(dest)
	if destination != self:
		var bit = packet.instance()
		bit.transform.origin = SpawnPos
		rng.randomize()
		bit.light_color = Color(rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0))
		nav.add_child(bit)
		bit.move_to(destination.SpawnPos)


func _on_Data_timeout():
	#rng.randomize()
	#$OmniLight.light_color = Color(rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0),rng.randf_range(0.1, 1.0))
	spawn_packet("HQ")
	#spawn_packet(locales[rng.randi_range(0,4)])
