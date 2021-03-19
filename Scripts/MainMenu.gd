extends Control

onready var quitButton = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	var os = OS.get_name()
	if os == "iOS":
		quitButton.visible = false

func _on_QuitButton_pressed() -> void:
	get_tree().quit()



func _on_PlayButton_pressed() -> void:
	Settings.load_settings()
	get_tree().change_scene("res://Scenes/Board.tscn")


func _on_OptionsButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/OptionsMenu.tscn")


func _on_RulesButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/HowToPlay.tscn")


func _on_StatsButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/StatsScreen.tscn")
