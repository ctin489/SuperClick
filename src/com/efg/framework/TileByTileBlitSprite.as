package com.efg.framework
{
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class TileByTileBlitSprite extends BlitSprite
	{
		public var inTunnel:Boolean = false;
		public var currRow:int;
		public var currCol:int;
		public var nextRow:int;
		public var nextCol:int;
		public var moveDirectionsToTest:Array = [];
		public var missileDelay:Number = 100;
		public var missileTime:int;
		public var healthPoints:int;
		public var distinationX:Number;
		public var distinationY:Number;
		public var currentDirection:int = 0;
		public var moveSpeed:Number = 2;
		public var currentRegion:int;
		
		public function TileByTileBlitSprite(tileSheet:TileSheet, tileList:Array, firstFrame:int) {
	
			super(tileSheet, tileList, firstFrame);
		}
		
	}
	
}