extends Sprite2D

var shader_material = preload("res://new_shader_material.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func itemPositionWithValue(key_to_check, value_to_check):
	for i in range(inv.size()):
		var item = inv[i]
		if item.has(key_to_check) and item[key_to_check] == value_to_check:
			return i
	return -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var inv = []

func createCard (card, choice) :
	var temp = itemPositionWithValue("name", str(card.id))
	if  temp == -1:
		var child = Sprite2D.new()
		child.texture = load(Global._imageram[choice - 1])
		if (card.foil == true): 
			child.material = shader_material
			pass
		child.position = Vector2(-300, -300)
		child.name = card.id
		child.scale = Vector2(0.29, 0.29)
		inv.push_back({"name" : card.id, "info": card, "count": 1})
		add_child(child)
		print("made child")
		pass
		print(get_node(str(inv[0].name)))
		print(inv)
	else:
		inv[float(temp)].count = inv[float(temp)].count + 1
		print(inv)
		pass
var screen = 0

func loadInv() :
	removeInv()
	var x_positions = []
	var y_positions = []
	var loaded
	for i in range(inv.size()):
		x_positions.push_back(360 + ((i % 6) * 275))
		y_positions.push_back(150 + (floor(i / 6) * 500))
		pass
	var stop_condition = inv.size()
	if (stop_condition > 12) :
		if (inv.size() > 12 * (screen + 1)) :
			stop_condition = 12
		else:
			stop_condition = stop_condition % 12
	else:
		stop_condition = min(12 * (screen + 1), (inv).size())
		pass
	for i in range(stop_condition):
		get_node(str(inv[i + (screen * 12)].name)).position = Vector2(x_positions[i], y_positions[i])
		pass
		

		
		var price = Label.new();
		price.position.x = 300 + ((i % 6) * 275)
		price.position.y = 300 + (floor(i / 6) * 500)
		price.text = "$" + str(inv[i].info.price)
		price.add_theme_font_size_override("font_size", 20)
		add_child(price)
		
		var countLabel = Label.new()
		countLabel.position.x = 400 + ((i % 6) * 275)
		countLabel.position.y = 300 + (floor(i / 6) * 500)
		countLabel.set_text("x" +  str(inv[i + (screen * 12)]["count"]))
		countLabel.add_theme_font_size_override("font_size", 20)
		add_child(countLabel)
		
		if ((screen + 1) * 12 < len(inv)) :
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
	pass

var shader_time = 0.0


func _button_pressed() :
	screen = screen + 1
	loadInv()
	pass

func _back_button_pressed () :
	screen = screen - 1 
	loadInv()
	pass

	
func removeInv() :
	for child in $".".get_children():
		if child.get_class() == "Label" or child.get_class() == "Button":
			child.queue_free()
			pass
		child.position = Vector2(-300, -300)
		pass
	pass
	
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

