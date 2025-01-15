extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Vsync" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Disabled
	if get_selected_id() == 0:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	#On
	if get_selected_id() == 1:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	#Adaptive
	if get_selected_id() == 2:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	#Mailbox
	if get_selected_id() == 3:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	#print(Engine.get_frames_per_second())
	pass
