extends Control

export var tb_path : NodePath
onready var toolbar : Control = get_node(tb_path)

onready var preview_right : AdvancedTextLabel = $HSplitContainer/VSplit/HSplit/PreviewRight
onready var preview_bottom : AdvancedTextLabel = $HSplitContainer/VSplit/PreviewBottom

var current_preview : AdvancedTextLabel

func _ready():
	preview_right.hide()
	preview_bottom.hide()
	
	# just for now, later it will be loaded from settings
	current_preview = preview_right
	toolbar.preview_switch.selected = 0
	current_preview.visible = false
	toolbar.preview_toggle.pressed = false

	toolbar.connect("selected_preview", self, "_on_preview_selected")
	toolbar.connect("preview_toggled", self, "_on_preview_toggled")
	toolbar.connect("selected_markup", self, "_on_markup_selected")

func _on_preview_selected(mode:String):
	current_preview.hide()
	match mode.to_lower():
		"right":
			current_preview = preview_right
		"bottom":
			current_preview = preview_bottom
	
	toolbar.preview_toggle.pressed = true
	current_preview.show()

func _on_preview_toggled(toggle:bool):
	current_preview.visible = toggle

func _on_markup_selected(markup:String):
	markup = markup.to_lower()
	current_preview.markup = markup

		
