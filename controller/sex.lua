local Sex = Class{
	__includes = Controller,
	init = function(self, host)
		Controller.init(self, "sex")
		self.hostname = host
	end
}

function Sex:added(to)
	local collide = self.parent:get("collide")
	if not collide then
		print("parent entity needs to have collide. Failing.")
		self.parent.remove(self.name);
	else
		collide.signals:register("colliding", function(e) 
			for i, v in ipairs(e) do
				if v.name == self.hostname then
					self:enter(v)
				end
			end
		end)
	end
end

function Sex:enter(target)
	table.insert(target.occupants, self.parent)
	self.staying = target

	target.signals:register("filled", function(e)	
		Timer.add(3, function()
			self:leave()
		end)
	end)

	
	for k, v in pairs(self.parent:getAll()) do
		if k ~= self.name then
			v:disable()
			v:hide()
		end
	end
end

function Sex:leave()
	table.remove(self.staying, _.detect(self.staying, self))
	self.staying = nil
end

function Sex:update()

end


return Sex