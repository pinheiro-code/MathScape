extends Node

enum Operation { SUM, SUBTRACTION, MULTIPLICATION, DIVISION }

@export var operation: Operation = Operation.SUM
@export var num1: int = 5
@export var num2: int = 10

var target_amount: int = 0
var coletaveis_pegos: int = 0
var is_dead: bool = false

@onready var hud: CanvasLayer = $HUD
@onready var porta_de_saida: Area2D = $ExitDoor
@onready var level_completed_sound = $LevelCompleted_Sound

func game_over() -> void:
	if is_dead:
		return
	is_dead = true
	
	$Error_Sound.play()
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		player.velocity = Vector2.ZERO
		player.set_physics_process(false)
		
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().call_deferred("reload_current_scene")

func _on_hud_time_up() -> void:
	game_over()

func _on_espinho_morreu() -> void:
	game_over()

func _on_exit_door_player_entered_door() -> void:
	if coletaveis_pegos == target_amount:
		$HUD/LevelTimer.stop()
		
		var players = get_tree().get_nodes_in_group("player")
		var player = players[0]
		player.velocity = Vector2.ZERO
		player.set_physics_process(false)
		
		player.get_node("AnimatedSprite2D").play("victory")
		var fogueiras = get_tree().get_nodes_in_group("Fogueira")
		if fogueiras.size() > 0:
			fogueiras[0].get_node("AnimatedSprite2D").play("fire_on")
			
		level_completed_sound.play()
		await level_completed_sound.finished
		
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		
		get_tree().change_scene_to_file("res://Cenas/carta_fase_4_screen.tscn")

func _ready() -> void:
	level_completed_sound.process_mode = Node.PROCESS_MODE_ALWAYS
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		if players[0].has_method("ativar_modo_neve_pesada"):
			players[0].ativar_modo_neve_pesada()
		elif players[0].has_method("ativar_modo_neve"):
			players[0].ativar_modo_neve()
	
	calculate_target_amount()
	hud.update_problem(num1, num2, get_operation_symbol())
	hud.update_count(coletaveis_pegos, target_amount)
	conectar_coletaveis()
	desativar_porta_de_saida()

func conectar_coletaveis() -> void:
	coletaveis_pegos = 0
	for child in get_children():
		if child is Area2D and child.name.begins_with("Cubo"):
			child.collected.connect(_on_MagicCube_collected)

func _on_MagicCube_collected(value_from_cube: int) -> void:
	$ObjectCollet_Sound.play()
	coletaveis_pegos += value_from_cube
	hud.update_count(coletaveis_pegos, target_amount)
	
	if coletaveis_pegos > target_amount:
		print("PEGOU DEMAIS!")
		game_over()
	elif coletaveis_pegos == target_amount:
		ativar_porta_de_saida()

func calculate_target_amount() -> void:
	match operation:
		Operation.SUM: target_amount = num1 + num2
		Operation.SUBTRACTION: target_amount = num1 - num2
		Operation.MULTIPLICATION: target_amount = num1 * num2
		Operation.DIVISION:
			if num2 != 0: target_amount = num1 / num2
			else: target_amount = 0

func get_operation_symbol() -> String:
	match operation:
		Operation.SUM: return "+"
		Operation.SUBTRACTION: return "-"
		Operation.MULTIPLICATION: return "x"
		Operation.DIVISION: return "/"
	return "?"

func ativar_porta_de_saida() -> void:
	porta_de_saida.set_collision_mask_value(1, true)
	porta_de_saida.set_physics_process(true) 
	if porta_de_saida.has_node("Sprite2D"):
		porta_de_saida.get_node("Sprite2D").modulate = Color("ffffff") 

func desativar_porta_de_saida() -> void: 
	porta_de_saida.set_collision_mask_value(1, false)
	if porta_de_saida.has_node("Sprite2D"):
		porta_de_saida.get_node("Sprite2D").modulate = Color("4b4b4bff")
