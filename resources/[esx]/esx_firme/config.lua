Config              = {}
Config.DrawDistance = 100
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.Color        = {r = 0, g = 128, b = 255}
Config.Type         = 1
Config.Locale       = 'hr'

Config.Price = 100

Config.AllTattooList = json.decode(LoadResourceFile(GetCurrentResourceName(), 'AllTattoos.json'))
Config.TattooCats = {
	{"ZONE_HEAD", "Glava", {vec(0.0, 0.7, 0.7), vec(0.7, 0.0, 0.7), vec(0.0, -0.7, 0.7), vec(-0.7, 0.0, 0.7)}, vec(0.0, 0.0, 0.5)},
	{"ZONE_LEFT_LEG", "Lijeva noga", {vec(-0.2, 0.7, -0.7), vec(-0.7, 0.0, -0.7), vec(-0.2, -0.7, -0.7)}, vec(-0.2, 0.0, -0.6)},
	{"ZONE_LEFT_ARM", "Lijeva ruka", {vec(-0.4, 0.5, 0.2), vec(-0.7, 0.0, 0.2), vec(-0.4, -0.5, 0.2)}, vec(-0.2, 0.0, 0.2)},
	{"ZONE_RIGHT_LEG", "Desna noga", {vec(0.2, 0.7, -0.7), vec(0.7, 0.0, -0.7), vec(0.2, -0.7, -0.7)}, vec(0.2, 0.0, -0.6)},
	{"ZONE_TORSO", "Tijelo", {vec(0.0, 0.7, 0.2), vec(0.0, -0.7, 0.2)}, vec(0.0, 0.0, 0.2)},
	{"ZONE_RIGHT_ARM", "Desna ruka", {vec(0.4, 0.5, 0.2), vec(0.7, 0.0, 0.2), vec(0.4, -0.5, 0.2)}, vec(0.2, 0.0, 0.2)},
}

-- Config.Shops = {
-- 	vec(1322.6, -1651.9, 51.2),
-- 	vec(-1153.6, -1425.6, 4.9),
-- 	vec(322.1, 180.4, 103.5),
-- 	vec(-3170.0, 1075.0, 20.8),
-- 	vec(1864.6, 3747.7, 33.0),
-- 	vec(-293.7, 6200.0, 31.4)
-- }

-- Config.interiorIds = {}
-- for k, v in ipairs(Config.Shops) do
--     Config.interiorIds[#Config.interiorIds + 1] = GetInteriorAtCoords(v)
-- end

Config.Zones = {

	TwentyFourSeven = {
		Items = {},
		Pos = {
			vector3(373.875,   325.896,  102.566),
			vector3(2557.458,  382.282,  107.622),
			vector3(-3038.939, 585.954,  6.908),
			vector3(-3241.927, 1001.462, 11.830),
			vector3(547.431,   2671.710, 41.156),
			vector3(1961.464,  3740.672, 31.343),
			vector3(2678.916,  3280.671, 54.241),
			vector3(1729.216,  6414.131, 34.037),
			vector3(189.938, -889.800, 29.713), --glavna
			vector3(25.746, -1346.904, 28.497)
		}
	},

	RobsLiquor = {
		Items = {},
		Pos = {
			vector3(1135.808,  -982.281,  45.415),
			vector3(-1222.915, -906.983,  11.326),
			vector3(-1487.553, -379.107,  39.163),
			vector3(-2968.243, 390.910,   14.043),
			vector3(1166.024,  2708.930,  37.157),
			vector3(1392.562,  3604.684,  33.980)
		}
	},

	LTDgasoline = {
		Items = {},
		Pos = {
			vector3(-48.519,   -1757.514, 28.421),
			vector3(1163.373,  -323.801,  68.205),
			vector3(-707.501,  -914.260,  18.215),
			vector3(-1820.523, 792.518,   137.118),
			vector3(1698.388,  4924.404,  41.063)
		}
	},

	TuningShop = {
		Items = {},
		Pos = {}
	},
	
	Bar = {
		Items = {},
		Pos = {
			vector3(127.78149414063, -1284.6822509766, 28.279939651489),
			vector3(-560.11688232422, 287.00296020508, 81.176391601563),
			vector3(-1377.7868652344, -626.80126953125, 29.819589614868),
			vector3(1110.5810546875, 211.38018798828, -50.440074920654),
			vector3(359.98645019531, 280.59167480469, 93.191062927246),
		}
	},

	BurgeriSeSutaju = {
		Items = {},
		Pos = {
			
		}
	},
}