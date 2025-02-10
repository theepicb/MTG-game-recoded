extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".size.x = 200
	$".".size.y = 60
	$".".position.y = 180
	$".".position.x = 0
	$".".text = "packs"
	pass 

var packScale = [.35, 1]

func _pressed():
	if $"../Inventory_handler".script_running == true:
		$"../Inventory_handler".stop_function = true
		pass
	$".".deleteChild()
	$"../upgrades".deleteChild()
	$"../ShopButton".deleteChild()
	$"../Money_Clicker".visible = false
	$"../Combo_Counter".visible = false
	$"../Inventory_handler".removeInv()
	var x = 0
	var have = 0;
	for i in range(Global._packsinv.size()):
		if Global._packsinv[x] > 0:
			checkpack(x, 250, 100, 120, 0)
			have = 1
			pass
		x += 1
		pass
	if have == 0:
		var display = Label.new()
		add_child(display)
		display.position.x = get_viewport_rect().size.x / 2 - 130
		display.position.y = get_viewport_rect().size.y / 2 - 300
		display.text = "unlock packs in the upgrades tab!"
		display.add_theme_font_size_override("font_size", 25)
		print("iongiojrngon")
			
	pass
	
func deleteChild():
	for child in $".".get_children():
		child.queue_free()
		pass
	pass

func openpack(x) :
	$"../Card_Handler".openpack(x)
	Global._packsinv[x] = Global._packsinv[x] - 1
	deleteChild()
	pass
	
	
func checkpack(x, offsetx, offsety, extraoffset, i) :
	var button = Button.new()
	button.position.x = offsetx + ((x % 4) * 250)
	button.position.y = floor(x/4) - 70
	button.size.x = 230
	button.size.y = 400
	button.pressed.connect(self.openpack.bind(float(x)))
	add_child(button)
	var packsprite = Sprite2D.new()
	packsprite.set_texture(load(Global._packid[x]))
	add_child(packsprite)
	packsprite.position.x = offsetx + ((x % 4) * 250) + extraoffset
	packsprite.position.y = (floor(x/4) * 1.2) + 110
	packsprite.scale = Vector2(packScale[x], packScale[x])
	var label = Label.new()
	label.set_text("owned: " + str(Global._packsinv[x]))
	label.position.x = offsetx + ((x % 4) * 250) + 60
	label.position.y = (floor(x/4) * 1.2) + 290
	label.add_theme_font_size_override("font_size", 25)
	add_child(label)
	pass
pass
