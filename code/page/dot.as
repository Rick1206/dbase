package code.page
{
	
	import code.events.PChangeEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.Event;
	import code.tool.RollTool;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	public class dot extends MovieClip
	{
		
		private var intNum:int = 1;
		private var tArr:Array;
		private var mArr:Array;
		
		public function dot()
		{
			if (stage)
			{
				initAll();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, initAll);
			}
		}
		
		private function initAll(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
			ar1.visible = false;
			
			RollTool.setRoll(ar1);
			
			RollTool.setRoll(ar2);
			
			ar1.addEventListener(MouseEvent.ROLL_OUT, onArRollHadler);
			ar1.addEventListener(MouseEvent.ROLL_OVER, onArRollHadler);
			
			ar2.addEventListener(MouseEvent.ROLL_OUT, onArRollHadler);
			ar2.addEventListener(MouseEvent.ROLL_OVER, onArRollHadler)
			
			ar2.addEventListener(MouseEvent.CLICK, onNextHandler);
			ar1.addEventListener(MouseEvent.CLICK, onPrevHandler);
			
			tArr = [t1, t2];
			for (var i:int = 0; i < 2; i++)
			{
				tArr[i].visible = false;
				tArr[i].alpha = 0;
			}
			
			tArr[0].visible = true;
			tArr[0].alpha = 1;
			TweenMax.from(mn, 0.33, {alpha: 0});
			
			mArr = [mn.b1, mn.b2];
			for (i = 0; i < 2; i++)
			{
				mArr[i].addEventListener(MouseEvent.ROLL_OUT, onRollHadler);
				mArr[i].addEventListener(MouseEvent.ROLL_OVER, onRollHadler);
				mArr[i].addEventListener(MouseEvent.CLICK, onMenuHadler);
				
				RollTool.setRoll(mArr[i]);
			}
			
			CheckState();
			setMenu();
			
			RollTool.setRoll(t2.w1);
			
			//t2.w1.addEventListener(MouseEvent.CLICK, onPicHadler);
			
			t2.w1.addEventListener(MouseEvent.CLICK, onPicHadler);
		}
		
		private function onPicHadler(e:MouseEvent):void 
		{
			var myEvent:PChangeEvent = new PChangeEvent(PChangeEvent.CHANGE);
			myEvent.page = "config/dotw1.xml";
			stage.dispatchEvent(myEvent);
			
		}
		private function setMenu()
		{
			TweenMax.to(mn, 0.33, {_alpha: 0, ease: Cubic.easeInOut});
			hit1.addEventListener(MouseEvent.ROLL_OVER, onMnRollHadler);
			hit2.addEventListener(MouseEvent.ROLL_OVER, onMnRollHadler);
			
			hit1.useHandCursor = false;
			hit2.useHandCursor = false;
		}
		
		private function onMnRollHadler(e:MouseEvent):void
		{
			
			switch (e.currentTarget.name)
			{
				case "hit1": 
					TweenMax.to(mn, 0.33, {alpha: 1, ease: Cubic.easeInOut});
					break;
				case "hit2": 
					TweenMax.to(mn, 0.33, {alpha: 0, ease: Cubic.easeInOut});
					break;
			}
		}
		
		private function onMenuHadler(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch (e.currentTarget.name)
			{
				case "b1": 
					ar1.visible = false;
					ar2.visible = true;
					intNum = 1;
					
					break;
				case "b2": 
					ar1.visible = true;
					ar2.visible = true;
					intNum = 2;
					break;
			}
			
			for (var i:int = 0; i < 2; i++)
			{
				if ((intNum - 1) == i)
				{
					TweenMax.to(tArr[i], 0.5, {autoAlpha: 1});
				}
				else
				{
					TweenMax.to(tArr[i], 0.3, {autoAlpha: 0});
				}
				
			}
			
			CheckState();
		
		}
		
		private function CheckState()
		{
			for (var i:int = 0; i < 2; i++)
			{
				if ((intNum - 1) == i)
				{
					mArr[i].gotoAndStop(2);
					
					mArr[i].removeEventListener(MouseEvent.ROLL_OUT, onRollHadler);
					mArr[i].removeEventListener(MouseEvent.ROLL_OVER, onRollHadler);
				}
				else
				{
					mArr[i].gotoAndStop(1);
					
					mArr[i].addEventListener(MouseEvent.ROLL_OUT, onRollHadler);
					mArr[i].addEventListener(MouseEvent.ROLL_OVER, onRollHadler);
				}
				
			}
			
			if (intNum == 1)
			{
				ar1.visible = false;
			}
			
			if (intNum == 2)
			{
				ar2.visible = false;
			}
		}
		
		private function onPrevHandler(e:MouseEvent):void
		{
			if (intNum > 1)
			{
				
				TweenMax.to(tArr[intNum - 1], 0.33, {autoAlpha: 0, onComplete: function()
					{
						
						TweenMax.to(tArr[intNum - 1], 0.5, {autoAlpha: 1});
					
					}});
				
				ar2.visible = true;
				
				intNum--;
				
			}
			
			CheckState();
		}
		
		private function onNextHandler(e:MouseEvent):void
		{
			if (intNum < 2)
			{
				
				TweenMax.to(tArr[intNum - 1], 0.33, {autoAlpha: 0, onComplete: function()
					{
						
						TweenMax.to(tArr[intNum - 1], 0.5, {autoAlpha: 1});
					
					}});
				
				ar1.visible = true;
				
				intNum++;
				
			}
			CheckState();
		}
		
		private function onArRollHadler(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch (e.type)
			{
				case "rollOut": 
					mc.gotoAndStop(1);
					break;
				case "rollOver": 
					mc.gotoAndStop(2);
					break;
			}
		}
		
		private function onRollHadler(e:Event):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch (e.type)
			{
				case "rollOut": 
					mc.gotoAndStop(1);
					break;
				case "rollOver": 
					mc.gotoAndStop(3);
					break;
			}
		}
	}

}
