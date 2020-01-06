extends Sprite

# exports
export(int) var int_value
export(String) var suit
export(String) var face_value
export(Texture) var card_front_texture
export(Texture) var card_back_texture
export(PackedScene) var stack

# signals
signal card_clicked(card)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = card_front_texture


func _on_Button_pressed() -> void:
	emit_signal("card_clicked", self)
