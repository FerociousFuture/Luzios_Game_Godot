extends Node2D
@onready var Sound = $sound
signal recoger

func _ready():
	connect("recoger", self._recoger_moneda)

func _recoger_moneda():
	print("¡Moneda recogida!")
	Sound.play()
	queue_free()
