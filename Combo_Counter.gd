extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	position.x = get_viewport_rect().size.x/2 - size.x / 2 + 15
	position.y = get_viewport_rect().size.y/2 - size.y/2 +50
	size = Vector2(50, 50)
	
	
	# math for combo, only appliciable over 10 clicks, shouldnt really be here but i am silly :p
	$"../Money_Clicker".counter = $"../Money_Clicker".counter + 1
	if $"../Money_Clicker".counter > 60 :
		$"../Money_Clicker".clicks = 0
		pass
	if $"../Money_Clicker".clicks > 10:
		set_text(str($"../Money_Clicker".clicks/10) + "%")
	else:
		set_text("0%")
		pass 



	pass
