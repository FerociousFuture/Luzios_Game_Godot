extends Node2D

@onready var area2d : Area2D = $Area2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var raycast_pared : RayCast2D = $Pared
@onready var raycast_suelo : RayCast2D = $Suelo
@onready var damage: AudioStreamPlayer2D = $damage

var velocidad := 50
var direccion := -1
var vida := 3
var muerto := false

func _physics_process(delta):
	if muerto:
		return

	if raycast_pared.is_colliding() or not raycast_suelo.is_colliding():
		direccion *= -1
		scale.x *= -1

	position.x += direccion * velocidad * delta
	animation.play("Caminar")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if muerto:
		return

	if area.is_in_group("P_Punch"):
		vida -= 1
		damage.play()
		print("Ahh me pegó!!! Vida restante:", vida)

		if vida <= 0:
			morir()

func morir():
	muerto = true
	print("¡He muerto!")
	queue_free()
	print("Ya se murio en serio")
