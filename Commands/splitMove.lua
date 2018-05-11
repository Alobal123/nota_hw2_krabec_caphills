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

local function ClearState(self)

end

function Run(self, units, parameter)
	local hills = parameter.positions -- Vec3
	local N = parameter.N
	--Spring.Echo(dump(parameter.formation))
	
	-- validation
	if (#units < N) then
		Logger.warn("formation.move", "Your formation size [" .. #formation .. "] is smaller than needed for given count of units [" .. #units .. "] in this group.") 
		return FAILURE
	end
	
	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
	
	-- check pointman success
	-- THIS LOGIC IS TEMPORARY, NOT CONSIDERING OTHER UNITS POSITION
		
	for i=1, N do
		local thisUnitWantedPosition = hills[i]
		SpringGiveOrderToUnit(units[i], cmdID, thisUnitWantedPosition:AsSpringVector(), {})
	end
		
	return RUNNING
end


function Reset(self)
	ClearState(self)
end
