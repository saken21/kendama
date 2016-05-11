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
import utils.DiscInfo;

class Main {
	
	private static var KEYS:Map<String,String> = [
		
		'name' => 'ディスク名',
		'team' => 'チーム名',
		'clients' => 'クライアントリスト',
		'works' => '案件リスト',
		'record_date' => '登録日',
		'last_modified_date' => '最終更新日',
		'size' => 'データ容量',
		'file_length' => 'ファイル数'
	
	];
	
	public static function main():Void {
		
		new JQuery('document').ready(function(event:JqEvent):Void {
			
			new JQuery('#input-file').on('change',function(event:JqEvent):Void {
				
				showResult(DiscInfo.get(untyped event.target.files));
				
			});
			
		});
		
	}
	
	private static function showResult(info:Map<String,String>):Void {
		
		var result:String = '';
		
		for (key in KEYS.keys()) {
			result += '<dl><dt>' + KEYS[key] + '</dt><dd>' + info[key] + '</dd></dl>';
		}
		
		new JQuery('#result').html(result);
		
	}

}