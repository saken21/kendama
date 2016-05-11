package view;

import haxe.Timer;
import js.JQuery;
import utils.Data;
import utils.DiscInfo;

class Editbox {
	
	private static var _jParent  :JQuery;
	private static var _jMainArea:JQuery;
	private static var _jCover   :JQuery;
	private static var _jColumns :JQuery;
	
	private static var _width    :Int;
	private static var _isOpened :Bool;
	private static var _currentID:Int;
	
	/* =======================================================================
	Public - Init
	========================================================================== */
	public static function init():Void {
		
		_jParent   = new JQuery('#editbox');
		_jMainArea = new JQuery('#all').add(new JQuery('#header'));
		_jCover    = _jParent.find('.cover');
		_jColumns  = _jParent.find('[data-column]');
		
		_width     = _jParent.width();
		_isOpened  = false;
		
		_jParent.find('.submit').on('click',submit);
		_jParent.find('#editbox-file').on('change',selectDirectory);
		
	}
	
		/* =======================================================================
		Public - Toggle
		========================================================================== */
		public static function toggle():Void {
			
			_currentID = null;
			
			if (_isOpened) close();
			else open();

		}
		
		/* =======================================================================
		Public - Edit
		========================================================================== */
		public static function edit(id:Int):Void {
			
			_currentID = id;
			open();
			
			Data.loadOne(id,setData);

		}
		
		/* =======================================================================
		Public - Open
		========================================================================== */
		public static function open():Void {

			if (_isOpened) return;

			_isOpened = true;
			move(_width);

			setDefault();

		}
		
		/* =======================================================================
		Public - Close
		========================================================================== */
		public static function close():Void {

			if (!_isOpened) return;

			_isOpened = false;
			move(0);

		}
		
	/* =======================================================================
	Set Default
	========================================================================== */
	private static function setDefault():Void {
		
		_jColumns.prop('value','');
		_jParent.find('#editbox-record_date').prop('value',DateTools.format(Date.now(),"%Y-%m"));

	}
	
	/* =======================================================================
	Set Data
	========================================================================== */
	private static function setData(data:Dynamic):Void {
		
		function getFormattedDate(value:String):String {
			
			return value.split(' ')[0];
			
		}
		
		_jColumns.each(function():Void {
			
			var jTarget:JQuery = JQuery.cur;
			var column :String = jTarget.data('column');
			var value  :String = Reflect.getProperty(data,column);
			
			if (jTarget.prop('type') == 'date') {
				value = getFormattedDate(value);
			}
			
			jTarget.prop('value',value);
			
		});

	}
	
	/* =======================================================================
	Move
	========================================================================== */
	private static function move(x:Int):Void {
		
		_jMainArea.stop().animate({ left:x }, 200);

	}
	
	/* =======================================================================
	Submit
	========================================================================== */
	private static function submit(event:JqEvent):Void {
		
		var jRequired:JQuery = _jParent.find('input[required]');
		
		for (i in 0...jRequired.length) {
			
			if (jRequired.eq(i).prop('value').length == 0) {
				return;
			}
			
		}
		
		_jCover.show();
		
		if (_currentID == null) Data.insert(getParams(),onUpdated);
		else Data.update(_currentID,getParams(),onUpdated);
		
		return untyped false;

	}
	
	/* =======================================================================
	On Updated
	========================================================================== */
	private static function onUpdated():Void {
		
		var timer:Timer = new Timer(1000);
		
		timer.run = function():Void {
			
			timer.stop();
			setDefault();
			
			_jCover.hide();
			
			if (_currentID != null) {
				
				_currentID = null;
				close();
				
			}
			
			Searchbox.reload();
			
		};
		
	}
	
	/* =======================================================================
	Get Params
	========================================================================== */
	private static function getParams():ParamMap {
		
		var params:ParamMap = new Map();
		
		_jColumns.each(function():Void {
			
			var jTarget:JQuery = JQuery.cur;
			var key    :String = jTarget.data('column');
			var value  :String = jTarget.prop('value');
			
			if (key == 'date') {
				value = StringTools.replace(value,'-','');
			}
			
			params[key] = value;
			
		});
		
		return params;
		
	}
	
	/* =======================================================================
	Select Directory
	========================================================================== */
	private static function selectDirectory(event:JqEvent):Void {
		
		setData(DiscInfo.get(untyped event.target.files));

	}

}