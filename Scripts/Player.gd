extends "res://Scripts/CharacterTemplate.gd"

var Motion=Vector2(0,0)
onready var Torch=$Torch
	
func UpdateMovement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		Motion.y=clamp(Motion.y-SPEED,-MAX_SPEED,0)  
	elif Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		Motion.y=clamp(Motion.y+SPEED,0,MAX_SPEED)
	else:
		Motion.y=lerp(Motion.y,0,STOPPING_TIME)
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		Motion.x=clamp(Motion.x+SPEED,0,MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		Motion.x=clamp(Motion.x-SPEED,-MAX_SPEED,0)
	else:
		Motion.x=lerp(Motion.x,0,STOPPING_TIME)
	
	if Input.is_action_just_pressed("ToggleTorch"):
		Torch.enabled=not Torch.enabled
	
func  _physics_process(delta):
	UpdateMovement()
	move_and_slide(Motion)
