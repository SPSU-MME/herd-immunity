local worldState = State()

function worldState:enter()
	for i=1,2 do
		self:addEntity(Person(4*i, 4*i))
	end

	for i=1, 7 do
		currHouse = self:addEntity(House(Random:random(100, 700), Random:random(200, 500)))

	end

	debugHuman = Person(500, 500, 2)
	self:addEntity(debugHuman)

end

function worldState:stateDraw()

	table.sort(self.entities, function(a, b) 
		return a.y + a:get("sprite").image:getHeight() < b.y + b:get("sprite").image:getHeight() 
	end)

	for i, v in ipairs(self.entities) do
		v:draw(dt)
	end
	love.graphics.setBackgroundColor(100, 170, 100)
end

--[[
function worldState:distribute(entity, number, method)
	local current
	for i=1,number do
		self:addEntity(entity())
	end
end
]]

return worldState