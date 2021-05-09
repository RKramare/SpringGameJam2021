extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var thrown = false
var max_force = 20
var impulse_force = max_force

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
	#connect("body_entered", self, "thud")
	pass # Replace with function body.
	
func _physics_process(delta):
	if (thrown):
		var vel_vec = self.linear_velocity
		
		vel_vec = vel_vec.rotated(Vector3(-1,0,0), rotation.x)
		vel_vec = vel_vec.rotated(Vector3(0,-1,0), rotation.y)
		vel_vec = vel_vec.rotated(Vector3(0,0,-1), rotation.z)
		
		vel_vec.y = 0
		
		var power = sqrt(vel_vec.length() / max_force)
		
		
		var vec = Vector3(0,0.4,0)
		vec = vec.rotated(Vector3(1,0,0), rotation.x)
		vec = vec.rotated(Vector3(0,1,0), rotation.y)
		vec = vec.rotated(Vector3(0,0,1), rotation.z)
		
		var off_vec = self.linear_velocity.normalized()/impulse_force*0.00001
		
		vec.y = vec.y/2
		vec = vec*power
		self.apply_impulse(off_vec, vec)
		
	

func _input(event):
	if (event.is_action_released("SHOOT")):

		rotation.z = -0.1
		var test = Vector3(impulse_force,impulse_force/-10,0)
		#test = test.rotated(Vector3(0,1,0), 0.35)
		self.apply_impulse(Vector3(0,0,0), test)
		gravity_scale = 1
		thrown = true
		
	elif (event.is_action_released("RESET")):
		get_tree().reload_current_scene()
		thrown = false
		
	elif event is InputEventMouseButton:
		if event.is_pressed() and thrown == false:
			start = event.position
			start_time = elapsed_time
			print("THUD")
			var thud = self.get_parent().get_parent().get_node("Maps").get_node("thud")
			thud.play()
			yield(thud, "finished")
			
		elif thrown == false:
			direction = event.position - start
			speed = (direction.length())/(elapsed_time - start_time)
			direction = direction.normalized()
			rotation.x = direction[0]*0.8
			
			if speed < 60:
				speed = 0
		
			impulse_force = speed/150.0
			
			var dir = Vector3(impulse_force, impulse_force/10,0)
			dir = dir.rotated(Vector3(0, 1, 0), -direction[0]*0.7)
			
			self.apply_impulse(Vector3(0,0,0), dir)
			gravity_scale = 1
			thrown = true
			

func _process(delta):
	elapsed_time += delta
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


##func _on_FrisbeeRigidBody_body_entered(body):
#	if body.get_name() == "map10part2":
#		self.get_parent().get_node("res://")
