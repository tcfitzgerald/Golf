extends Node

const SAVE_PATH = "user://stats.json"

var _stats = {
		"num_games_played": 0,
		"num_games_won": 0,
		"best_score": 35,
		"fewest_moves": 52,
		"moves_streak": 0
}

func save_stats(stats):
	var json_string = to_json(stats)
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(json_string)
	save_file.close()

func load_stats():
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return _stats
	
	save_file.open(SAVE_PATH, File.READ)
	var stats = parse_json(save_file.get_as_text())
	save_file.close()
	
	return stats
