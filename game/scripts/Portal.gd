class_name Portal
extends Node2D

const _portal_scene: PackedScene = preload("res://game/game_objects/portal.tscn")
const portal_cooldown: float = 0.1
const portal_offset: float = 11
const portal_distance:float = 75
const _characterCenterOffset: Vector2 = Vector2(0.0,-1.0)


var is_portal_active: bool = false
var teleport_vector: Vector2


@onready var entry: Area2D = get_node("entry")
@onready var exit: Area2D = get_node("exit")

# Called when the node enters the scene tree for the first time.
func _ready():
	# place the exit
	exit.position = Vector2(portal_distance,0)
	# calculate the vector to apply character to travel through portal
	teleport_vector = exit.global_position - entry.global_position
	$entry/entrySprite.play("warping")
	$exit/exitSprite.play("warping")
	is_portal_active = true


static func summon_portal(portal_origin:Vector2,camera:Camera2D, characterPos:Vector2) -> Portal:
	var portal: Portal = _portal_scene.instantiate()
	var portal_orientation = _get_portal_direction(camera, characterPos)
	portal.position = portal_origin+_characterCenterOffset+Vector2.from_angle(portal_orientation)*portal_offset
	portal.rotation = portal_orientation
	
	return portal


static func _get_portal_direction(camera:Camera2D, characterPos: Vector2) -> float :
	var mouse_pos = camera.get_global_mouse_position() 
	var mouse_orient = (characterPos+_characterCenterOffset).angle_to_point(mouse_pos)
	return mouse_orient


func _body_entered_portal(body:Node2D):
	if body.position.distance_to(exit.global_position) <= 30 :
		teleportation(body,false)
	else :
		teleportation(body,true)



func teleportation(body:Node2D,is_door1:bool):
	if is_portal_active :
		if body.get_groups().has("player") :
			#prevent auto infinite teleportation by cooldown
			is_portal_active=false
			get_tree().create_timer(portal_cooldown).timeout.connect(func(): is_portal_active = true)
			# teleport
			if (is_door1) :
				body.translate(teleport_vector)
			else:
				body.translate(-teleport_vector)
