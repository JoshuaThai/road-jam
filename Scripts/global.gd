extends Node

var bar_points = 100
var driving_points = 100
var drunk = false

# Determine if police is activated in road dodging level.
# Police can be activated three ways:
	# Speeding by the police
	# Crashing into the Police
	# Crashing into too many cars over time.
var policeActivated = false

# You start with 100 percent car health in road dodging level
var carHealth = 100

func _ready():
	bar_points = 50
