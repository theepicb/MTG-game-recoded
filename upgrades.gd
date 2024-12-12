extends Button

func _ready():
	size = Vector2(200, 60)
	position.y = 60
	text = "upgrades"
	pass

var i = 0
# Called when the node enters the scene tree for the first time.
func createButton():
	deleteChild()
	#$"../shopButton".deleteschild()
	$"../Money_Clicker".visible = false
	$"../Combo_Counter".visible = false
	#$"../Button5".deleteschildren()
	#$"../Button4".removeInv()
	var x = 0
	if float(Global._upgradesUnlocked.size()) != 0:
		while x < float(Global._upgradesUnlocked.size()):
			i = float(Global._upgradesUnlocked[x])
			var button = Button.new()
			button.pressed.connect(self._button_pressed.bind(float(x), float(i)))
			button.position = Vector2(210, 20 + x * 70)
			button.size = Vector2(700, 65)
			add_child(button)
			var label = Label.new()
			label.text = Global._upgrades[i].name
			label.position.y = 25 + x * 70
			label.position.x = 230
			add_child(label)
			var labeldes = Label.new()
			labeldes.text = str(Global._upgrades[i].des)
			labeldes.position = Vector2(230, 50 + x * 70)
			add_child(labeldes)
			var price = Label.new()
			price.text = "$" +  str(Global._upgrades[i].price)
			price.position = Vector2(42 + x * 70, 800)
			add_child(price)
			print("button made", x, i)
			x = x + 1
			pass
		pass
	pass

func _button_pressed(x, i):
	if float(Global._money) >= float(Global._upgrades[i].price):
		Global._money = float(Global._money) - float(Global._upgrades[i].price)
		if i == 0:
			Global._moneyClick = float(Global._moneyClick) + 0.01
			pass
		if i == 1:
			
			Global._automoney = float(Global._automoney) + 0.01
			pass
		if i == 2:
			#$"../Button5".makeVisible()
			Global._packsUnlocked.push_back(0)
			pass
		if i == 3:
			Global._packsUnlocked.push_back(1)
			pass
			
		for child in $".".get_children():
			child.queue_free()
			print($".".get_children())
			pass
		Global._upgradesUnlocked.remove_at(x)
		createButton()
		pass
	pass


func _pressed():
	createButton.call()
	print(Global._upgradesUnlocked.size(), Global._upgradesUnlocked)
	text = "upgrades"
	pass
	
var set_text = func (text) :
	text = (str(text))
	pass

func deleteChild():
	for child in $".".get_children():
			child.queue_free()
	pass
