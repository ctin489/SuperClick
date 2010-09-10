package com.efg.framework{
	
	import flash.display.BitmapData;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TileSheet  
	{
		public var sourceBitmapData:BitmapData;
		public var width:int;
		public var height:int;
		public var tileWidth:int;
		public var tileHeight:int;
		public var tilesPerRow:int;
		
		public function TileSheet(sourceBitmapData:BitmapData,tileWidth:int, tileHeight:int ) 
		{
			
			this.sourceBitmapData = sourceBitmapData;
			width = sourceBitmapData.width;
			height =  sourceBitmapData.height;
			this.tileHeight = tileHeight;
			this.tileWidth = tileWidth;
			tilesPerRow = int(width / this.tileWidth);
		}
		
	
		
	}
	
}