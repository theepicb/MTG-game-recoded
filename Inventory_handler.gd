extends Sprite2D

var shader_material = preload("res://new_shader_material.tres")


var script_running = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




var screen = 0

func loadInv() :
	print(Global._inv.size())
	removeInv()
	var x_positions = []
	var y_positions = []
	var loaded
			
	for i in range(Global._inv.size()):
		x_positions.push_back(360 + ((i % 6) * 220))
		y_positions.push_back(150 + (floor(i / 6) * 400))
		pass
	var stop_condition = Global._inv.size()
	if (stop_condition > 12) :
		if (Global._inv.size() > 12 * (screen + 1)) :
			stop_condition = 12
		else:
			stop_condition = stop_condition % 12
	else:
		stop_condition = min(12 * (screen + 1), Global._inv.size())
		pass
	for i in range(stop_condition):
		script_running = true
		print(Global._inv[i])
		var price = Label.new();
		price.position.x = 300 + ((i % 6) * 220)
		price.position.y = 300 + (floor(i / 6) * 350)
		price.text = "$" + str(Global._inv[i].price)
		price.add_theme_font_size_override("font_size", 20)
		add_child(price)
		
		var countLabel = Label.new()
		countLabel.position.x = 400 + ((i % 6) * 220)
		countLabel.position.y = 300 + (floor(i / 6) * 350)
		countLabel.set_text("x" +  str(Global._inv[i + (screen * 12)]["owned"]))
		countLabel.add_theme_font_size_override("font_size", 20)
		add_child(countLabel)
		
		if (stop_function == true):
			script_running = false
			stop_function = false
			break
			pass
		
		$"../Card_Grabber".create_object(Global._inv[i + (screen * 12)]["set"], Global._inv[i + (screen * 12)]["num"], Global._inv[i + (screen * 12)]["foil"], x_positions[i], y_positions[i])
		await $"../HTTPRequest2".request_completed

		pass
	if ((screen + 1) * 12 < len(Global._inv)):
		var forwardButton = Button.new()
		forwardButton.position = Vector2(120, 200)
		forwardButton.size = Vector2(50, 40)
		forwardButton.set_text("next")
		forwardButton.pressed.connect(self._button_pressed)
		add_child(forwardButton)
		pass
			
	if (screen > 0) :
		var backButton = Button.new()
		backButton.position = Vector2(200, 200)
		backButton.size = Vector2(50, 40)
		backButton.set_text("back")
		backButton.pressed.connect(self._back_button_pressed)
		add_child(backButton)
		pass
	stop_function = false
	script_running = false
	pass

var shader_time = 0.0


func _button_pressed() :
	if script_running:
		stop_function = true
	screen = screen + 1
	loadInv()
	pass

func _back_button_pressed () :
	if script_running:
		stop_function = true
		pass
	screen = screen - 1 
	loadInv()
	pass

	
func removeInv() :
	for child in $".".get_children():
		child.queue_free()
		pass
		$"../Card_Grabber".deleteChild()
		$"../HTTPRequest".cancel_request()
		$"../HTTPRequest2".cancel_request()
		script_running = false
		stop_function = false
	pass
	
var stop_function = false
	
func getPrice (set, num, foil, x) :
	var price = Label.new()

	if foil == true :
		price.text = "$" + (str(set[num]["foil"]))
		print("num: " + str(num))
	else:
		price.text = "$" + (str(set[num]["nf"]))
		print("num: " + str(num))
		pass
	price.position.x = 275 + ((x % 6) * 275)
	price.position.y = 220 + (floor(x / 6) * 500)
	price.add_theme_font_size_override("font_size", 20)
	add_child(price)
	pass
