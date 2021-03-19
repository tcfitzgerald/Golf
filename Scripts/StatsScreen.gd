extends Control

onready var gamesPlayedValue = $MarginContainer/VBoxContainer/VBoxContainer/GamesPlayedContainer/GamesPlayedValue
onready var gamesWonValue = $MarginContainer/VBoxContainer/VBoxContainer/GamesWonContainer/GamesWonValue
onready var gamesLostValue = $MarginContainer/VBoxContainer/VBoxContainer/GamesLostContainer/GamesLostValue
onready var winPercentageValue = $MarginContainer/VBoxContainer/VBoxContainer/WinPercentageContainer/WinPercentageValue
onready var bestTimeValue = $MarginContainer/VBoxContainer/VBoxContainer/BestTimeContainer/BestTimeValue
onready var longestChainValue = $MarginContainer/VBoxContainer/VBoxContainer/LongestChainContainer/LongestChainValue

func _ready():
	load_stats()


func load_stats():
	Stats.load_stats()
	var best_time = Stats.best_time	
	if best_time == 0:
		best_time = "n/a"
	else:
		var minutes = int(Stats.best_time) / 60
		var seconds = int(Stats.best_time) % 60
		best_time = "%2d:%02d" % [minutes, seconds]
	
	var win_percentage_calc: float
	var win_percentage
	if Stats.num_games_played > 0:
		win_percentage_calc = (float(Stats.num_games_won) / float(Stats.num_games_played)) * 100
		win_percentage = "%2.0f%%" % [win_percentage_calc]
	else:
		win_percentage = 0
	
	gamesPlayedValue.text = str(Stats.num_games_played)
	gamesWonValue.text = str(Stats.num_games_won)
	gamesLostValue.text = str(Stats.num_games_lost)
	winPercentageValue.text = str(win_percentage)
	bestTimeValue.text = str(best_time)
	longestChainValue.text = str(Stats.longest_chain)
	


func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

