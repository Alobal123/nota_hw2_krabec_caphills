function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",

			},
			{ 
				name = "tolerance",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "30",
			}
		}
	}
end

function euclideanDistance(v1,v2)
	return math.sqrt((v1["x"] - v2["x"])*(v1["x"] - v2["x"]) + (v1["z"] - v2["z"])*(v1["z"] - v2["z"]))
end

-- speed-ups
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit
local SpringGetUnitPosition = Spring.GetUnitPosition

function Run(self, units, parameter)
	local position = parameter.position -- Vec3
	local tolerance = parameter.tolerance
	
	-- pick the spring command implementing the move
	local cmdID = CMD.MOVE
		
	for i=1, #units do
		local x,z = position["x"],position["z"]
		local thisUnitWantedPosition = Vec3(x,Spring.GetGroundHeight(x,z),z)
		SpringGiveOrderToUnit(units[i], cmdID, thisUnitWantedPosition:AsSpringVector(), {})
	end
	
	for i=1,#units do
		local x,y,z = SpringGetUnitPosition(units[i])
		if (euclideanDistance(Vec3(x,y,z),position) > tolerance) then
			return RUNNING
		end
	end
	return SUCCESS
end


function Reset(self)
	
end
