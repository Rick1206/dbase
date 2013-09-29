package code.page
{
	import flashandmath.as3.gallery.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import com.greensock.TweenMax;
	import code.tool.RollTool;
	public class gallery extends MovieClip
	{
		
		public function gallery()
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
		
		public function init(xml:String):void {
			var gallery:CylindricalGallery = new CylindricalGallery(xml, 600,0xffffff,0xffffff,-100);
			
			this.addChild(gallery);
			
			gallery.x = 225;
			
			gallery.y = 150;
			
			RollTool.setRoll(cls);
			
			//cls.addEventListener(MouseEvent.CLICK, onCloseHandler);
		}
		private function initAll(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initAll);
		
		}
		
		//private function onCloseHandler(e:MouseEvent):void 
		//{
			//TweenMax.to(this, 0.3, { autoAlpha:0 } );
		//}
	
	}

}
