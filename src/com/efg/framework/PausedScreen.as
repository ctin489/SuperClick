package  
{
	import BasicScreen;
	import flash.geom.*;
	import flash.display.*;
	import flash.text.*;
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class PausedScreen extends BasicScreen
	
	{
		private var backgroundBD:BitmapData;
		private var backgroundBitmap:Bitmap;
		
		
		public function PausedScreen(width:int, height:int,bgcolor:Number, idval:String, okneeded:Boolean, btext:String, okLocationval:Point = null, okWidthval:Number = undefined, okHeightval:Number = undefined) 
		{
			
			backgroundBD = new BitmapData(width, height, true, bgcolor);
			backgroundBitmap = new Bitmap(backgroundBD);
			addChild(backgroundBitmap);
			super(idval,okneeded, btext, okLocationval, okWidthval,okHeightval);
		}
	}
	
}