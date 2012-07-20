package com.jfw.engine.motion
{
	import com.jfw.engine.animation.BmdMovieClip;
	import com.jfw.engine.animation.Texture;
	/**
	 * 多状态MovieClip。你可以通过setKeyFrame和gotoAndPlay方法来设置/跳转到某个关键帧 
	 * 
	 */	
	public class MutiStateMovieClip extends BmdMovieClip
	{
		/** 
		 * @param keyFrams		关键帧列表。MutiStateMovieClip将使用向量首个元素作为当前播放帧
		 * @param fps			帧频
		 */		
		public function MutiStateMovieClip(textures:Vector.<Texture>, fps:Number=12)
		{
			super(textures, fps);
		}
		/**  
		 * 改变当前MovieClip所用动画纹理序列 
		 * 
		 */
		protected function changeTextures(texturs:Vector.<Texture>):void
		{
			stop();
			
			var len:int = texturs.length;
			
			if(len>numFrames)
			{
				for(var i:int=0; i<len; i++)
				{
					if( i < numFrames )
					{
						this.width=texturs[i].width;
						this.height=texturs[i].height;
						setFrameTexture(i, texturs[i]);//改变动画中该帧纹理
					}
					else
					{
						addFrameAt(i, texturs[i]);
					}
				}
			}
			else if(len==numFrames)
			{
				for(var j:int=0; j<len; j++)
				{				
					this.width=texturs[j].width;
					this.height=texturs[j].height;
					setFrameTexture(j, texturs[j]);
				}
			}
			else//if(len<numFrames)
			{
				var len2:int=numFrames;
				
				for(var k:int=0; k<len2; k++)
				{
					if( k < len )
					{
						this.width=texturs[k].width;
						this.height=texturs[k].height;
						setFrameTexture(k, texturs[k]);
					}
					else
					{
						removeFrameAt(numFrames-1);
					}
				}
			}
			
			play();
		}
	}
}