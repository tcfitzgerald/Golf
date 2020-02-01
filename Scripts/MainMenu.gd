extends Control

func _ready():
	pass


func _on_QuitButton_pressed() -> void:
	get_tree().quit()



func _on_PlayButton_pressed() -> void:
	Settings.load_settings()
	get_tree().change_scene("res://Scenes/Board.tscn")


func _on_OptionsButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/OptionsMenu.tscn")


func _on_RulesButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/RulesMenu.tscn")
