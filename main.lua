require("lib.cupid")
_ = require("lib.Moses.moses")
_f = require("lib.Frob.frob")

game = {util = {}, controller = {}, entity = {}}

game.globalEvents = _f.object(_f.evt)
game.util.stateManager = require("util.stateManager")
game.util.state = require("util.state")
game.util.entity = require("util.entity")
game.util.controller = require("util.controller")

game.controller.sprite = require("sprite")
game.entity.person = require("person")


worldState = game.util.state:new()
game.util.stateManager:construct(game.globalEvents, worldState)

worldState:on("draw", function()
	love.graphics.setBackgroundColor(50, 170, 50)
end)

person0 = game.entity.person:new(worldState, 100, 100).observing

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