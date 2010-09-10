package com.efg.framework
{
	import com.efg.framework.BasicBlitArrayObject;
	/**
	 * ...
	 * @author ...
	 */
	public class BasicBiltArrayParticle extends BasicBlitArrayObject
	{
		
		public var lifeDelayCount:int = 0;
		public var lifeDelay:int=0;
		
		private var remove:Boolean = false;
		
		public function BasicBiltArrayParticle(xMin:int,xMax:int, yMin:int, yMax:int  ) {
			super(xMin, xMax, yMin, yMax);
		}
		
		public function update(step:Number=1 ):Boolean {
			remove = false;
			nextX+=dx*speed*step;
			nextY+=dy*speed*step;
			
			if (lifeDelayCount > lifeDelay) {
				lifeDelayCount = 0;
				frame++;
				if (frame == animationList.length) {
					remove = true;
				}else {
					bitmapData = animationList[frame];
				}
			}else {
				lifeDelayCount++;
			}
			
			if (nextX > xMax || nextX < xMin || nextY > yMax || nextY < yMin) {
				remove = true;
			}
				
			return(remove);

		}
		
	}

}