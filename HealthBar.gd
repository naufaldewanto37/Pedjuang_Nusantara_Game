extends ProgressBar

@export var satria: satria

func ready():
	print('satria ready')
	satria.healthChanged.connect(update)
	update()
	

func update():
	value = satria.current_health * 100 / satria.max_health
