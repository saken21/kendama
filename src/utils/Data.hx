package utils;

import jp.saken.utils.API;
import view.Works;

typedef ParamMap  = Map<String,String>;
typedef DataArray = Array<Dynamic>;

class Data {
	
	private static inline var API_NAME:String = 'webResults2';
	private static inline var MY_IP   :String = '192.168.0.39';
	
	/* =======================================================================
	Public - Load
	========================================================================== */
	public static function load(keyword:String,from:String,to:String):Void {
		
		var params:ParamMap = ['from'=>from,'to'=>to];
		
		if (keyword.length > 0) {
			params['client'] = keyword;
		}
		
		API.getJSON(API_NAME,params,function(data:DataArray):Void {
			
			if (data.length == 0) {
				
				params.remove('client');
				params['keyword'] = keyword;
				
				API.getJSON(API_NAME,params,onLoaded);
				
				return;
				
			}
			
			onLoaded(data);
		
		});
		
	}
	
		/* =======================================================================
		Public - Insert
		========================================================================== */
		public static function insert(params:ParamMap,onLoaded:Void->Void):Void {
			
			params['mode'] = 'insert';
			set(params,onLoaded);

		}
		
		/* =======================================================================
		Public - Update
		========================================================================== */
		public static function update(id:Int,params:ParamMap,onLoaded:Void->Void):Void {
			
			params['id']   = Std.string(id);
			params['mode'] = 'update';

			set(params,onLoaded);

		}
		
		/* =======================================================================
		Public - Load One
		========================================================================== */
		public static function loadOne(id:Int,onLoaded:Dynamic->Void):Void {
			
			API.getJSON(API_NAME,['id'=>Std.string(id)],function(data:DataArray):Void {
				onLoaded(data[0]);
			});

		}
	
	/* =======================================================================
	On Loaded
	========================================================================== */
	private static function onLoaded(data:DataArray):Void {
		
		if (data.length > 0) Works.setHTML(getSplitedData(data));
		else Works.setEmptyHTML();
		
		traceMembersCost(data);
		
	}
	
	/* =======================================================================
	Set
	========================================================================== */
	private static function set(params:ParamMap,onLoaded:Void->Void):Void {
		
		API.getString(API_NAME,params,function(data:String):Void {
			onLoaded();
		});
		
	}
	
	/* =======================================================================
	Get Splited Data
	========================================================================== */
	private static function getSplitedData(data:DataArray):Map<Int,DataArray> {
		
		var map:Map<Int,DataArray> = new Map();
		
		for (i in 0...data.length) {
			
			var info :Dynamic   = data[i];
			var date :Int       = info.date;
			var array:DataArray = map[date];
			
			if (array == null) array = [];
			array.push(info);
			
			map[date] = array;
			
		}
		
		return map;
		
	}
	
	/* =======================================================================
	Trace Members Cost
	========================================================================== */
	private static function traceMembersCost(data:DataArray):Void {
		
		API.getIP(function(ip:String):Void {
			
			if (ip != MY_IP) return;
			
			var map:Map<String,Int> = new Map();
			
			for (i in 0...data.length) {
				
				var ratioList:String = data[i].price_ratio_list;
				if (ratioList == null) continue;
				
				var ratios:Array<String> = ratioList.split(',');
				
				for (j in 0...ratios.length) {
					
					var splits:Array<String> = ratios[j].split('=');
					
					var member:String = splits[0];
					var cost  :Int    = Std.parseInt(splits[1]);
					var total :Int = map[member];
					
					if (total == null) total = 0;
					total += cost;
					
					map[member] = total;
					
				}
				
			}
			
			trace(map);
			
		});
		
	}

}