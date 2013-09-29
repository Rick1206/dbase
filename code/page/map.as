package code.page
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import code.tool.RollTool;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	
	public class map extends MovieClip
	{
		private var place = this;
		public function map()
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
			
			for (var i:int = 1; i < 11; i++)
			{
				var tip:MovieClip = this["t" + i];
				tip.alpha = 0;
				tip.visible = false;
			}
			
			
			
			for (i = 1; i < 11; i++)
			{
				var btn:MovieClip = this["d" + i];
				btn.num = i;
				RollTool.setRoll(btn);
				TweenMax.from(btn, 1, {scaleY: 10, scaleX: 10, autoAlpha: 0, delay: i * 0.10});
				
				btn.addEventListener(MouseEvent.ROLL_OUT, onArRollHadler);
				btn.addEventListener(MouseEvent.ROLL_OVER, onArRollHadler);
				
				
			}
		}
		
		private function onArRollHadler(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			switch (e.type)
			{
				case "rollOut": 
					for (var i:int = 1; i < 11; i++)
					{
						if (i == mc.num)
						{
							TweenMax.to(place["t" + i], 0.33, {autoAlpha: 0});
						}
					}
					break;
				case "rollOver":
					for (i = 1; i < 11; i++)
					{
						if (i == mc.num)
						{
							TweenMax.to(place["t" + i], 0.66, {autoAlpha: 1});
						}
					}
					break;
			}
		}
	}

}
