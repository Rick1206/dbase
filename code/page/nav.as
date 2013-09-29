package code.page
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import code.tool.RollTool;
	import com.greensock.TweenMax;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public class nav extends MovieClip
	{
		
		private var menuArr:Array;
		
		public function nav()
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
			
			menuArr = new Array();
			for (var i:Number = 1; i < 5; i++)
			{
				var btn:MovieClip = this.getChildByName("b" + i) as MovieClip;
				btn.enabled = false;
				btn.alpha = 0;
				btn.visible = false;
				btn.gotoAndStop(1);
				menuArr.push(btn);
				btn.addEventListener(MouseEvent.CLICK, onBtnHandler);
				RollTool.setRoll(btn);
			}
			
			hm.addEventListener(MouseEvent.ROLL_OUT, onHmRollHadler);
			hm.addEventListener(MouseEvent.ROLL_OUT, onHmRollHadler);
			
			RollTool.setRoll(hm);
			RollTool.setRoll(cu);
						
			hm.addEventListener(MouseEvent.CLICK, onHmClcikHadler);
			
			cu.addEventListener(MouseEvent.CLICK, onCuClcikHadler);
		
		}
		
		private function onBtnHandler(e:MouseEvent):void
		{
			switch (e.currentTarget.name)
			{
				case "b1": 
					setAddress("/dot/", "#/dot/", "dbase - dot");
					break;
				case "b2": 
					setAddress("/furniture/", "#/furniture/", "dbase - furniture");
					break;
				case "b3": 
					setAddress("/project/", "#/project/", "dbase - project");
					break;
				case "b4": 
					setAddress("/resource/", "#/resource/", "dbase - resource");
					break;
			}
		}
		
		public function showMenu()
		{
			
			for (var i:int = 0; i < 4; i++)
			{
				TweenMax.to(menuArr[i], 0.3, { autoAlpha:1 } );
			}
		}
		
		
		public function hideMenu()
		{
			
			for (var i:int = 0; i < 4; i++)
			{
				TweenMax.to(menuArr[i], 0.3, { autoAlpha:0 } );
			}
		}
		
		private function onCuClcikHadler(e:MouseEvent):void
		{
			setAddress("/contactus/", "#/contactus/", "dbase - Contact us - 联系我们");
		}
		
		private function onHmClcikHadler(e:MouseEvent):void
		{
			setAddress("/brand/", "#/brand/", "dbase - Home - 首页");
		}
		
		private function onHmRollHadler(e:MouseEvent):void
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
		
		private function setAddress(v:String, h:String, t:String)
		{
			SWFAddress.setValue(v);
			SWFAddress.href(h);
			SWFAddress.setTitle(t);
		}
	}

}
