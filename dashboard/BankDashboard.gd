extends Node2D

var wide_zoom = Vector2(3.0, 3.0)
var narrow_zoom = Vector2(.9,.9)
var zoom_time = 1
var move_time = 1
var edge_scale = 0.35
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
		if event.pressed and event.scancode == KEY_UP:
			$Tween.interpolate_property($HQ/Edges/Edge1.get_node("Sprite"), "scale", $HQ/Edges/Edge1.get_node("Sprite").scale, Vector2(1.0,1.0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			for bank in $HQ/Banks.get_children():
				for edge in bank.get_node("Edges").get_children():
					$Tween.interpolate_property(edge.get_node("Sprite"), "scale", edge.get_node("Sprite").scale, Vector2(1.0,1.0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		if event.pressed and event.scancode == KEY_DOWN:
			$Tween.interpolate_property($HQ/Edges/Edge1.get_node("Sprite"), "scale", $HQ/Edges/Edge1.get_node("Sprite").scale, Vector2(edge_scale,edge_scale), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			for bank in $HQ/Banks.get_children():
				for edge in bank.get_node("Edges").get_children():
					$Tween.interpolate_property(edge.get_node("Sprite"), "scale", edge.get_node("Sprite").scale, Vector2(edge_scale,edge_scale), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
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
		0: #Opening Global Map
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			if reverse:
				$HQ.build(reverse)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
		1: #Zoom to HQ
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if !reverse:
				$HQ.build()
				$HQ.Network = true
			else:
				$HQ/Banks/London.build(reverse)
		2: #Pan to London
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/London.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if !reverse:
				$HQ/Banks/London.build()
				$HQ/Banks/London.Network = true
			else:
				$HQ/Banks/Sydney.build(reverse)
		3: #Pan to Sydney
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Sydney.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if !reverse:
				$HQ/Banks/Sydney.build()
				$HQ/Banks/Sydney.Network = true
			else:
				$HQ/Banks/Singapore.build(reverse)
		4: #Pan to Singapore
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Singapore.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if !reverse:
				$HQ/Banks/Singapore.build()
				$HQ/Banks/Singapore.Network = true
			else:
				$HQ/Banks/SanFrancisco.build(reverse)
		5: #Pan to SF
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/SanFrancisco.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if !reverse:
				$HQ/Banks/SanFrancisco.build()
				$HQ/Banks/SanFrancisco.Network = true
			else:
				$HQ/Banks/SaoPaulo.build(reverse)
		6: #Pan to SaoPaulo
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/SaoPaulo.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if !reverse:
				$HQ/Banks/SaoPaulo.build()
				$HQ/Banks/SaoPaulo.Network = true
			else:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		7: #Global Map
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			if reverse:
				$HQ/Banks/Frankfurt.build(reverse)
		8: #Zoom and Build Frankfurt
			if !reverse:
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Frankfurt.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
				$HQ/Banks/Frankfurt.build()
				$HQ/Banks/Frankfurt.Network = true
			if reverse:
				$HQ/Banks/London.Network = true
				for edge in ldnEdges:
					$HQ/Banks/Frankfurt/Edges.remove_child(edge)
					$HQ/Banks/London/Edges.add_child(edge)
					edge.position = edge.position - ($HQ/Banks/London/Edges.global_position - $HQ/Banks/Frankfurt/Edges.global_position)
		9: #Disconnect London
			if !reverse:
				$HQ/Banks/London.Network = false
				for edge in ldnEdges:
					$HQ/Banks/London/Edges.remove_child(edge)
					$HQ/Banks/Frankfurt/Edges.add_child(edge)
					edge.position = edge.position + ($HQ/Banks/London/Edges.global_position - $HQ/Banks/Frankfurt/Edges.global_position)
			if reverse:
				$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, narrow_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $HQ/Banks/Frankfurt.global_position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
		10: #Global View
			$Tween.interpolate_property($FocalPoint, "position", $FocalPoint.position, $CenterPoint.position, move_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($FocalPoint/Cam, "zoom", $FocalPoint/Cam.zoom, wide_zoom, zoom_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
