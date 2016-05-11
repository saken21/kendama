package view;

import js.JQuery;
import jp.saken.utils.Handy;
import utils.Data;

class Html {
	
	private static var _totalCost:Int;
	
	private static var COLUMN_LIST:Map<String,String> = [
	
		'name'               => 'ディスク名',
		'team'               => '部署／チーム名',
		'clients'            => 'クライアントリスト',
		'works'              => '案件リスト',
		'keywords'           => 'その他キーワード',
		'last_modified_date' => '最終更新日',
		'note'               => 'コメント'
		
	];
	
	private static inline var COLUMN_LENGTH:Int = 9;
	
	/* =======================================================================
	Public - Get
	========================================================================== */
	public static function get(map:Map<String,DataArray>):String {
		
		_totalCost = 0;

		var html:String = '<table>';

		for (key in map.keys()) {
			html += getMonthlyWorks(key,map[key]);
		}

		return html + '</table>';

	}
	
		/* =======================================================================
		Public - Get Formatted Date
		========================================================================== */
		public static function getFormattedDate(date:Int,separator:String = '.'):String {

			var string:String = Std.string(date);
			return string.substr(0,4) + separator + string.substr(4,2);

		}
		
	/* =======================================================================
	Get Monthly Works
	========================================================================== */
	private static function getMonthlyWorks(key:String,array:DataArray):String {
		
		var html:String = '
		<tr class="month">
			<th colspan="' + COLUMN_LENGTH + '">' + key + '</th>
		</tr>';
		
		html += getTitle();
		
		for (i in 0...array.length) {
			html += getDisc(array[i]);
		}
		
		html += '<tr class="blank"><td colspan="' + COLUMN_LENGTH + '"></td></tr>';
		
		return html;
		
	}
	
	/* =======================================================================
	Get Title
	========================================================================== */
	private static function getTitle():String {
		
		var html:String = '<tr class="title">';
		
		for (key in COLUMN_LIST.keys()) {
			html += '<th class="' + key + '">' + COLUMN_LIST[key] + '</th>';
		}
		
		html += '<th class="edit">編集</th><th class="delete">削除</th>';
		
		return html + '</tr>';
		
	}
	
	/* =======================================================================
	Get Work
	========================================================================== */
	private static function getDisc(info:Dynamic):String {
		
		var html:String = '<tr class="disc" data-id="' + info.id + '">';
		
		for (key in COLUMN_LIST.keys()) {
			html += getTD(info,key);
		}
		
		html += '<td class="edit"><button type="button" class="edit-button">✎</button></td>';
		html += '<td class="delete"><button type="button" class="delete-button">×</button></td>';
		
		return html + '</tr>';
		
	}
	
	/* =======================================================================
	Get Table Data
	========================================================================== */
	private static function getTD(info:Dynamic,key:String):String {
		
		var value:String = Std.string(Reflect.getProperty(info,key));
		if (value.length == 0) value = '-';
		
		return '<td class="' + key + '">' + value + '</td>';
		
	}

}