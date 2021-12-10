extends Popup

onready var Resume = $CenterContainer/VBoxContainer/Resume
onready var Quit = $CenterContainer/VBoxContainer/Quit

onready var menu_options = [Resume, Quit]
onready var max_index = menu_options.size() -1

var hover_index = 0

func _ready():
	set_selected_option(hover_index)

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel") and !is_visible_in_tree():
		get_tree().paused = true
		show()
		return
		
	if Input.is_action_just_pressed("ui_cancel") and is_visible_in_tree():
		hide()
		get_tree().paused = false
		return
		
	if Input.is_action_just_pressed("ui_up") and is_visible_in_tree():
		var index = clamp(hover_index - 1, 0, max_index)
		hover_menu_option(index)
		
	if Input.is_action_just_pressed("ui_down") and is_visible_in_tree():
		var index = clamp(hover_index + 1, 0, max_index)
		hover_menu_option(index)
		
	if Input.is_action_just_pressed("ui_accept") and is_visible_in_tree():
		select_menu_option()
		
func select_menu_option():
	if hover_index == 0:
		hide()
		get_tree().paused = false
	
	if hover_index == 1:
		get_tree().quit()
	
func hover_menu_option(new_index):
	reset_selected_option(hover_index)
	hover_index = new_index
	set_selected_option(hover_index)

func reset_selected_option(index):
	menu_options[index].add_color_override("font_color", Color.white)

func set_selected_option(index):
	menu_options[index].add_color_override("font_color", Color.aqua)
