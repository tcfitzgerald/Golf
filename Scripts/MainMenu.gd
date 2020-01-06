extends Control

func _ready():
	pass


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_HowToPlayButton_pressed() -> void:
	pass # Replace with function body.


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Board.tscn")
