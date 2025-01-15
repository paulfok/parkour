extends VBoxContainer
var OptionsOpened = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if OptionsOpened == 1:
		show()
		if Input.is_action_pressed("menu"):
			OptionsOpened = 0
			hide()
			print("e")
	pass
