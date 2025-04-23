extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var area2d: Area2D = $Area2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var cuerpo: Area2D = $Cuerpo
@onready var stun: Timer = $Stun

var state_machine
var vida = 100
var atacando := false
var herido := false
var ataque_timer := 0.0
var monedas = 0

func _ready() -> void:
	anim_tree.active = true
	state_machine = anim_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not atacando and is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("Atacar"):
			atacando = true
			ataque_timer = 0.5

	if not atacando and not herido:
		var dir := Input.get_axis("ui_left", "ui_right")
		velocity.x = dir * SPEED if dir else move_toward(velocity.x, 0, SPEED)
		if dir:
			sprite.flip_h = dir < 0
			area2d.scale.x = -1 if sprite.flip_h else 1
	else:
		velocity.x = 0

	if vida <= 0:
		morir()

	move_and_slide()
	actualizar_animaciones()

	if atacando:
		ataque_timer -= delta
		atacando = ataque_timer > 0

func actualizar_animaciones():
	if herido:
		state_machine.travel("Hurt")
	elif atacando:
		state_machine.travel("Atacar")
	elif not is_on_floor():
		state_machine.travel("Salto" if velocity.y < 0 else "Caer")
	elif abs(velocity.x) > 0.1:
		state_machine.travel("Caminar")
	else:
		state_machine.travel("Idle")

func _on_cuerpo_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigo") and not herido:
		vida -= 25
		herido = true
		stun.start()
		state_machine.travel("Hurt")
		velocity.x = 5000 if sprite.flip_h else -5000
		velocity.y = -500.0
		velocity.y = lerp(velocity.y, 0.0, 0.1)
	
	elif area.is_in_group("Death_box"):
		herido = true
		stun.start()
		state_machine.travel("Hurt")
		velocity.x = 5000 if sprite.flip_h else -5000
		velocity.y = -600.0
		velocity.y = lerp(velocity.y, 0.0, 0.1)
		morir()
		move_and_slide()
	
	if area.is_in_group("Moneda"):
		var nodo = area.get_parent()
		if nodo and nodo.has_signal("recoger"):
			nodo.emit_signal("recoger")
			monedas += 1
			print(monedas)

func morir() -> void:
	state_machine.travel("Hurt")
	await stun.timeout
	queue_free()
	

func _on_stun_timeout() -> void:
	herido = false
