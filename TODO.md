## TODO

* At client, remove all elements before the "new" call, so that memory does not grow which will slow down the client. The client becomes a bit more slower each time entering and exiting a scene.

* Instead of destroying a scene or a variable, remove them. opposite of add(). Do not use = NULL as that will stop some game features from working at next game restart.

* sys.ssl certificate commands are needed so that html5 can connect to server.

* Create a new game. Either do a chess variant or captains mistress.

* For the online players list at the waiting room, each column data is "var _data = new" in a loop. Instead, those data should each be placed in a sprite group or text group because currently doing a destroy() will only remove the last element.

* At client are Reg._doStartGameOnce or Reg._roomIsLocked needed? Perhaps a lot more variables are no longer needed. Please verify.

* Organize the client and server events.

* At server, put events in its own file.

* Message boxes can no longer be stacked on each other because a message box that is displayed will stop user from clicking the scene underneath it. therefore, remove messageBoxMessageOrder() code and all references to it.

* The software needs improved commenting. Lots of functions need a description. Lots of static variables need /* tags.

* Reg._buttonCodeValues and buttonCodeValues() are currently used in many class. Place those data into a single class.

* make the client look better or improve the layout.