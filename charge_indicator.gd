extends ColorRect

var start_tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if size.x == 0: #very bad
		charge_end()
	
	if $"../../CharacterBody3D".charge_cooldown == 0 and $".".modulate.a == 1:
		create_tween().tween_property($".", "modulate:a", 0, .25).set_trans(Tween.TRANS_QUART)

func charge_end_jump():
	start_tween.kill()
	size.x = 0
	charge_end()

func charge_start():
	color = Color8(0,255,0)
	$".".modulate.a = 1
	start_tween = create_tween()
	start_tween.tween_property($".", "size", Vector2(0,24), 0.5).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($".", "anchors_preset", PRESET_CENTER_BOTTOM, 0.5).set_trans(Tween.TRANS_SINE)

func charge_end():
	color = Color8(255,255,255)
	create_tween().tween_property($".", "size", Vector2(192,24), 1).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property($".", "anchors_preset", PRESET_CENTER_BOTTOM, 1).set_trans(Tween.TRANS_SINE)
