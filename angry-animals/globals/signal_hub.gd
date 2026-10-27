extends Node


signal launched
signal fallen
signal vanished

func animal_launched() -> void:
	launched.emit()

func animal_fell() -> void:
	fallen.emit()

func cup_vanished() -> void:
	vanished.emit()
