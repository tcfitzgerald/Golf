extends TextureButton

# onready
onready var anim = $AnimationPlayer

func _ready():
	pass
	
func blink():
	anim.play("Blink")

func shake():
	anim.play("Shake")
