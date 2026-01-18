extends Panel

signal choice_made(choice_index)

func _ready() -> void:

	$Option1Button.pressed.connect(_on_option_1_pressed)
	$Option2Button.pressed.connect(_on_option_2_pressed)

func _on_option_1_pressed() -> void:

	choice_made.emit(1)
	hide()

func _on_option_2_pressed() -> void:

	choice_made.emit(2)
	hide()
