extends Button

func _ready():
	size = Vector2(600, 220)
	var timer = Timer.new ()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()
	pass 

# adds money every second based on auto money (you dont wanna know how i did it before... hint: memory leak)
func _on_Timer_timeout () :
	Global._money  = Global._money + Global._automoney
	pass

# timer before combo stops
var counter = 0;
# Counts amount of clicks for combo, gets reset after time of not clicking
var clicks = 0

func _pressed():
	# Math for combo 10 clicks = 1%
	# combo reset is in combo counter node for some reason and cant be assed moving it back
	Global._money = Global._money + ((Global._moneyClick * Global._moneyclickmulti) * (1 + float(clicks) / 1000));
	clicks = clicks + 1
	counter = 0
	Global._clicksTotal = Global._clicksTotal + 1;
	# tells achievement handler that thine butten been cickered
	$"../Achievement_Handler".clickerCounter()
	pass


func _process(delta):
	# sets text to amount of money
	set_text("$" + str("%1.2f" % Global._money))
	position.x = get_viewport_rect().size.x/2 - $".".size.x / 2
	position.y = get_viewport_rect().size.y/2 - $".".size.y/2 +10
	pass

# function to make the button invisible (im not telling you where i hide it)
func hidebutton():
	$".".visible = false
	pass
	
