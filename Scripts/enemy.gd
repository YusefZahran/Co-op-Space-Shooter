extends Area2D
var Bullet = preload("res://Scenes/bullet.tscn")
var level = get_parent()
signal dead
var speed = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed

func kill(): # this works
	dead.emit()
	queue_free()

func _on_timer_timeout():
	shoot()
	
func shoot():
	var bullet = Bullet.instantiate()
	bullet.isdown = true
	bullet.position = Vector2(position.x, position.y +100)
	#bullet.scale = Vector2(0.5,0.5)
	bullet.rotation_degrees += 180
	bullet.parent = 3
	get_parent().add_child(bullet)


func _on_body_entered(body):
	if (body.is_in_group("Player")):
		body.hurt(1)
