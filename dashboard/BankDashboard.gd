extends Node2D

var wide_zoom = Vector2(3.0, 3.0)
var narrow_zoom = Vector2(0.75,0.75)
var zoom_time = 1
var move_time = 1
var scene = 0
var ldnEdges


#WS URL ws://ui-admin-hq.apps.summit-hq1.openshift.redhatkeynote.com/socket

func _ready():
	 ldnEdges = $HQ/Banks/London/Edges.get_children()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.pressed and event.scancode == KEY_RIGHT:
			if(scene < 12):
				scene = scene + 1
				run_scene(scene, false)
		if event.pressed and event.scancode == KEY_LEFT:
			if(scene > 0):
				scene = scene - 1
				run_scene(scene, true)
#		if event.pressed and event.scancode == KEY_SPACE:
#			$SanFrancisco/Edge1.build()
#			$SanFrancisco/Edge2.build()
#			$SanFrancisco/Edge3.build()
#		if event.pressed and event.scancode == KEY_1:
#			pass
#		if event.pressed and event.scancode == KEY_2:
#			$HQ.play("build",true)
#		if event.pressed and event.scancode == KEY_3:
#			$London.play("build")
#		if event.pressed and event.scancode == KEY_4:
#			$London.play("build",true)
#		if event.pressed and event.scancode == KEY_X:
#			pass
#		

func run_scene(scene,reverse):
	match scene:
		0:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			if reverse:
				$HQ.build(reverse)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		1:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ.build()
			$HQ.buildEdges()
			$HQ.Network = true
			if reverse:
				$HQ/Banks/London.build(reverse)
		2:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/London.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ/Banks/London.build()
			$HQ/Banks/London.buildEdges()
			$HQ/Banks/London.Network = true
			if reverse:
				$HQ/Banks/Sydney.build(reverse)
		3:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Sydney.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ/Banks/Sydney.build()
			$HQ/Banks/Sydney.buildEdges()
			$HQ/Banks/Sydney.Network = true
			if reverse:
				$HQ/Banks/Singapore.build(reverse)
		4:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Singapore.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ/Banks/Singapore.build()
			$HQ/Banks/Singapore.buildEdges()
			$HQ/Banks/Singapore.Network = true
			if reverse:
				$HQ/Banks/SanFrancisco.build(reverse)
		5:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/SanFrancisco.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ/Banks/SanFrancisco.build()
			$HQ/Banks/SanFrancisco.buildEdges()
			$HQ/Banks/SanFrancisco.Network = true
			if reverse:
				$HQ/Banks/SaoPaulo.build(reverse)
		6:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/SaoPaulo.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$HQ/Banks/SaoPaulo.build()
			$HQ/Banks/SaoPaulo.buildEdges()
			$HQ/Banks/SaoPaulo.Network = true
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		7:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if reverse:
				$HQ/Banks/SanFrancisco.buildEdges(reverse)
		8:
			if !reverse:
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Frankfurt.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
				$HQ/Banks/Frankfurt.build()
				$HQ/Banks/Frankfurt.buildEdges()
				$HQ/Banks/Frankfurt.Network = true
			if reverse:
				$HQ/Banks/London.Network = true
				for edge in ldnEdges:
					$HQ/Banks/Frankfurt/Edges.remove_child(edge)
					$HQ/Banks/London/Edges.add_child(edge)
					edge.position = edge.position - ($HQ/Banks/London/Edges.global_position - $HQ/Banks/Frankfurt/Edges.global_position)
		9:
			if !reverse:
				$HQ/Banks/London.Network = false
				for edge in ldnEdges:
					$HQ/Banks/London/Edges.remove_child(edge)
					$HQ/Banks/Frankfurt/Edges.add_child(edge)
					edge.position = edge.position + ($HQ/Banks/London/Edges.global_position - $HQ/Banks/Frankfurt/Edges.global_position)
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		10:
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
