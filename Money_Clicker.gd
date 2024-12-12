extends Button
# Counts amount of clicks
var clicks = 0;
var counter = 0;
var totalClicks = 0;
# Creates new label for combo 

func _ready():
	size = Vector2(600, 220)
	pass 

func _pressed():
	# Math for combo 10 clicks = 1%
	Global._money = Global._money + ((Global._moneyClick * Global._moneyclickmulti) * (1 + float(clicks) / 1000));
	clicks = clicks + 1
	counter = 0
	totalClicks = totalClicks + 1
	pass


func _process(delta):
	set_text("$" + str("%1.2f" % Global._money))
	position.x = get_viewport_rect().size.x/2 - $".".size.x / 2
	position.y = get_viewport_rect().size.y/2 - $".".size.y/2 +10
	pass


	
func hidebutton():
	$".".visible = false
	pass
	




