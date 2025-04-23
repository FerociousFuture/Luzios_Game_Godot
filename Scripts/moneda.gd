extends Node2D

signal recoger

func _ready():
	connect("recoger", self._recoger_moneda)

func _recoger_moneda():
	print("¡Moneda recogida!")
	queue_free()
