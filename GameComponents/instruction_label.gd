extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(4.0).timeout.connect(func(): visible = false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
