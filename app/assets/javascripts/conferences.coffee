# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$btn_priority 			= $('#btn-priority-config')
	$hdn_conference_id	= $('#conference_id')
	$select_prority 		= $('#priority_configuration')

	$btn_priority.click ->
		window.location.href = '/conferences/change_priority?id=' + $hdn_conference_id.val() + '&config=' + $select_prority.val()