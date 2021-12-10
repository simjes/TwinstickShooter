extends Popup

onready var Resume = $Resume
onready var Restart = $Restart
onready var Exit = $Exit

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") and !is_visible_in_tree():
		get_tree().paused = true
		show()
		return
		
	if Input.is_action_just_pressed("ui_cancel") and is_visible_in_tree():
		hide()
		get_tree().paused = false
		return

func _on_Resume_pressed():
	hide()
	get_tree().paused = false

func _on_Exit_pressed():
	get_tree().quit()
