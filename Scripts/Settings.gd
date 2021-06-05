extends Node

const SAVE_PATH = "user://config.cfg"

var _config_file = ConfigFile.new()

var _settings = {
	"variations": {
		"queens_on_kings": false,
		"turn_corners": false,
		"jokers_wildcard": false,
		"empty_foundation": false
	},
	"sound": {
		"play_sfx": true
	},
	"data": {
		"collect_data": true
	}
}
# variations
var allow_queens_on_kings
var turn_corners
var jokers_wildcard
var empty_foundation

# sound
var play_sfx

# data
var collect_data

func _ready() -> void:
	load_settings()
	var config_file = File.new()
	if not config_file.file_exists(SAVE_PATH):
		save_settings()

	
func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
			
	_config_file.save(SAVE_PATH)
	
func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		allow_queens_on_kings = _settings["variations"]["queens_on_kings"]
		turn_corners = _settings["variations"]["turn_corners"]
		jokers_wildcard = _settings["variations"]["jokers_wildcard"]
		empty_foundation = _settings["variations"]["empty_foundation"]
		play_sfx = _settings["sound"]["play_sfx"]
		collect_data = _settings["data"]["collect_data"]
		return null
		
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, _settings[section][key])
			
	allow_queens_on_kings = _settings["variations"]["queens_on_kings"]
	turn_corners = _settings["variations"]["turn_corners"]
	jokers_wildcard = _settings["variations"]["jokers_wildcard"]
	empty_foundation = _settings["variations"]["empty_foundation"]
	play_sfx = _settings["sound"]["play_sfx"]
	collect_data = _settings["data"]["collect_data"]
			
func get_setting(section, key):
	return _settings[section][key]
	
func save_setting(section, key, value):
	_config_file.set_value(section, key, value)
			
	_config_file.save(SAVE_PATH)
