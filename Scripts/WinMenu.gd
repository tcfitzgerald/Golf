extends Popup

# onready
onready var board = get_parent()

func _ready():
	pass


func _on_PlayAgainButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Board.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
