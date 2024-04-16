extends CharacterBody2D

var SPEED = 300.0
const JUMP_VELOCITY = -500.0
var Jump_count = 0
var max_jumps = 2


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if (Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("ui_accept")) and Jump_count < max_jumps:
		Jump_count += 1
		velocity.y = JUMP_VELOCITY
	elif Jump_count >= max_jumps and is_on_floor():
		Jump_count = 0
		
		
	if Input.is_action_pressed("dash"):
		SPEED = 555

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
	SPEED = 300
	var plasma_blaster_equiped = true
	var shoot_cooldown = true
	var Plasma_bullet = preload("res://Scenes/plasma_bullet.tscn")
	
	
	if Input.is_action_pressed("Shoot") and plasma_blaster_equiped and shoot_cooldown == true:
		shoot_cooldown = false
		var bullet_instance = Plasma_bullet.instantiate()
		bullet_instance.rotation = $Marker2D.rotation
		bullet_instance.global_position = $Marker2D.global_position
		add_child(bullet_instance)
