extends "res://Scripts/CharacterTemplate.gd"


const FOV_TOLERANCE=19
const DISTANCE_TOLERANCE=640
const RED=Color(1,0,0)
const WHITE=Color(1,1,1)

#Get player node
onready var Player=get_node("/root").find_node("Player",true,false)
#Get animation node
onready var MoveAnimation=$"../AnimationPlayer"


func _ready():
	MoveAnimation.play("Rotate")
		
func _process(delta):
	if PlayerInFOV() and PlayerInLOS():
		$Torch.color=RED
	else:
		$Torch.color=WHITE
		
		
func PlayerInFOV():
	if Player==null:
		return false	
	#Get the current orientation of the camera with respect to X Axis unit vector
	var NPC_Facing_Direction=Vector2(1,0).rotated(global_rotation)
	#Get the direciton to the player
	var DirectionToPlayer=(Player.position-global_position).normalized()
	#If the player is less than 20 degs off of the orientation 0f the camera, return true
	if abs(DirectionToPlayer.angle_to(NPC_Facing_Direction))<deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false
	
		
		
func PlayerInLOS():
	#Get the global physics process
	var Space=get_world_2d().direct_space_state
	#Ray cast from camera to player
	var LOS_Obstacle=Space.intersect_ray(global_position,Player.position,[self],collision_mask)
	#If theres no result,return false
	if not LOS_Obstacle:
		return false
	#Get distance to player
	var DistanceToPlayer=global_position.distance_to(Player.global_position)
	var PlayerInRange=DistanceToPlayer<DISTANCE_TOLERANCE
	#If player in range of camera and can be hit by raycast,return true
	if LOS_Obstacle.collider==Player and PlayerInRange:
		return true
	else:
		return false
	return true
	
	
	
