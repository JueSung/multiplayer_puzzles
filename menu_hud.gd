extends CanvasLayer


func _unhandled_input(event):
	if event.is_action_pressed("ESC"):
		if visible:
			visible = false
		else:
			visible = true
			$Settings.visible = false
			


func close_pressed() -> void:
	visible = false

#Settings
func _on_settings_pressed() -> void:
	$Settings.visible = true
	$MainMenu/Mouse_Blocker.visible = true

func settings_back_pressed():
	$Settings.visible = false
	$MainMenu/Mouse_Blocker.visible = false
