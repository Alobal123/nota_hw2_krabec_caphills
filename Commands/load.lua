local testBuildOrder = Spring.TestBuildOrder
local giveOrderToUnit = Spring.GiveOrderToUnit

function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
					{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
			{ 
				name = "radius",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "100",
			}
		
		}

	}
end

local tick = 0
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

function Run(self, units, parameter)
	tick = tick + 1
	local pos = parameter.position
	local rad = parameter.radius
	local x,y,z = pos["x"],pos["y"],pos["z"]
	local cmdID = CMD.LOAD_UNITS
	SpringGiveOrderToUnit(units[1], cmdID,{x,y,z,rad},{})
	if(tick<10) then
		return RUNNING
	end
	return SUCCESS
end

function Reset(self)
	tick = 0
end
