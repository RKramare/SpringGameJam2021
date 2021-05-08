extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var bg = get_node("map_big_4")
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scale = viewportWidth / bg.texture.get_size().x

	bg.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	bg.set_scale(Vector2(scale, scale))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btnStartGame_button_up():
	get_tree().change_scene("res://World.tscn")
