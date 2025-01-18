extends CanvasLayer

signal restart
signal quit

func set_player1_score(score: int):
	$Player1Score/Label.text = str(score)

func set_player2_score(score: int):
	$Player2Score/Label.text = str(score)

func game_over(text: String):
	$GameOver/VictoryText.text = text
	$GameOver/Restart.visible = true
	$GameOver/Quit.visible = true

func restart_game():
	$GameOver/VictoryText.text = ''
	$GameOver/Restart.visible = false
	$GameOver/Quit.visible = false
	set_player1_score(0)
	set_player2_score(0)

func _on_restart_pressed() -> void:
	restart.emit()




func _on_quit_pressed() -> void:
	quit.emit()
