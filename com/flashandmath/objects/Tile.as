package com.flashandmath.objects {
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Tile extends Sprite {
		public var which:Number;
		public var openPosition:Point;
		public var closedPosition:Point;
		public var color:uint;				
		public var thumbnailHolder:Sprite;
		
		public function Tile() {
			openPosition = new Point();
			closedPosition = new Point();
			thumbnailHolder = new Sprite();
			thumbnailHolder.mouseEnabled = false;
			this.addChild(thumbnailHolder);			
		}
	}
}