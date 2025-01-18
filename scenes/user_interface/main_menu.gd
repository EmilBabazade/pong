extends CanvasLayer


func _on_start_pressed() -> void:
	Globals.ai = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_ai_pressed() -> void:
	Globals.ai = true
	get_tree().change_scene_to_file("res://scenes/main.tscn")
