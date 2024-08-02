class_name TestGameplayComponent extends Component

func _process(delta):
	if !is_enabled:
		return
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
