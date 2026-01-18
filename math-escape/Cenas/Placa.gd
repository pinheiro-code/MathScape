extends Node2D

@export var texto: String = ""

@onready var text_label: Label = $Label

@onready var Placa: Sprite2D = $Sprite2D

var chat_esta_visivel = false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	text_label.hide()
	Placa.hide()
	text_label.text = texto

func _on_area_2d_body_entered(body: Node2D) -> void:
	text_label.show()
	Placa.show()
	get_tree().paused = true
	chat_esta_visivel = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if chat_esta_visivel:
		text_label.hide()
		get_tree().paused = false
		chat_esta_visivel = false

func _process(delta):
	if chat_esta_visivel and Input.is_action_just_pressed("Action"):
		text_label.hide()
		get_tree().paused = false
