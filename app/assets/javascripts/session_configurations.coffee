# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$time_element 			= $('.session_configuration_select_time')
	$hdn_start_time			= $('#session_configuration_start_time')
	$hdn_end_time				= $('#session_configuration_end_time')

	if $hdn_start_time.length > 0
		start_time_hour			= $hdn_start_time.val().split(':')[0]
		start_time_minute		= $hdn_start_time.val().split(':')[1]
	if $hdn_end_time.length > 0
		end_time_hour				= $hdn_end_time.val().split(':')[0]
		end_time_minute			= $hdn_end_time.val().split(':')[1]

	# init
	$time_element.each ->
		$this = $(this)
		if $this.attr('id') == 'start_time_hour'
			$this.val(start_time_hour)
		if ($this.attr('id') == 'start_time_minute')
			$this.val(start_time_minute)
		if ($this.attr('id') == 'end_time_hour')
			$this.val(end_time_hour)
		if ($this.attr('id') == 'end_time_minute')
			$this.val(end_time_minute)

	#change event
	$time_element.change ->
		$this = $(this)
		if $this.attr('id') == 'start_time_hour'
			$hdn_start_time.val($this.val() + ':' + $hdn_start_time.val().split(':')[1])
		if $this.attr('id') == 'start_time_minute'
			$hdn_start_time.val($hdn_start_time.val().split(':')[0] + ':' + $this.val())
		if ($this.attr('id') == 'end_time_hour')
			$hdn_end_time.val($this.val() + ':' + $hdn_end_time.val().split(':')[1])
		if ($this.attr('id') == 'end_time_minute')
			$hdn_end_time.val($hdn_end_time.val().split(':')[0] + ':' + $this.val())
