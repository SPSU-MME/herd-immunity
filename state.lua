local state = _f.object(_f.class, _f.evt)

function state:construct()
	self.entities = {}
	self.started = false
	self.visible = true
end


---------------------------------------
---CALLBACKS---
--------------------

function state:init() end -- runs as soon as the state is set

function state:preStart() end -- runs right before firing the start event (like before entities run their own starts)

function state:start() end -- right after firing the start event

function state:stop() end -- upon being called upon to stop

function state:update(dt) end -- do every 

function state:destroy() end -- clean up everything

return state