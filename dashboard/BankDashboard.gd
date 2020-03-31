extends Node2D

var wide_zoom = Vector2(3.0, 3.0)
var narrow_zoom = Vector2(0.75,0.75)
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
		if event.pressed and event.scancode == KEY_RIGHT:
			if(scene < 10):
				scene = scene + 1
				run_scene(scene, false)
		if event.pressed and event.scancode == KEY_LEFT:
			if(scene > 0):
				scene = scene - 1
				run_scene(scene, true)
#		if event.pressed and event.scancode == KEY_1:
#			pass
#		if event.pressed and event.scancode == KEY_2:
#			$HQ.play("build",true)
#		if event.pressed and event.scancode == KEY_3:
#			$London.play("build")
#		if event.pressed and event.scancode == KEY_4:
#			$London.play("build",true)
#		if event.pressed and event.scancode == KEY_SPACE:
#			if $FocalPoint/Cam.zoom == wide_zoom:
#				$Tween.interpolate_property($FocalPoint/Cam, "zoom", wide_zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#			else:
#				$Tween.interpolate_property($FocalPoint/Cam, "zoom", narrow_zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#			$Tween.start()
#		if event.pressed and event.scancode == KEY_X:
#			pass
#		

func run_scene(scene,reverse):
	match scene:
		0:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			if reverse:
				$HQ.build()
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		1:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ.build()
			$HQ.Network = true
			if reverse:
				$London.build()
		2:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $London.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$London.build()
			$London.Network = true
			if reverse:
				$Sydney.build()
		3:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $Sydney.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Sydney.build()
			$Sydney.Network = true
			if reverse:
				$Singapore.build()
		4:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $Singapore.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$Singapore.build()
			$Singapore.Network = true
			if reverse:
				$SanFrancisco.build()
		5:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $SanFrancisco.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$SanFrancisco.build()
			$SanFrancisco.Network = true
			if reverse:
				$SaoPaulo.build()
		6:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $SaoPaulo.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$SaoPaulo.build()
			$SaoPaulo.Network = true
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		7:
			if !reverse:
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
			if reverse:
				$Frankfurt.build()
		8:
			if !reverse:
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $Frankfurt.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
				$Frankfurt.build()
				$Frankfurt.Network = true
			if reverse:
				$London.Network = true
		9:
			if !reverse:
				$London.Network = false
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		10:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
