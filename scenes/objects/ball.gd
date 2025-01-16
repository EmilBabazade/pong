extends CharacterBody2D

@export var speed = 500
var direction = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		var collider = collision.get_collider()
		var collision_normal = Vector2.ZERO
		if collider.is_in_group('player'):
			speed += 50
			collision_normal = (global_position - collider.global_position).normalized()
		else:
			collision_normal = collision.get_normal()
		direction = direction.bounce(collision_normal).normalized()

#func _on_collision_detector_body_entered(body: Node2D) -> void:
	#if body.is_in_group('player'):
		#var collision_normal = (global_position - body.global_position).normalized()
		#direction = direction.bounce(collision_normal).normalized()
		#print("Direction Before: ", direction)
		#print("Direction After: ", direction)
		##global_position.direction_to()
		##print(linear_velocity)
