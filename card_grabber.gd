extends Sprite2D

# variables for foil shader
var shader_material = preload("res://new_shader_material.tres")
var shader_time = 0.0

func _process(delta):
	# Accumulate delta time to update shader time
	shader_time += delta
	# Update the time uniform in the shader material
	material.set_shader_parameter("time", shader_time)
	shader_material = preload("res://new_shader_material.tres")
	pass


func _ready ():
	# sets material as a variable for the shader and sets up time change
	material = shader_material
	material.set_shader_parameter("time", shader_time)
	# connects both http requests and connects to functions
	# 2 http requests are needed as scripts need to wait for specifically the second http request to finish
	# also need to find a way to get these running async to speed up draws of cards
	$"../HTTPRequest".request_completed.connect(_on_request_completed)
	$"../HTTPRequest2".request_completed.connect(_on_request_completed2)
	pass

# sets up variables, not really needed but was more for testing phases, could very easily have them removed and changed in script
var url
var posxy = Vector2(0, 0)
var cardname = ""
var isfoil = 2
var cardID

# function called by other nodes wanting to get a card image, scryfalls json file can be called from https://api.scryfall.com/cards/(3 letter set name)/(number in set)
# need to test what happens with specific cards that have an a, b, c varient ect
# set name is 3 letter set name, number is position in set, foil is if the card is foil true/false
func create_object(setname, number, foil, posx, posy):
	posxy = Vector2(posx, posy)
	isfoil = foil
	cardID = createID(str(setname), str(number), foil)
	# url maker
	url = ("https://api.scryfall.com/cards/" + str(setname)+ "/" + str(number))
	$"../HTTPRequest".request(url)
	dir_contents("res://sprites/cards/")
	
	pass

func create_object_quick(url, foil, posx, posy):
	isfoil = foil
	posxy = Vector2(posx, posy)
	$"../HTTPRequest2".request(url)
	
	pass

func _on_request_completed(result, response_code, headers, body):
	# headers 1 is json content type 
	if headers[1] == "Content-Type: application/json; charset=utf-8" :
		# turns json header into text
		var json = JSON.parse_string(body.get_string_from_utf8())
		print(json)
		# gets name of card
		cardname = (json["name"])
		# used to attatch png url from scyfall to card in dictionary to speed up redrawing
		$"../Card_Handler".url = json["image_uris"].png
		if isfoil == 0:
			$"../Card_Handler".price = float(json["prices"].usd)
			pass
		elif isfoil == 1:
			$"../Card_Handler".price = float(json["prices"].usd_foil)
		elif isfoil == 2:
			$"../Card_Handler".price = float(json["prices"].usd_etched)
			pass
		# gets link to png of card in json file and then does a second request for it
		$"../HTTPRequest2".request(json["image_uris"].png)
	pass
	
func _on_request_completed2(result, response_code, headers, body):
	# creates card sprite
	var tempcard = Sprite2D.new()
	# creates image that will later become sprites texture
	var image = Image.new()
	# checks if image can be loaded
	var error = image.load_png_from_buffer(body)
	if error != OK:
		print(error);
	else:
		# turns image into texture (idk the difference ima be honest)
		var texture = ImageTexture.create_from_image(image)
		# sets sprites texture to new made texture
		tempcard.texture = texture;
		# sets pos and scale 
		tempcard.position = posxy
		tempcard.scale = Vector2(0.33, 0.33)
		# sets name grabbed from json file
		tempcard.name = cardname
		# applies foil shader if wanted
		if isfoil == 1:
			tempcard.material = shader_material
			pass
		add_child(tempcard)
		image.save_png("res://sprites/cards/" + str(cardID))
		pass
	
	pass

# function to delete of children from this node
func deleteChild():
	for child in $".".get_children():
			child.queue_free()
	pass
	
func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				if not Global._cardFiles.has(str(file_name)) :
					Global._cardFiles.push_back(String(file_name))
					pass
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		pass
	print(Global._cardFiles)

func createID (set, num, foil):
	var foiling = ""
	if foil == 1:
		foiling = "f"
	elif foil == 2:
		foiling = "ef"
		pass
	var cardID = str(set) + str(num) + foiling
	return cardID
	
