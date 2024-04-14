# Lua-Table-Reconstructor
A simple function that can be used to reconstruct a given table.
# Usage
```lua
local testtable = {
	[1] = "Hello! This is a table with a numbered index!",
	["NestedTable"] = {
		"Hello! This is a string inside a nested table, with some numbers!",
		1,
		5,
		0 / 0,
		math.huge,
		math.pi,
	},
	["ThisIsABoolean"] = false,
	["ThisIsAnotherBoolean"] = true,
	[2] = {
		"This is a table nested with an integer index!",
	},
	['Ori"""ginal""_Te""stTab""le!!!!"!\000""""\242\240\042\030'] = {
		"About that beer i owed ya!",
		"The Missile Knows Where It Is.",
		"To be, or not to be, that is the question.",
		4,
		math.huge,
		true,
		false,
		0 / 0,
	},
}

reconstruct_table(testtable)
```

# Output
```lua
-- Table reconstructed using table_reconstructor by usrDottik (Oroginally made by MakeSureDudeDies)
-- Reconstruction   began   @ 2024-04-14 19:58:42 - GMT 00:00
-- Reconstruction completed @ 2024-04-14 19:58:42 - GMT 00:00
-- Indexes Found inside of the Table (W/o  Nested Tables): 6
--                                   (With Nested Tables): 21
local t = {
	[1] = "Hello! This is a table with a numbered index!",
	[2] = {
		[1] = "This is a table nested with an integer index!",
	},
	["ThisIsAnotherBoolean"] = true,
	["NestedTable"] = {
		[1] = "Hello! This is a string inside a nested table, with some numbers!",
		[2] = 1,
		[3] = 5,
		[4] = 0 / 0,
		[5] = math.huge,
		[6] = math.pi,
	},
	["Ori\"\"\"ginal\"\"_Te\"\"stTab\"\"le!!!!\"! \"\"\"\"òð*"] = {
		[1] = "About that beer i owed ya!",
		[2] = "The Missile Knows Where It Is.",
		[3] = "To be, or not to be, that is the question.",
		[4] = 4,
		[5] = math.huge,
		[6] = true,
		[7] = false,
		[8] = 0 / 0,
	},
	["ThisIsABoolean"] = false,
}
```
