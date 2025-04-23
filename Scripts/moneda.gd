extends Node2D

signal recoger

@onready var Sound = $sound


func _ready():
	connect("recoger", self._recoger_moneda)

func _recoger_moneda():
	print("¡Moneda recogida!")
	Sound.play()
	queue_free()
