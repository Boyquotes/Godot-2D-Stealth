extends CanvasModulate
#const DARK=Color("484848")
const DARK=Color("1e1f1d")
const NIGHTVISION=Color("8ee263")
var Cooldown=false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interface")
	set_color(DARK)
	
func ChangeColour():
	if not Cooldown:
		if get_color()==NIGHTVISION:
			GoDark()
			Cooldown=true
		elif get_color()==DARK:
			GoLight()
		

func GoDark():
	set_color(DARK)
	$NightVisionAudio.stream=load("res://SFX/nightvision_off.wav")
	$NightVisionAudio.play()
	$Timer.start()

func GoLight():
	set_color(NIGHTVISION)
	$NightVisionAudio.stream=load("res://SFX/nightvision.wav")
	$NightVisionAudio.play()
	


func _on_Timer_timeout():
	Cooldown=false
