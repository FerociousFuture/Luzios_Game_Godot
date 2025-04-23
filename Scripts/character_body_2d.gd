extends CharacterBody2D
@onready var animasao = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	animasao.play("default")
