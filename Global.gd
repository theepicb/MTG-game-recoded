extends Node2D
var _inv: Array
# Holds useful variables and functions
var _clicksTotal = 0
# starting money
var _money = 500
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
# pack handeling need to change to dictionary
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
# assigning rarities, probably a better way of doing this, need to figure out how to use spreadsheet to make this easier
var _matu = [1, 3, 7, 8, 12, 13, 14, 17, 19, 20, 25, 27, 28, 30, 31]
var _matr = [2, 4, 5, 9, 10, 11, 15, 16, 18, 21, 23, 24, 29, 32, 33, 34, 37, 39, 40, 42, 43, 44, 47, 50]
var _matm = [22, 26, 35, 36, 38, 41, 45, 46, 48, 49]
var _matsu = [51, 53, 57, 58, 62, 63, 64, 67, 69, 70, 75, 77, 78, 79, 80, 81]
var _matsr = [52, 54, 55, 56, 59, 60, 61, 65, 66, 68, 71, 73, 74, 82, 83, 84, 87, 89, 90, 92, 93, 94, 97, 100]
var _matsm = [72, 76, 85, 86, 88, 91, 95, 96, 98, 99]
var _mateu = [101, 103, 107, 108, 112, 113, 114, 117, 119, 120, 125, 127, 128, 130, 131]
var _mater = [102, 104, 105, 106, 109, 110, 111, 115, 116, 118, 121, 123, 124, 129, 132, 133, 134, 137, 139, 140, 142, 143, 144, 147, 150]
var _matem = [122, 126, 135, 136, 138, 141, 145, 146, 148, 149]
var _matexr = [151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 163, 164, 166, 167, ]
# ways of increasing odds/adding extra cards to packs
var _luck = 1
var _addChance = 0

var _cardFiles = []

# Level up function to be added
func _levelUp(x) :
	
	pass


func _ready():
	
	pass
