_ = require("lib.Moses.moses")
--_f = require("lib.Frob.frob")

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

worldState = require("state.worldstate")

function love.load()
	Gamestate.switch(worldState)
end

function love.update(dt)
	Gamestate.update(dt)
	Timer.update(dt)
end
 
function love.draw()
	Gamestate.draw()
end 

function love.keypressed(key, code)
	Gamestate.keypressed(key, code)
end

function love.mousepressed(x, y, button)
	Gamestate.mousepressed(x, y, button)
end