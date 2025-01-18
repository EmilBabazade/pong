extends Node2D

@onready var ball_scene: PackedScene = preload("res://scenes/objects/ball.tscn")
@export var winning_score: int = 5
var player1_score = 0
var player2_score = 0
var game_finished = false

func _ready() -> void:
	spawn_ball()

func spawn_ball():
	if game_finished:
		return
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
	if game_finished:
		return
	player2_score += 1
	$UI.set_player2_score(player2_score)
	check_if_winning()
	goal()


func _on_player_2_goal_body_entered(body: Node2D) -> void:
	if game_finished:
		return
	player1_score += 1
	$UI.set_player1_score(player1_score)
	check_if_winning()
	goal()

func check_if_winning():
	if player1_score >= winning_score:
		$UI.game_over('PLAYER 1 IS VICTORIOUS !')
		game_finished = true
	if player2_score >= winning_score:
		$UI.game_over('PLAYER 2 IS VICTORIOUS !')
		game_finished = true


func _on_ui_quit() -> void:
	get_tree().quit()


func _on_ui_restart() -> void:
	player1_score = 0
	player2_score = 0
	game_finished = false
	$UI.restart_game()
	spawn_ball()
