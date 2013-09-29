/* ***********************************************************************
ActionScript 3 Tutorial by Barbara Kaskosz

http://www.flashandmath.com/

Last modified: July 12, 2010

See the tutorial page 

http://www.flashandmath.com/flashcs4/rings/

for discussion of the class.
************************************************************************ */

package com.flashandmath.loaders { 
	
	import flash.display.Loader;
	
	import flash.display.BitmapData;
	
	import flash.display.Bitmap;
	
	import flash.events.EventDispatcher;
	
	import flash.events.Event;
	
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequest;
	
	import flash.net.URLLoader;
	
	
    public class GalleryLoader extends EventDispatcher {
		
		  public static const ALL_LOADED:String = "allLoaded";
		  
		  public static const XMLLOAD_ERROR:String = "xmlLoadError";
		  
		  public static const IMGSLOAD_ERROR:String = "imgsLoadError";
		   
		  private var xmlRequest:URLRequest;
		  
		  private var xmlLoader:URLLoader;
		  
		  private var xmlContent:XML;
		  
		  private var _numPics:int;
		    
		  private var isError:Boolean;
		  
		  private var _bmpDataVec:Vector.<BitmapData>;
		  
		  private var _capsVec:Vector.<String>;
		  
		  private var _picsVec:Vector.<String>;
		  
		  private var thumbsToLoad:Array;
		  
		  private var thumbsLoader:ThumbsLoader;
		  
		  
	     public function GalleryLoader(xml:String){
			  
		     xmlRequest=new URLRequest(xml);
		  
	             }
	
	
	   public function loadXML():void {
		   
		   xmlLoader=new URLLoader();
		   
		   xmlLoader.addEventListener(Event.COMPLETE, xmlLoadComplete);
		   
           xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlError);
		
		   xmlLoader.load(xmlRequest);
		
	    }
		
	   private function xmlLoadComplete(e:Event):void {
	
	     xmlContent = new XML(xmlLoader.data);
	
	     xmlLoader.removeEventListener(Event.COMPLETE, xmlLoadComplete);
		   
         xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, xmlError);
		 
		 procXML();
		 
     }
	 
	 private function procXML():void {
		 
		 var j:int;
		 
		 _numPics=xmlContent.tile.length();
		 
		 thumbsToLoad=[];
		 
		 _bmpDataVec=new Vector.<BitmapData>(_numPics);
		  
		 _picsVec=new Vector.<String>(_numPics);
		 
		 _capsVec=new Vector.<String>(_numPics);
		  
		   for(j=0;j<_numPics;j++){
				 
				 thumbsToLoad.push(xmlContent.tile[j].thumb.toString());
				 
				 _picsVec[j]=xmlContent.tile[j].pic.toString();
				 
				 _capsVec[j]=xmlContent.tile[j].cap.toString();
				 
			 } 
		 
		 
		 
		 thumbsLoader=new ThumbsLoader();
		 
		 thumbsLoader.addEventListener(ThumbsLoader.IMGS_LOADED,imgsDone);
		 
		 thumbsLoader.addEventListener(ThumbsLoader.LOAD_ERROR,imgsError);
		 
		 thumbsLoader.loadImgs(thumbsToLoad);
		
	 }
	 
	 private function imgsError(e:Event):void {
		
		dispatchEvent(new Event(GalleryLoader.IMGSLOAD_ERROR));
		
	}
	
	private function imgsDone(e:Event):void {
		
		 var j:int;
		
		thumbsLoader.removeEventListener(ThumbsLoader.IMGS_LOADED,imgsDone);
		 
		thumbsLoader.removeEventListener(ThumbsLoader.LOAD_ERROR,imgsError);
		
		
			 
			 for(j=0;j<_numPics;j++){
				 
				 _bmpDataVec[j]=thumbsLoader.bitmapsArray[j].clone();
				 
				 thumbsLoader.bitmapsArray[j].dispose();
				 
				 
			 }
			
		
		
		dispatchEvent(new Event(GalleryLoader.ALL_LOADED));
		
		
	}

     

	private function xmlError(e:IOErrorEvent):void {
		
	
		dispatchEvent(new Event(GalleryLoader.XMLLOAD_ERROR));
		
	}
	
	
	
	public function get bmpDataVec():Vector.<BitmapData> {
		
		return _bmpDataVec;
		
	}
	
	public function get picsVec():Vector.<String> {
		
		return _picsVec;
		
	}
	
	public function get capsVec():Vector.<String> {
		
		return _capsVec;
		
	}
	
	public function get numPics():int {
		
		return _numPics;
		
	}
	
	
	
   }

}