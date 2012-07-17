package com.jfw.engine.core.mvc.control
{
   import flash.events.Event;

   public class ControllerEvent extends Event
   {
      public var data : *;
      
      public function ControllerEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
      {
         super( type, bubbles, cancelable );
      }
      public function dispatch() : Boolean
      {
         return ControllerEvtDispatcher.getInstance().dispatchEvent( this );
      }
   }
}