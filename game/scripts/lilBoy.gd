extends CharacterBody2D


const SPEED:float = 150.0
const JUMP_VELOCITY:float = -300.0
const OUT_WALL_SPEED:float = 10.0
const MAX_LIFE_POINT:int = 100
const FALL_DAMAGE_SPEED_THRESHOLD:float = 375.0
const FALL_DAMAGE_MULTIPLIER:float = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
var portal:Portal


var life_point:int = 100
var can_heal:bool = true
var healing_cooldown:float = 2.0




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
	
	var damages = get_fall_damages()
	lose_life(damages)
	

	
func _process(_delta):
	_animated_sprite.play("idle")
	
	#summon portal
	if Input.is_action_just_pressed("create_portal"):
		if portal != null:
			portal.queue_free()
		portal = Portal.summon_portal(self.position,get_viewport().get_camera_2d(),self)
		self.add_sibling(portal)
		portal.teleported.connect(_on_warping)
		
	# retrieve portal
	if Input.is_action_just_pressed("retrieve_portal"):
		if portal != null:
			portal.queue_free()
	
	ScoreManager.add_warpflow(get_velocity().length_squared()*_delta)
	
	

func _on_collide_in_wall(body):
	print("VERRRY STUUCK "+str(body.name))
	position-=Vector2(0,OUT_WALL_SPEED)
	lose_life(10)
	

func _on_warping():
	print("WARPING")
	if can_heal:
		print("heal")
		life_point = MAX_LIFE_POINT
		can_heal = false
		get_tree().create_timer(healing_cooldown).timeout.connect(func(): can_heal = true)
	
	
func lose_life(hurt_point:int):
	if hurt_point > 0:
		life_point-=hurt_point
		$AudioStreamPlayer2D.play()
		print("HURT !! life "+str(life_point))
	

func get_fall_damages():
	var damages = 0
	if get_slide_collision_count() >> 0 and is_on_floor():
		var exec_speed = get_real_velocity().length()-FALL_DAMAGE_SPEED_THRESHOLD
		damages = exec_speed*FALL_DAMAGE_MULTIPLIER
	if damages > 0 :
		print("THAT A LOT OF DAMAGES " + str(damages))
	return damages
