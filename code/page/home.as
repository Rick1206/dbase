package code.page
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import flash.events.MouseEvent;
	import com.greensock.TweenLite;
	import code.tool.RollTool;
	import code.GlobalVars;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public class home extends MovieClip
	{
		
		public function home()
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
			p1.etc.btns.en.addEventListener(MouseEvent.CLICK, onChangeVersionHandler);
			p1.etc.btns.cn.addEventListener(MouseEvent.CLICK, onChangeVersionHandler);
		}
		
		private function onChangeVersionHandler(e:MouseEvent):void
		{
		
			switch (e.currentTarget.name)
			{
				case "en": 
					GlobalVars.setVserion("en");
					setAddress("/intro/", "#/intro/", "dbase - Intro");
					break;
				case "cn": 
					GlobalVars.setVserion("cn");
					setAddress("/intro/", "#/intro/", "dbase - Intro");
					break;
				default: 
			}
		
		}
		
		private function onRollHandler(e:MouseEvent):void
		{
		
		}
		
		private function setAddress(v:String, h:String, t:String)
		{
			SWFAddress.setValue(v);
			SWFAddress.href(h);
			SWFAddress.setTitle(t);
		}
	}

}
