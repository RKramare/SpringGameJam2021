extends Spatial

func _ready():
	pass 


func _on_OutOfMapArea_body_entered(body):
	var name = body.get_name()
	
	if name == "FrisbeeRigidBody":
		get_tree().reload_current_scene()


func _on_GoalArea_body_entered(body):
	var name = body.get_name()
	
	if name == "FrisbeeRigidBody":
		print("GOAL!")
