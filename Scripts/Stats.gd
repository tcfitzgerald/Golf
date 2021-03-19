extends Node

const SAVE_PATH = "user://stats.cfg"

var _config_file = ConfigFile.new()

var _stats = {
	"stats": {
		"num_games_played": 0,
		"num_games_won": 0,
		"num_games_lost": 0,
		"best_score": 35,
		"best_time": 0,
		"fewest_moves": 0,
		"longest_chain": 0
	}
}

# stats
var num_games_played
var num_games_won
var num_games_lost
var best_score
var best_time
var fewest_moves
var longest_chain

func _ready() -> void:
	load_stats()
	var config_file = File.new()
	if not config_file.file_exists(SAVE_PATH):
		save_stats()

	
func save_stats():
	for section in _stats.keys():
		for key in _stats[section]:
			_config_file.set_value(section, key, _stats[section][key])
			
	_config_file.save(SAVE_PATH)
	
func load_stats():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		num_games_played = _stats["stats"]["num_games_played"]
		num_games_won = _stats["stats"]["num_games_won"]
		num_games_lost = _stats["stats"]["num_games_lost"]
		best_score = _stats["stats"]["best_score"]
		best_time = _stats["stats"]["best_time"]
		fewest_moves = _stats["stats"]["fewest_moves"]
		longest_chain = _stats["stats"]["longest_chain"]
		return null
		
	for section in _stats.keys():
		for key in _stats[section]:
			_stats[section][key] = _config_file.get_value(section, key, null)
			
	num_games_played = _stats["stats"]["num_games_played"]
	num_games_won = _stats["stats"]["num_games_won"]
	num_games_lost = _stats["stats"]["num_games_lost"]
	best_score = _stats["stats"]["best_score"]
	best_time = _stats["stats"]["best_time"]
	fewest_moves = _stats["stats"]["fewest_moves"]
	longest_chain = _stats["stats"]["longest_chain"]
			
func get_setting(section, key):
	return _stats[section][key]
	
func save_stat(section, key, value):
	_config_file.set_value(section, key, value)
			
	_config_file.save(SAVE_PATH)
	
func set_high_score(score):
	if score < best_score:
		save_stat("stats", "best_score", score)

func set_best_time(time):
	if best_time == 0:
		save_stat("stats", "best_time", time)
	elif time < best_time:
		save_stat("stats", "best_time", time)

func set_longest_chain(chain):
	if chain > longest_chain:
		save_stat("stats", "longest_chain", chain)

func set_fewest_moves(moves):
	if fewest_moves == 0:
		save_stat("stats", "fewest_moves", moves)
	elif moves < fewest_moves:
		save_stat("stats", "fewest_moves", moves)
		
func set_num_games_played():
	save_stat("stats", "num_games_played", num_games_played + 1)
	
func set_num_games_won():
	save_stat("stats", "num_games_won", num_games_won + 1)

func set_num_games_lost():
	save_stat("stats", "num_games_lost", num_games_lost + 1)
