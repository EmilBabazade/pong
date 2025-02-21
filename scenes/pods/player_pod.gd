extends StaticBody2D
class_name PlayerPod

@export var speed = 600
@export var alternative_controls = false
var direction: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	get_input()

func _physics_process(delta: float) -> void:
	move(delta)

func get_input():
	if alternative_controls:
		direction.y = Input.get_axis('up_alternative', 'down_alternative')
	else:
		direction.y = Input.get_axis('up', 'down')

func move(delta: float):
	move_and_collide(direction * delta * speed)
