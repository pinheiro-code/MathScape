extends CharacterBody2D

@export_group("Locomotion")
@export var speed = 100
@export var acceleration = 1200 
@export var friction = 1000 
@export var jump_velocity = -350

@export_group("Wall Movement")
@export var wall_slide_speed = 50
@export var wall_jump_push = 300

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var coyote_timer = $CoyoteTimer

func _physics_process(delta: float) -> void:
	
	var was_on_floor = is_on_floor()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if is_on_wall() and velocity.y > 0:
			velocity.y = min(velocity.y, wall_slide_speed)
	if Input.is_action_just_pressed("jump"):
		
		if is_on_floor() or not coyote_timer.is_stopped():
			velocity.y = jump_velocity
			$Jump_Sound.play()
			coyote_timer.stop()
			
		elif is_on_wall():
			velocity.y = jump_velocity
			var wall_normal = get_wall_normal()
			velocity.x = wall_normal.x * wall_jump_push
			$Jump_Sound.play()
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		
	$AnimatedSprite2D.trigger_animation(velocity, direction)
	
	move_and_slide()
	

	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_timer.start()
		


func ativar_modo_gelo():
	speed = 100
	
	friction = 50 
	
	acceleration = 200
	


func ativar_modo_neve_pesada():
	speed = 60
	friction = 4000
	
	acceleration = 600
	
	jump_velocity = -280 
