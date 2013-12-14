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
		@structure_form.find('select').on( "change", =>
			@loadStructure @structure_form.find(':selected').val()
		).trigger('change')

	loadStructure: (type) ->
		@structure_form.find('#current_structure_form').html($('#structure_forms .'+type).clone().html())

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
		$('#form_preview').empty().dform(form)


class StructureElement
	@data
	constructor: (data) ->
		obj = {}
		$.map data, (n, i) ->
			if n['name'] is 'options'
				obj[n['name']] = $.parseJSON(n['value'])
			else
				obj[n['name']] = n['value']
		obj['name'] = obj['caption'].toLowerCase()
		console.log(obj['name'])
				

		console.log(obj)
		@data = obj
