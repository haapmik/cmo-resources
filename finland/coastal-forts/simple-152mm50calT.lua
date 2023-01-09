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
-- @param fortLoc for battery location
-- @param fortSide for side of the fort
-- @param fortName for battery name
-- @param fortSize for amouth of guns in the battery
-- @param fortType for fire control type, either `raval` or `ranta`
-- @param fortGroup optional group name
-- @return Unit wrapper
function addFort_152mm50calT(fortLoc, fortSide, fortName, fortSize, fortGroup)
	-- Add side
	addSide(fortSide)

	-- Create from CMO template
	local fort = ScenEdit_AddUnit({
		type = "Facility",
		side = fortSide,
		dbid = facilityId.fort_152mm50calT_x3,
		name = fortName .. " (152mm/50 T Turret x " .. tostring(fortSize) .. ")",
		latitude = fortLoc.latitude,
		longitude = fortLoc.longitude,
	})

	-- Add unit to group
	if fortGroup ~= nil then
		fort.group = fortGroup
	end

	-- CMO template for the fort contains three guns.
	-- This updates the fort to use correct amouth of guns.
	local fortGuns = 3
	if fortSize < 3 then
		for i = 1, fortGuns - fortSize, 1 do
			ScenEdit_UpdateUnit({
				guid = fort.guid,
				mode = "remove_mount",
				dbid = mountId.weapon_152mm50calT,
			})
		end
	end
	if fortSize > 3 then
		for i = 1, fortSize - fortGuns, 1 do
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
	-- These guns doesn't have the traditional protective cupola shielding
	-- them and one is hiding inside a house.
	local fortGuns = 3
	local fortName = "Alskär " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 59.989124282, longitude = 21.242755232 }, fortSide, fortName, fortGuns)
end

function coastalFort_gylto()
	-- Sources says there should be 4 guns but I can only find three.
	-- There are couple of other possible guns but the aerial photos
	-- are not good enough.
	local fortGuns = 4
	local fortName = "Gyltö " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.111405404, longitude = 21.484861289 }, fortSide, fortName, fortGuns)
end

function coastalFort_hastobuso()
	-- Aerial photos shows four guns.
	local fortGuns = 4
	local fortName = "Hästö-Busö " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 59.837908429, longitude = 23.329650535 }, fortSide, fortName, fortGuns)
end

function coastalFort_isosaari()
	-- Map for visitors clearly marks these old guns
	-- so you can go and explore them.
	local fortGuns = 4
	local fortName = "Isosaari " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.100158102, longitude = 25.052993395 }, fortSide, fortName, fortGuns)
end

function coastalFort_jungfruskar()
	-- According to the Coastal Artillery Museum,
	-- Jungfruskär has three guns without the armoured cupola.
	local fortGuns = 4
	local fortName = "Jungfruskär " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.138499873, longitude = 21.077742966 }, fortSide, fortName, fortGuns)
end

function coastalFort_katanpaa()
	-- Aerial photos show two guns
	local fortGuns = 2
	local fortName = "Katanpää " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.614191530, longitude = 21.168813638 }, fortSide, fortName, fortGuns)
end

function coastalFort_kirkonmaa()
	-- Aerial photos shows four guns
	local fortGuns = 2
	local fortName = "Kirkonmaa " .. fortSuffix
	local fortSide = side
	addFort_152mm50calT({ latitude = 60.375319449, longitude = 27.049473942 }, fortSide, fortName, fortGuns)
end

function coastalFort_kuuskajaskari()
	-- Aerial photos shows three guns.
	local fortGuns = 4
	local fortName = "Kuuskajaskari " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 61.136648265, longitude = 21.364455492 }, fortSide, fortName, fortGuns)
end

function coastalFort_kyto()
	-- Aerial photos shows one gun and one empty gun placement.
	local fortGuns = 2
	local fortName = "Kytö " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.336534157, longitude = 26.512440836 }, fortSide, fortName, fortGuns)
end

function coastalFort_lehtinen()
	-- Can't find any guns from aerial photos.
	-- The whole island has overgrown but sources
	-- indicates there should had been two guns.
	local fortGuns = 2
	local fortName = "Lehtinen " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.336534157, longitude = 26.512440836 }, fortSide, fortName, fortGuns)
end

function coastalFort_makiluoto()
	-- Can only find one possible 155mm/50 T gun placement.
	-- Written records from former commander of the fort says there
	-- were four guns of this type.
	local fortGuns = 4
	local fortName = "Mäkiluoto " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 59.918929555, longitude = 24.348995475 }, fortSide, fortName, fortGuns)
end

function coastalFort_norrskar()
	-- Aerial photos shows three old gun placements that
	-- has been dismantled. Written sources says that there
	-- used to be three 152mm/45 C which were usually upgraded
	-- to 152mm/50 T after the Second World War.
	local fortGuns = 3
	local fortName = "Norrskär " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 63.234462964, longitude = 20.607843421 }, fortSide, fortName, fortGuns)
end

function coastalFort_pirttisaari()
	-- Aerial photos shows three guns and one possible gun.
	-- Sources indicates that there should be four guns and
	-- that one is in the middle of the forest under trees.
	local fortGuns = 4
	local fortName = "Pirttisaari " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.159780585, longitude = 25.441677898 }, fortSide, fortName, fortGuns)
end

function coastalFort_rankki()
	-- There are three guns at the island that can be seen from
	-- aerial photos. Two are a bit more hidden and barely seen
	-- between tree line.
	local fortGuns = 3
	local fortName = "Rankki " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.370492062, longitude = 26.960993073 }, fortSide, fortName, fortGuns)
end

function coastalFort_ronnskar()
	-- I can only find one possible old gun bunker
	-- from aerial photos. Sources indicates that there
	-- was only one turret, which was dismantled.
	local fortGuns = 1
	local fortName = "Rönnskär " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 59.935004327, longitude = 24.392436265 }, fortSide, fortName, fortGuns)
end

function coastalFort_uto()
	-- You can clearly see four old gun bunkers from
	-- aerial photos. Three of them has been distmantled.
	local fortGuns = 4
	local fortName = "Utö " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 59.782098909, longitude = 21.362103282 }, fortSide, fortName, fortGuns)
end

function coastalFort_vanhankylanmaa()
	-- I can see only two old guns from aerial photos
	-- and two possible locations. Sources indicates
	-- that there were three guns.
	local fortGuns = 3
	local fortName = "Vanhankylänmaa " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 60.289463491, longitude = 27.143692586 }, fortSide, fortName, fortGuns)
end

function coastalFort_oro()
	local fortGuns = 4
	local fortName = "Örö " .. fortSuffix
	local fortSide = side
	local fort =
		addFort_152mm50calT({ latitude = 59.803426015, longitude = 22.314327743 }, fortSide, fortName, fortGuns)
end

coastalFort_katanpaa()
coastalFort_kirkonmaa()
coastalFort_alskar()
coastalFort_gylto()
coastalFort_hastobuso()
coastalFort_isosaari()
coastalFort_jungfruskar()
coastalFort_kuuskajaskari()
coastalFort_kyto()
coastalFort_lehtinen()
coastalFort_makiluoto()
coastalFort_norrskar()
coastalFort_pirttisaari()
coastalFort_rankki()
coastalFort_ronnskar()
coastalFort_uto()
coastalFort_vanhankylanmaa()
coastalFort_oro()
