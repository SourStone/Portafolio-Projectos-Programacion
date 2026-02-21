extends CenterContainer

@onready var _score_label = $VBoxContainer/ScoreLabel

func _on_retry_button_pressed():
	get_tree().reload_current_scene()

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://screens/ui/menu.tscn")



func _on_draw():
	_score_label.text = 'Score: ' + str(HighscoreManager.highscore)
