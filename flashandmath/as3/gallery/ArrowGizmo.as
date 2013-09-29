
/*
ActionScript 3 Tutorials by Barbara Kaskosz.

www.flashandmath.com

Last modified: January 12, 2010. 

*/


 
package flashandmath.as3.gallery {
	
	
	 import flash.display.Sprite;
  
     
	 public class ArrowGizmo extends Sprite {
		 
        
		public function ArrowGizmo() {
			 
		  drawGizmo();
		  
		  this.buttonMode=true;
		     
		}
		
		
		private function drawGizmo():void {
			
			this.graphics.lineStyle();
			
			this.graphics.beginFill(0xCCCCCC);
			
			this.graphics.drawCircle(0,0,12);
			
			this.graphics.endFill();
			
			this.graphics.lineStyle(2,0x999999);
			
			this.graphics.drawCircle(0,0,10);
			
			this.graphics.lineStyle();
			
			this.graphics.beginFill(0x000000);
			
			this.graphics.moveTo(-3,-5);
			
			this.graphics.lineTo(-3,5);
			
			this.graphics.lineTo(6,0);
			
			this.graphics.lineTo(-3,-5);
			
			this.graphics.endFill();
			
			
		}
		
		
		
	}
	
	
}

