extends CharacterBody2D

@onready var animasao = $AnimationPlayer

func _physics_process(delta: float) -> void:
	animasao.play("Idle"
