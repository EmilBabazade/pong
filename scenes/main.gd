extends Node2D

@onready var ball_scene: PackedScene = preload("res://scenes/objects/ball.tscn")
var player1_score = 0
var player2_score = 0

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
		await get_tree().create_timer(0.5).timeout
		spawn_ball()


func _on_player_1_goal_body_entered(body: Node2D) -> void:
	player2_score += 1
	$UI.set_player2_score(player2_score)
	goal()


func _on_player_2_goal_body_entered(body: Node2D) -> void:
	player1_score += 1
	$UI.set_player1_score(player1_score)
	goal()
