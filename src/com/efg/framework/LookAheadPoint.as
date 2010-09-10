package  com.efg.framework
{
	import flash.display.*;
	/**
	 * ...
	 * @author Jeff Fulton
	 * 
	 */
	public class LookAheadPoint extends Sprite
	{
		
		public var parentContainer:Sprite;
		private var circle:Shape;
		private var circleColor:Number;
		
		
		public function LookAheadPoint(x:Number, y:Number, parentContainer:Sprite, circleColor:Number=0xffff00) 
		{
			this.x = x;
			this.y = y;
			this.parentContainer = parentContainer;
			this.circleColor = circleColor;
			circle = new Shape();
			circle.graphics.clear();
			circle.graphics.lineStyle(1, circleColor);
			circle.graphics.drawCircle(-1, -1, 2);
			addChild(circle);
		}
		
		public function show():void {
			parentContainer.addChild(this);
		}
		
		public function hide():void {
			parentContainer.removeChild(this);
		}
		
	}
	
}