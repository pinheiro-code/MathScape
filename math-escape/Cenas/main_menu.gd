extends Control

func _ready():
	MusicPlayer.play()
	AudioStreamPlayer2d.stop()


func _on_button_start_game_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Cenas/tutorial_screen.tscn")


func _on_button_leave_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().quit();
