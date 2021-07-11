extends Node2D

# exports
export(int) var int_value
export(String) var suit
export(String) var face_value
export(String) var texture_name
export(Texture) var card_front_texture
export(Texture) var card_back_texture

# onready
onready var animate = $AnimationPlayer
onready var sprite = $Sprite
onready var textureRect = $TextureRect

# signals
signal card_clicked(card)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textureRect.texture = card_front_texture


func _on_Button_pressed() -> void:
	emit_signal("card_clicked", self)

func blink():
	animate.play("Blink")
	
func shake():
	animate.play("TextureShake")
	
func change_card_texture(new_texture):
	if new_texture == "back":
		textureRect.texture = card_back_texture
	elif new_texture == "front":
		textureRect.texture = card_front_texture
