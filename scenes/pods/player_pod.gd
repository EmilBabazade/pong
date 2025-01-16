extends CharacterBody2D

@export var speed = 20000
@export var alternative_controls = false
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	get_input()
	move(delta)

func get_input():
	if alternative_controls:
		direction.y = Input.get_axis('up_alternative', 'down_alternative')
	else:
		direction.y = Input.get_axis('up', 'down')

func move(delta: float):
	velocity.y = direction.y * delta * speed
	move_and_slide()
