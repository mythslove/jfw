package com.jfw.engine.core.mvc.control
{
   import flash.events.IEventDispatcher;
   import flash.events.EventDispatcher;

   public class ControllerEvtDispatcher
   {
      private static var instance : ControllerEvtDispatcher;  
      private var eventDispatcher : IEventDispatcher;
      
      public static function getInstance() : ControllerEvtDispatcher 
      {
         if ( instance == null )
            instance = new ControllerEvtDispatcher();
          
           return instance;
      }
      
      public function ControllerEvtDispatcher( target:IEventDispatcher = null ) 
      {
         eventDispatcher = new EventDispatcher( target );
      }
      
      public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ) : void 
      {
         eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
      }
      
      public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ) : void 
      {
         eventDispatcher.removeEventListener( type, listener, useCapture );
      }

      public function dispatchEvent( event:ControllerEvent ) : Boolean 
      {
         return eventDispatcher.dispatchEvent( event );
      }
      
      public function hasEventListener( type:String ) : Boolean 
      {
         return eventDispatcher.hasEventListener( type );
      }
      
      public function willTrigger(type:String) : Boolean 
      {
         return eventDispatcher.willTrigger( type );
      }
   }
}