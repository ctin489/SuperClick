package com.efg.framework
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class CustomEventLevelScreenUpdate extends Event
	{
		public static const UPDATE_TEXT:String = "update level text";
		
		public var text:String;

		public function CustomEventLevelScreenUpdate(type:String,text:String,bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type, bubbles,cancelable);
			this.text = text;
		}
		
		
		public override function clone():Event {
			return new CustomEventLevelScreenUpdate(type,text, bubbles,cancelable)
		}
		
		
	}
	
}