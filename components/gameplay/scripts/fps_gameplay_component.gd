class_name FPS_Gameplay_Component extends Component

# Called when the node enters the scene tree for the first time.
func _ready():
	if !is_enabled:
		return
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
