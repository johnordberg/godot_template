class_name Component extends Node

@export var is_enabled: bool = true

var component_name: StringName = &""

func _init():
	component_name = get_component_name()

func _enter_tree() -> void:
	owner.set_meta(component_name, self) # Register

func _exit_tree() -> void:
	owner.remove_meta(component_name) # Unregister

func get_component_name() -> String:
	var script: Script = get_script()
	if script:
		var script_path: String = script.resource_path
		if script_path:
			return StringName(script_path.get_file().split(".")[0])
	return StringName(get_class())


