package  com.efg.games.superclick
{
	// Import necessary classes from the flash libraries
	import flash.display.Shape;
	import flash.display.Sprite
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class Circle extends Sprite
	{
		//Constsants used to define circle type
		public static const CIRCLE_GOOD:int = 0;
		public static const CIRCLE_BAD:int = 1;
		
		public var type:int;
		public var clicked:Boolean=false;
		public var fadingOut:Boolean = false;
		//private var shape:Shape=new Shape();
		
	
		public var nextScale:Number;
		
		//Constructor sets the handcursor mode and accepts type constant
		//init is called and type is passed to it
		
		public function Circle(typeval:int) 
		{
			buttonMode = true;
			useHandCursor = true;
			init(typeval);
			
		}
		
		//init
		//1. Based on the typeval passed, sets the type attribute
		//2. Based on type, sets the color of the cirle
		public function init(typeval:int):void {
			var shapeColor:Number;
			switch (typeval) {
				case CIRCLE_GOOD: 
					//good circle
					shapeColor = 0x0000FF;
					type = typeval;
					break;
				case CIRCLE_BAD:
					//bad circle
					shapeColor = 0xFF0000;
					type = typeval;
					break;
				
			}
			
			graphics.clear();
			graphics.lineStyle(2, 0xffffff);
			graphics.beginFill(shapeColor);
			graphics.drawCircle(5, 5, 8);
			graphics.endFill();
		
			
			x = int(Math.random() * 399);
			y = int(Math.random() * 399);
			
			scaleX = .5;
			scaleY = .5;
			nextScale = scaleX;
			
		
			
			addEventListener(MouseEvent.MOUSE_DOWN, clickedListener, false, 0, true);
		}
		
		public function update(growSpeed:Number):void {
			if (fadingOut) {
				alpha -= .05;
			}else{
				nextScale += growSpeed;
			}
		}
		
		
		//Dispose is needed to get rid of unwanted objects and get them ready for garbage collection
		public function dispose():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, clickedListener);
	
		}
		
		//Once clicked, the clicked property is set to true and evaluated by the game class
		private function clickedListener(e:MouseEvent):void {
			clicked = true;
			removeEventListener(MouseEvent.MOUSE_DOWN, clickedListener);
			
		}
	}
	
}