extends Area2D

signal morreu;


func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		morreu.emit();
