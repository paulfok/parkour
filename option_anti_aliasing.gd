extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Anti-Aliasing"
	if get_selected_id() == 0:
		get_viewport().msaa_3d = 0 as Viewport.MSAA
	if get_selected_id() == 1:
		get_viewport().msaa_3d = 1 as Viewport.MSAA
	if get_selected_id() == 2:
		get_viewport().msaa_3d = 2 as Viewport.MSAA
	if get_selected_id() == 3:
		get_viewport().msaa_3d = 3 as Viewport.MSAA
