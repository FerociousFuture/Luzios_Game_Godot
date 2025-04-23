extends Control

func _on_inicio_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()

func _on_about_pressed() -> void:
	pass # Replace with function body.
