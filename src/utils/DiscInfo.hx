package utils;

class DiscInfo {
	
	private static var _name        :String;
	private static var _team        :String;
	private static var _clients     :Array<String>;
	private static var _works       :Array<String>;
	private static var _results     :Map<String,String>;
	private static var _lastModified:Int;
	private static var _size        :Int;
	
	/* =======================================================================
	Public - Get
	========================================================================== */
	public static function get(files:Array<Dynamic>):Dynamic {
		
		_name         = null;
		_team         = null;
		_clients      = [];
		_works        = [];
		_results      = new Map();
		_lastModified = 0;
		_size         = 0;
		
		var length:Int = files.length;
		
		for (i in 0...length) {
			analyzeFile(files[i]);
		}
		
		return {
			
			name : _name,
			team : _team,
			clients : _clients.join(','),
			works : _works.join(','),
			record_date : Date.now().toString(),
			last_modified_date : Date.fromTime(_lastModified).toString(),
			size : Std.string(_size),
			file_length : Std.string(length)
		
		};
		
	}
	
	/* =======================================================================
	Analyze File
	========================================================================== */
	private static function analyzeFile(file:Dynamic):Void {
		
		var lastModified:Int = file.lastModified;
		if (lastModified > _lastModified) _lastModified = lastModified;
		
		var size:Int = file.size;
		_size += size;
		
		var paths:Array<String> = file.webkitRelativePath.split('/');
		
		pushKeyword(_clients,paths[1]);
		pushKeyword(_works,paths[2]);
		
		if (_name != null) return;
		
		var info:Array<String> = paths[0].split('.');
		
		_name = info[0];
		_team = info[1];
		
	}
	
	/* =======================================================================
	Push Keyword
	========================================================================== */
	private static function pushKeyword(array:Array<String>,value:String):Void {
		
		if (value == null) return;
		if (array.indexOf(value) > -1) return;
		
		array.push(value);
		
	}

}