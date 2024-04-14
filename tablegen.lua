--[[
    LuaTableReconstructor - Made by Dottik

    Generate random tables which nest tables, numbers and strings, with indexes that are numbers and strings.
]]

local tNesting = 0
local function genTable(base, maxNesting, depth)
	if i > 50 then
		table.insert(base, "END")
		return base
	end

	local r = math.random(50, 200)

	for _ = 0, r do
		local num = math.random(0, 2)
		if num == 1 then
			table.insert(base, tostring(depth))
		elseif num == 2 then
			table.insert(base, tonumber(depth))
		else
			if tNesting < maxNesting then
				tNesting = tNesting + 1
				table.insert(base, genTable({}, maxNesting, depth + 5))
			end
		end
	end
	return genTable(base, maxNesting, depth + 1)
end

-- Generates tables, used for testing LuaTableReconstructor.lua
return genTable
