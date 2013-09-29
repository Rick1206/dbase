
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
  
     
	 public class LoadGizmo extends Sprite {
		 
		 
		 public var loadTextBox:TextField;
		 
        
		public function LoadGizmo(cl:Number) {
			
		  setUpText(cl);
		     
		}
		
		internal function setUpText(c:Number):void {
			
			var format:TextFormat=new TextFormat();
			
			loadTextBox=new TextField();
			
			loadTextBox.type=TextFieldType.DYNAMIC;
			
			loadTextBox.multiline=true;
			
			loadTextBox.mouseEnabled=false;
			
			loadTextBox.width=350;
			
		    format.color=c;
		
		    format.size=12;
		
		    format.font="Arial";
		
		    loadTextBox.defaultTextFormat=format;
		
		    loadTextBox.text="Loading... Please wait.";
			
			this.addChild(loadTextBox);
			
			
		}
		
		
	}
	
	
}

