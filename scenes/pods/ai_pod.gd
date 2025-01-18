extends PlayerPod

func _ready() -> void:
	speed = 700

func get_input():
	direction.y = global_position.direction_to(Globals.ball_position).y
