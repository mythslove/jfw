package examples.animation
{
	import com.isolib.as3isolib.display.IsoView;
	import com.isolib.as3isolib.display.scene.IsoScene;
	
	import flash.display.Sprite;

	public class Test2 extends Sprite
	{

		public function Test2()
		{
			var pig:Pig=new Pig();
			
			
			var scene:IsoScene = new IsoScene();

			scene.hostContainer = this;
			scene.addChild(pig);
			scene.render();
			pig.moveBy(100,100,0);
			pig.render();
			var view:IsoView=new IsoView();
			view.addScene(scene);
			view.setSize(500,300);
		

			this.addChild(view);
		}
	}
}