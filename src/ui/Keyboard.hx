package ui;

import js.JQuery;
import jp.saken.utils.Dom;
import view.Editbox;
 
class Keyboard {
	
	/* =======================================================================
	Public - Init
	========================================================================== */
	public static function init():Void {
		
		Dom.jWindow.on('keydown',onKeydown);
		
	}
	
	/* =======================================================================
	On Keydown
	========================================================================== */
	private static function onKeydown(event:JqEvent):Void {
		
		var keyCode:Int = event.keyCode;
		
		if (event.ctrlKey) {
			
			if (keyCode == 69) {
				Editbox.toggle();
			}
			
		}
		
	}

}