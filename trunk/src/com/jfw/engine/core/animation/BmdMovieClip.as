package com.jfw.engine.core.animation
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.media.Sound;
	import com.jfw.engine.core.interfaces.IAnimatable;
	
	public class BmdMovieClip extends Bitmap implements IAnimatable
	{
		private var mTextures:Vector.<BitmapData>;
		private var mSounds:Vector.<Sound>;
		private var mDurations:Vector.<Number>;
		private var mStartTimes:Vector.<Number>;
		
		private var mDefaultFrameDuration:Number;
		private var mTotalTime:Number;
		private var mCurrentTime:Number;
		private var mCurrentFrame:int;
		private var mLoop:Boolean;
		private var mPlaying:Boolean;
		
		/** Creates a moviclip from the provided textures and with the specified default framerate.
		 *  The movie will have the size of the first frame. */  
		public function BmdMovieClip(bmds:Vector.<BitmapData>, fps:Number=12)
		{
			if (bmds.length > 0)
			{
				super(bmds[0]);
				mDefaultFrameDuration = 1.0 / fps;
				mLoop = true;
				mPlaying = true;
				mTotalTime = 0.0;
				mCurrentTime = 0.0;
				mCurrentFrame = 0;
				mTextures = new <BitmapData>[];
				mSounds = new <Sound>[];
				mDurations = new <Number>[];
				mStartTimes = new <Number>[];
				
				for each (var bmd:BitmapData in bmds)
					addFrame(bmd);
			}
			else
			{
				throw new ArgumentError("Empty bitmapdata array");
			}
		}
		
		/** Adds an additional frame, optionally with a sound and a custom duration. If the 
		 *  duration is omitted, the default framerate is used (as specified in the constructor). */   
		public function addFrame(bmd:BitmapData, sound:Sound=null, duration:Number=-1):void
		{
			addFrameAt(numFrames, bmd, sound, duration);
		}
		
		/** Adds a frame at a certain index, optionally with a sound and a custom duration. */
		public function addFrameAt(frameID:int, bmd:BitmapData, sound:Sound=null, 
								   duration:Number=-1):void
		{
			if (frameID < 0 || frameID > numFrames) throw new ArgumentError("Invalid frame id");
			if (duration < 0) duration = mDefaultFrameDuration;
			
			mTextures.splice(frameID, 0, bmd);
			mSounds.splice(frameID, 0, sound);
			mDurations.splice(frameID, 0, duration);
			mTotalTime += duration;
			
			if (frameID > 0 && frameID == numFrames) 
				mStartTimes[frameID] = mStartTimes[frameID-1] + mDurations[frameID-1];
			else
				updateStartTimes();
		}
		
		/** Removes the frame at a certain ID. The successors will move down. */
		public function removeFrameAt(frameID:int):void
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			if (numFrames == 1) throw new IllegalOperationError("Movie clip must not be empty");
			
			mTotalTime -= getFrameDuration(frameID);
			mTextures.splice(frameID, 1);
			mSounds.splice(frameID, 1);
			mDurations.splice(frameID, 1);
			
			updateStartTimes();
		}
		
		/** Returns the texture of a certain frame. */
		public function getFrameTexture(frameID:int):BitmapData
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			return mTextures[frameID];
		}
		
		/** Sets the texture of a certain frame. */
		public function setFrameTexture(frameID:int, bmd:BitmapData):void
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			mTextures[frameID] = bmd;
		}
		
		/** Returns the sound of a certain frame. */
		public function getFrameSound(frameID:int):Sound
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			return mSounds[frameID];
		}
		
		/** Sets the sound of a certain frame. The sound will be played whenever the frame 
		 *  is displayed. */
		public function setFrameSound(frameID:int, sound:Sound):void
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			mSounds[frameID] = sound;
		}
		
		/** Returns the duration of a certain frame (in seconds). */
		public function getFrameDuration(frameID:int):Number
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			return mDurations[frameID];
		}
		
		/** Sets the duration of a certain frame (in seconds). */
		public function setFrameDuration(frameID:int, duration:Number):void
		{
			if (frameID < 0 || frameID >= numFrames) throw new ArgumentError("Invalid frame id");
			mTotalTime -= getFrameDuration(frameID);
			mTotalTime += duration;
			mDurations[frameID] = duration;
			updateStartTimes();
		}
		
		// playback methods
		
		/** Starts playback. Beware that the clip has to be added to a juggler, too! */
		public function play():void
		{
			mPlaying = true;
		}
		
		/** Pauses playback. */
		public function pause():void
		{
			mPlaying = false;
		}
		
		/** Stops playback, resetting "currentFrame" to zero. */
		public function stop():void
		{
			mPlaying = false;
			currentFrame = 0;
		}
		
		
		// helpers
		
		private function updateStartTimes():void
		{
			var numFrames:int = this.numFrames;
			
			mStartTimes.length = 0;
			mStartTimes[0] = 0;
			
			for (var i:int=1; i<numFrames; ++i)
				mStartTimes[i] = mStartTimes[i-1] + mDurations[i-1];
		}
		
		public function advanceTime(passedTime:Number):void
		{
			var finalFrame:int;
			var previousFrame:int = mCurrentFrame;
			
			if (mLoop && mCurrentTime == mTotalTime) { mCurrentTime = 0.0; mCurrentFrame = 0; }
			if (!mPlaying || passedTime == 0.0 || mCurrentTime == mTotalTime) return;
			
			mCurrentTime += passedTime;
			finalFrame = mTextures.length - 1;
			
			while (mCurrentTime >= mStartTimes[mCurrentFrame] + mDurations[mCurrentFrame])
			{
				if (mCurrentFrame == finalFrame)
				{
					if (hasEventListener(Event.COMPLETE))
					{
						var restTime:Number = mCurrentTime - mTotalTime;
						mCurrentTime = mTotalTime;
						dispatchEvent(new Event(Event.COMPLETE));
						
						// user might have changed movie clip settings, so we restart the method
						advanceTime(restTime);
						return;
					}
					
					if (mLoop)
					{
						mCurrentTime -= mTotalTime;
						mCurrentFrame = 0;
					}
					else
					{
						mCurrentTime = mTotalTime;
						break;
					}
				}
				else
				{
					mCurrentFrame++;
					
					var sound:Sound = mSounds[mCurrentFrame];
					if (sound) sound.play();
				}
			}
			
			if (mCurrentFrame != previousFrame)
				this.bitmapData = mTextures[mCurrentFrame];
		}
		
		/** Indicates if a (non-looping) movie has come to its end. */
		public function get isComplete():Boolean 
		{
			return !mLoop && mCurrentTime >= mTotalTime;
		}
		
		// properties  
		
		/** The total duration of the clip in seconds. */
		public function get totalTime():Number { return mTotalTime; }
		
		/** The total number of frames. */
		public function get numFrames():int { return mTextures.length; }
		
		/** Indicates if the clip should loop. */
		public function get loop():Boolean { return mLoop; }
		public function set loop(value:Boolean):void { mLoop = value; }
		
		/** The index of the frame that is currently displayed. */
		public function get currentFrame():int { return mCurrentFrame; }
		public function set currentFrame(value:int):void
		{
			mCurrentFrame = value;
			mCurrentTime = 0.0;
			
			for (var i:int=0; i<value; ++i)
				mCurrentTime += getFrameDuration(i);
			
			this.bitmapData = mTextures[mCurrentFrame];
			if (mSounds[mCurrentFrame]) mSounds[mCurrentFrame].play();
		}
		
		/** The default number of frames per second. Individual frames can have different 
		 *  durations. If you change the fps, the durations of all frames will be scaled 
		 *  relatively to the previous value. */
		public function get fps():Number { return 1.0 / mDefaultFrameDuration; }
		public function set fps(value:Number):void
		{
			var newFrameDuration:Number = value == 0.0 ? Number.MAX_VALUE : 1.0 / value;
			var acceleration:Number = newFrameDuration / mDefaultFrameDuration;
			mCurrentTime *= acceleration;
			mDefaultFrameDuration = newFrameDuration;
			
			for (var i:int=0; i<numFrames; ++i)
				setFrameDuration(i, getFrameDuration(i) * acceleration);
		}
		
		/** Indicates if the clip is still playing. Returns <code>false</code> when the end 
		 *  is reached. */
		public function get isPlaying():Boolean 
		{
			if (mPlaying)
				return mLoop || mCurrentTime < mTotalTime;
			else
				return false;
		}
	}
}