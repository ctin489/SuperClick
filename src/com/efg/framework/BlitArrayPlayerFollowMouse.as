package  com.efg.framework 
{
	import com.efg.framework.BasicBlitArrayObject;
	import com.efg.framework.BlitArrayAsset;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.filters.GlowFilter;
	
	public class BlitArrayPlayerFollowMouse extends BasicBlitArrayObject

	{
		
		public var xMove:int;
		public var yMove:int;
		private var xChange:int;
		private var yChange:int;
		private var radians:Number;
		private var degrees:int;
		
		private var drawingCanvas:Shape = new Shape();
		
		public var shipBitmapData:BitmapData = new BitmapData(32, 32, true, 0x00000000);
		public var shieldBitmapData:BitmapData = new BitmapData(32, 32, true, 0x00000000);
		public var shieldRender:Boolean = false;
		public var shieldCount:int = 0;
		public var shieldLife:int = 5;
		
		
		public function BlitArrayPlayerFollowMouse(xMin:int,xMax:int, yMin:int, yMax:int ) {
			super(xMin, xMax, yMin, yMax);
			
		}
		
		public function update(mousePositionX:Number, mousePositionY:Number, delay:int,step:Number=1):void {
	
			radians = Math.atan2((mousePositionY)-y,(mousePositionX)-x);
			degrees= (radians * (180 / Math.PI));
			
			yChange= (mousePositionY-y);
			xChange= (mousePositionX-x);
			
			yMove=(yChange/delay)*step;
			xMove=(xChange/delay)*step;
			
			nextY+=yMove;
			nextX+=xMove;
			
			if (nextX > xMax) { 
				nextX = xMax;
			}else if (nextX < +xMin) {
				nextX = xMin;
			}

			if (nextY > yMax) { 
				nextY = yMax;
			}else if (nextY < yMin) {
				nextY = yMin;
			}
			
			frame = degrees;
			
			
			if (degrees < 0) {
				frame = 359+degrees;
			}
			
			bitmapData=animationList[frame]
		}
		
		public function createPlayerShip(spriteGlowFilter:GlowFilter):void {
			var tempBlitArrayAsset:BlitArrayAsset = new BlitArrayAsset();
			drawingCanvas.graphics.clear();
			drawingCanvas.graphics.lineStyle(1, 0xffffff);
			drawingCanvas.graphics.moveTo(15, 7);
			drawingCanvas.graphics.lineTo(7, 24);
			drawingCanvas.graphics.lineTo(15, 19);
			drawingCanvas.graphics.moveTo(16, 19);
			drawingCanvas.graphics.lineTo(24, 24);
			drawingCanvas.graphics.lineTo(16, 7);
			
			trace("drawingCanvas.height=" + drawingCanvas.height);
			trace("drawingCanvas.width=" + drawingCanvas.width);
			
			shipBitmapData.draw(drawingCanvas);
			shipBitmapData.applyFilter(shipBitmapData, shipBitmapData.rect, new Point(0,0), spriteGlowFilter);
			
			animationList=tempBlitArrayAsset.createRotationBlitArrayFromBD(shipBitmapData, 1,90);
			//player.aAnimation = tempBlitArrayAsset.aTileList;
	
			
			//*** end player ship
			
			//*** shield
			drawingCanvas.graphics.clear();
			drawingCanvas.graphics.lineStyle(3, 0xffffff);
			drawingCanvas.graphics.drawCircle(15, 15, 14);
			shieldBitmapData.draw(drawingCanvas);
			
			//*** end shield
			
			
		}
		
		
	}

}