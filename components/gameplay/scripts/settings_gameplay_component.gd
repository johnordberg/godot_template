class_name SettingsGameplayComponent extends Component

var config = ConfigFile.new()
var config_file_name = "user://settings_pref.cfg"

func _ready():
	if !is_enabled:
		initConfig()

func _process(delta):
	if !is_enabled:
		return

func initConfig():
	var err = config.load(config_file_name)
	if err != OK:
		config.set_value("Sounds", "master_volume", 100)
		config.set_value("Sounds", "music_volume", 100)
		config.set_value("Sounds", "game_volume", 100)
		
		config.save(config_file_name)
	else:
		Global.master_volume = config.get_value("Sounds", "master_volume")
		Global.music_volume = config.get_value("Sounds", "music_volume")
		Global.game_volume = config.get_value("Sounds", "game_volume")

func saveConfig():
	config.set_value("Sounds", "master_volume", Global.master_volume)
	config.set_value("Sounds", "music_volume", Global.music_volume)
	config.set_value("Sounds", "game_volume", Global.game_volume)
	
	config.save(config_file_name)
