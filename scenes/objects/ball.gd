extends CharacterBody2D

@export var speed = 600
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var random_num = rng.randi_range(0, 100)
	direction = Vector2(1, 0.3) if random_num % 2 == 0 else Vector2(-1, -0.3)
	velocity = direction * speed

func _process(_delta: float) -> void:
	Globals.ball_position = global_position


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
		$AudioStreamPlayer.pitch_scale = randf_range(0.8, 1.2)
		$AudioStreamPlayer.play()
		direction = direction.bounce(collision_normal).normalized()
