extends Control

var config = ConfigFile
var config_file_name = "user://settings_pref.cfg"

@onready var ui_animator_component = $UiAnimatorComponent

@onready var master_volume = $MarginContainer/Control/VBoxContainer/Wrapper/MasterVolume
@onready var music_volume = $MarginContainer/Control/VBoxContainer/Wrapper2/MusicVolume
@onready var game_volume = $MarginContainer/Control/VBoxContainer/Wrapper3/GameVolume
@onready var save_and_return = $MarginContainer/Control/VBoxContainer/SaveAndReturn

signal master_volume_changed
signal music_volume_changed
signal game_volume_changed
signal save_and_return_pressed

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

func save_config():
	config.load(config_file_name)
	config.set_value("Sounds", "master_volume", Global.master_volume)
	config.set_value("Sounds", "music_volume", Global.music_volume)
	config.set_value("Sounds", "game_volume", Global.game_volume)
	
	config.save(config_file_name)
	print("config file saved")
