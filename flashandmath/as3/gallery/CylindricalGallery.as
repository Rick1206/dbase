﻿
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 16, 2010. 

*/


 
package flashandmath.as3.gallery {
	
	
	 import flash.display.Sprite;
	 
	 import flash.display.BitmapData;
	 
	 import flash.display.Shape;
	 
	 import flash.display.Loader;
	 
	 import flash.events.Event;
	 
	 import flash.events.MouseEvent;
	 
	 import flash.events.IOErrorEvent;
	 
	 import flash.geom.PerspectiveProjection;
	 
	 import flash.geom.Point;
	 
	 import flash.filters.DropShadowFilter;
	 
	 import flash.filters.GlowFilter;
	 
	 import flash.net.URLRequest;
	 
	 import code.tool.RollTool;
     
	 public class CylindricalGallery extends Sprite {
		 
 
		private var numCols:int;
		
		private var thumbWidth:Number;
		
		private var thumbHeight:Number;
		
		private var thumbsArray:Array;
		
		private var pxSpace:int;

		private var colHeight:Number;
		
		private var colWidth:Number;
		
		private var rad:Number;
		
		private var containerHeight:Number;
		
		private var containerWidth:Number;
		
		private var contMask:Shape;
		
		private var colsVec:Vector.<Column>;
		
		private var colLen:int;
		
		private var angle:Number;
		
		private var galLoader:GalleryLoader;
		
		private var notReady:Boolean;
		
		private var container:Sprite;
		
		private var capsArray:Array;
		
		private var picsArray:Array;
		
		private var picWidth:Number;
		
		private var picHeight:Number;
		
		private var vertAddOn:Number;
		
		private var vertDrop:Number;
		
		private var pp:PerspectiveProjection;
		
		private var photoHolder:Sprite;
		
		private var loader:Loader;
		
		private var holdersRefArray:Array;
		
		private var isLoading:Boolean;
		
		private var rotateRight:Boolean=false;

        private var rotateLeft:Boolean=false;
		
		private var rotateGizmo:RotateGizmo;
		
		private var closeGizmo:CloseGizmo;
		
		private var captionGizmo:CaptionGizmo;
		
		private var captionGizmoOver:CaptionGizmo;
		
		private var loadGizmo:LoadGizmo;
		
		private var colorText:Number;
		
		private var colorGlow:Number;
		
		private var diffAng:Number;
		
		private var widthOfStage:Number;
		
		private var fW:Number;
		
		private var th:Number;
		
		public function CylindricalGallery(xmldata:String,w:Number=700,tc:Number=0x999999,gc:Number=0x6699FF,theight:Number=0) {
			
		  notReady=true;
		  
		  colorText=tc;
		  
		  colorGlow=gc;
		  
		  widthOfStage=w;
		  
		  fW = 55;
		  
		  th = theight;
			 
		  galLoader=new GalleryLoader(xmldata);
		  
		  galLoader.addEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

          galLoader.addEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);

          galLoader.addEventListener(GalleryLoader.ALL_LOADED, loadEnded);
		  
		  loadGizmo=new LoadGizmo(colorGlow);
		 
		  this.addChild(loadGizmo);
		  
		  loadGizmo.x=150;
		  
		  loadGizmo.y=0;
		 
		  loadGizmo.visible=true;
		  
		  galLoader.loadXML();
		      
		}
		
	 private function xmlError(e:Event):void {
	
	     galLoader.removeEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

         galLoader.removeEventListener(GalleryLoader.ALL_LOADED, loadEnded);
		 
		 galLoader.removeEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);
		 
		 loadGizmo.loadTextBox.text="There has been an error loading the XML file. The server\nmay be busy. Try refreshing the page.";
	
      }

	private function imgsError(e:Event):void {
	
	   galLoader.removeEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

       galLoader.removeEventListener(GalleryLoader.ALL_LOADED, loadEnded);
	
	   galLoader.removeEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);
	   
	   loadGizmo.loadTextBox.text="There has been an error loading thumbnails. The server\nmay be busy. Try refreshing the page.";
	
        }

	 private function loadEnded(e:Event):void {
	
	     galLoader.removeEventListener(GalleryLoader.XMLLOAD_ERROR, xmlError);

         galLoader.removeEventListener(GalleryLoader.ALL_LOADED, loadEnded);
	
	     galLoader.removeEventListener(GalleryLoader.IMGSLOAD_ERROR, imgsError);
		 
		 initApp();
		 
		  
}

   private function initApp():void {
	   
	      var i:int;
		  
		  var j:int;
		  
		  var fL:Number=widthOfStage/(2*Math.tan((Math.PI/180)*(fW/2)));
		
		  pxSpace=galLoader.pxSpace;
		  
		  numCols=galLoader.numCols;
		  
		  colLen=galLoader.colLen;
		  
		  picWidth=galLoader.picWidth;
		  
		  picHeight=galLoader.picHeight;
		  
		  thumbsArray=[];
		  
		  picsArray=[];
		  
		  capsArray=[];
		  
		  for(i=0;i<numCols;i++){
			  
			  thumbsArray[i]=new Vector.<BitmapData>(colLen);
			  
			  picsArray[i]=new Vector.<String>(colLen);
			  
			  capsArray[i]=new Vector.<String>(colLen);
			  
			  for(j=0;j<colLen;j++){
			 
			  thumbsArray[i][j]=galLoader.bmpDataArray[i][j].clone();
			  
			  galLoader.bmpDataArray[i][j].dispose();
			  
			  picsArray[i][j]=galLoader.picsArray[i][j];
			  
			  capsArray[i][j]=galLoader.capsArray[i][j];
			  
			  }
			    
		  }
		  
		  
		  thumbWidth=thumbsArray[0][0].width;
			 
		  thumbHeight=thumbsArray[0][0].height;
		  
		  colsVec=new Vector.<Column>();
		  
		  colHeight=thumbHeight*colLen+(colLen-1)*pxSpace;
		  
		  colWidth=thumbWidth;
		  
		  rad=galLoader.radius;
		  
		  angle=360/numCols;
		  
		  container=new Sprite();
		  
		  this.addChild(container);
		  
		  containerWidth=2*rad;
		  
		  vertAddOn=40;
		  
		  vertDrop=15;
		  
		  containerHeight=colHeight+vertAddOn;
		  
		  container.x=containerWidth/2;
		  
		  container.y=containerHeight/2+vertDrop;
		  
		  contMask=new Shape();
		  
		  this.addChild(contMask);
		  
		  contMask.x=container.x;
		  
		  contMask.y=container.y;
		  
		  prepContainer();
		  
		  diffAng=Math.round((Math.asin(rad/fL)*180/Math.PI)*1000)/1000;
		    
		  for(i=0;i<numCols;i++){
			  
			  colsVec[i]= new Column(thumbsArray[i],pxSpace,rad);
			  
			  container.addChild(colsVec[i]);
			  
			  colsVec[i].y=0;
			  
			  colsVec[i].x=0;
			  
			  colsVec[i].z=0;
			  
			  colsVec[i].rotationY=angle*i;
			  
			  if((colsVec[i].rotationY>90+diffAng && colsVec[i].rotationY<270-diffAng) || (colsVec[i].rotationY<-(90+diffAng) && colsVec[i].rotationY>-(270-diffAng))){
		
		              if(container.contains(colsVec[i])){
						  
						  container.removeChild(colsVec[i]);
						  
					  }
		
	                       } else {
							   
							 if(!container.contains(colsVec[i])){
		
		                         container.addChild(colsVec[i]);
					  
							   }
								   
	                      }
			    
		  }
		  
		   holdersRefArray=[];
		  
		   for(i=0;i<numCols;i++){
			  
			  holdersRefArray[i]=new Vector.<Sprite>(colLen);
			  
			  for(j=0;j<colLen;j++){
			  
			  holdersRefArray[i][j]=colsVec[i].holdersVec[j];
			  
			  holdersRefArray[i][j].name=String(i)+"_"+String(j);
			  
			  RollTool.setRoll(holdersRefArray[i][j]);
			  
			  holdersRefArray[i][j].addEventListener(MouseEvent.ROLL_OVER,thumbOver);
			  
			  holdersRefArray[i][j].addEventListener(MouseEvent.ROLL_OUT,thumbOut);
			  
			  holdersRefArray[i][j].addEventListener(MouseEvent.CLICK,thumbClick);
			  
			  }
			    
		  }
		  
		 pp=new PerspectiveProjection();

         pp.fieldOfView=fW;

         pp.projectionCenter=new Point(0,0);

         container.transform.perspectiveProjection=pp;
		  
		 photoHolder=new Sprite();

         this.addChild(photoHolder);
		 
		 loader=new Loader();

         photoHolder.addChild(loader);
		 
         photoHolder.x=containerWidth/2-picWidth/2;

         photoHolder.y=containerHeight/2-picHeight/2;
		 
		 loader.contentLoaderInfo.addEventListener(Event.COMPLETE,donePhotoLoad);
	
	     loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,photoLoadError);
		 
		 photoHolder.addEventListener(MouseEvent.CLICK,photoClick);
		 
		 photoHolder.filters=[new DropShadowFilter() ];

		 photoHolder.visible=false;
		 
		 rotateGizmo=new RotateGizmo(colorText);
		 
		 this.addChild(rotateGizmo);
		   
		 rotateGizmo.x=containerWidth/2-rotateGizmo.width/2;
		 
		 rotateGizmo.y = th;
		 
		 closeGizmo=new CloseGizmo(colorText);
		 
		 this.addChild(closeGizmo);
		  
		 closeGizmo.x=containerWidth/2-closeGizmo.width/2;
		 
		 closeGizmo.visible=false;
		 
		 closeGizmo.y = th;
		 
		 trace(th);
		 
		 captionGizmo=new CaptionGizmo(colorText);
		 
		 this.addChild(captionGizmo);
		  
		 captionGizmo.x=containerWidth/2-captionGizmo.width/2;
		 
		 captionGizmo.y=photoHolder.y+picHeight+vertDrop+closeGizmo.height;
		 
		 captionGizmo.visible=false;
		 
		 captionGizmoOver=new CaptionGizmo(colorText);
		 
		 this.addChild(captionGizmoOver);
		  
		 captionGizmoOver.x=containerWidth/2-captionGizmoOver.width/2;
		 
		 captionGizmoOver.y=photoHolder.y+picHeight+vertDrop+closeGizmo.height;
		 
		 captionGizmoOver.visible=false;
		  
		 RollTool.setRoll( rotateGizmo.rightArrow);
		 
		  RollTool.setRoll( rotateGizmo.rightArrow);
		  
		 rotateGizmo.rightArrow.addEventListener(MouseEvent.ROLL_OVER, rightOver);
		 
		 rotateGizmo.rightArrow.addEventListener(MouseEvent.ROLL_OUT, rightOut);
		 
		 rotateGizmo.leftArrow.addEventListener(MouseEvent.ROLL_OVER, leftOver);
		 
		 rotateGizmo.leftArrow.addEventListener(MouseEvent.ROLL_OUT, leftOut);
		 
		 this.addEventListener(Event.ENTER_FRAME,onEnter);
		 
		 loadGizmo.visible=false;
		 
		 isLoading=false;
		 
		 notReady=false;
	   
	   
	   
   }
   
   private function photoLoadError(e:IOErrorEvent):void {
	
	loadGizmo.loadTextBox.text="There has been an error loading the image. The server\nmay be busy. Try refreshing the page.";
	
	if(this.contains(container)){
		
		this.removeChild(container);
	}
	
   }
   
   private function donePhotoLoad(e:Event):void {
	
	if(this.contains(container)){
		
		this.removeChild(container);
	}
	
	RollTool.setRoll(photoHolder);
	
	photoHolder.visible=true;
	
	isLoading=false;
	
	closeGizmo.visible=true;
	
	captionGizmo.visible=true;
	
	loadGizmo.visible=false;
	
  }
  
    private function rightOver(e:MouseEvent):void {
	
	  rotateRight=true;
	
    }
	
	private function rightOut(e:MouseEvent):void {
	
	  rotateRight=false;
	
    }
	
	private function leftOver(e:MouseEvent):void {
	
	  rotateLeft=true;
	
    }
	
	private function leftOut(e:MouseEvent):void {
	
	  rotateLeft=false;
	
    }
	
	private function onEnter(e:Event):void {
	
	  if (rotateRight){
		
	    this.doRotate(0.5);
	  }
		
		
     if (rotateLeft){
	  
	    this.doRotate(-0.5);
	  
      }
	
}
  
    private function thumbOver(e:MouseEvent):void {
	
	  var a:Array=parseIndices(e.target.name);
	  
	  holdersRefArray[a[0]][a[1]].filters=[new GlowFilter(colorGlow)];
	  
	  captionGizmoOver.visible=true;
	  
	  captionGizmoOver.captionTextBox.text=capsArray[Number(a[0])][Number(a[1])];
	  
    }
	
	private function thumbOut(e:MouseEvent):void {
	
	  var a:Array=parseIndices(e.target.name);
	  
	  holdersRefArray[a[0]][a[1]].filters=[];
	  
	  captionGizmoOver.visible=false;
	  
	  captionGizmoOver.captionTextBox.text="";

    }
	
	private function thumbClick(e:MouseEvent):void {
		
	 if(isLoading || notReady){
		 
		 return;
		 
	 }
	 
	  var a:Array=parseIndices(e.target.name);
	 
	  isLoading=true;
	  
	  rotateGizmo.visible=false;
	  
	  loadGizmo.loadTextBox.text="Loading... Please wait.";
	  
	  loadGizmo.visible=true;
		
	  loader.load(new URLRequest(picsArray[Number(a[0])][Number(a[1])]));
	  
	  captionGizmo.captionTextBox.text=capsArray[Number(a[0])][Number(a[1])];
	  
    }
	
	private function photoClick(e:MouseEvent):void {
		
	 if(isLoading || notReady){
		 
		 return;
		 
	 }
		 
	  photoHolder.visible=false;
	  
	  rotateGizmo.visible=true;
	  
	  closeGizmo.visible=false;
	  
	  captionGizmo.visible=false;
	  
	  captionGizmo.captionTextBox.text="";
	  
	  if(!this.contains(container)){
		
		this.addChild(container);
	}

    }
	
	
	private function parseIndices(s:String):Array {
		
		var a:Array=[];
		
		a=s.split("_");
		
		return [Number(a[0]), Number(a[1])];
		
	}


	private function prepContainer():void {
	
	   contMask.graphics.lineStyle();
	
	   contMask.graphics.beginFill(0xFFFFFF);
	
	   contMask.graphics.drawRect(-containerWidth/2,-containerHeight/2,containerWidth,containerHeight);
	
	   contMask.graphics.endFill();
	
	   container.mask=contMask;
	
  }
		
	public function doRotate(ang:Number):void {
		
		    if(isLoading || notReady){
		 
		            return;
		 
	          }
			
			if(!this.contains(container)){
				
				return;
				
			}
			
			var i:int;
			
			 for(i=0;i<numCols;i++){
				 
			   colsVec[i].rotationY+=ang;
			   
			   colsVec[i].rotationY=colsVec[i].rotationY%360;
			  
			   if((colsVec[i].rotationY>90+diffAng && colsVec[i].rotationY<270-diffAng) || (colsVec[i].rotationY<-(90+diffAng) && colsVec[i].rotationY>-(270-diffAng))){
		
		              if(container.contains(colsVec[i])){
						  
						  container.removeChild(colsVec[i]);
						  
					  }
		
	                 } else {    
							   if(!container.contains(colsVec[i])){
		
		                         container.addChild(colsVec[i]);
					  
							   }
								   
	                         }
	 
			 }
			
		}
		
		
		
	}
	
	
}

