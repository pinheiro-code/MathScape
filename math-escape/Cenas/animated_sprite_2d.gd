extends AnimatedSprite2D

func trigger_animation(velocity: Vector2, direction: int):
	
	if(direction != 0):
		scale.x = direction;
		
	if not get_parent().is_on_floor():
		play("small_Jump")
	elif sign(velocity.x) != sign(direction) and velocity.x != 0 and direction != 0:
		play("slide")
	elif velocity.x != 0:
		play("run")
	else:
		play("idle")
