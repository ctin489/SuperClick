package  com.efg.framework
{
	import flash.utils.getTimer;
	import flash.events.*;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BasicTimer extends EventDispatcher
	{
		
		public static const TIMESUP:String = "timesup";
		
		public var countUp:Boolean = false;
		public var min:int = 0;
		public var max:int = 0;
		public var seconds:int;
		private var lastTime:Number;
		public var started:Boolean = false;
		
		
		public function BasicTimer() 
		{
	
		}
		
		public function start():void {
			lastTime = getTimer();
			started = true;
		}
		
		public function stop():void {
			started = false;
		}
		
		public function reset():void {
			if (countUp) {
				seconds = max;
			}else {
				seconds = min;
			}
		}
		
		public function update():void {
			
			if (started) {
				if (getTimer() > lastTime + 1000) {
					lastTime = getTimer();
					if (countUp) {
						seconds++;
						if (seconds == max) {
							stop();
							dispatchEvent(new Event(TIMESUP));
						}
					}else {
						seconds--;
						if (seconds == min) {
							stop();
							dispatchEvent(new Event(TIMESUP));
						}
					}
				}
				
			}
			
			
		}
		
	}
}