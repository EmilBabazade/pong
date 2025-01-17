extends Node2D

@onready var ball_scene: PackedScene = preload("res://scenes/objects/ball.tscn")

func _ready() -> void:
	spawn_ball()

func spawn_ball():
	var ball = ball_scene.instantiate()
	ball.position = Vector2(578, 319)
	add_child(ball)

func goal():
	var ball: Node2D = get_tree().get_first_node_in_group('ball')
	if ball:
		ball.queue_free()
		await get_tree().create_timer(2).timeout
		spawn_ball()


func _on_player_1_goal_body_entered(body: Node2D) -> void:
	goal()


func _on_player_2_goal_body_entered(body: Node2D) -> void:
	goal()
