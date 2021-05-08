extends Control

var tex3 = preload("res://Maps/map_10/map_10_3.JPG")
var tex0 = preload("res://Maps/map_10/map_10_0.JPG")
var bg

func _ready():
	bg = get_node("bgSprite")
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scale = viewportWidth / bg.texture.get_size().x

	bg.set_position(Vector2(viewportWidth/2, viewportHeight/2-50))
	bg.set_scale(Vector2(scale, scale))


func _input(event):
	
	if (event.is_action("LEFT")):
		bg.set_texture(tex3)
	elif (event.is_action("RIGTH")):
		bg.set_texture(tex0)
