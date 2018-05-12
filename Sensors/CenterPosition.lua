local sensorInfo = {
	name = "AveragePosition",
	desc = "Return the center of unit group",
	author = "krabecm",
	date = "2018-05-12",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
local SpringGetUnitPosition = Spring.GetUnitPosition

-- @description return the center of the unit group
return function()
	X = 0
	Z = 0
	for i=1,#units do
		local x,_,z = SpringGetUnitPosition(units[i])
		X = X + x
		Z = Z + z
	end
	X = math.floor(X/#units)
	Z = math.floor(Z/#units)
	return Vec3(X,Spring.GetGroundHeight(X,Z),Z)
end