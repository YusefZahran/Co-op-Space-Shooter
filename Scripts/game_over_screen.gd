extends Control



func _on_restart_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/P1_score.text = "Player 1 Score: " + str(value)

func set_high_score(value):
	$Panel/P2_score.text = "Player 2 Score: " + str(value)

