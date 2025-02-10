extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".size.x = 200
	$".".size.y = 60
	$".".position.y = 240
	$".".position.x = 0
	$".".text = "inventory"
	pass # Replace with function body.


func _pressed():
	$"../Inventory_handler".stop_function = true
	if $"../Inventory_handler".script_running != true:
		$"../Inventory_handler".stop_function = false
		$"../Inventory_handler".loadInv()
		$"../Money_Clicker".visible = false
		$"../Combo_Counter".visible = false
		$"../ShopButton".deleteChild()
		$"../Packs_Inventory".deleteChild()
		pass
	pass
