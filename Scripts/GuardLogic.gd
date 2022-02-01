extends "res://Scripts/PlayerDetection.gd"


onready var Nav2D=get_node("/root").find_node("Navigation2D",true,false)
onready var Destinations=Nav2D.get_node("Destinations")

var Motion
var PossibleDestinations
var ArrSize
var NavPath

export var ArrivalThreshold :float =5.0
export var WalkSpeed: float=0.5



func _ready():
	randomize()
	PossibleDestinations=Destinations.get_children()
	ArrSize=PossibleDestinations.size()
	print(ArrSize)
	make_path()
	

func _physics_process(delta):
	Navigate()
	

func make_path():
	var NewDestination=PossibleDestinations[randi()%ArrSize]
	NavPath=Nav2D.get_simple_path(position,NewDestination.position,false)
	#print(NavPath)
	

func Navigate():
	if NavPath.size()>0:
		var DistanceToDestination=position.distance_to(NavPath[0])
		if DistanceToDestination>ArrivalThreshold:
			Move()
		else:
			update_path()
	
		
		
func update_path():
	if NavPath.size()==1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		NavPath.remove(0)
		
func Move():
	look_at(NavPath[0])
	Motion=(NavPath[0]-position).normalized()*(MAX_SPEED*WalkSpeed)
	if is_on_wall():
		make_path()
	move_and_slide(Motion)
	

func _on_Timer_timeout():
	make_path()
