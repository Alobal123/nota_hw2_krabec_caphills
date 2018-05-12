local testBuildOrder = Spring.TestBuildOrder
local giveOrderToUnit = Spring.GiveOrderToUnit

function getInfo()
	return {
		onNoUnits = SUCCESS,
		parameterDefs = {
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
local SpringGetUnitPosition = Spring.GetUnitPosition


function Run(self, units, parameter)
	tick = tick + 1
	local x,y,z = SpringGetUnitPosition(units[1])
	local rad = parameter.radius

	local cmdID = CMD.UNLOAD_UNITS
	SpringGiveOrderToUnit(units[1], cmdID,{x,y,z,rad},{})
	if(tick<20) then
		return RUNNING
	end
	return SUCCESS
end

function Reset(self)
	tick = 0
end
