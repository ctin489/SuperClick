package com.efg.framework
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.geom.*;
	import flash.events.*;
	import flash.utils.getTimer;
	import flash.text.*;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class FrameRateProfiler extends Sprite //so you can place it on the screen and see status
	
	{
		
		public static const EVENT_COMPLETE:String = "profile complete";
		
		private var profileTimer:Timer;
		
		//public preperties
	
		public var profilerRenderObjects:int = 500;
		public var profilerRenderLoops:int = 10;
		public var profilerDisplayOnScreen:Boolean = false;
		public var profilerXLocation:int = 0;
		public var profilerYLocation:int = 0;
		
		public var profilerFrameRateAverage:int = 0;
		
		private var profilerFrameRate:int = 40;
		private var profilerRenderFrames:int = 0;
		private var profilerBackground:BitmapData = new BitmapData(400, 400, false, 0x000000);
		private var profilerCanvas:BitmapData = new BitmapData(400, 400, false, 0x000000);
		private var profilerBitmap:Bitmap = new Bitmap(profilerCanvas);
		private var profilerObject:BitmapData = new BitmapData(20, 20,false, 0xff0000);
		private var profilerFrameRateTotal:int=0;
		private var profilerFrameRateEventCounter:int = 0;
		private var profilerFrameCount:int = 0;
		private var profilerTempObject:Object;
		private var profilerObjectArray:Array = [];
		private var profilerRenderPoint:Point = new Point(0, 0);
		private var profilerFrameRateArray:Array= [];
		
		private var format:TextFormat=new TextFormat();
		private var messageTextField:TextField = new TextField();
		
		private var frameCounter:FrameCounter = new FrameCounter(); //added chapter 11
		
		public function FrameRateProfiler() {
			
			addChild(frameCounter); 
			frameCounter.x = 0;	
			frameCounter.y = 0;
		}
		
		public function startProfile(frameRate:int):void {
			trace("start profile");
			profilerFrameRate = frameRate;
			
			if (profilerDisplayOnScreen) {
				profilerBitmap.y = 20;
				profilerBitmap.x = 0;
			}else {
				profilerBitmap.x = stage.width + 10;
			}
			addChild(profilerBitmap);
			format.align = "center";
			format.size=24;
			format.font="Arial";
			format.color = 0xffffff
			format.bold = true;
			messageTextField.defaultTextFormat = format;
			messageTextField.text = "Profiling\nOptimal\nFrame Rate";
			
			messageTextField.width=200;
			messageTextField.height = 200;
			messageTextField.x = 100;
			messageTextField.y = 100;
			addChild(messageTextField);
			
			
			for (var ctr:int = 0; ctr < profilerRenderObjects; ctr ++) {
				 profileAddObject()
			}
			
			profilerRenderFrames = profilerRenderLoops * profilerFrameRate;
			addEventListener(Event.ENTER_FRAME, runProfile);
			
		}
		
		private function runProfile(e:Event):void {
			profileUpdate();
			profileRender();
			if (frameCounter.countFrames()) {
				profilerFrameRateTotal += frameCounter.lastframecount;
				profilerFrameRateEventCounter++;
				messageTextField.text = "Profiling\nOptimal\nFrame Rate\n" + String(int(profilerFrameCount / profilerRenderFrames * 100)) + "%";
				profilerFrameRateArray.push(frameCounter.lastframecount);
			}
		
			profilerFrameCount++;
			if (profilerFrameCount > profilerRenderFrames) {
				profileCalculate();
			}
			
			
		}
		
		private function profileCalculate():void {
		
			profilerFrameRateAverage = profilerFrameRateTotal / profilerFrameRateEventCounter;
			dispose();
			dispatchEvent(new Event(EVENT_COMPLETE));
		}
		
		
		private function profileAddObject():void {
			var profilerTempObject:Object = new Object();
			profilerTempObject.x=(Math.random() * 399);
			profilerTempObject.y=(Math.random() * 399);
			profilerTempObject.speed = (Math.random() * 5) + 1;
			profilerTempObject.dx=Math.cos(2.0*Math.PI*((Math.random()*360)-90)/360.0);
			profilerTempObject.dy = Math.sin(2.0 * Math.PI * ((Math.random()*360) - 90) / 360.0);
			profilerObjectArray.push(profilerTempObject);
		}
		
		
		private function profileUpdate():void {
			for each (profilerTempObject in profilerObjectArray) {
				profilerTempObject.x += profilerTempObject.dx * profilerTempObject.speed;
				profilerTempObject.y += profilerTempObject.dy * profilerTempObject.speed;
				if (profilerTempObject.x > profilerCanvas.width) {
					profilerTempObject.x = 0;
				}else if (profilerTempObject.x < 0) {
					profilerTempObject.x = profilerCanvas.width;
				}
				
				if (profilerTempObject.y > profilerCanvas.height) {
					profilerTempObject.y = 0;
				}else if (profilerTempObject.y < 0) {
					profilerTempObject.y = profilerCanvas.height;
				}
			}
		}
		
		private function profileRender():void {
			profilerCanvas.lock();
			profilerRenderPoint.x = 0;
			profilerRenderPoint.y = 0;
			profilerCanvas.copyPixels(profilerBackground, profilerBackground.rect, profilerRenderPoint);
			for each (profilerTempObject in profilerObjectArray) {
				
				
				profilerRenderPoint.x = profilerTempObject.x;
				profilerRenderPoint.y = profilerTempObject.y;
				profilerCanvas.copyPixels(profilerObject, profilerObject.rect, profilerRenderPoint);
			}
			profilerCanvas.unlock();
		}
		
		
		public function dispose():void {
			removeEventListener(Event.ENTER_FRAME, runProfile);
			for (var ctr:int = 0; ctr < profilerObjectArray.length; ctr++) {
				profilerObjectArray[ctr] = null;
				profilerObjectArray.splice(1, 0);
			}
			
			removeChild(profilerBitmap);
			
			removeChild(messageTextField);
			profilerObjectArray = null;
			profilerBackground.dispose();
			profilerBackground = null;
			profilerCanvas.dispose();
			profilerBitmap = null;
			profileTimer = null;
			format = null;
			messageTextField = null;
			frameCounter = null;
		}
		
		
		
		
		
		
	}

}