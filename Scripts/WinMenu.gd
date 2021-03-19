extends Popup

# onready
onready var board = get_parent()
onready var quitButton = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	var os = OS.get_name()
	if os == "iOS":
		quitButton.visible = false


func _on_PlayAgainButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Board.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_MainMenuButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
