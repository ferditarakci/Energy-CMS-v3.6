// http://tinymce.moxiecode.com/wiki.php/API3:class.tinymce.Plugin
 
(function() {
 
	tinymce.create('tinymce.plugins.wrapper', {
		/**
		 * Initializes the plugin, this will be executed after the plugin has been created.
		 * This call is done before the editor instance has finished its initialization so use the onInit event
		 * of the editor instance to intercept that event.
		 *
		 * @param {tinymce.Editor} ed Editor instance that the plugin is initialized in.
		 * @param {string} url Absolute URL to where the plugin is located.
		 */
		init : function(ed, url) {
 
			//this command will be executed when the button in the toolbar is clicked
			ed.addCommand('mceWrapper', function() {
 
				selection = tinyMCE.activeEditor.selection.getContent();
 
				//prompt for a tag to use
				//tag = prompt('Tag:');
				//tinyMCE.activeEditor.selection.setContent('<' + tag + '>' + selection + '</' + tag + '>');
 
				tinyMCE.activeEditor.selection.setContent('<div class="clearfix">' + selection + '</div>');
 
			});
 
			ed.addButton('wrapper', {
				title : 'wrapper.desc',
				cmd : 'mceWrapper',
				image : url + '/icon_16_gear.gif'
				//image : 'http://mdawg123.wikispaces.com/i/icon_16_gear.gif'
			});
 
		},
 
	});
 
	// Register plugin
	tinymce.PluginManager.add('wrapper', tinymce.plugins.wrapper);
})();