/**
* ================================================================================
*
* KendaMa ver 1.00.00
*
* Author : KENTA SAKATA
* Since  : 2016/05/10
* Update : 2016/05/16
*
* Licensed under the MIT License
* Copyright (c) Kenta Sakata
* http://saken.jp/
*
* ================================================================================
*
**/
package;

import js.JQuery;
import jp.saken.utils.Dom;
import view.Header;
import view.Searchbox;
import view.Editbox;
import view.Discs;
import ui.Keyboard;

class Main {
	
	public static function main():Void {
		
		new JQuery('document').ready(function(event:JqEvent):Void {
			
			if (~/chrome/i.match(Dom.userAgent)) {
				new JQuery('body').addClass('chrome');
			}
			
			Searchbox.init();
			Header.init();
			
			Editbox.init();
			Discs.init();
			
			Keyboard.init();
			
		});
		
	}

}