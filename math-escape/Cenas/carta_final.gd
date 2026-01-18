extends Control


func _ready() -> void:
	MusicPlayer.stop()
	AudioStreamPlayer2d.play()
	


func _on_button_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Cenas/vitoria.tscn")
