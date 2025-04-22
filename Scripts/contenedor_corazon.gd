extends HBoxContainer

@onready var corazon = preload("res://Scenes/Corazon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_max_vida(max: int):
	for i in range(max):
		var heart = corazon.instantiate()
		add_child(heart)
