package view;

import js.JQuery;
import jp.saken.utils.Handy;
import jp.saken.utils.Dateformat;
import utils.Data;

class Searchbox {
	
	private static var _jParent :JQuery;
	private static var _jKeyword:JQuery;
	private static var _jFrom   :JQuery;
	private static var _jTo     :JQuery;
	private static var _jSubmit :JQuery;
	
	private static inline var TERM:Int = 5;
	
	/* =======================================================================
	Public - Init
	========================================================================== */
	public static function init():Void {
		
		_jParent  = new JQuery('#searchbox');
		_jKeyword = _jParent.find('.keyword').find('input');
		_jFrom    = _jParent.find('.from').find('input');
		_jTo      = _jParent.find('.to').find('input');
		_jSubmit  = _jParent.find('.submit').find('button');
		
		_jSubmit.on('click',submit);
		_jParent.find('.register').on('click',register);
		
		reset();
		
	}
	
		/* =======================================================================
		Public - Reload
		========================================================================== */
		public static function reload():Void {

			_jSubmit.trigger('click');

		}
		
		/* =======================================================================
		Public - Reset
		========================================================================== */
		public static function reset():Void {
			
			var date:Date = Date.now();
			
			_jFrom.prop('value',Dateformat.getMonth(Dateformat.getAddedDate(date,-365 * TERM)));
			_jTo.prop('value',Dateformat.getMonth(date));
			
			searchKeyword('');

		}
		
		/* =======================================================================
		Public - Search Keyword
		========================================================================== */
		public static function searchKeyword(keyword:String):Void {
			
			_jKeyword.prop('value',keyword);
			reload();

		}
	
	/* =======================================================================
	Submit
	========================================================================== */
	private static function submit(event:JqEvent):Void {
		
		var keyword:String = _jKeyword.prop('value');
		var from   :String = _jFrom.prop('value') + '-00';
		var to     :String = _jTo.prop('value') + '-31';
		
		Data.load(keyword,from,to);
		
		return untyped false;
		
	}
	
	/* =======================================================================
	Register
	========================================================================== */
	private static function register(event:JqEvent):Void {
		
		Editbox.open();
		
	}

}