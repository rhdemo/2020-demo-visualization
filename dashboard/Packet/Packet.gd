extends KinematicBody

export var light_color: Color = Color('13d3d7');

var path = []
var path_ind = 0
const move_speed = 10
onready var nav = get_parent()
func _ready():
	add_to_group("packets")

func _physics_process(delta):
	$Mesh.get_surface_material(0).emission = light_color
	if path_ind < path.size():
		var move_vec = (path[path_ind] - global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			move_and_slide(move_vec.normalized() * move_speed, Vector3(0, 1, 0))
	else:
		self.get_parent().remove_child(self)

func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_ind = 0
