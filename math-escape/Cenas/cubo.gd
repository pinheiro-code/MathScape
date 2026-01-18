extends Area2D


signal collected(value)


@export var resource_value: int = 1

@onready var value_label: Label = $Label

func _ready():
	value_label.text = str(resource_value)
	
	body_entered.connect(_on_body_entered)



func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		$CollisionShape2D.set_deferred("disabled", true)
		
		collected.emit(resource_value)
		
		queue_free()
