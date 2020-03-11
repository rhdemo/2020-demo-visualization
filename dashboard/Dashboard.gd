extends Spatial


func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.pressed and event.scancode == KEY_1:
			$Camera.set_target($Scene1)
			$Nav/NavMesh/HQ/OmniLight.visible = true
			$Nav/NavMesh/HQ/DataBits.emitting = true
			$Nav/NavMesh/HQ/DataPipe.visible = true
		if event.pressed and event.scancode == KEY_2:
			$Camera.set_target($Scene2)
#			$Nav/NavMesh/edge1.toggle_Data()
#			$Nav/NavMesh/edge2.toggle_Data()
#			$Nav/NavMesh/edge3.toggle_Data()
		if event.pressed and event.scancode == KEY_3:
			$Camera.set_target($Scene3)
#			$Nav/NavMesh/edge4.toggle_Data()
#			$Nav/NavMesh/edge5.toggle_Data()
#			$Nav/NavMesh/edge6.toggle_Data()
		if event.pressed and event.scancode == KEY_4:
			$Camera.set_target($Scene4)
		if event.pressed and event.scancode == KEY_SPACE:
			$Nav/NavMesh/EN.toggle_Data()
			$Nav/NavMesh/JP.toggle_Data()
			$Nav/NavMesh/ES.toggle_Data()
			$Nav/NavMesh/FR.toggle_Data()
			$Nav/NavMesh/UK.toggle_Data()
			$Nav/NavMesh/SP.toggle_Data()
		if event.pressed and event.scancode == KEY_X:
			$Nav/NavMesh/UK.toggle_Data()
			$Nav/NavMesh/EN/DataBits.amount = 100
			$Nav/NavMesh/JP/DataBits.amount = 100
			$Nav/NavMesh/ES/DataBits.amount = 100
			$Nav/NavMesh/FR/DataBits.amount = 100
			$Nav/NavMesh/SP/DataBits.amount = 100
