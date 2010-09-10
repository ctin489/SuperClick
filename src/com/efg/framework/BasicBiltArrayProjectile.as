package com.efg.framework 
{
	import com.efg.framework.BasicBlitArrayObject;
	import com.efg.framework.BasicBiltArrayProjectile;
	/**
	 * ...
	 * @author ...
	 */
	public class BasicBiltArrayProjectile extends BasicBlitArrayObject
	{
		
		
		public function BasicBiltArrayProjectile(xMin:int,xMax:int, yMin:int, yMax:int  ) {
			super(xMin, xMax, yMin, yMax);
		}
		
		public function update(xAdjust:Number, yAdjust:Number,step:Number=1 ):Boolean {
			//x adjust and y adjust change speed of projectile.
			//in this case they are used to ensure that sprojetciles are as fast or faster than the player ship
			//add xMove to dx and dy so the missiles fire faster if ship is moving faster
			nextX+=(dx*(speed+Math.abs(xAdjust)))*step;
			nextY+=(dy*(speed+Math.abs(yAdjust)))*step;
			
			if (nextX > xMax || nextX < xMin || nextY > yMax || nextY < yMin) {
				return(true)
			}else {
				return(false);
			}
				
		}
		
		
		
	}

}