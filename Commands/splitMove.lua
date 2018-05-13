-- Given some locations, this sends one unit from a group to that each location.

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{ 
				name = "positions",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				-- number of places to send units to
				name = "N",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "3",
			}
		}
	}
end

-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)
	local hills = parameter.positions -- Vec3
	local N = parameter.N
	
	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
		
	-- this is hardcoded for our problem, but can be rather easily generalized
	for i=1, math.min(N, #units) do
		local thisUnitWantedPosition = hills[i]
		SpringGiveOrderToUnit(units[i], cmdID, thisUnitWantedPosition:AsSpringVector(), {})
	end
		
	return RUNNING
end


function Reset(self)
	
end
