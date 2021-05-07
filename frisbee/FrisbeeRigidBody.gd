extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true);
	pass # Replace with function body.

func _input(event):
	if (event.is_action_released("SHOOT")):
		self.apply_impulse(Vector3(0,0,0), Vector3(35,10,0))
	if (event.is_action_released("RESET")):
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
