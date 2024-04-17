extends Control

var joblist: Array  # Stores the list of job data from the CSV file
@export var id_option: OptionButton
@export var name_display: Label
@export var description_display: Label
@export var skills_list_container: Container

func _ready():
	# Read the job data from the CSV file
	joblist = read_csv("res://resource/class.csv").slice(1)
	# Populate the OptionButton with job IDs
	for job in joblist:
		id_option.add_item(job[0])  # Add the first element (job ID) to the OptionButton
	# Call the selection handler for the initially selected item
	_on_id_option_item_selected(id_option.selected)

func read_csv(path):
	var output = []
	# If file exist read the file to output
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		while file.get_position() < file.get_length():
			output.append(file.get_csv_line())
	return output

func _on_id_option_item_selected(index):
	# Update the job details based on the selected index
	name_display.text = joblist[index][1]
	description_display.text = joblist[index][2]
	# Clear the existing skill buttons before adding new ones
	for skill_button in skills_list_container.get_children():
		skill_button.queue_free()
	# Split the skills string into an array and create buttons for each
	var skill_array = joblist[index][3].split(";", false)
	for skill in skill_array:
		var skill_button = Button.new()
		skill_button.text = skill
		skills_list_container.add_child(skill_button)
