package code.page
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import code.tool.RollTool;
	
	public class landing extends MovieClip
	{
		
		public function landing()
		{
			// constructor code
			
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			TweenMax.from(etc, 1, {alpha: 0});
			for (var i:Number = 1; i < 8; i++)
			{
				var pic:MovieClip = this["p" + i];
				TweenMax.from(pic, 1, {alpha: 0, ease: Cubic.easeInOut, delay: i * 0.5});
				
			}
			
			TweenMax.to(etc.btns, 0, {_alpha: 0, ease: Cubic.easeInOut});
			
			etc.hit2.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			etc.hit1.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
			
			etc.hit1.useHandCursor = false;
			etc.hit2.useHandCursor = false;
			etc.hit2.enabled = false;
			
			
			
			RollTool.setRoll(etc.btns.en);
			RollTool.setRoll(etc.btns.cn);
			etc.btns.en.addEventListener(MouseEvent.ROLL_OUT, onBtnRollHandler);
			etc.btns.en.addEventListener(MouseEvent.ROLL_OVER, onBtnRollHandler);
			
			etc.btns.cn.addEventListener(MouseEvent.ROLL_OUT, onBtnRollHandler);
			etc.btns.cn.addEventListener(MouseEvent.ROLL_OVER, onBtnRollHandler);
	
		
		}
		
		private function onBtnRollHandler(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch (e.type)
			{
				case 'rollOver':
					
					TweenLite.to(mc, 0.33, {tint: 0xba000c});
					break;
				case 'rollOut': 
					TweenLite.to(mc, 0.33, {tint: 0x6d6c6c});
					break;
			
			}
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch (e.type)
			{
				case 'rollOver':			
					switch (mc.name)
				{
					case 'hit1': 
						etc.hit1.enabled = false;
						etc.hit2.enabled = true;
						TweenLite.to(etc.btns, 0.33, {alpha: 100});
						break;
					case 'hit2': 
						etc.hit1.enabled = true;
						etc.hit2.enabled = false;
						TweenLite.to(etc.btns, 0.33, {alpha: 0});
						break;
				}
					break;
			
			}
		}
	}

}
