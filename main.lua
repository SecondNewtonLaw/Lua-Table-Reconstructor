--[[
    Table Reconstructor - Original by MakeSureDudeDies (MSDD). Modified by Dottik.

    A simple lua program to make a lua table into valid, runnable, lua code.
]]

local function tL(t)
	if type(t) ~= "table" then
		return 0
	end
	local a = 0
	for _, _ in pairs(t) do
		a = a + 1
	end
	return a
end

local function tL_nested(t)
	if type(t) ~= "table" then
		return 0
	end
	local a = 0
	for _, v in pairs(t) do
		if type(v) == "table" then
			a = a + tL_nested(v)
		end
		a = a + 1 -- Even if it was a table, we still count the table index itself as a value, not just its subvalues!
	end
	return a
end

local function reconstruct_table(t_)
	if type(t_) ~= "table" then
		return string.format("-- Given object is not a table, rather a %s. Cannot reconstruct.", type(t_))
	end

	local function inner__reconstruct_table(t, isChildTable, childDepth)
		local tableConstruct = ""
		if not isChildTable then
			tableConstruct = "local t = {\n"
		end

		if childDepth > 30 then
			tableConstruct = string.format("%s\n--Cannot Reconstruct, Too much nesting!\n", tableConstruct)
			return tableConstruct
		end

		for idx, val in pairs(t) do
			local idxType = type(val)
			if idxType == "boolean" then
				tableConstruct = string.format(
					'%s%s["%s"] = %s',
					tableConstruct,
					string.rep("\t", childDepth),
					tostring(idx),
					val and "true" or "false"
				)
			elseif idxType == "function" or idxType == "number" or idxType == "string" then
				local v = tostring(val)

				if idxType == "number" then
					if string.match(tostring(v), "nan") then
						v = "0 / 0"
					elseif string.match(tostring(v), "inf") then
						v = "math.huge"
					end
				end

				if idxType == "string" then
					v = string.format('"%s"', v)
				end

				tableConstruct =
					string.format('%s%s["%s"] = %s', tableConstruct, string.rep("\t", childDepth), tostring(idx), v)
			elseif idxType == "table" then
				local r = inner__reconstruct_table(val, true, childDepth + 1)
				tableConstruct =
					string.format('%s%s["%s"] = {\n%s', tableConstruct, string.rep("\t", childDepth), tostring(idx), r)
			elseif idxType == "nil" then
				tableConstruct =
					string.format('%s%s["%s"] = nil', tableConstruct, string.rep("\t", childDepth), tostring(idx))
			elseif idxType == "userdata" then
				tableConstruct = string.format(
					'%s%s["%s"] = "UserData. Cannot represent."',
					string.rep("\t", childDepth),
					tableConstruct,
					tostring(idx)
				)
			end
			tableConstruct = string.format("%s,\n", tableConstruct)
		end
		if isChildTable then
			return string.format("%s%s}", tableConstruct, string.rep("\t", childDepth - 1))
		else
			return string.format("%s}\n", tableConstruct)
		end
	end
	local welcomeMessage = [[
-- Table reconstructed using table_reconstructor by usrDottik (Originally made by MakeSureDudeDies)
-- Reconstruction   began   @ %s - GMT 00:00
-- Reconstruction completed @ %s - GMT 00:00
-- Indexes Found inside of the Table (W/o  Nested Tables): %d
--                                   (With Nested Tables): %d
]]
	local begin = tostring(os.date("!%Y-%m-%d %H:%M:%S"))
	local reconstruction = inner__reconstruct_table(t_, false, 1)
	local finish = tostring(os.date("!%Y-%m-%d %H:%M:%S"))
	welcomeMessage = string.format(welcomeMessage, begin, finish, tL(t_), tL_nested(t_))

	return string.format("%s%s", welcomeMessage, reconstruction)
end
