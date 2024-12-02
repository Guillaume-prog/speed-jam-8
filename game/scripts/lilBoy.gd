extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const OUT_WALL_SPEED = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var portal:Portal
var is_stuck_in_wall=false


@onready var _animated_sprite = $AnimSpriteLilBoy

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	_exit_wall_stuck(is_wall_stuck())
	
	
func _process(delta):
	_animated_sprite.play("idle")
	
	#summon portal
	if Input.is_action_just_pressed("create_portal"):
		if portal != null:
			portal.queue_free()
		portal = Portal.summon_portal(self.position,get_viewport().get_camera_2d(),global_position)
		self.add_sibling(portal)
	# retrieve portal
	if Input.is_action_just_pressed("retrieve_portal"):
		if portal != null:
			portal.queue_free()


func is_wall_stuck():
	#prevent inside wall teleportation
	if is_on_wall() and not is_on_floor():
		print("STUCK")
		return true
	else:
		return false


func _exit_wall_stuck(is_wall_stuck:bool):
	if is_wall_stuck():
		is_stuck_in_wall = true
		$CollisionShape2D.disabled = true
		position-=Vector2(0,OUT_WALL_SPEED)

		# TODO: add damage and healing ?
	else :
		is_stuck_in_wall = false
		$CollisionShape2D.disabled = false
	
	
	
