extends Node

const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()

var _settings = {
	"variations": {
		"queens_on_kings": false,
		"turn_corners": false,
		"jokers_wildcard": false,
		"empty_foundation": false
	}
}

func _ready() -> void:
	load_settings()
	
func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
			
	_config_file.save(SAVE_PATH)
	
func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		return null
		
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)
			
func get_setting(key):
	return _settings["variations"][key]
	
func save_setting(key, value):
	_config_file.set_value("variations", key, value)
			
	_config_file.save(SAVE_PATH)