local Host = Class{
	__includes = Controller,
	init = function(self, forWhom)
		Controller.init(self, "host")
		self.signals = Signals.new()
		self.forWhom = forWhom
		self.occupants = {}
		self.occupants.consent = {}
		self.waiting = false
		self.filled = false
	end
}

function Host:update(dt)
	self.filled = (#self.occupants >= 2)
end

function Host:addOccupant(occupant)
	table.insert(self.occupants, occupant)
	self:checkFull()
	return #self.occupants
end

function Host:removeOccupant(index)
	table.remove(self.occupants, index)
	self:checkFull()
end

function Host:checkFull()
	if #self.occupants >= 2 then
		self.signals:emit("filled")
		self.signals:clear("filled")
	end
end

function Host:consent(index)
	local ready = true;
	self.occupants.consent[index] = true
	print("occupant "..index.." consented")
	for i, v in ipairs(self.occupants) do
		if not self.occupants.consent[i] then
			print("but occupant "..i.." hasn't")
			ready = false --nope not ready
		end
	end

	if ready then 
		print("both occupants consented! Sexy time time!")
		self.signals:emit("ready")
		self.signals:clear("ready")
		self.occupants.consent = {} -- clear!
	end
	
end

function Host:getOther(isnt)
	for i, v in ipairs(self.occupants) do
		if v ~= isnt then return v end
	end
end

return Host