package com.efg.framework
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class CustomEventScoreBoardUpdate extends Event
	{
		
		public static const UPDATE_TEXT:String = "update scoreboard text";
		public var element:String;
		public var value:String;

		public function CustomEventScoreBoardUpdate(type:String,element:String, value:String, bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type, bubbles,cancelable);
			this.element = element;
			this.value = value;
		}
		
		
		public override function clone():Event {
			return new CustomEventScoreBoardUpdate(type,element,value, bubbles,cancelable)
		}
		
		
	}
	
}