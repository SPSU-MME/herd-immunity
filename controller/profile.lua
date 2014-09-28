-- okay yes I will admit this one really only works on humans.

local Profile = Class{
	__includes = Controller,

	init = function(self, info)
		Controller.init(self, "profile")
		self.information = {
			name = "John Doe",
			gender = "male", --or "female"
			sex = {
				anal = 0,
				vaginal = 0,
				oral = 0
			},
		}
	end
}

function Profile:added(to)
	if not to:get("collide") then
		print("Won't work without collide.")
		to:remove(self.name) -- bye bye!
	end
end

function Profile:update() 

end

function Profile:draw() 

end

function Profile:mousepressed(x, y, button) 
	if self.parent:get("collide"):pointCollisionTest(x, y) then
		self.visible = (not self.visible) -- toggle!
	end
end

function Profile:hadSex(type)
	self.information.sex[type] = self.information.sex[type] + 1
end

return Profile