extends Popup

onready var ScoreUI = get_node("/root/World/CanvasLayer/ScoreUI")
onready var Score = $CenterContainer/VBoxContainer/Score

onready var PlayAgain = $CenterContainer/VBoxContainer/PlayAgain
onready var Quit = $CenterContainer/VBoxContainer/Quit
onready var menu_options = [PlayAgain, Quit]
onready var max_index = menu_options.size() -1

var hover_index = 0

func _ready():
	Score.text = "Score: " + String(ScoreUI.score)
	show()
	set_selected_option(hover_index)

func _input(_event):
	if Input.is_action_just_pressed("ui_up"):
		var index = clamp(hover_index - 1, 0, max_index)
		hover_menu_option(index)
		
	if Input.is_action_just_pressed("ui_down"):
		var index = clamp(hover_index + 1, 0, max_index)
		hover_menu_option(index)
		
	if Input.is_action_just_pressed("ui_accept"):
		select_menu_option(hover_index)
		
func select_menu_option(index):
	if index == 0:
		get_tree().reload_current_scene()
		get_tree().paused = false
	
	if index == 1:
		get_tree().quit()
	
func hover_menu_option(new_index):
	reset_selected_option(hover_index)
	hover_index = new_index
	set_selected_option(hover_index)

func reset_selected_option(index):
	menu_options[index].add_color_override("font_color", Color.white)

func set_selected_option(index):
	menu_options[index].add_color_override("font_color", Color.aqua)

func _on_PlayAgain_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		select_menu_option(0)

func _on_Quit_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		select_menu_option(1)
