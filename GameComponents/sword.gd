extends Node2D

@onready var interactable: Area2D = $Sprite2D/Interactable
@onready var sprite = $Sprite2D  # Assuming your sword has a Sprite2D child

var collected = false

func _ready() -> void:
	interactable.interact = on_interact

func on_interact():
	collected = true
	# Hide the sword
	visible = false
	
	# Disable interaction
	interactable.is_interactable = false
