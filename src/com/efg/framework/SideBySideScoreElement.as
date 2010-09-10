package  com.efg.framework
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class SideBySideScoreElement extends Sprite
	{
		private var label:TextField = new TextField();
		private var content:TextField = new TextField();
		private var bufferWidth:Number;
		
		
		public function SideBySideScoreElement(x:Number, y:Number, bufferWidth:Number, labelText:String, labelTextFormat:TextFormat, labelWidth:Number, contentText:String, contentTextFormat:TextFormat) {
			this.x = x;
			this.y = y;
			
			this.bufferWidth= bufferWidth;
			label.autoSize;
			label.defaultTextFormat = labelTextFormat;
			label.text = labelText;
			content.autoSize;
			content.defaultTextFormat = contentTextFormat;
			content.text = contentText;
			label.x = 0;
			content.x = labelWidth + bufferWidth;
			addChild(label);
			addChild(content);
			
		}
		
		public function setLabelText(str:String):void {
			label.text = str;
		}
		
		public function setContentText(str:String):void {
			content.text = str;
		}
	}
	
}