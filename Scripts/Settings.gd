extends Node

const SAVE_PATH = "user://config.cfg"

var _config_file = ConfigFile.new()

var _settings = {
	"variations": {
		"queens_on_kings": false,
		"turn_corners": false,
		"jokers_wildcard": false,
		"empty_foundation": false
	}
}
# variations
var allow_queens_on_kings
var turn_corners
var jokers_wildcard
var empty_foundation

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
		return null
		
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)
			
	allow_queens_on_kings = _settings["variations"]["queens_on_kings"]
	turn_corners = _settings["variations"]["turn_corners"]
	jokers_wildcard = _settings["variations"]["jokers_wildcard"]
	empty_foundation = _settings["variations"]["empty_foundation"]
			
func get_setting(key):
	return _settings["variations"][key]
	
func save_setting(key, value):
	_config_file.set_value("variations", key, value)
			
	_config_file.save(SAVE_PATH)
