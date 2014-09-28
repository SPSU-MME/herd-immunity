_ = require("lib.Moses.moses")
--_f = require("lib.Frob.frob")
Monocle = require("lib.monocle")
Monocle.new({       -- ALL of these parameters are optional!
   isActive=false,          -- Whether the debugger is initially active
   customPrinter=false,    -- Whether Monocle prints status messages to the output
   printColor = {51,51,51},-- Color to print with
   debugToggle='`',        -- The keyboard button for toggling Monocle
   filesToWatch=           -- Files that, when edited, cause the game to reload automatically
      {
         'main.lua'
      }
})

Gamestate = require("lib.hump.gamestate")
Class = require("lib.hump.class")
Signals = require("lib.hump.signal")
Timer = require("lib.hump.timer")
Vector = require("lib.hump.vector")
Camera = require("lib.hump.camera")

Random = love.math.newRandomGenerator()
Random:setSeed(os.time())

PI = math.pi

State = require("state.state")
Entity = require("entity.entity")
Controller = require("controller.controller")

Sex = require("controller.sex")
Host = require("controller.host")
Collide = require("controller.collide")
Sprite = require("controller.sprite")
Move = require("controller.move")

Person = require("entity.person")
House = require("entity.house")

worldState = require("state.worldstate")

function love.load()
	Gamestate.switch(worldState)
end

function love.update(dt)
	Monocle.update()
	Gamestate.update(dt)
	Timer.update(dt)
end
 
function love.draw()
	Gamestate.draw()
	Monocle.draw()
end 

function love.keypressed(key, code)
	Gamestate.keypressed(key, code)
end

function love.mousepressed(x, y, button)
	Gamestate.mousepressed(x, y, button)
end