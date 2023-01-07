-- Created by using publicly available information.
--
-- 152mm/50 T was an upgrade for older 152/45 C coastal gun.
-- They were equipped with a four ton cover shield against air
-- threats.
--
-- CMO doesn't model Finnish archipelago correctly and thus
-- we cannot spread coastal guns as a single units around
-- each island. This script uses a bit simpler method and
-- places each battery as a single facility.
--
-- Author: humi / haapmik
--
-- SPDX-License-Identifier: MIT

local side = "Finland"
local fortSuffix = "Coastal Fort"

-- Enums for different database IDs
local facilityId = {
	fort_152mm50calT_x3 = 2642,
}

local mountId = {
	weapon_152mm50calT = 2832,
}

local sensorId = {
	radar_fika = 364,
}

--- Adds side to scenario if it doesn't exist
-- @param name for the side
-- @return a table of the side
function addSide(name)
	local sides = VP_GetSides()

	for _, value in pairs(sides) do
		-- Skip if side has already been added
		if value.name == name then
			return VP_GetSide({ side = value.name })
		end
	end
	return ScenEdit_AddSide({ name = name })
end

--- Adds requested 152mm/50 T battery
-- @param loc for battery location
-- @param name for battery name
-- @param size for amouth of guns in the battery
-- @param type for fire control type, either `raval` or `ranta`
-- @param group optional group name
-- @return Unit wrapper
function addFort_152mm50calT(loc, name, size, group)
	-- Create from CMO template
	local fort = ScenEdit_AddUnit({
		type = "Facility",
		side = side,
		dbid = facilityId.fort_152mm50calT_x3,
		name = name .. " (152mm/50 T Turret x " .. size .. ")",
		latitude = loc.latitude,
		longitude = loc.longitude,
	})

	-- Add unit to group
	if group ~= nil then
		fort.group = group
	end

	-- CMO template for the fort contains three guns.
	-- This updates the fort to use correct amouth of guns.
	local fortGuns = 3
	if size < 3 then
		for i = 1, fortGuns - size, 1 do
			ScenEdit_UpdateUnit({
				guid = fort.guid,
				mode = "remove_mount",
				dbid = mountId.weapon_152mm50calT,
			})
		end
	end
	if size > 3 then
		for i = 1, size - fortGuns, 1 do
			ScenEdit_UpdateUnit({
				guid = fort.guid,
				mode = "add_mount",
				dbid = mountId.weapon_152mm50calT,
				arc_mount = { "360" },
			})
		end
	end

	-- Prevent autodetection
	ScenEdit_SetUnit({
		guid = fort.guid,
		autodetectable = false,
	})

	return fort
end

function coastalFort_alskar()
	local fortName = "Alskär " .. fortSuffix
end

function coastalFort_gylto()
	local fortName = "Gyltö " .. fortSuffix
end

function coastalFort_hastobuso()
	local fortName = "Hästö-Busö " .. fortSuffix
end

function coastalFort_isosaari()
	local fortName = "Isosaari " .. fortSuffix
end

function coastalFort_jungfruskar()
	local fortName = "Jungfruskär " .. fortSuffix
end

function coastalFort_katanpaa()
	local fortName = "Katanpää " .. fortSuffix
end

function coastalFort_kirkonmaa()
	local fortName = "Kirkonmaa " .. fortSuffix
end

function coastalFort_kuustajaskari()
	local fortName = "Kuustajaskari " .. fortSuffix
end

function coastalFort_kyto()
	local fortName = "Kytö " .. fortSuffix
end

function coastalFort_lehtinen()
	local fortName = "Lehtinen " .. fortSuffix
end

function coastalFort_makiluoto()
	local fortName = "Mäkiluoto " .. fortSuffix
end

function coastalFort_norrskar()
	local fortName = "Norrskär " .. fortSuffix
end

function coastalFort_pirttisaari()
	local fortName = "Pirttisaari " .. fortSuffix
end

function coastalFort_rankki()
	local fortName = "Rankki " .. fortSuffix
end

function coastalFort_ronnskar()
	local fortName = "Rönnskär " .. fortSuffix
end

function coastalFort_uto()
	local fortName = "Utö " .. fortSuffix
end

function coastalFort_vanhankylanmaa()
	local fortName = "Vanhankylänmaa " .. fortSuffix
end

function coastalFort_oro()
	local fortGuns = 4
	local fortName = "Örö " .. fortSuffix

	local fort = addFort_152mm50calT({ latitude = 59.803426015, longitude = 22.314327743 }, fortName, fortGuns)
end

-- Unfinished
--coastalFort_alskar()
--coastalFort_gylto()
--coastalFort_hastobuso()
--coastalFort_isosaari()
--coastalFort_jungfruskar()
--coastalFort_katanpaa()
--coastalFort_kirkonmaa()
--coastalFort_kuustajaskari()
--coastalFort_kyto()
--coastalFort_lehtinen()
--coastalFort_makiluoto()
--coastalFort_norrskar()
--coastalFort_pirttisaari()
--coastalFort_rankki()
--coastalFort_ronnskar()
--coastalFort_uto()
--coastalFort_vanhankylanmaa()

-- Finished
coastalFort_oro()
