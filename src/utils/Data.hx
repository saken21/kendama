package utils;

import jp.saken.utils.API;
import jp.saken.utils.Dateformat;
import view.Discs;

typedef ParamMap  = Map<String,String>;
typedef DataArray = Array<Dynamic>;

class Data {
	
	private static inline var API_NAME:String = 'kendama';
	
	/* =======================================================================
	Public - Load
	========================================================================== */
	public static function load(keyword:String,from:String,to:String):Void {
		
		var params:ParamMap = ['from'=>from,'to'=>to];
		if (keyword.length > 0) params['keyword'] = keyword;
		
		API.getJSON(API_NAME,params,onLoaded);
		
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
		Public - Delete
		========================================================================== */
		public static function delete(id:Int,onLoaded:Void->Void):Void {
			
			set(['mode'=>'delete','id'=>Std.string(id)],onLoaded);

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
		
		if (data.length > 0) Discs.setHTML(getSplitedData(data));
		else Discs.setEmptyHTML();
		
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
	private static function getSplitedData(data:DataArray):Map<String,DataArray> {
		
		var map:Map<String,DataArray> = new Map();
		
		for (i in 0...data.length) {
			
			var info :Dynamic   = data[i];
			var month:String    = Dateformat.getMonth(Date.fromString(info.record_date));
			var array:DataArray = map[month];
			
			info.last_modified_date = Dateformat.getMonth(Date.fromString(info.last_modified_date));
			
			if (array == null) array = [];
			array.push(info);
			
			map[month] = array;
			
		}
		
		return map;
		
	}

}