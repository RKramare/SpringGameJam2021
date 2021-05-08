extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var thrown = false
var impulse_force = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true);
	gravity_scale = 0
	pass # Replace with function body.
	
func _physics_process(delta):
	if (thrown):
		var vel_vec = self.linear_velocity
		
		vel_vec = vel_vec.rotated(Vector3(-1,0,0), rotation.x)
		vel_vec = vel_vec.rotated(Vector3(0,-1,0), rotation.y)
		vel_vec = vel_vec.rotated(Vector3(0,0,-1), rotation.z)
		
		vel_vec.y = 0
		
		var power = vel_vec.length() / impulse_force
		
		var vec = Vector3(0,0.5,0)
		vec = vec.rotated(Vector3(1,0,0), rotation.x)
		vec = vec.rotated(Vector3(0,1,0), rotation.y)
		vec = vec.rotated(Vector3(0,0,1), rotation.z)
		
		var off_vec = self.linear_velocity.normalized()/impulse_force*0.1
		
		vec.y = vec.y/3
		vec = vec*power
		self.apply_impulse(off_vec, vec)
	

func _input(event):
	if (event.is_action_released("SHOOT")):
		self.apply_impulse(Vector3(0,0,0), Vector3(impulse_force,impulse_force/10,0))
		gravity_scale = 1
		thrown = true
	if (event.is_action("LEFT")):
		rotation.x = rotation.x - 0.03
	if (event.is_action("RIGTH")):
		rotation.x = rotation.x + 0.03
	if (event.is_action_released("RESET")):
		get_tree().reload_current_scene()
		thrown = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
