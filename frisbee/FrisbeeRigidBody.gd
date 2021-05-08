extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var thrown = false
var impulse_force = 80

# Mouse logic variables
var elapsed_time = 0    
var start
var speed
var start_time
var direction

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
		
		var power = 0.1
		if (impulse_force > 0):
			power = vel_vec.length() / impulse_force
		
		
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
		
	elif (event.is_action("LEFT")):
		rotation.x = rotation.x - 0.03
		
	elif (event.is_action("RIGTH")):
		rotation.x = rotation.x + 0.03
		print(rotation.x)
		
	elif (event.is_action_released("RESET")):
		get_tree().reload_current_scene()
		thrown = false
		
	elif event is InputEventMouseButton:
		if event.is_pressed():
			start = event.position
			start_time = elapsed_time
			print(event.position)
			
		elif thrown == false:
			direction = event.position - start
			speed = (direction.length())/(elapsed_time - start_time)
			direction = direction.normalized()
			rotation.x = direction[0]*0.8
			
			if speed < 60:
				speed = 0
		
			impulse_force = speed/100.0
			
			var dir = Vector3(impulse_force, impulse_force/10,0)
			dir = dir.rotated(Vector3(0, 1, 0), -direction[0]*0.7)
			
			self.apply_impulse(Vector3(0,0,0), dir)
			gravity_scale = 1
			thrown = true
			
#	elif event is InputEventMouseMotion:
#		if (event.get_pressure() > 0) and thrown == false:
#			print(translation)
#			translation = Vector3(event.position[0], event.position[1], 0)
			

func _process(delta):
	elapsed_time += delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
