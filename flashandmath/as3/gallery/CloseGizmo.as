
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
  
     
	 public class CloseGizmo extends Sprite {
		 
		 
		 public var closeTextBox:TextField;
		 
        
		public function CloseGizmo(cl:Number) {
			
		  setUpText(cl);
		     
		}
		
		internal function setUpText(c:Number):void {
			
			var format:TextFormat=new TextFormat();
			
			closeTextBox=new TextField();
			
			closeTextBox.type=TextFieldType.DYNAMIC;
			
			closeTextBox.multiline=true;
			
			closeTextBox.mouseEnabled=false;
			
			closeTextBox.autoSize=TextFieldAutoSize.LEFT;
			
		    format.color=c;
		
		    format.size=12;
		
		    format.font="Arial";
		
		    closeTextBox.defaultTextFormat=format;
		
		    closeTextBox.text="Click the image to close it and return to the gallery.";
			
			this.addChild(closeTextBox);
			
			
		}
		
		
	}
	
	
}

