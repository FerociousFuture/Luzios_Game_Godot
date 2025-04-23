extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(float) -> void:
	_animated_sprite.play("default")
