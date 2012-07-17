package com.jfw.engine.core.mvc.control
{   
   import flash.utils.Dictionary;
   
   public class Controller
   {
      protected var commands : Dictionary = new Dictionary();

      public function addCommand( commandName : String, commandRef : Class, useWeakReference : Boolean = true ) : void
      {
         if( commands[ commandName ] != null )
            throw new Error( "", commandName );
         
         commands[ commandName ] = commandRef;
         ControllerEvtDispatcher.getInstance().addEventListener( commandName, executeCommand, false, 0, useWeakReference );
      }
      
      public function removeCommand( commandName : String ) : void
      {
         if( commands[ commandName ] === null)
            throw new Error( "", commandName);  
         
         ControllerEvtDispatcher.getInstance().removeEventListener( commandName, executeCommand );
         commands[ commandName ] = null;
         delete commands[ commandName ]; 
      }
      
      protected function executeCommand( event : ControllerEvent ) : void
      {
         var commandToInitialise : Class = getCommand( event.type );
         var commandToExecute : ICommand = new commandToInitialise();

         commandToExecute.execute( event );
      }
      
      protected function getCommand( commandName : String ) : Class
      {
         var command : Class = commands[ commandName ];
         
         if ( command == null )
            throw new Error( "", commandName );
            
         return command;
      }      
   }   
}
