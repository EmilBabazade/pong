extends Node2D

@onready var ball_scene: PackedScene = preload("res://scenes/objects/ball.tscn")
@onready var player_scene: PackedScene = preload("res://scenes/pods/player_pod.tscn")
@onready var ai_scene: PackedScene = preload("res://scenes/pods/ai_pod.tscn")
@export var winning_score: int = 5
var player1_score = 0
var player2_score = 0
var game_finished = false

func _ready() -> void:
	spawn_player2()
	spawn_ball()

func spawn_player2():
	var player2: PlayerPod
	if Globals.ai:
		player2 = ai_scene.instantiate()
	else:
		player2 = player_scene.instantiate()
		player2.alternative_controls = true
	player2.position = Vector2(1117, 322)
	$Players.add_child(player2)

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
		if not game_finished:
			$GoalAudio.play()
		await get_tree().create_timer(0.5).timeout
		spawn_ball()


func _on_player_1_goal_body_entered(_body: Node2D) -> void:
	if game_finished:
		return
	player2_score += 1
	$UI.set_player2_score(player2_score)
	check_if_winning()
	goal()


func _on_player_2_goal_body_entered(_body: Node2D) -> void:
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
		$GameFInishedAudio.play()
	if player2_score >= winning_score:
		$UI.game_over('PLAYER 2 IS VICTORIOUS !')
		game_finished = true
		$GameFInishedAudio.play()


func _on_ui_quit() -> void:
	get_tree().change_scene_to_file('res://scenes/user_interface/main_menu.tscn')


func _on_ui_restart() -> void:
	player1_score = 0
	player2_score = 0
	game_finished = false
	$UI.restart_game()
	spawn_ball()
