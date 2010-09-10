package com.efg.framework
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class CustomEventButtonId extends Event
	{
		
		public static const BUTTON_ID:String = "button id";
		public var id:int;

		public function CustomEventButtonId(type:String,id:int, bubbles:Boolean=false,cancelable:Boolean=false)
		{
			super(type, bubbles,cancelable);
			this.id = id;
		}
		
		
		public override function clone():Event {
			return new CustomEventButtonId(type,id, bubbles,cancelable)
		}
		
		
	}
	
}