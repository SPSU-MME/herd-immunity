require("lib.cupid")
_ = require("lib.Moses.moses")
_f = require("lib.Frob.frob")

Gamestate = require("lib.hump.gamestate")
Class = require("lib.hump.class")
Signal = require("lib.hump.signal")
Timer = require("lib.hump.timer")
Vector = require("lib.hump.vector")
Camera = require("lib.hump.camera")

State = require("state.state")
Entity = require("entity.entity")
Controller = require("controller.controller")

Sprite = require("controller.sprite")

--worldState = game.util.state:new()
--game.util.stateManager:construct(game.globalEvents, worldState)

function worldState:start()
	print("started")
end

function love.load()
	game.globalEvents:fire("start")
	for k, v in pairs(person0) do
		print(k, v)
	end
end

function love.update(dt)
	game.globalEvents:fire("update", dt)
end

function love.draw()
	worldState:fire("draw")
end