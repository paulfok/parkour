extends CharacterBody3D

var Menu = 1
var slide = 0
var sliding = 0
var charge_time = 0
var charging = 0
var charge_cooldown = 0
var nearwallleft
var nearwallright
var nearwall
var nearwallleftright
var nearwallforward
var nearwallbackward

var SPEED = 5.0
const JUMP_VELOCITY = 5
@export_range(0, 10, 0.01) var sensitivity : float = 3

func _input(event):
	
	if Menu == 1:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x / 1000 * sensitivity
			$Camera3D.rotation.x -= event.relative.y / 1000 * sensitivity
			$Camera3D.rotation.x = clamp($Camera3D.rotation.x, PI/-2, PI/2)

func _physics_process(delta: float) -> void:


	if Menu == 0:
		$"../Menus".hide()
	else:
		$"../Menus".show()
		velocity.x = 0
		velocity.y = 0
		velocity.z = 0
		
		

	if Menu == 0:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("jump") and is_on_floor() and sliding == 1:
			velocity.y = 7.5
			var input_dir := Input.get_vector("left", "right", "forward", "backward")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			velocity.x = direction.x * (SPEED + 2.5)
			velocity.z = direction.z * (SPEED + 2.5)
		
		if Input.is_action_just_pressed("charge") and charging == 0 and charge_cooldown == 0:
			$"../Control/ChargeIndicator".charge_start()
			charge_time = 0.5
			charge_cooldown = 1.5
			
		if charge_time > 0:
			charge_time -= 1 * delta
			if nearwall == 1 and not is_on_floor() and Input.is_action_just_pressed("jump") and nearwallbackward == 1:
				velocity.y = 15
				var input_dir := Input.get_vector("left", "right", "forward", "backward")
				var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
				SPEED += 4
				create_tween().tween_property($".", "SPEED", 5, 2).set_trans(Tween.TRANS_QUART)
				charging = 0
				
		if charge_time <= 0:
			charge_time = 0
			charging = 0
				
		if charge_cooldown > 0:
			charge_cooldown -= 1 * delta
			if charge_cooldown <= 0:
				charge_cooldown = 0

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if sliding == 0 and is_on_floor():
			var input_dir := Input.get_vector("left", "right", "forward", "backward")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction:
				velocity.x *= 0.9
				velocity.z *= 0.9
				velocity.x += (direction.x * SPEED * 0.15)
				velocity.z += (direction.z * SPEED * 0.15)
			else:
				velocity.x *= 0.9
				velocity.z *= 0.9
				
		if sliding == 0 and not is_on_floor():
			var input_dir := Input.get_vector("left", "right", "forward", "backward")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction:
				velocity.x *= 0.975
				velocity.z *= 0.975
				velocity.x += (direction.x * SPEED * 0.025) #* velocity.x
				velocity.z += (direction.z * SPEED * 0.025) #* velocity.z
			
		if Input.is_action_just_pressed("down") and is_on_floor() and slide == 0 and abs(velocity.x) + abs(velocity.z) > 5:
			create_tween().tween_property($Camera3D, "position", Vector3(0,0.35,0), 0.25).set_trans(Tween.TRANS_QUART)
			var input_dir := Input.get_vector("left", "right", "forward", "backward")
			var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			SPEED += 5
			velocity.x = direction.x * (SPEED)
			velocity.z = direction.z * (SPEED)
			create_tween().tween_property($".", "SPEED", 5, 2).set_trans(Tween.TRANS_QUART)
			slide = 1
			sliding = 1
			
		if slide > 0:
			slide -= 1 * delta
			if slide < 0:
				slide = 0
		
		if Input.is_action_just_released("down") and slide > 0 or Input.is_action_just_pressed("jump") and slide > 0 or slide == 0 and sliding == 1:
			create_tween().tween_property($Camera3D, "position", Vector3(0,1.5,0), 0.25).set_trans(Tween.TRANS_QUART)
			sliding = 0
			slide = 0
			
		if Input.is_action_just_pressed("respawn"):
			position.x = 0
			position.y = 0
			position.z = 0
		if Input.is_action_just_pressed("menu"):
			Menu = 1
	if $CollisionShape3D/LeftWall.is_colliding():
		nearwallleft = 1
		nearwall = 1
	else:
		nearwallleft = 0
	if $CollisionShape3D/RightWall.is_colliding():
		nearwallright = 1
		nearwall = 1
	else:
		nearwallright = 0
	if $CollisionShape3D/ForwardWall.is_colliding():
		nearwallforward = 1
		nearwall = 1
	else:
		nearwallforward = 0
	if $CollisionShape3D/BackwardWall.is_colliding():
		nearwallbackward = 1
		nearwall = 1
	else:
		nearwallbackward = 0
	if not $CollisionShape3D/RightWall.is_colliding() and not $CollisionShape3D/LeftWall.is_colliding():
		nearwallleftright = 0
	if not $CollisionShape3D/RightWall.is_colliding() and not $CollisionShape3D/LeftWall.is_colliding() and not $CollisionShape3D/BackwardWall.is_colliding() and not $CollisionShape3D/ForwardWall.is_colliding():
		nearwall = 0
	move_and_slide()
