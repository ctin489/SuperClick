package  com.efg.games.superclick
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class ScoreTextField extends Sprite
	{
		
		private var textField:TextField = new TextField();
		private var life:int;
		private var lifeCount:int;
		//private var test:Vector.<int> = new Vector.<int>();
		
		
		public function ScoreTextField(text:String, textFormat:TextFormat,x:Number,y:Number, life:int) {
			this.x = x;
			this.y = y;
			this.life = life;
			this.lifeCount = 0;
			textField.defaultTextFormat = textFormat;
			textField.selectable = false;
			textField.text = text;
			addChild(textField);
		}
		
		public function update():Boolean {
			trace("scoreText update");
			lifeCount++;
			if (lifeCount > life) {
				return true;
			}else {
				return false;
			}
		}
		
		public function dispose():void {
			removeChild(textField);
			textField = null;
		}
		
	}

}