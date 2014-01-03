$ ->
	if typeof structure_to_render is 'undefined'
		structure_form = new StructureForm
	else
		structure_form = new StructureForm(structure_to_render)
		if not(typeof form is 'undefined')
			structure_form.form = form	
		#console.log(structure_form)
		structure_form.renderPreview()

class StructureForm
	@structure_form_tag
	@form

	constructor: (@elements=[]) ->
		@editable = $('form#add_structure').length > 0
		console.log @editable
		@structure_form_tag = $('#add_structure')
		@structure_form_tag.find('.submit').on "click", (e) =>
			e.preventDefault()
			@addToStructure()
		@structure_form_tag.find('#current_structure_form').on 'click', '.add_option', (e) =>
			e.preventDefault()
			@add_option()
		@structure_form_tag.find('select').on( "change", =>
			@loadStructureForm @structure_form_tag.find(':selected').val()
		).trigger('change')
		$('#form_preview').on 'click', '.delete_element', (e) =>
			e.preventDefault()
			@elements.splice [parseInt($(e.target).attr('id').replace('delete_', ''))], 1
			@renderPreview()
			$('#form_structure').val(JSON.stringify(@elements))

	add_option: ->
		console.log('add option')
		options_len = @structure_form_tag.find('#current_structure_form .options_set').length
		console.log(options_len)
		new_option = $('<div class="options_set option'+options_len+'" data-option="'+options_len+'">
		      <label for="option'+options_len+'">Option '+options_len+'</label>
		      <input class="disabled" type="text" name="option'+options_len+'">
		    </div>')
		new_option.on 'change', (e) =>
			options = {}
			@structure_form_tag.find('.options_set input').each ->
				options[$(@).attr('name')] = $(@).val()
			console.log(options)
			console.log @structure_form_tag.find('.options')
			@structure_form_tag.find('input[name="options"]').val(JSON.stringify(options))
			#@structure_form_tag.find('input[name="options"]').val()
		@structure_form_tag.find('#current_structure_form .add_option').before new_option

	loadStructureForm: (type) ->
		@structure_form_tag.find('#current_structure_form').empty().html($('#structure_forms .'+type).clone().html())

	addToStructure: ->
		@structure_form_tag.find('.disabled').each ->
			$(@).prop('disabled', true)
		data = @structure_form_tag.serializeArray()
		structure_element = new StructureElement(data)
		@elements.push structure_element.data
		$('#form_structure').val(JSON.stringify(@elements))

		console.log(@elements)
		@renderPreview()
		@loadStructureForm(@structure_form_tag.find(':selected').val())
		$('#add_structure #caption').val('')

	renderPreview: ->
		console.log 'render'
		if @editable
			editable_form_elements = []
			index = 0
			for element in @elements
				element['id'] = ""+index
				editable_form_elements.push element
				link = {type: "a", href: ""+index, html: "Delete", class: "delete_element", id: "delete_"+index}
				editable_form_elements.push link
				index++
			form = if @form then @form else {html:[]}
			form.html = editable_form_elements
		else
			for element in @elements
				console.log element
			form = if @form then @form else {html:[]}
			form.html = @elements
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
		obj['name'] = obj['caption'].toLowerCase().replace(/[^a-z0-9\s]/gi, '').replace(/[-\s]/g, '_')
		#console.log(obj['name'])
				
		#console.log(obj)
		@data = obj
