/**
* ...
* @author Jeff Fulton
* @version 0.1
*/

package  {
	import flash.display.*;
	import flash.events.*;
	import flash.system.System;
	import flash.utils.getTimer;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class FrameTimer extends Sprite{
		private var format:TextFormat=new TextFormat();
		private var framectrText:String;
		private var memorypagesText:String;
		private var framectrTextField:TextField = new TextField();
		private var memorypagesField:TextField = new TextField();
		public var lastframecount:int = 0;
		private var frameLast:int = getTimer();
		private var frameCtr:int = 0;	
		public var showProfiledRate:Boolean = false;
		public var profiledRate:int;
		public var updateAfterEvent:Boolean = false;
		
		public function FrameTimer(color:Number=0xffffff):void {
			
			format.size=12;
			format.font="Arial";
			format.color = String(color);
			format.bold = true;
			
			framectrText="0";
			framectrTextField.text=framectrText;
			framectrTextField.defaultTextFormat = format;
			framectrTextField.width=80;
			framectrTextField.height = 20;
			addChild(framectrTextField);
			
			memorypagesText = "0";
			memorypagesField.text=memorypagesText;
			memorypagesField.defaultTextFormat = format;
			memorypagesField.width=100;
			memorypagesField.height = 20;
			memorypagesField.x = 80;
			addChild(memorypagesField);
			
			
			
		}
	

		public function countFrames():Boolean{	
			if (getTimer() >= frameLast + 1000) {
				lastframecount = frameCtr;
				if (showProfiledRate) {
					framectrText = frameCtr.toString() + "/" + profiledRate + " " + updateAfterEvent.toString();
				}else{
					framectrText = frameCtr.toString();
				}
				framectrTextField.text =framectrText; 
				frameCtr = 0;
				frameLast = getTimer();
				
				memorypagesText = String(System.totalMemory / 4096);
				trace(memorypagesText);
				memorypagesField.text=memorypagesText;
				return(true);
			}else {
				frameCtr++;
				return(false);
			}
		}
		
		
		
	} // end class

} // end package