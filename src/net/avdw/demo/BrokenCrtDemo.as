package net.avdw.demo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import net.avdw.fx.AnimatedNoiseFx;
	import net.avdw.fx.RefreshBarFx;
	import net.avdw.fx.RGBDistortableFx;
	import net.avdw.generate.makeOverlayTextureFromPattern;
	import net.avdw.generate.pattern.scanlinePattern;
	
	/**
	 * ...
	 * @author Andrew van der Westhuizen
	 */
	public class BrokenCrtDemo extends Sprite
	{
		[Embed(source="../../../../../assets/images/680x495 Misty Pixie.jpg")]
		private const MistyPixie:Class;
		
		public function BrokenCrtDemo()
		{
			addChild(new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0)));
			
			var mistyPixie:RGBDistortableFx = new RGBDistortableFx(new MistyPixie());
			addChild(mistyPixie);
			mistyPixie.distort({x: 10, y: 3, alpha: .3, speed: .8});
			
			addChild(makeOverlayTextureFromPattern(scanlinePattern(), stage.stageWidth, stage.stageHeight));
			
			new RefreshBarFx(stage);
			new AnimatedNoiseFx(stage);
		}
	
	}

}