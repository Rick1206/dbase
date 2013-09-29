package code
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import code.GlobalVars;
	import code.events.PChangeEvent;
	import code.page.gallery;
	import flash.events.MouseEvent;
	public class main extends MovieClip
	{
		
		private var loader:Loader;
		private var mc:MovieClip;
		private var _percentage:Number;
		private var _status:String = "";
		private var gc:gallery;
		public function main()
		{
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
			
			var str:String = stage.loaderInfo.parameters["loc"];
			if (str != null && str != "")
			{
				GlobalVars.setPath(str);
			}
			else
			{
				GlobalVars.setPath("swf/");
			}
			
			//loadSwf(GlobalVars.getPath()+"home.swf");
			
			//setAddress("/brand/", "#/brand/", "dbase - Home - 首页");
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onChangePageHandler);
			//SWFAddress.addEventListener(SWFAddressEvent.INIT, onChangePageHandler);
			
			stage.addEventListener(PChangeEvent.CHANGE, onGalleryHandler);
		
		}
		
		private function onGalleryHandler(e:PChangeEvent):void 
		{
			
			gc = new gallery();
			gc.x = 40;
			gc.y = 40;
			photoMc.addChild(gc);
			gc.init(e.page);
			gc.cls.addEventListener(MouseEvent.CLICK, onCloseHandler);
			
			
		}
		
		private function onCloseHandler(e:Event):void 
		{
			if (gc != null) {
					TweenMax.to(gc, .3, { autoAlpha:0, onComplete:function() {
						photoMc.removeChild(gc);	
						}});
			}
		}
		
		private function onChangePageHandler(e:SWFAddressEvent):void
		{
			var curPageName:String = SWFAddress.getValue();
			
			switch (curPageName)
			{
				case "/brand/": 
					_status = "";
					loadSwf(GlobalVars.getPath() + "home.swf");
					navMC.hideMenu();
					break;
				
				case "/contactus/": 
					_status = "";
					if (GlobalVars.getVersion() == "")
					{
						loadSwf(GlobalVars.getPath() + "contactus.swf");
					}else {
						loadSwf(GlobalVars.getPath() + GlobalVars.getVersion() + "/contactus.swf");
					}
					navMC.showMenu();
					break;
				
				case "/intro/": 
					_status = "intro";
					if (GlobalVars.getVersion() == "")
					{
						loadSwf(GlobalVars.getPath() + "/en/intro.swf");
					}else {
						loadSwf(GlobalVars.getPath() + GlobalVars.getVersion() + "/intro.swf");
					}
					navMC.hideMenu();
					break;
				
				case "/dot/": 
					_status = "";
					if (GlobalVars.getVersion() == "")
					{
						loadSwf(GlobalVars.getPath() + "/en/dot.swf");
					}
					else
					{
						loadSwf(GlobalVars.getPath() + GlobalVars.getVersion() + "/dot.swf");
					}
					navMC.showMenu();
					break;
				
				case "/furniture/": 
					_status = "";
					if (GlobalVars.getVersion() == "")
					{
						loadSwf(GlobalVars.getPath() + "/en/furniture.swf");
					}
					else
					{
						loadSwf(GlobalVars.getPath() + GlobalVars.getVersion() + "/furniture.swf");
					}
					navMC.showMenu();
					break;
				case "/project/": 
					_status = "";
					if (GlobalVars.getVersion() == "")
					{
						loadSwf(GlobalVars.getPath() + "/en/project.swf");
					}
					else
					{
						
						loadSwf(GlobalVars.getPath() + GlobalVars.getVersion() + "/project.swf");
					}
					navMC.showMenu();
					break;
				case "/resource/": 
					_status = "";
					if (GlobalVars.getVersion() == "")
					{
						loadSwf(GlobalVars.getPath() + "/en/resource.swf");
					}
					else
					{
						loadSwf(GlobalVars.getPath() + GlobalVars.getVersion() + "/resource.swf");
					}
					navMC.showMenu();
					break;
				default: 
					_status = "";
					loadSwf(GlobalVars.getPath() + "home.swf");
			}
		
		}
		
		private function loadSwf(str:String):void
		{
			if (mc != null)
			{
				contentMc.removeChild(mc);
				loader.unloadAndStop();
			}
			
			loader = new Loader();
			loader.load(new URLRequest(str));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function progressHandler(e:ProgressEvent):void
		{
			subLoading.visible = true;
			_percentage = Math.round(e.bytesLoaded / e.bytesTotal * 100);
			subLoading.txt_loading.text = String(_percentage) + "%";
		}
		
		private function completeHandler(e:Event):void
		{
			mc = loader.content as MovieClip;
			mc.alpha = 0;
			TweenMax.to(mc, 0.5, {alpha: 1});
			
			if (_status == "intro")
			{
				mc.addEventListener(PChangeEvent.CHANGE, onShowNavHandler);
				contentMc.addChild(mc);
			}
			else
			{
				contentMc.addChild(mc);
			}
			
			subLoading.visible = false;
		
		}
		
		private function onShowNavHandler(e:PChangeEvent):void
		{
			if (e.page == "end")
			{
				navMC.showMenu();
			}
			else
			{
				navMC.hideMenu();
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
