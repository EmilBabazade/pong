extends CanvasLayer

func set_player1_score(score: int):
	$Player1Score/Label.text = str(score)

func set_player2_score(score: int):
	$Player2Score/Label.text = str(score)

func set_victory_text(text: String):
	$VictoryText.text = text
