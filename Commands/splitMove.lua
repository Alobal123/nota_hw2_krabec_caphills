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

function Run(self, units, parameter)
	local hills = parameter.positions -- Vec3
	local N = parameter.N
	--Spring.Echo(dump(parameter.formation))
	
	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
		
	for i=1, math.min(N, #units) do
		local thisUnitWantedPosition = hills[i]
		SpringGiveOrderToUnit(units[i], cmdID, thisUnitWantedPosition:AsSpringVector(), {})
	end
		
	return RUNNING
end


function Reset(self)
	
end
