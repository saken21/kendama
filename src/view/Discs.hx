package view;

import js.JQuery;
import jp.saken.utils.Handy;
import utils.Data;

class Discs {
	
	private static var _jParent:JQuery;
	
	/* =======================================================================
	Public - Init
	========================================================================== */
	public static function init():Void {
		
		_jParent = new JQuery('#discs');
		_jParent.on('click',onClick);
		
	}
	
		/* =======================================================================
		Public - Set HTML
		========================================================================== */
		public static function setHTML(map:Map<String,DataArray>):Void {
			
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
		var jParent:JQuery = jTarget.parents('.disc');
		
		var id:Int = jParent.data('id');
		
		if (jTarget.hasClass('edit-button')) {
			
			Editbox.edit(id);
			return;
		
		} else if (jTarget.hasClass('delete-button')) {
			
			deleteDisc(id,jParent);
			return;
			
		}
		
		Editbox.close();

	}
	
	/* =======================================================================
	Delete Disc
	========================================================================== */
	private static function deleteDisc(id:Int,jTarget:JQuery):Void {
		
		var text:String = '「' + jTarget.find('.name').text() + '」を削除してもよろしいですか？';
		
		Handy.confirm(text,function():Void {
			
			Data.delete(id,function():Void {
				jTarget.remove();
			});
			
		});

	}

}