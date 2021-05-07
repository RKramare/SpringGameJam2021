extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var maps = ["res://Minimap/map01.png", "res://Minimap/map02.png"]
var mapIndex = 0
onready var mapSprite = get_node("mapSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if (event.is_action_released("NEXTMAP")):
		mapIndex = 0 if (mapIndex == 17) else mapIndex + 1
		print(mapIndex)
		var mapStr = "res://Minimap/map" + str(mapIndex+1) + ".png"
		print(mapStr)
		var mapTexture = load(mapStr)
		mapSprite.set_texture(mapTexture) #maps[mapIndex])
		
	if (event.is_action_released("MAP")):
		if (mapSprite.visible):
			mapSprite.hide()
		else:
			mapSprite.show()
			
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
