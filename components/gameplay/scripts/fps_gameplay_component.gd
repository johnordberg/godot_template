class_name FPS_Gameplay_Component extends Component

var mouse_hidden = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !is_enabled:
		return
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func hide_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_hidden = false
	
func show_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_hidden = true

func toggle_mouse_mode():
	if mouse_hidden:
		hide_mouse()
	else:
		show_mouse()
