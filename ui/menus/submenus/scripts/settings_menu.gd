extends Control

var config = ConfigFile
var config_file_name = "user://settings_pref.cfg"

@onready var ui_animator_component = $UiAnimatorComponent

@onready var master_volume = $MarginContainer/HBoxContainer/VBoxContainer/Wrapper/MasterVolume
@onready var music_volume = $MarginContainer/HBoxContainer/VBoxContainer/Wrapper2/MusicVolume
@onready var game_volume = $MarginContainer/HBoxContainer/VBoxContainer/Wrapper3/GameVolume

@onready var forwards_button = $MarginContainer/HBoxContainer/VBoxContainer2/SplitContainer/VBoxContainer2/ForwardsButton
@onready var backwards_button = $MarginContainer/HBoxContainer/VBoxContainer2/SplitContainer/VBoxContainer2/BackwardsButton
@onready var left_button = $MarginContainer/HBoxContainer/VBoxContainer2/SplitContainer/VBoxContainer2/LeftButton
@onready var right_button = $MarginContainer/HBoxContainer/VBoxContainer2/SplitContainer/VBoxContainer2/RightButton
@onready var jump_button = $MarginContainer/HBoxContainer/VBoxContainer2/SplitContainer/VBoxContainer2/JumpButton
@onready var pause_button = $MarginContainer/HBoxContainer/VBoxContainer2/SplitContainer/VBoxContainer2/PauseButton

@onready var save_and_return = $MarginContainer/VBoxContainer/SaveAndReturn

var key_waiting = false
var key_bind_target: Button

signal master_volume_changed
signal music_volume_changed
signal game_volume_changed
signal save_and_return_pressed

func _unhandled_input(event):
	if key_waiting:
		if event is InputEventKey:
			if event.pressed:
				key_bind_target.set_key_text(event)
				key_bind_target.set_key(event)
				var action = key_bind_target.get_action()
				InputMap.action_erase_events(action)
				InputMap.action_add_event(action, event)
				key_waiting = false
				key_bind_target.release_focus()

func get_animator_component():
	return ui_animator_component

func get_master_volume():
	return master_volume
	
func get_music_volume():
	return music_volume
	
func get_game_volume():
	return game_volume
	
func set_master_volume(new_value):
	master_volume.value = new_value
	
func set_music_volume(new_value):
	music_volume.value = new_value
	
func set_game_volume(new_value):
	game_volume.value = new_value
	
func get_save_and_return():
	return save_and_return

func _on_master_volume_value_changed(value):
	master_volume_changed.emit(value)

func _on_music_volume_value_changed(value):
	music_volume_changed.emit(value)

func _on_game_volume_value_changed(value):
	game_volume_changed.emit(value)

func _on_save_and_return_pressed():
	save_and_return_pressed.emit()

func init_config():
	config = ConfigFile.new()
	var _err = config.load(config_file_name)
	if _err != OK:
		print("no config file found")
		config.set_value("Sounds", "master_volume", 100)
		config.set_value("Sounds", "music_volume", 100)
		config.set_value("Sounds", "game_volume", 100)
		
		config.set_value("Controls", "up", forwards_button.get_key())
		config.set_value("Controls", "down", backwards_button.get_key())
		config.set_value("Controls", "left", left_button.get_key())
		config.set_value("Controls", "right", right_button.get_key())
		config.set_value("Controls", "jump", jump_button.get_key())
		config.set_value("Controls", "esc", pause_button.get_key())
		
		config.save(config_file_name)
		print("new config file created")
	else:
		print("loaded config file")
		Global.master_volume = config.get_value("Sounds", "master_volume")
		Global.music_volume = config.get_value("Sounds", "music_volume")
		Global.game_volume = config.get_value("Sounds", "game_volume")
		
		master_volume.value = Global.master_volume
		music_volume.value = Global.music_volume
		game_volume.value = Global.game_volume
		
		InputMap.action_erase_events("up")
		InputMap.action_erase_events("down")
		InputMap.action_erase_events("left")
		InputMap.action_erase_events("right")
		InputMap.action_erase_events("jump")
		InputMap.action_erase_events("esc")
		
		InputMap.action_add_event("up", config.get_value("Controls", "up"))
		InputMap.action_add_event("down", config.get_value("Controls", "down"))
		InputMap.action_add_event("left", config.get_value("Controls", "left"))
		InputMap.action_add_event("right", config.get_value("Controls", "right"))
		InputMap.action_add_event("jump", config.get_value("Controls", "jump"))
		InputMap.action_add_event("esc", config.get_value("Controls", "esc"))
		
		forwards_button.set_key_text(config.get_value("Controls", "up"))
		backwards_button.set_key_text(config.get_value("Controls", "down"))
		left_button.set_key_text(config.get_value("Controls", "left"))
		right_button.set_key_text(config.get_value("Controls", "right"))
		jump_button.set_key_text(config.get_value("Controls", "jump"))
		pause_button.set_key_text(config.get_value("Controls", "esc"))

func save_config():
	config.load(config_file_name)
	config.set_value("Sounds", "master_volume", Global.master_volume)
	config.set_value("Sounds", "music_volume", Global.music_volume)
	config.set_value("Sounds", "game_volume", Global.game_volume)
	
	config.set_value("Controls", "up", forwards_button.get_key())
	config.set_value("Controls", "down", backwards_button.get_key())
	config.set_value("Controls", "left", left_button.get_key())
	config.set_value("Controls", "right", right_button.get_key())
	config.set_value("Controls", "jump", jump_button.get_key())
	config.set_value("Controls", "esc", pause_button.get_key())
	
	config.save(config_file_name)
	print("config file saved")

func _wait_for_input_for(button):
	if not key_waiting:
		key_waiting = true
		key_bind_target = button
		key_bind_target.text = "Press a key..."

func _on_forwards_button_button_up():
	_wait_for_input_for(forwards_button)

func _on_backwards_button_button_up():
	_wait_for_input_for(backwards_button)

func _on_left_button_button_up():
	_wait_for_input_for(left_button)

func _on_right_button_button_up():
	_wait_for_input_for(right_button)

func _on_jump_button_button_up():
	_wait_for_input_for(jump_button)

func _on_pause_button_button_up():
	_wait_for_input_for(pause_button)
