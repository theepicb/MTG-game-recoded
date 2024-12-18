extends Node2D
# Holds useful variables and functions
var _clicksTotal = 0
# starting money
var _money = 230.00
# value per click
var _moneyClick = 0.01
# multiplier for each click
var _moneyclickmulti = 1
# money per second
var _automoney = 0.00
# list of upgrades values ect..
var _upgrades = [{"name": "your first achievement... probably", "des": "increases money gained per second by $0.01", "price": 0.1}, {"name": "clicker upgrade", "des": "increases clicking by $0.01", "price": 1}, {"name": "unlocks your first pack: March of the machine epilogue!", "des": "unlocks march of the machine: aftermath epilogue packs!", "price": 2},
{"name": "unlocks march of the machine: epilogue collector boosters!", "des": "unlocks the march of the machine: epilogue collector boosters for $40", "price": 10} ]
var _upgradesUnlocked = [1, 2]
# clicker combo values
var _autotimer = 0
var _totalclicks = 0
var _frame = 0
# pack handeling
var _packsUnlocked = []
var _packsinv = [0, 0, 0]
var _packscost = [5, 40]
# pack spride ID
var _packid = ["res://sprites/packs/MOTM-E-pack.png", "res://sprites/packs/collector booster motm.jpg"]
# leveling up variables
var _xp = 0
var _level = 1
var _xpToNextLevel = [null, 10, 500]
# used when grabbing sprite textures
var _imageram = []
# assigning rarities, probably a better way of doing this
var _matu = [1, 3, 7, 8, 12, 13, 14, 17, 19, 20, 25, 27, 28, 30, 31]
var _matr = [2, 4, 5, 9, 10, 11, 15, 16, 18, 21, 23, 24, 29, 32, 33, 34, 37, 39, 40, 42, 43, 44, 47, 50]
var _matm = [22, 26, 35, 36, 38, 41, 45, 46, 48, 49]
var _matsu = [51, 53, 57, 58, 62, 63, 64, 67, 69, 70, 75, 77, 78, 79, 80, 81]
var _matsr = [52, 54, 55, 56, 59, 60, 61, 65, 66, 68, 71, 73, 74, 82, 83, 84, 87, 89, 90, 92, 93, 94, 97, 100]
var _matsm = [72, 76, 85, 86, 88, 91, 95, 96, 98, 99]
var _matPrice = [{"nf":null, "foil": null}, {"nf":0.32, "foil": 0.40}, {"nf":0.28, "foil": 0.22}, {"nf":0.03, "foil": 0.07}, {"nf":1.27, "foil": 1.47}, {"nf":0.13, "foil": 0.11}, {"nf":0.12, "foil": 0.15}, {"nf":0.34, "foil": 0.28}, {"nf":0.03, "foil": 0.02}, {"nf":4.04, "foil": 3.66}, {"nf":0.32, "foil": 0.32}, {"nf":0.50, "foil": 0.45}, 
{"nf":0.03, "foil": 0.04}, {"nf":0.02, "foil": 0.04}, {"nf":0.22, "foil": 0.26}, {"nf":0.29, "foil": 0.20}, {"nf":0.20, "foil": 0.21}, {"nf":0.03, "foil": 0.04}, {"nf":1.19, "foil": 2.53}, {"nf":0.14, "foil": 0.20},{"nf":0.06, "foil": 0.10}, {"nf":0.49, "foil": 0.52}, {"nf":17.20, "foil": 17.88}, {"nf":3.17, "foil": 1.18}, {"nf":5.55, "foil": 5.19},
{"nf":0.03, "foil": 0.03}, {"nf":12.11, "foil": 13.57}, {"nf":0.03, "foil": 0.03}, {"nf":0.18, "foil": 0.15}, {"nf":0.50, "foil": 0.49}, {"nf":0.11, "foil": 0.11}, {"nf":0.15, "foil": 0.18}, {"nf":0.87, "foil": 0.80}, {"nf":0.20, "foil": 0.14}, {"nf":0.20, "foil": 0.16}, {"nf":0.99, "foil": 1.01}, {"nf":1.04, "foil": 2.04}, {"nf":0.37, "foil": 0.45}, {"nf":4.47, "foil": 4.24}, {"nf":0.18, "foil": 0.13}, {"nf":0.25, "foil": 0.29}, {"nf": 3.27, "foil": 3.49}, {"nf":0.89, "foil": 0.81}, {"nf":0.12, "foil": 0.10}, {"nf":0.24, "foil": 0.24}, {"nf":3.34, "foil": 4.00}, {"nf":8.01, "foil": 6.04}, {"nf":2.25, "foil": 3.33}, {"nf":2.39, "foil": 2.43}, {"nf":11.56, "foil": 10.76}, {"nf":0.73, "foil": 0.86},
{"nf": 0.43, "foil": 0.44}, {"nf": 0.57, "foil": 0.65}, {"nf":0.03, "foil": 0.07}, {"nf":0.87, "foil": 0.50}, {"nf":0.52, "foil": 0.27}, {"nf":0.22, "foil": 0.17}, {"nf": 0.19, "foil": 0.23}, {"nf": 0.05, "foil": 0.08}, {"nf": 3.23, "foil": 3.22}, {"nf": 0.86, "foil": 0.32}, {"nf": 0.95, "foil": 0.36}, {"nf": 0.25, "foil": 0.06}, {"nf": 0.04, "foil": 0.06}, {"nf": 0.22, "foil": 0.16}, {"nf": 0.87, "foil": 0.37}, {"nf": 0.28, "foil": 0.24}, {"nf": 0.06, "foil": 0.05}, {"nf": 2.30, "foil": 2.06}, {"nf": 0.14, "foil": 0.19}, {"nf": 0.05, "foil": 0.10}, {"nf": 0.63, "foil": 0.40}, {"nf": 18.20, "foil": 19.62}, {"nf": 1.54, "foil": 1.85}, {"nf": 6.23, "foil": 4.34}, {"nf": 0.02, "foil": 0.06}, {"nf": 16.13, "foil": 16.57}, {"nf": 0.05, "foil": 0.05},
{"nf": 0.10, "foil": 0.11}, {"nf": 0.34, "foil": 0.24}, {"nf": 0.10, "foil": 0.15}, {"nf": 0.10, "foil": 0.12}, {"nf": 1.32, "foil": 0.52}, {"nf": 0.19, "foil": 0.24}, {"nf": 0.37, "foil": 0.22}, {"nf": 3.41, "foil": 1.88}, {"nf": 3.91, "foil": 3.52}, {"nf": 0.57, "foil": 0.37}, {"nf": 3.70, "foil": 2.98}, {"nf": 0.63, "foil": 0.59}, {"nf": 0.57, "foil": 0.35}, {"nf": 5.63, "foil": 5.02}, {"nf": 1.87, "foil": 0.81}, {"nf": 0.16, "foil": 0.22}, {"nf": 0.47, "foil": 0.36}, {"nf": 3.57, "foil": 2.45}, {"nf": 5.96, "foil": 5.58}, {"nf": 2.71, "foil": 2.36}, {"nf": 5.09, "foil": 4.32}, {"nf": 12.78, "foil": 11.38}, {"nf": 1.01, "foil": 0.60}]

# ways of increasing odds/adding extra cards to packs
var _luck = 1
var _addChance = 0



# Called when the node enters the scene tree for the first time.
func _process(delta):

		pass

# Level up function to be added
func _levelUp(x) :
	
	pass

# Function to load all of a packs names into an array
func dir_contents(path):
	_imageram.clear()
	_imageram.push_front(null)
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "png":
				_imageram.push_back(str(path) + str(file_name))
			file_name = dir.get_next()
			pass
		_imageram.sort()
		
	else:
		print("An error occurred when trying to access the path.")
		pass


