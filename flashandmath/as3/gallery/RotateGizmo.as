
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 12, 2010. 

*/


 
package flashandmath.as3.gallery {
	
	
	 import flash.display.Sprite;
	 
	 import flash.text.TextField;
	 
	 import flash.text.TextFieldType;
	 
	 import flash.text.TextFieldAutoSize;
	 
	 import flash.text.TextFormat;
  
     
	 public class RotateGizmo extends Sprite {
		 
		 public var rightArrow:ArrowGizmo;
		 
		 public var leftArrow:ArrowGizmo;
		 
		 public var rotateTextBox:TextField;
		 
        
		public function RotateGizmo(cl:Number) {
			
		  rightArrow=new ArrowGizmo();
		  
		  leftArrow=new ArrowGizmo();
		  
		  leftArrow.rotation=180;
		  
		  leftArrow.x=12;
		  
		  rightArrow.x=64;
		  
		  leftArrow.y=17;
		  
		  rightArrow.y=17;
		  
		  this.addChild(leftArrow);
		  
		  this.addChild(rightArrow);
		  
		  setUpText(cl);
		     
		}
		
		internal function setUpText(c:Number):void {
			
			var format:TextFormat=new TextFormat();
			
			rotateTextBox=new TextField();
			
			rotateTextBox.type=TextFieldType.DYNAMIC;
			
			rotateTextBox.multiline=true;
			
			rotateTextBox.mouseEnabled=false;
			
			rotateTextBox.autoSize=TextFieldAutoSize.LEFT;
			
		    format.color=c;
		
		    format.size=12;
		
		    format.font="Arial";
		
		    rotateTextBox.defaultTextFormat=format;
		
		    rotateTextBox.text="Mouse over the arrow buttons to rotate the gallery.\nClick the thumbnail to load an image.";
			
			this.addChild(rotateTextBox);
			
			rotateTextBox.x=100;
		}
		
		
	}
	
	
}

