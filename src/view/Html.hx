package view;

import js.JQuery;
import jp.saken.utils.Handy;
import utils.Data;

class Html {
	
	private static var _totalCost:Int;
	private static inline var COLUMN_LENGTH:Int = 7;
	
	/* =======================================================================
	Public - Get
	========================================================================== */
	public static function get(map:Map<Int,DataArray>):String {
		
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
	private static function getMonthlyWorks(key:Int,array:DataArray):String {
		
		var monthlyCost:Int = 0;
		
		var html:String = '
		<tr class="date">
			<th colspan="' + COLUMN_LENGTH + '">' + getFormattedDate(key) + '</th>
		</tr>';
		
		for (i in 0...array.length) {
			
			var info:Dynamic = array[i];
			
			html += getWork(info);
			monthlyCost += info.cost;
			
		}
		
		_totalCost += monthlyCost;
		
		html += '
		<tr class="monthly-cost">
			<td class="cost" colspan="' + COLUMN_LENGTH + '">月計：' + Handy.getFormattedPrice(monthlyCost) + '</td>
		</tr>
		<tr class="total-cost">
			<td class="cost" colspan="' + COLUMN_LENGTH + '">累計：' + Handy.getFormattedPrice(_totalCost) + '</td>
		</tr>
		<tr class="blank"><td colspan="' + COLUMN_LENGTH + '"></td></tr>';
		
		return html;
		
	}
	
	/* =======================================================================
	Get Work
	========================================================================== */
	private static function getWork(info:Dynamic):String {
		
		var keys:Array<String> = ['number','client','name','members','sales','cost'];
		var html:String = '<tr class="work" data-id="' + info.id + '">';
		
		for (i in 0...keys.length) {
			html += getTD(info,keys[i]);
		}
		
		html += '<td class="edit"><button type="button" class="edit-button">✎</button></td>';
		
		return html + '</tr>';
		
	}
	
	/* =======================================================================
	Get Table Data
	========================================================================== */
	private static function getTD(info:Dynamic,key:String):String {
		
		var content:String = '';
		
		if (key == 'members') {
			
			var ratioList:String = info.price_ratio_list;
			if (ratioList != null) content = getMembers(ratioList.split(','));
			
		} else {
			
			var value:String = Std.string(Reflect.getProperty(info,key));
			if (value == 'null') value = '';
			
			switch (key) {
				
				case 'cost' : content = Handy.getFormattedPrice(Std.parseInt(value));

				case 'name' : {

					var url :String = info.url;
					var name:String = value;
					var prop:String = '';

					if (url.length > 0) {
						prop = ' href="' + url + '" class="link" target="_blank"';
					}

					content = '<a' + prop + '>' + name + '</a>';

				}

				default : content = value.length > 0 ? value : '-';

			}
			
		}
		
		return '<td class="' + key + '">' + content + '</td>';
		
	}
	
	/* =======================================================================
	Get Members
	========================================================================== */
	private static function getMembers(ratios:Array<String>):String {
		
		ratios.sort(function(a:String,b:String):Int {
			return Std.parseInt(b.split('=')[1]) - Std.parseInt(a.split('=')[1]);
		});
		
		var members:Array<String> = [];
		
		for (i in 0...ratios.length) {
			members.push(ratios[i].split('=')[0]);
		}
		
		return members.join(',');
		
	}

}