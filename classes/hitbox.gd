class_name Hitbox
extends Area2D

signal hit(hurtbox)


func _init() -> void:
	area_entered.connect(_on_area_enterd)


func _on_area_enterd(hurtbox: Hurtbox) -> void:
	print("[Hit] %s => %s" % [owner.name, hurtbox.owner.name])
	hit.emit(hurtbox)
	hurtbox.hurt.emit(self)
