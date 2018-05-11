local sensorInfo = {
	name = "Hills",
	desc = "Returns table of all hills on the map",
	author = "Krabec",
	date = "2018-05-11",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 1000 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups

function euclideanDistance(v1,v2)
	return math.sqrt((v1["x"] - v2["x"])*(v1["x"] - v2["x"]) + (v1["z"] - v2["z"])*(v1["z"] - v2["z"]))

end

function isNewHill(spots, newSpot)
	for _,value in pairs(spots) do
		if euclideanDistance(value,newSpot) < 350 then
			return false
		end
	end
	return true
end


-- @description return current wind statistics
return function()
	--local X,Z = Game.mapSizeX/Game.squareSize , Game.mapSizeZ/Game.squareSize
	local X,Z = Game.mapSizeX , Game.mapSizeZ
	local areaSize = 100
	X,Z = math.floor(X/areaSize), math.floor(Z/areaSize)
	--x,z = 5,5
	local spots = {}
	local spotsLen = 0
	
	
	for j=0, Z do
		for i=0, X do
			x = i*areaSize
			z = j*areaSize
			y = Spring.GetGroundHeight(x,z)
			newSpot = Vec3(x+20, Spring.GetGroundHeight(x,z), z+20)
			if (y > 180) and isNewHill(spots, newSpot) then
				spots[spotsLen] = newSpot
				spotsLen = spotsLen + 1
			end
		end
	end
	return spots
	
end