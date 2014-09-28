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
	local host = target:get("host")
	print("entering house")

	self.parent.x = target.x
	self.parent.y = target.y
	
	host.signals:register("filled", function()	
		print("house filled")
		Timer.add(3, function()
			print("leaving house")
			self:leave(target)
		end)
	end)

	self.occupantIndex = host:addOccupant(self.parent)
	self.unfreezeParent = self.parent:freeze(true, self.name)
end

function Sex:leave(from)
	
	table.remove(from:get("host").occupants, self.occupantIndex)
	self.parent.x = from.x
	self.parent.y = from.y

	self.unfreezeParent()
	self.unfreezeParent = nil -- don't want a stale closure

	self.parent:get("collide"):disable()

	Timer.add(2, function() 
		self.parent:get("collide"):enable() 
	end)

	print("Left.")
end

return Sex