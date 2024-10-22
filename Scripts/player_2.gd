extends CharacterBody2D
@onready var Bullet = preload("res://Scenes/bullet.tscn")
var SPEED = 400
var score = 0
var health = 3
signal change_health(health)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("P2_Left", "P2_Right")
	if direction:
		velocity.x = direction  * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("P2_shoot"):
		var bullet = Bullet.instantiate()
		bullet.position = Vector2(position.x, position.y -100)
		bullet.parent = 2
		get_parent().add_child(bullet)

	move_and_slide()

func hurt(damage):
	health -= damage
	print("P2 health is :" + str(health))
	emit_signal("change_health", health)
	if health <= 0:
		die()
	emit_signal("change_health", health)
	
func die():
	queue_free()
