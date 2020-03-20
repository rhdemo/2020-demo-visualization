extends Sprite

enum STATE{
	Resting,
	Happy,
	Sad
}
enum COLOR_SET{
	Red,
	Orange,
	Yellow,
	Green,
	Blue
}
export (STATE) var State = STATE.Resting;
export (COLOR_SET) var colors = COLOR_SET.Blue;


var color_set = [
	PoolColorArray([Color('e800e8'),Color('600068')]),
	PoolColorArray([Color('ff8d8d'),Color('961d1d')]),
	PoolColorArray([Color('ff7c1a'),Color('5b2900')]),
	PoolColorArray([Color('9755ff'),Color('330066')]),
	PoolColorArray([Color('b1e200'),Color('384211')]),
	PoolColorArray([Color('11e500'),Color('01490b')]),
	PoolColorArray([Color('ff1d6f'),Color('5b0d2d')]),
	PoolColorArray([Color('00ffec'),Color('03373a')]),
	PoolColorArray([Color('f90808'),Color('470606')]),
	PoolColorArray([Color('7be6ff'),Color('274b4f')])
]
var body_state = 0;

func _init(data):
	$Eyes.animation = data.avatar.eyes;
	$Eyes.frame = 0;
	$Mouth.animation = data.avatar.mouth;
	$Mouth.frame = 0;
	$Ears.frame = data.avatar.ears;
	$Nose.frame = data.avatar.nose;
	$Body.frame = data.avatar.body;
	$Background.material.set_shader_param("light_color", color_set[data.avatar.color][0]);
	$Background.material.set_shader_param("dark_color", color_set[data.avatar.color][1]);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _on_Area2D_input_event(viewport, event, shape_idx):
#	print("Input Event")
#	RandomNumberGenerator
#	var random_emote = (randi() % 3);
#	var random_color = (randi() % 5);
#	var random_body = (randi() % 5);
#	var random_eye = (randi() % 5);
#	var random_ear = (randi() % 5);
#	var random_nose = (randi() % 5);
#	var random_mouth = (randi() % 5);
#	var mouse_click = event as InputEventMouseButton
#	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
#		self.colors = random_color;
#		$Eyes.animation = str(random_eye);
#		$Eyes.frame = random_emote;
#		$Mouth.animation = str(random_mouth);
#		$Mouth.frame = random_emote;
#		$Ears.frame = random_ear;
#		$Nose.frame = random_nose;
#		$Body.frame = random_body;
#		$Background.material.set_shader_param("light_color", color_set[colors][0]);
#		$Background.material.set_shader_param("dark_color", color_set[colors][1]);
##		self.State = random_emote;
##		self.colors = random_color;
##		self.body_state = random_body;
