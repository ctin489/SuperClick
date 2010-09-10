package  com.efg.framework
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	/**
	 * ...
	 * @author ...
	 */
	public class BasicBlitArrayObject extends EventDispatcher{
		
		public var x:Number = 0;
		public var y:Number = 0;
		public var nextX:Number = 0;
		public var nextY:Number = 0;
		public var dx:Number = 0;
		public var dy:Number = 0;
		public var frame:int = 0;
		public var bitmapData:BitmapData;
		public var animationList:Array=[];
		public var point:Point = new Point(0, 0);
		public var speed:Number=0;
		public var xMax:int=0;
		public var yMax:int=0;
		public var xMin:int=0;
		public var yMin:int=0;

		
		public function BasicBlitArrayObject(xMin:int,xMax:int, yMin:int, yMax:int  ) 
		{
			this.xMin = xMin;
			this.xMax = xMax;
			this.yMin = yMin;
			this.yMax = yMax;
		}
		
		public function updateFrame(inc:int):void {
			frame += inc;
			if (frame > animationList.length-1) {
				frame = 0;
			}
			bitmapData = animationList[frame];
		}
		
		
		public function render(canvasBitmapData:BitmapData):void {
			x = nextX;
			y = nextY;
			point.x = x;
			point.y = y;
			canvasBitmapData.copyPixels(bitmapData, bitmapData.rect, point);
			
		}
		
		public function dispose():void {
			bitmapData.dispose();
			bitmapData = null;
			animationList = null;
			point = null;
		}
		
	}

}