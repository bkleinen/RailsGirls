$ ->
	structure_form = new StructureForm

class StructureForm
	elements = []
	@structure_form

	constructor: ->
		@structure_form = $('#add_structure')
		@structure_form.find('.submit').on "click", (e) =>
			e.preventDefault()
			@addToStructure @structure_form.serializeArray()
		@loadStructure('text')		

	loadStructure: (type) ->
		@structure_form.find('#current_structure_form').html($('#structure_forms .'+type))

	addToStructure: (data) ->
		structure_element = new StructureElement(data)
		elements.push structure_element.data
		$('#form_structure').val(JSON.stringify(elements))

		console.log(elements)
		@renderPreview()

	renderPreview: ->
		form =
			#action: "/registrations"
			#method: "post"
			html: elements

		console.log form

		$('#form_preview').empty().dform(form)


class StructureElement
	@data
	constructor: (data) ->
		obj = {}
		$.map data, (n, i) ->
			obj[n['name']] = n['value']
		@data = obj


		#for data_object in data
		#	console.log(data_object)
