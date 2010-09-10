package com.efg.framework
{
	import com.efg.framework.BlitSprite;
	import com.efg.framework.TileSheet;
	/**
	 * ...
	 * @author ...
	 */
	public class CarBlitSprite extends BlitSprite
	{
		
		public var reverse:Boolean = false;
		public var velocity:Number = 0;
		public var deceleration:Number = 0;
		public var acceleration:Number=0;
		public var maxVelocity:Number=0;
		public var nextRotation:Number=0;
		public var turnSpeed:Number = 0;
		public var maxTurnSpeed:Number;
		public var minTurnSpeed:Number;
		public var move:Boolean = false;
		public var reverseVelocityModifier:Number = 0;
		public var radius:int = 0;
		public var worldX:Number;
		public var worldY:Number;
		public var worldNextX:Number;
		public var worldNextY:Number
		
		
		
		
		
		public function CarBlitSprite(tileSheet:TileSheet, tileList:Array, firstFrame:int) {
			super(tileSheet,tileList,firstFrame);
			
		}
	
		
		
		override public function updateCurrentTile():void {
		
			if (animationLoop) {
				if (animationCount > animationDelay) {
					animationCount = 0;
					if (reverse) {
						currentTile--
					}else {
						currentTile++;
					}
					
					doCopyPixels = true;
					if (currentTile > tileList.length - 1) {
						currentTile = 0;
						if (useLoopCounter) loopCounter++;
					}
					if (currentTile < 0) {
						currentTile = tileList.length - 1;
						if (useLoopCounter) loopCounter++;
					}
					
				}
				animationCount++;
			}
			
		}
	}
	
}