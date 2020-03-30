extends Node2D

var wide_zoom = Vector2(2.5, 2.5)
var narrow_zoom = Vector2(0.5,0.5)
var zoom_time = 1
var move_time = 1
var scene = 0

#WS URL ws://ui-admin-hq.apps.summit-hq1.openshift.redhatkeynote.com/socket

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.pressed and event.scancode == KEY_1:
			pass
		if event.pressed and event.scancode == KEY_2:
			$HQ.play("build",true)
		if event.pressed and event.scancode == KEY_3:
			$London.play("build")
		if event.pressed and event.scancode == KEY_4:
			$London.play("build",true)
		if event.pressed and event.scancode == KEY_SPACE:
			if $FocalPoint/Cam.zoom == wide_zoom:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", wide_zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			else:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", narrow_zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		if event.pressed and event.scancode == KEY_X:
			pass
		if event.pressed and event.scancode == KEY_RIGHT:
			if(scene < 10):
				scene = scene + 1
				run_scene(scene, false)
		if event.pressed and event.scancode == KEY_LEFT:
			if(scene > 0):
				scene = scene - 1
				run_scene(scene, true)

func run_scene(scene,reverse):
	match scene:
		0:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			if reverse:
				$HQ.play("build",true)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		1:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ.play("build")
			if reverse:
				$London.play("build",true)
		2:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $London.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$London.play("build")
			if reverse:
				$Sydney.play("build",true)
		3:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $Sydney.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Sydney.play("build")
			if reverse:
				$Singapore.play("build",true)
		4:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $Singapore.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Singapore.play("build")
			if reverse:
				$SanFrancisco.play("build",true)
		5:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $SanFrancisco.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$SanFrancisco.play("build")
			if reverse:
				$SaoPaulo.play("build",true)
		6:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $SaoPaulo.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$SaoPaulo.play("build")
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		7:
			if !reverse:
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
			if reverse:
				$Frankfurt.play("build",true)
		8:
			if !reverse:
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $Frankfurt.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
				$Frankfurt.play("build")	
			if reverse:
				$London.play("build")
		9:
			if !reverse:
				$London.play("build", true)
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		10:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
