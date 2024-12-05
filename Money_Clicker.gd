extends Button
# Counts amount of clicks
var clicks = 0;
var counter = 0;
var totalClicks = 0;
# Creates new label for combo 
var comboCounter = Label.new()

func _ready():
	size = Vector2(600, 220)
	add_child(comboCounter)
	pass 

func _pressed():
	# Math for combo 10 clicks = 1%
	Global._money = Global._money + ((Global._moneyClick * Global._moneyclickmulti) * (1 + float(clicks) / 1000));
	clicks = clicks + 1
	counter = 0
	totalClicks = totalClicks + 1
	pass




func _process(_delta):
	# Sets money to 2 dp
	set_text("$" + str("%1.2f" % Global._money))
	# math for combo, only appliciable over 10 clicks
	counter = counter + 1
	if counter > 60 :
		clicks = 0
		pass
	if clicks > 10:
		comboCounter.set_text(str(clicks/10) + "%")
	else:
		comboCounter.set_text("0%")
		pass 
		position = Vector2(get_viewport_rect().size.x/2 - size.x/2, (get_viewport_rect().size.y/2) - (size.y /2))
		# i am going insane
		comboCounter.position = Vector2(position.x / 2 + 300, position.y / 2 - (comboCounter.size.y /2))
		comboCounter.size = Vector2(50, 50)
		print( get_viewport_rect().size)
	pass
	
func hidebutton():
	$".".visible = false
	pass
	




