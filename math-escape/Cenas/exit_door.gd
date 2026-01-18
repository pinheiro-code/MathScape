extends Area2D

signal player_entered_door


func _ready() -> void:
	self.body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	
	
	if body.is_in_group("player"):
		
		player_entered_door.emit()
