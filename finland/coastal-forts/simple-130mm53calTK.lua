-- Created by using publicly available information.
--
-- According to different sources, these 130mm/53 TK forts
-- will stay in use till 2020's. These static gun placements
-- are not alone responsible for Finnish coastal defence, but
-- only a part of it.
--
-- CMO doesn't model Finnish arhcipedago correctly and thus
-- we cannot spread coastal guns as a single units around
-- each island. This script uses a bit simpler method and
-- places each battery as a single facility.
--
-- Author: Mikko Haapanen <haapanen.mo@gmail.com>
--
-- SPDX-License-Identifier: MIT

local side = "Finland"
local fortSuffix = "Coastal Fort"

-- Enum for facility IDs
local facilityId = {
	-- There seems to be no difference between RAVAL and RANTA in CMO
	-- even though these are two different fire control systems.
	fort_130mm53calTK_x2_raval = 2632,
	fort_130mm53calTK_x2_ranta = 2633,
	fort_130mm53calTK_x3_raval = 2634,
	fort_130mm53calTK_x3_ranta = 2636,
	fort_130mm53calTK_x4_raval = 2635,
	fort_130mm53calTK_x4_ranta = 2637,
}

-- Enum for sensor IDs
local sensorId = {
	radar_pra3000 = 5072,
	radar_18045x = 5071,
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

--- Adds requested 130mm/53 TK battery
-- @param loc for battery location
-- @param name for battery name
-- @param size for amouth of guns in the battery
-- @param type for fire control type, either `raval` or `ranta`
-- @param group optional group name
-- @return Unit wrapper
function addFort_130mm53calTK(loc, name, size, type, group)
	-- Create from CMO template
	local fort = ScenEdit_AddUnit({
		type = "Facility",
		side = side,
		dbId = facilityId["fort_130mm53calTK_x" .. tostring(size) .. "_" .. type],
		name = name,
		latitude = loc.latitude,
		longitude = loc.longitude,
	})

	-- Add unit to group
	if group ~= nil then
		fort.group = group
	end

	-- Prevent autodetection
	ScenEdit_SetUnit({
		guid = fort.guid,
		autodetectable = false,
	})

	return fort
end

function coastalFort_gylto()
	local fortName = "Gyltö " .. fortSuffix
end

function coastalFort_isosaari()
	local fortName = "Isosaari " .. fortSuffix
end

function coastalFort_miessaari()
	local fortName = "Miessaari " .. fortSuffix
end

--- Adds Mäkiluoto Coastal Fort
function coastalFort_makiluoto()
	local fortName = "Makiluoto " .. fortSuffix

	-- Soviets blew up Mäkiluoto Coastal Fort before
	-- they left there in the 1950's. You can clearly
	-- see these old destroyed gun placements from aerial
	-- photos.

	-- Aerial photos shows three possible 130/53 TK guns.
	local fort = addFort_130mm53calTK({ latitude = 59.917027061, longitude = 24.347881879 }, fortName, 3, "ranta")
end

--- Adds Rankki Coastal Fort
function coastalFort_rankki()
	local fortName = "Rankki " .. fortSuffix

	-- Finnish Navy left from Rankki by the end of 2013,
	-- but it is not known whether guns are still kept in
	-- operational condition. Atleast parts of the island
	-- are still marked as military area in maps and photos
	-- shows fences around these guns.

	-- Aerial photos shows three possible 130mm/53 TK guns
	local fort = addFort_130mm53calTK({ latitude = 60.371789830, longitude = 26.959687004 }, fortName, 3, "ranta")

	-- An old 152mm/50 T gun placement can be seen from previously
	-- mentioned aerial photos.

	-- Tourist photos shows 18045X radar
	ScenEdit_UpdateUnit({
		guid = fort.guid,
		mode = "remove_sensor",
		dbid = sensorId.radar_fika,
	})
	ScenEdit_UpdateUnit({
		guid = fort.guid,
		mode = "add_sensor",
		dbid = sensorId.radar_18045x,
		arc_detect = { "360" },
		arc_track = { "360" },
	})
end

-- Adds Russarö Coastal Fort
function coastalFort_russaro()
	local fortName = "Russarö " .. fortSuffix

	-- Aerial photos shows three possible 130mm/53 TK guns
	local fort = addFort_130mm53calTK({ latitude = 59.772922230, longitude = 22.945779695 }, fortName, 3, "ranta")

	-- Aerial photos also shows two old 234mm/50 model BS guns
	-- which currently serves as museum guns and are probably disabled.
	--
	-- Tourist photos shows old 100mm gun near to Russarö lighthouse,
	-- which is no longer in use.
	--
	-- Tourist photos and videos from 2016 and before shows Fika radar,
	-- so we will not change the default facility setup.
end

-- Adds Ronnskär Coastal Fort
function coastalFort_ronnskar()
	local fortName = "Rönnskär" .. fortSuffix

	-- Aerial photos shows two 130mm/53 TK guns
	local fort = addFort_130mm53calTK({ latitude = 59.934308608, longitude = 24.390601055 }, fortName, 2, "ranta")

	-- Aerial photos also shows multiple underground storages
	-- and possible old gun placement (152mm/50 T?).

	-- Rönnskär lighthouse has PRA3000 on top of it.
	ScenEdit_UpdateUnit({
		guid = fort.guid,
		mode = "remove_sensor",
		dbid = sensorId.radar_fika,
	})
	ScenEdit_UpdateUnit({
		guid = fort.guid,
		mode = "add_sensor",
		dbid = sensorId.radar_pra3000,
		arc_detect = { "360" },
		arc_track = { "360" },
	})
end

-- Adds Utö Coastal Fort
function coastalFort_uto()
	local fortName = "Utö" .. fortSuffix

	-- Sources, Aerial photos, and photos taken by tourists in 2021
	-- shows four 130mm/53 TK guns, two at east and two at west of Utö.
	local fort = addFort_130mm53calTK({ latitude = 59.780974602, longitude = 21.369452746 }, fortName, 4, "ranta")

	-- Aerial photos also shows four old 152mm/50 T guns at west of Utö,
	-- from which three has been dismantled and one disabled.
	--
	-- There is one unknown gun west of Utö. Some Coastal forts includes
	-- empty gun hulls for deceoption so this could be one of those?

	-- Tourist photo from 2021 shows PRA3000 radar
	ScenEdit_UpdateUnit({
		guid = fort.guid,
		mode = "remove_sensor",
		dbid = sensorId.radar_fika,
	})
	ScenEdit_UpdateUnit({
		guid = fort.guid,
		mode = "add_sensor",
		dbid = sensorId.radar_pra3000,
		arc_detect = { "360" },
		arc_track = { "360" },
	})
end

function coastalFort_oro()
	local fortName = "Örö" .. fortSuffix
end

-- Create side if not available
addSide(side)

-- Add forts
coastalFort_rankki()
coastalFort_russaro()
coastalFort_ronnskar()
coastalFort_uto()

-- Unfinished
-- coastalFort_oro()
-- coastalFort_gylto()
-- coastalFort_isosaari()
-- coastalFort_miessaari()
-- coastalFort_makiluoto()
