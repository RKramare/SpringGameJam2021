extends Control


func _ready():
	var bg = get_node("bgSprite")
	var viewportWidth = get_viewport().size.x
	var viewportHeight = get_viewport().size.y
	var scale = viewportWidth / bg.texture.get_size().x

	bg.set_position(Vector2(viewportWidth/2, viewportHeight/2-50))
	bg.set_scale(Vector2(scale, scale))
