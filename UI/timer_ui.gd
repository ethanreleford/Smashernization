extends CanvasLayer  # Replace this with the node you're attaching the script to (e.g., Control)

# Declare variables
var countdown_time = 30 * 60  # 30 minutes in seconds
@onready var timer = $Time
@onready var countdown_label = $label  # Adjust the path if needed

func _ready():
	countdown_label.text = format_time(countdown_time)
	timer.start()

# This function will be called every second
func _on_time_timeout():
	countdown_time -= 1  # Decrease the countdown by 1 second
	countdown_label.text = format_time(countdown_time)  # Update the label text

	# Stop the timer when the countdown reaches zero
	if countdown_time <= 0:
		timer.stop()
		# Optionally, trigger other logic when countdown finishes
		countdown_label.text = "Time's up!"

# Helper function to format time as MM:SS
func format_time(time_in_seconds: int) -> String:
	var minutes = time_in_seconds / 60  # Calculate minutes
	var seconds = time_in_seconds % 60  # Calculate remaining seconds

	# Return a formatted string with leading zeroes
	return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
