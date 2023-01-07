-- Åland convention of 1856 was signed by Russia after
-- the Crimean War to agree not to militarise the Åland
-- islands.
--
-- After Finland gained independency in 1918, another Åland
-- convention was signed in 1921 by Finland, Sweden, Germany,
-- United Kingdom, France, Italy, Denmark, Poland, Estonia,
-- and Latvia.
--
-- Third convention was signed between Finland and Russia in 1940.
--
-- More information:
--     - https://en.wikipedia.org/wiki/%C3%85land_Islands_dispute
--     - https://en.wikipedia.org/wiki/%C3%85land_convention
--     - https://www.finlex.fi/fi/sopimukset/sopsteksti/1922/19220001
--
-- Author: Mikko Haapanen <haapanen.mo@gmail.com>
--
-- SPDX-License-Identifier: MIT

local side = "Finland"
local zoneName = "Åland DMZ"

-- East side
local aaland_dmz_refs = {
	{ latitude = 60.683333333, longitude = 21.000000000 },
	{ latitude = 60.585833333, longitude = 21.102500000 },
	{ latitude = 60.550833333, longitude = 21.133333333 },
	{ latitude = 60.252222222, longitude = 21.084722222 },
	{ latitude = 60.184444444, longitude = 21.001111111 },
	{ latitude = 60.151111111, longitude = 21.017222222 },
	{ latitude = 60.084722222, longitude = 21.067500000 },
	{ latitude = 60.016944444, longitude = 21.184166667 },
	{ latitude = 59.983333333, longitude = 21.134166667 },
	{ latitude = 59.883333333, longitude = 21.333333333 },
	{ latitude = 59.801388889, longitude = 21.333333333 },
	{ latitude = 59.450000000, longitude = 20.767500000 },
	{ latitude = 59.450000000, longitude = 20.151944444 },
	{ latitude = 59.785555556, longitude = 19.666666667 },
	{ latitude = 60.185555556, longitude = 19.084722222 },
	{ latitude = 60.301111111, longitude = 19.134722222 },
	{ latitude = 60.683333333, longitude = 19.234444444 },
}

for _, value in pairs(aaland_dmz_refs) do
	ScenEdit_AddReferencePoint({
		side = side,
		name = zoneName,
		lat = value.latitude,
		lon = value.longitude,
		highlighted = true,
	})
end
