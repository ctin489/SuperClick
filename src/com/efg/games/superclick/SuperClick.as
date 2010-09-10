package  com.efg.games.superclick
{
	// Import necessary classes from the flash libraries
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.efg.framework.Game;
	import com.efg.framework.CustomEventLevelScreenUpdate;
	import com.efg.framework.CustomEventScoreBoardUpdate;
	import com.efg.framework.CustomEventSound;
	
	/**
	 * ...
	 * @author Jeff Fulton
	 */
	public class SuperClick extends com.efg.framework.Game
	{
	
		//game logic and flow
		private var score:int;
		private var level:int;
		private var percent:Number;
		private var clicked:int;
		private var gameOver:Boolean;
		private var circles:Array;
		private var tempCircle:Circle;
		private var numCreated:int;
		
		//messaging
		private var scoreTexts:Array;
		private var tempScoreText:ScoreTextField;
		private var textFormat:TextFormat = new TextFormat("_sans", 12, "0xffffff", "true");
		
		
		//game level difficulty
		private var maxScore:int = 50;
		private var numCircles:int;
		private var circleGrowSpeed:Number;
		private var circleMaxSize:Number
		private var percentNeeded:Number;
		private var maxCirclesOnscreen:int;
		private var percentBadCircles:Number;
		
		
		
		
		
		
		
		
		public function SuperClick() {
		}
		
		
		//newGame() is called by the Main
		//1. Resets level and score to 0
		//2. dispatched custom events to reset scoreBoard display items
		override public function newGame():void {
			trace("new game");
			level = 0;
			score = 0;
			gameOver = false;
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_SCORE,"0"));
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_CLICKED,"0/0"));
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_PERCENT_NEEDED,"0%"));
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_PERCENT_ACHIEVED,"0%"));
		}
		
		//newLevel() is called by the Main
		//1. Resets level specific variables 
		//2 Increases game leveling based on leveling logic
		//3. Number of Blue Circles per level: 25 * level
		//4. % Chance for a bad circle: level  + 9. after level 25 % is  40%
		//5. Circle Growth Speed:  .01*level
		//6. Max Circle Size: 5 – level. After level 5 = Max is 1
		//7. Percent successful Clicks needed to move to next level:  10 + (5 * level)
		//8. Max Circles on screen: 10 * level
		//9. Sends custom events to Main reset scoreBoard
		//10. Sends custom even to Main to update Level Screen text
		override public function newLevel():void {
			trace("new level");
			percent = 0;
			clicked = 0;
			circles = [];
			scoreTexts = [];
			level++;
			numCircles = level * 25;
			circleGrowSpeed = .01*level;
			circleMaxSize = (level < 5) ? 5-level : 1;
			percentNeeded = 10 + (5 * level);
			if (percentNeeded > 90)  percentNeeded = 90;
			maxCirclesOnscreen = 10 * level;
			numCreated = 0;
			percentBadCircles = (level < 25) ? level + 9 : 40;
			
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT, Main.SCORE_BOARD_PERCENT_NEEDED, String(percentNeeded)));
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_CLICKED,String(clicked + "/" + numCircles)));
			dispatchEvent(new CustomEventLevelScreenUpdate(CustomEventLevelScreenUpdate.UPDATE_TEXT, String(level)));
			
		}
		
		//runGame() is repeatedly called by Main in game loop
		//1. We make sure to call render() only if DISPLAY_UPDATE_NORMAL is passed in 
		override public function runGame():void {
			trace("run game");
			update();
			checkCollisions();
			render();					
			checkforEndLevel();
			checkforEndGame();
		}
		
	
		
		//update() is called every frame
		//1. creates a new circle if number on screen is less than max on screen
		//2. creates a new circle is number created so far is less than the number of circles for the level
		//3. uses a random var 0-99 to check if a red circle should appear
		//4. Creates the new circle, pushes it to circles, adds to the screen
		private function update():void {
			
			if (circles.length < maxCirclesOnscreen && numCreated <numCircles) {
				var newCircle:Circle;
				if (int(Math.random() * 100) <= percentBadCircles ) {
					newCircle=new Circle(Circle.CIRCLE_BAD)
				}else {
					newCircle=new Circle(Circle.CIRCLE_GOOD)
					numCreated ++;
				}
				addChild(newCircle);
				circles.push(newCircle);
			}
			
			
			// Checks circles every frame for size and adds to their nextScale property
			//1. if nextScale is larger than the max, removes the circle
			var circleLength:int = circles.length-1;
			for (var counter:int = circleLength; counter >= 0; counter--) {
				tempCircle = circles[counter];
				tempCircle.update(circleGrowSpeed);
				if (tempCircle.nextScale > circleMaxSize || tempCircle.alpha <0 ) {
					removeCircle(counter);
				}
			}
			
			var scoreTextLength:int = scoreTexts.length-1;
			for (counter= scoreTextLength; counter >= 0; counter--) {
				tempScoreText = scoreTexts[counter];
				
			if (tempScoreText.update()){ //returns true is life is over
					removeScoreText(counter);
				}
			}
		}
		
		//checkCollisions() is called every frame
		//1. loops through circles and checks for ones that have "clicked" set to true
		//2. Updates the 
		//2. If so, removes them, gives a score (if blue) and disposes of them
		//3. if a red circle was clicked, sets gameOver to true
		private function checkCollisions():void {
			var circleLength:int = circles.length-1;
			for (var counter:int = circleLength; counter >= 0; counter--) {
				tempCircle = circles[counter];
				if (tempCircle.clicked && !tempCircle.fadingOut) {
					tempCircle.fadingOut = true;
					if (tempCircle.type==Circle.CIRCLE_GOOD && tempCircle.alpha==1) {
						var scoreAdjust:Number = 1 / tempCircle.scaleX;
						var scoreAdd:int=maxScore * scoreAdjust;
						addToScore(scoreAdd);
						tempScoreText = new ScoreTextField(String(scoreAdd), textFormat, tempCircle.x, tempCircle.y, 20);
						scoreTexts.push(tempScoreText);
						addChild(tempScoreText);
						//dispatchEvent( new CustomEventSound(CustomEventSound.PLAY_SOUND,Main.SOUND_CLICK,false,1,0,1));
					}else if (tempCircle.type==Circle.CIRCLE_BAD) {
						gameOver = true;
					}
				}
				
			}
		}
		
		//render() is called only on frames where we have a constant frame rate
		//1. Loops through circles and sets scaleX and scaleY to the nextScale value
		private function render():void {
			var circleLength:int = circles.length-1;
			for (var counter:int = circleLength; counter >= 0; counter--) {
				tempCircle = circles[counter];
				tempCircle.scaleX = tempCircle.nextScale;
				tempCircle.scaleY = tempCircle.nextScale;
			}
		}
		
		//checkforEndGame() checks for gameOver==true and sends basic custom event to Main
		//If game is over, cleanUp is called to free memory for garbage collection
		private function checkforEndGame():void {
			if (gameOver) {
				dispatchEvent(new Event(GAME_OVER));
				cleanUp();
			}
		}
		
		//checkForEndOfLevel checks for the level end conditions:
		//1. no more circles on the screen
		//2. number of circles creates equals the number for the level
		//3. If both true, then checks to make sure the user clicked enough to move to nnect level
		//4. based on that evlauation, either sets gameOver to true, or dispatched simple custom event NEWLEVEL
		private function checkforEndLevel():void {
			
			if (circles.length == 0 && numCreated == numCircles && scoreTexts.length == 0) {
				if (percent >= percentNeeded) {
					dispatchEvent(new Event(NEW_LEVEL));
				}else {
					gameOver = true;
				}
			}
		}
		
		//addToScore() - 1/scaleX is passed in. This allows the score to be based on the size of the circle. 
		//1. The smaller the circle, the more points earned for clickingg it
		//2. ScoreBoard custom events are fired off to update display fields
		private function addToScore(scoreAdd:Number):void {
			score += scoreAdd;
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_SCORE,String(score)));
			clicked++;
			percent = 100 * (clicked / numCircles);
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT, Main.SCORE_BOARD_PERCENT_ACHIEVED, String(percent)));
			dispatchEvent(new CustomEventScoreBoardUpdate(CustomEventScoreBoardUpdate.UPDATE_TEXT,Main.SCORE_BOARD_CLICKED,String(clicked + "/" + numCircles)));
		}
		
		
		//removeCircle() - cleanly disposes of object instances
		private function removeCircle(counter:int):void {
			tempCircle = circles[counter];
			tempCircle.dispose();
			removeChild(tempCircle);
			circles.splice(counter, 1);
		}
		
		private function removeScoreText(counter:int):void {
			tempScoreText = scoreTexts[counter];
			tempScoreText.dispose();
			removeChild(tempScoreText);
			scoreTexts.splice(counter, 1);
		}
		
		//cleanUp() - at end of game, removes and diaposes of all circles left on screen.
		private function cleanUp():void {
			var circleLength:int = circles.length-1;
			for (var counter:int = circleLength; counter >= 0; counter--) {
				removeCircle(counter);
			}
			var scoreTextLength:int = scoreTexts.length-1;
			for (counter= scoreTextLength; counter >= 0; counter--) {
				removeScoreText(counter);
			}
		}
	}
	
}