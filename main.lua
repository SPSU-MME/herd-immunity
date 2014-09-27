require("lib.cupid")
_ = require("lib.Moses.moses")
_f = require("lib.Frob.frob")

game = {}

game.globalEvents = _f.object(_f.evt)

game.state = require("state")
game.entity = require("entity")

mainState = game.state:new(game.globalEvents)


function mainState:start()
	print("started")
end

function mainState:update()
	game.globalEvents.fire("start")
end

mainState:on("draw", function() -- states really shouldn't need to draw things.
	love.graphics.circle("fill", 5, 5, 200, 60)
end)


function love.load()
	game.globalEvents:fire("start")
end

function love.update(dt)
	game.globalEvents:fire("update", dt)
end

function love.draw()
	game.globalEvents:fire("draw")
end

function love.keypressed(k)
	
end