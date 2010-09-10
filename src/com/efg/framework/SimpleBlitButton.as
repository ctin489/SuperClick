package  com.efg.framework
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class SimpleBlitButton extends Sprite
	{
		public static const OFF:int = 1;
		public static const OVER:int = 2;
		//all buttons backgrounds. 
		//using a simple Bitmapdata rectangle to create the white and red button background states
		private var offBackGroundBD:BitmapData;
		private var overBackGroundBD:BitmapData;
		
		private var positionOffset:Number;
		
		//OK button
		//The OK button is made up of a Bitmap of the text and a bitmap of the background layered onto one another.
		//They both are layerd into a Sprite to get Click events 
		
		private var buttonBackGroundBitmap:Bitmap;
		private var buttonTextBitmapData:BitmapData;
		private var buttonTextBitmap:Bitmap;
		
		
		public function SimpleBlitButton(x:Number,y:Number,width:Number,height:Number, text:String, offColor:uint, overColor:uint, textformat:TextFormat, positionOffset:Number=0) 
		{
			this.positionOffset = positionOffset;
			this.x = x;
			this.y = y;
			//background
			offBackGroundBD = new BitmapData(width, height, false, offColor);
			overBackGroundBD = new BitmapData(width, height, false, overColor);
			buttonBackGroundBitmap = new Bitmap(offBackGroundBD);
			
			//text
			var tempText:TextField = new TextField();
			tempText.text = text;
			tempText.setTextFormat(textformat);
			
			buttonTextBitmapData  = new BitmapData(tempText.textWidth+positionOffset,tempText.textHeight+positionOffset, true, 0x00000000);
			buttonTextBitmapData.draw(tempText);
			buttonTextBitmap = new Bitmap(buttonTextBitmapData);
	
			buttonTextBitmap.x = ((buttonBackGroundBitmap.width - int(tempText.textWidth))/2)-positionOffset;
			buttonTextBitmap.y = ((buttonBackGroundBitmap.height - int(tempText.textHeight))/2)-positionOffset;
		
			
			addChild(buttonBackGroundBitmap);
			addChild(buttonTextBitmap);
			this.buttonMode = true;
			this.useHandCursor = true;
			
			
		}
		
		public function changeBackGroundColor(typeval:int):void {
			if (typeval == SimpleBlitButton.OFF) {
				buttonBackGroundBitmap.bitmapData = offBackGroundBD;
			}else {
				buttonBackGroundBitmap.bitmapData = overBackGroundBD;
			}
		}
		
		
	}
	
}