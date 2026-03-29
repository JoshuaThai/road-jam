extends Node

var score = 0
var bar_points = 100
var driving_points = 100
var drunk = false

# All variables for the second level
# Determine if police is activated in road dodging level.
# Police can be activated three ways:
	# Speeding by the police
	# Crashing into the Police
	# Crashing into a car
var policeActivated = false

# The distance that a player will have to travel to complete the level.
var distanceLeft = 10000

var roadDodgingStart = false

# You start with 100 percent car health in road dodging level
var carHealth = 100

func _ready():
	bar_points = 50
	
func _restore_defaults():
	carHealth = 100
	roadDodgingStart = false
	distanceLeft = 10000
	policeActivated = false
