package view;

import js.JQuery;
import utils.Data;

class Works {
	
	private static var _jParent:JQuery;
	
	/* =======================================================================
	Public - Init
	========================================================================== */
	public static function init():Void {
		
		_jParent = new JQuery('#works');
		_jParent.on('click',onClick);
		
	}
	
		/* =======================================================================
		Public - Set HTML
		========================================================================== */
		public static function setHTML(map:Map<Int,DataArray>):Void {
			
			_jParent.html(Html.get(map));

		}
		
		/* =======================================================================
		Public - Set Empty HTML
		========================================================================== */
		public static function setEmptyHTML():Void {
			
			_jParent.html('<tr><th>検索結果：0件<th></tr>');

		}
	
	/* =======================================================================
	On Click
	========================================================================== */
	private static function onClick(event:JqEvent):Void {
		
		var jTarget:JQuery = new JQuery(event.target);
		
		if (jTarget.hasClass('edit-button')) {
			
			Editbox.edit(jTarget.parents('.work').data('id'));
			return;
		
		} else if (jTarget.hasClass('client')) {
			
			Searchbox.searchKeyword(jTarget.text());
			
		}
		
		Editbox.close();

	}

}