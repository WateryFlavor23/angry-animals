extends Node2D


func _on_water_zone_body_entered(_body: Node2D) -> void:
	SignalHub.animal_fell()
