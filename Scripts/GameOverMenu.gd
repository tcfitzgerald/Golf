extends Control

# onready
onready var board = get_parent()
onready var scoreLabel = $CenterContainer/VBoxContainer/ScoreLabel

func _ready():
	pass


func _on_PlayAgainButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Board.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_UndoLastMoveButton_pressed() -> void:
	hide()
	board.undo()


func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
