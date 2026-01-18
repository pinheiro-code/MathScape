extends Control


signal continue_pressed
signal exit_pressed

func _ready():
	$ContinueButton.pressed.connect(_on_ContinueButton_pressed)
	$ExitButton.pressed.connect(_on_ExitButton_pressed)
	
	hide()

func _on_ContinueButton_pressed():
	emit_signal("continue_pressed")
	hide()

func _on_ExitButton_pressed():
	emit_signal("exit_pressed")
	hide()
