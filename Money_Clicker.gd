extends Button
# Counts amount of clicks
var counter = 0;
var totalClicks = 0;
var clicks = 0
func _ready():
	size = Vector2(600, 220)
	var timer = Timer.new ()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)
	timer.start()
	pass 

func _on_Timer_timeout () :
	Global._money  = Global._money + Global._automoney
	pass

func _pressed():
	# Math for combo 10 clicks = 1%
	Global._money = Global._money + ((Global._moneyClick * Global._moneyclickmulti) * (1 + float(clicks) / 1000));
	clicks = clicks + 1
	counter = 0
	Global._clicksTotal = Global._clicksTotal + 1;
	$"../Achievement_Handler".clickerCounter()
	pass


func _process(delta):
	set_text("$" + str("%1.2f" % Global._money))
	position.x = get_viewport_rect().size.x/2 - $".".size.x / 2
	position.y = get_viewport_rect().size.y/2 - $".".size.y/2 +10
	pass

func getMoney():
	Global._money = Global._money + Global._automoney
	await get_tree().create_timer(1.0).timeout
	getMoney()
	pass



	
func hidebutton():
	$".".visible = false
	pass
	
