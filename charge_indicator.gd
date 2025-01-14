extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".modulate.a = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if size.x == 0: #very bad
		charge_end()
	
	if $"../../CharacterBody3D".charge_cooldown == 0 and $".".modulate.a == 1:
		create_tween().tween_property($".", "modulate:a", 0, .25).set_trans(Tween.TRANS_QUART)
	pass

func charge_start():
	$".".modulate.a = 1
	create_tween().tween_property($".", "size", Vector2(0,48), 0.5).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($".", "anchors_preset", PRESET_CENTER_BOTTOM, 0.5).set_trans(Tween.TRANS_SINE)

func charge_end():
	create_tween().tween_property($".", "size", Vector2(192,48), 1).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($".", "anchors_preset", PRESET_CENTER_BOTTOM, 1).set_trans(Tween.TRANS_SINE)
