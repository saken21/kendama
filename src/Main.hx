/**
* ================================================================================
*
* KendaMa ver 1.00.00
*
* Author : KENTA SAKATA
* Since  : 2016/05/10
* Update : 2016/05/11
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
import view.Header;
import view.Searchbox;
import view.Editbox;
import view.Discs;
import ui.Keyboard;

class Main {
	
	public static function main():Void {
		
		new JQuery('document').ready(function(event:JqEvent):Void {
			
			Searchbox.init();
			Header.init();
			
			Editbox.init();
			Discs.init();
			
			Keyboard.init();
			
		});
		
	}

}