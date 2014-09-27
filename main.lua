require("lib.cupid")
_ = require("lib.Moses.moses")
_f = require("lib.Frob.frob")

game = {}

game.globalEvents = _f.object(_f.evt)

game.state = require("state")
game.entity = require("entity")
game.stateManager = require("stateManager")

worldState = game.state:new()
game.stateManager:construct(game.globalEvents, worldState)

function worldState:start()
	print("started")
end

function love.load()
	game.globalEvents:fire("start")
end

function love.update(dt)
	game.globalEvents:fire("update", dt)
end

function love.draw()
	game.globalEvents:fire("draw")
end