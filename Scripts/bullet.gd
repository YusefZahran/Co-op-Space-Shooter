extends Area2D
var parent = 0
var isdown = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isdown:
		position.y -= 20
	else:
		position.y +=10


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Enemy"):
		if ( parent == 1 || parent ==2):
			area.kill()
			if parent == 1:
				get_parent().p1_score +=1
			elif parent == 2:
				get_parent().p2_score +=1
			queue_free()
	elif area.is_in_group("Player"):
		if parent == 3:
			area.get_parent().hurt(3)
			#print("alo")
			queue_free()



func _on_body_entered(body):
	if body.is_in_group("Player"):
		if parent == 3:
			body.hurt(2)

