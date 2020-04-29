extends Line2D

export(bool) var linked = false
onready var follow = get_node("DataPath/DataFollow")
onready var follow2 = get_node("DataPath/DataFollow2")
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _process(delta):
	if linked:
		follow.unit_offset += (rng.randf_range(.75, 2) * delta)
		follow2.unit_offset += (rng.randf_range(.15, 1.75) * delta)
		$Tween.interpolate_property(self, "modulate", modulate, Color(1, 1, 1, 1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
	else:
		$Tween.interpolate_property(self, "modulate", modulate, Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()

func setLinkPoints(origin, destination, segments, radii, destRadii, connect=false):
	$DataPath.visible = connect
	var angle = atan2(destination.y-origin.y, destination.x-origin.x)
	var pts = PoolVector2Array([])
	for seg in range(segments):
		pts.append(Vector2(destination.x+(radii.x*cos(angle + (2*PI*((1.0+seg)/segments)))), destination.y+(radii.y*sin(angle + (2*PI*((1.0+seg)/segments))))))
	if connect:
		pts.append(-Vector2(origin.x+(destRadii.x*cos(angle)), origin.y+(destRadii.y*sin(angle))))
	self.clear_points()
	$DataPath.curve.clear_points()
	for pt in pts:
		self.add_point(pt)
		$DataPath.curve.add_point(pt)
