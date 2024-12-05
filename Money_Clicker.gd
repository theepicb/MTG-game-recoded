extends Button

var clicks = 0;
var counter = 0;
var totalClicks = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str("$" + str(Global._money)))
	pass # Replace with function body.

func _pressed():
	Global._money = Global._money + ((Global._moneyClick * Global._moneyclickmulti) * (1 + float(clicks) / 1000))
	clicks = clicks + 1
	counter = 0
	totalClicks = totalClicks + 1
	pass


func _process(_delta):
	set_text("$" + str("%1.2f" % Global._money))
	counter = counter + 1
	if counter > 60 :
		clicks = 0
		pass
	if clicks > 10:
		$"../Label1".set_text(str(clicks/10) + "%")
	else:
		$"../Label1".set_text("0%")
		pass 
		position.x = get_viewport_rect().size.x/2 - $".".size.x / 2
		position.y = get_viewport_rect().size.y/2 - $".".size.y/2 +10
		$"../Label1".position.x = get_viewport_rect().size.x/2 - $"../Label1".size.x / 2 + 15
		$"../Label1".position.y = get_viewport_rect().size.y/2 - $"../Label1".size.y/2 +50
		$"../Label1".size.x = 50
		$"../Label1".size.y = 50
	pass
	
func hidebutton():
	$".".visible = false
	pass
	




