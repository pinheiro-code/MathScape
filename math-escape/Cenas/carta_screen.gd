extends Control




func _on_button_2_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Cenas/fase1.tscn")
