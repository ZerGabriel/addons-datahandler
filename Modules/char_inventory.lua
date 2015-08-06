local mod = ADH:NewModule("char_inventory")

local retTbl = { ['equipped'] = {}, ['bags'] = {}, ['bank'] = {} }
local enchantIDs2spellIDs = {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
	mod:InitEnchantIDs()
end

function mod:OnEnable()
	ADH_DB['inventory'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	mod:GetEquippedItems()

	return retTbl
end

function mod:GetEquippedItems()
	for i = 1, 19, 1 do
		local itemLink = GetInventoryItemLink("player", i)
		if itemLink then
			local _, _, quality, iLevel, _, _, _, _, _, texture = GetItemInfo(itemLink)
			local itemId, enchantId, gem1, gem2, gem3, gem4, reforgeId = itemLink:match("item:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):%-?%d+:%-?%d+:%d+:(%d+)")

			retTbl['equipped'][tostring(i)] = {
				['id'] = itemId,
				['icon'] = texture,
				['quality'] = quality,
				['itemLevel'] = iLevel,
			}

			if reforgeId ~= 0 then
				retTbl['equipped'][tostring(i)]['reforge'] = reforgeId
			end

			if enchantId ~= "0" then
				retTbl['equipped'][tostring(i)]['enchant'] = {
					['id'] = enchantIDs2spellIDs[enchantId]['id'],
					['type'] = enchantIDs2spellIDs[enchantId]['type'],
					['enchant'] = enchantId
				}
			end

			for gemIndex = 1,4 do	-- We should build a new array cause, we don't see empty slots
				local _, gemLink = GetItemGem(itemLink, gemIndex)
				if gemLink then
					local gemId = gemLink:match("item:(%d+):")
					retTbl['equipped'][tostring(i)]['gem'..tostring(gemIndex)] = {
						['id'] = gemId,
						['icon'] = GetItemIcon(gemLink),
					}
				end
			end

		end
	end
end

-- Init enchant IDs
function mod:InitEnchantIDs()
	enchantIDs2spellIDs = {
		["15"] = {["id"] = 2304, ["type"] = "item"},
		["16"] = {["id"] = 2313, ["type"] = "item"},
		["17"] = {["id"] = 4265, ["type"] = "item"},
		["30"] = {["id"] = 4405, ["type"] = "item"},
		["32"] = {["id"] = 4406, ["type"] = "item"},
		["33"] = {["id"] = 4407, ["type"] = "item"},
		["36"] = {["id"] = 5421, ["type"] = "item"},
		["37"] = {["id"] = 6041, ["type"] = "item"},
		["43"] = {["id"] = 6042, ["type"] = "item"},
		["34"] = {["id"] = 6043, ["type"] = "item"},
		["463"] = {["id"] = 7967, ["type"] = "item"},
		["464"] = {["id"] = 7969, ["type"] = "item"},
		["18"] = {["id"] = 8173, ["type"] = "item"},
		["663"] = {["id"] = 10546, ["type"] = "item"},
		["664"] = {["id"] = 10548, ["type"] = "item"},
		["1483"] = {["id"] = 11622, ["type"] = "item"},
		["1503"] = {["id"] = 11642, ["type"] = "item"},
		["1504"] = {["id"] = 11643, ["type"] = "item"},
		["1505"] = {["id"] = 11644, ["type"] = "item"},
		["1506"] = {["id"] = 11645, ["type"] = "item"},
		["1507"] = {["id"] = 11646, ["type"] = "item"},
		["1508"] = {["id"] = 11647, ["type"] = "item"},
		["1509"] = {["id"] = 11648, ["type"] = "item"},
		["1510"] = {["id"] = 11649, ["type"] = "item"},
		["1704"] = {["id"] = 12645, ["type"] = "item"},
		["1843"] = {["id"] = 15564, ["type"] = "item"},
		["2483"] = {["id"] = 18169, ["type"] = "item"},
		["2484"] = {["id"] = 18170, ["type"] = "item"},
		["2485"] = {["id"] = 18171, ["type"] = "item"},
		["2486"] = {["id"] = 18172, ["type"] = "item"},
		["2487"] = {["id"] = 18173, ["type"] = "item"},
		["2488"] = {["id"] = 18182, ["type"] = "item"},
		["2503"] = {["id"] = 18251, ["type"] = "item"},
		["2523"] = {["id"] = 18283, ["type"] = "item"},
		["2543"] = {["id"] = 18329, ["type"] = "item"},
		["2544"] = {["id"] = 18330, ["type"] = "item"},
		["2545"] = {["id"] = 18331, ["type"] = "item"},
		["2583"] = {["id"] = 19782, ["type"] = "item"},
		["2584"] = {["id"] = 19783, ["type"] = "item"},
		["3755"] = {["id"] = 19784, ["type"] = "item"},
		["3754"] = {["id"] = 19785, ["type"] = "item"},
		["2587"] = {["id"] = 19786, ["type"] = "item"},
		["2588"] = {["id"] = 19787, ["type"] = "item"},
		["2589"] = {["id"] = 19788, ["type"] = "item"},
		["2590"] = {["id"] = 19789, ["type"] = "item"},
		["2591"] = {["id"] = 19790, ["type"] = "item"},
		["846"] = {["id"] = 19971, ["type"] = "item"},
		["2605"] = {["id"] = 20076, ["type"] = "item"},
		["2606"] = {["id"] = 20077, ["type"] = "item"},
		["2604"] = {["id"] = 20078, ["type"] = "item"},
		["2681"] = {["id"] = 22635, ["type"] = "item"},
		["2682"] = {["id"] = 22636, ["type"] = "item"},
		["2683"] = {["id"] = 22638, ["type"] = "item"},
		["2714"] = {["id"] = 23530, ["type"] = "item"},
		["2721"] = {["id"] = 23545, ["type"] = "item"},
		["2715"] = {["id"] = 23547, ["type"] = "item"},
		["2717"] = {["id"] = 23548, ["type"] = "item"},
		["2716"] = {["id"] = 23549, ["type"] = "item"},
		["2722"] = {["id"] = 23764, ["type"] = "item"},
		["2723"] = {["id"] = 23765, ["type"] = "item"},
		["2724"] = {["id"] = 23766, ["type"] = "item"},
		["2747"] = {["id"] = 24273, ["type"] = "item"},
		["2748"] = {["id"] = 24274, ["type"] = "item"},
		["2745"] = {["id"] = 24275, ["type"] = "item"},
		["2746"] = {["id"] = 24276, ["type"] = "item"},
		["2792"] = {["id"] = 25650, ["type"] = "item"},
		["2793"] = {["id"] = 25651, ["type"] = "item"},
		["2794"] = {["id"] = 25652, ["type"] = "item"},
		["2979"] = {["id"] = 28878, ["type"] = "item"},
		["2981"] = {["id"] = 28881, ["type"] = "item"},
		["2977"] = {["id"] = 28882, ["type"] = "item"},
		["2983"] = {["id"] = 28885, ["type"] = "item"},
		["2982"] = {["id"] = 28886, ["type"] = "item"},
		["2980"] = {["id"] = 28887, ["type"] = "item"},
		["2986"] = {["id"] = 28888, ["type"] = "item"},
		["2978"] = {["id"] = 28889, ["type"] = "item"},
		["2994"] = {["id"] = 28903, ["type"] = "item"},
		["2992"] = {["id"] = 28904, ["type"] = "item"},
		["2996"] = {["id"] = 28907, ["type"] = "item"},
		["2990"] = {["id"] = 28908, ["type"] = "item"},
		["2995"] = {["id"] = 28909, ["type"] = "item"},
		["2997"] = {["id"] = 28910, ["type"] = "item"},
		["2991"] = {["id"] = 28911, ["type"] = "item"},
		["2993"] = {["id"] = 28912, ["type"] = "item"},
		["2999"] = {["id"] = 29186, ["type"] = "item"},
		["2998"] = {["id"] = 29187, ["type"] = "item"},
		["3001"] = {["id"] = 29189, ["type"] = "item"},
		["3001"] = {["id"] = 29190, ["type"] = "item"},
		["3002"] = {["id"] = 29191, ["type"] = "item"},
		["3003"] = {["id"] = 29192, ["type"] = "item"},
		["3004"] = {["id"] = 29193, ["type"] = "item"},
		["3005"] = {["id"] = 29194, ["type"] = "item"},
		["3006"] = {["id"] = 29195, ["type"] = "item"},
		["3007"] = {["id"] = 29196, ["type"] = "item"},
		["3007"] = {["id"] = 29197, ["type"] = "item"},
		["3008"] = {["id"] = 29198, ["type"] = "item"},
		["3009"] = {["id"] = 29199, ["type"] = "item"},
		["2984"] = {["id"] = 29483, ["type"] = "item"},
		["2985"] = {["id"] = 29485, ["type"] = "item"},
		["2987"] = {["id"] = 29486, ["type"] = "item"},
		["2988"] = {["id"] = 29487, ["type"] = "item"},
		["2989"] = {["id"] = 29488, ["type"] = "item"},
		["3010"] = {["id"] = 29533, ["type"] = "item"},
		["3011"] = {["id"] = 29534, ["type"] = "item"},
		["3012"] = {["id"] = 29535, ["type"] = "item"},
		["3013"] = {["id"] = 29536, ["type"] = "item"},
		["3096"] = {["id"] = 30846, ["type"] = "item"},
		["3223"] = {["id"] = 33185, ["type"] = "item"},
		["3260"] = {["id"] = 34207, ["type"] = "item"},
		["2841"] = {["id"] = 34330, ["type"] = "item"},
		["3269"] = {["id"] = 34836, ["type"] = "item"},
		["3315"] = {["id"] = 37312, ["type"] = "item"},
		["2657"] = {["id"] = 37603, ["type"] = "item"},
		["3325"] = {["id"] = 38371, ["type"] = "item"},
		["3326"] = {["id"] = 38372, ["type"] = "item"},
		["3822"] = {["id"] = 38373, ["type"] = "item"},
		["3823"] = {["id"] = 38374, ["type"] = "item"},
		["3329"] = {["id"] = 38375, ["type"] = "item"},
		["3330"] = {["id"] = 38376, ["type"] = "item"},
		["41"] = {["id"] = 38679, ["type"] = "item"},
		["41"] = {["id"] = 38766, ["type"] = "item"},
		["44"] = {["id"] = 38767, ["type"] = "item"},
		["924"] = {["id"] = 38768, ["type"] = "item"},
		["24"] = {["id"] = 38769, ["type"] = "item"},
		["65"] = {["id"] = 38770, ["type"] = "item"},
		["66"] = {["id"] = 38771, ["type"] = "item"},
		["241"] = {["id"] = 38772, ["type"] = "item"},
		["242"] = {["id"] = 38773, ["type"] = "item"},
		["243"] = {["id"] = 38774, ["type"] = "item"},
		["783"] = {["id"] = 38775, ["type"] = "item"},
		["246"] = {["id"] = 38776, ["type"] = "item"},
		["247"] = {["id"] = 38777, ["type"] = "item"},
		["248"] = {["id"] = 38778, ["type"] = "item"},
		["249"] = {["id"] = 38779, ["type"] = "item"},
		["250"] = {["id"] = 38780, ["type"] = "item"},
		["723"] = {["id"] = 38781, ["type"] = "item"},
		["254"] = {["id"] = 38782, ["type"] = "item"},
		["255"] = {["id"] = 38783, ["type"] = "item"},
		["256"] = {["id"] = 38784, ["type"] = "item"},
		["66"] = {["id"] = 38785, ["type"] = "item"},
		["247"] = {["id"] = 38786, ["type"] = "item"},
		["66"] = {["id"] = 38787, ["type"] = "item"},
		["255"] = {["id"] = 38788, ["type"] = "item"},
		["247"] = {["id"] = 38789, ["type"] = "item"},
		["744"] = {["id"] = 38790, ["type"] = "item"},
		["848"] = {["id"] = 38791, ["type"] = "item"},
		["255"] = {["id"] = 38792, ["type"] = "item"},
		["724"] = {["id"] = 38793, ["type"] = "item"},
		["241"] = {["id"] = 38794, ["type"] = "item"},
		["804"] = {["id"] = 38795, ["type"] = "item"},
		["943"] = {["id"] = 38796, ["type"] = "item"},
		["823"] = {["id"] = 38797, ["type"] = "item"},
		["63"] = {["id"] = 38798, ["type"] = "item"},
		["843"] = {["id"] = 38799, ["type"] = "item"},
		["844"] = {["id"] = 38800, ["type"] = "item"},
		["845"] = {["id"] = 38801, ["type"] = "item"},
		["2603"] = {["id"] = 38802, ["type"] = "item"},
		["723"] = {["id"] = 38803, ["type"] = "item"},
		["847"] = {["id"] = 38804, ["type"] = "item"},
		["724"] = {["id"] = 38805, ["type"] = "item"},
		["848"] = {["id"] = 38806, ["type"] = "item"},
		["849"] = {["id"] = 38807, ["type"] = "item"},
		["850"] = {["id"] = 38808, ["type"] = "item"},
		["851"] = {["id"] = 38809, ["type"] = "item"},
		["724"] = {["id"] = 38810, ["type"] = "item"},
		["925"] = {["id"] = 38811, ["type"] = "item"},
		["852"] = {["id"] = 38812, ["type"] = "item"},
		["853"] = {["id"] = 38813, ["type"] = "item"},
		["854"] = {["id"] = 38814, ["type"] = "item"},
		["2463"] = {["id"] = 38815, ["type"] = "item"},
		["851"] = {["id"] = 38816, ["type"] = "item"},
		["856"] = {["id"] = 38817, ["type"] = "item"},
		["857"] = {["id"] = 38818, ["type"] = "item"},
		["255"] = {["id"] = 38819, ["type"] = "item"},
		["863"] = {["id"] = 38820, ["type"] = "item"},
		["943"] = {["id"] = 38821, ["type"] = "item"},
		["1897"] = {["id"] = 38822, ["type"] = "item"},
		["865"] = {["id"] = 38823, ["type"] = "item"},
		["866"] = {["id"] = 38824, ["type"] = "item"},
		["884"] = {["id"] = 38825, ["type"] = "item"},
		["903"] = {["id"] = 38826, ["type"] = "item"},
		["904"] = {["id"] = 38827, ["type"] = "item"},
		["852"] = {["id"] = 38828, ["type"] = "item"},
		["905"] = {["id"] = 38829, ["type"] = "item"},
		["852"] = {["id"] = 38830, ["type"] = "item"},
		["906"] = {["id"] = 38831, ["type"] = "item"},
		["907"] = {["id"] = 38832, ["type"] = "item"},
		["908"] = {["id"] = 38833, ["type"] = "item"},
		["909"] = {["id"] = 38834, ["type"] = "item"},
		["849"] = {["id"] = 38835, ["type"] = "item"},
		["856"] = {["id"] = 38836, ["type"] = "item"},
		["911"] = {["id"] = 38837, ["type"] = "item"},
		["803"] = {["id"] = 38838, ["type"] = "item"},
		["907"] = {["id"] = 38839, ["type"] = "item"},
		["912"] = {["id"] = 38840, ["type"] = "item"},
		["913"] = {["id"] = 38841, ["type"] = "item"},
		["923"] = {["id"] = 38842, ["type"] = "item"},
		["926"] = {["id"] = 38843, ["type"] = "item"},
		["904"] = {["id"] = 38844, ["type"] = "item"},
		["963"] = {["id"] = 38845, ["type"] = "item"},
		["927"] = {["id"] = 38846, ["type"] = "item"},
		["928"] = {["id"] = 38847, ["type"] = "item"},
		["805"] = {["id"] = 38848, ["type"] = "item"},
		["929"] = {["id"] = 38849, ["type"] = "item"},
		["930"] = {["id"] = 38850, ["type"] = "item"},
		["931"] = {["id"] = 38851, ["type"] = "item"},
		["1883"] = {["id"] = 38852, ["type"] = "item"},
		["1884"] = {["id"] = 38853, ["type"] = "item"},
		["1885"] = {["id"] = 38854, ["type"] = "item"},
		["1886"] = {["id"] = 38855, ["type"] = "item"},
		["1887"] = {["id"] = 38856, ["type"] = "item"},
		["927"] = {["id"] = 38857, ["type"] = "item"},
		["1888"] = {["id"] = 38858, ["type"] = "item"},
		["1889"] = {["id"] = 38859, ["type"] = "item"},
		["1890"] = {["id"] = 38860, ["type"] = "item"},
		["929"] = {["id"] = 38861, ["type"] = "item"},
		["929"] = {["id"] = 38862, ["type"] = "item"},
		["1887"] = {["id"] = 38863, ["type"] = "item"},
		["851"] = {["id"] = 38864, ["type"] = "item"},
		["1891"] = {["id"] = 38865, ["type"] = "item"},
		["1892"] = {["id"] = 38866, ["type"] = "item"},
		["1893"] = {["id"] = 38867, ["type"] = "item"},
		["1894"] = {["id"] = 38868, ["type"] = "item"},
		["1896"] = {["id"] = 38869, ["type"] = "item"},
		["1897"] = {["id"] = 38870, ["type"] = "item"},
		["1898"] = {["id"] = 38871, ["type"] = "item"},
		["1899"] = {["id"] = 38872, ["type"] = "item"},
		["1900"] = {["id"] = 38873, ["type"] = "item"},
		["1903"] = {["id"] = 38874, ["type"] = "item"},
		["1904"] = {["id"] = 38875, ["type"] = "item"},
		["2443"] = {["id"] = 38876, ["type"] = "item"},
		["2504"] = {["id"] = 38877, ["type"] = "item"},
		["2505"] = {["id"] = 38878, ["type"] = "item"},
		["2563"] = {["id"] = 38879, ["type"] = "item"},
		["2564"] = {["id"] = 38880, ["type"] = "item"},
		["2565"] = {["id"] = 38881, ["type"] = "item"},
		["2650"] = {["id"] = 38882, ["type"] = "item"},
		["2567"] = {["id"] = 38883, ["type"] = "item"},
		["2568"] = {["id"] = 38884, ["type"] = "item"},
		["2613"] = {["id"] = 38885, ["type"] = "item"},
		["2614"] = {["id"] = 38886, ["type"] = "item"},
		["2615"] = {["id"] = 38887, ["type"] = "item"},
		["2616"] = {["id"] = 38888, ["type"] = "item"},
		["2617"] = {["id"] = 38889, ["type"] = "item"},
		["2564"] = {["id"] = 38890, ["type"] = "item"},
		["2619"] = {["id"] = 38891, ["type"] = "item"},
		["2620"] = {["id"] = 38892, ["type"] = "item"},
		["910"] = {["id"] = 38893, ["type"] = "item"},
		["2621"] = {["id"] = 38894, ["type"] = "item"},
		["2622"] = {["id"] = 38895, ["type"] = "item"},
		["2646"] = {["id"] = 38896, ["type"] = "item"},
		["2647"] = {["id"] = 38897, ["type"] = "item"},
		["1891"] = {["id"] = 38898, ["type"] = "item"},
		["2648"] = {["id"] = 38899, ["type"] = "item"},
		["2650"] = {["id"] = 38900, ["type"] = "item"},
		["2679"] = {["id"] = 38901, ["type"] = "item"},
		["2649"] = {["id"] = 38902, ["type"] = "item"},
		["2650"] = {["id"] = 38903, ["type"] = "item"},
		["2653"] = {["id"] = 38904, ["type"] = "item"},
		["2654"] = {["id"] = 38905, ["type"] = "item"},
		["2655"] = {["id"] = 38906, ["type"] = "item"},
		["1888"] = {["id"] = 38907, ["type"] = "item"},
		["2656"] = {["id"] = 38908, ["type"] = "item"},
		["2649"] = {["id"] = 38909, ["type"] = "item"},
		["2658"] = {["id"] = 38910, ["type"] = "item"},
		["2659"] = {["id"] = 38911, ["type"] = "item"},
		["3233"] = {["id"] = 38912, ["type"] = "item"},
		["2661"] = {["id"] = 38913, ["type"] = "item"},
		["2662"] = {["id"] = 38914, ["type"] = "item"},
		["2664"] = {["id"] = 38915, ["type"] = "item"},
		["963"] = {["id"] = 38917, ["type"] = "item"},
		["2666"] = {["id"] = 38918, ["type"] = "item"},
		["2667"] = {["id"] = 38919, ["type"] = "item"},
		["2668"] = {["id"] = 38920, ["type"] = "item"},
		["2669"] = {["id"] = 38921, ["type"] = "item"},
		["2670"] = {["id"] = 38922, ["type"] = "item"},
		["2671"] = {["id"] = 38923, ["type"] = "item"},
		["2672"] = {["id"] = 38924, ["type"] = "item"},
		["2673"] = {["id"] = 38925, ["type"] = "item"},
		["2674"] = {["id"] = 38926, ["type"] = "item"},
		["2675"] = {["id"] = 38927, ["type"] = "item"},
		["1144"] = {["id"] = 38928, ["type"] = "item"},
		["3150"] = {["id"] = 38929, ["type"] = "item"},
		["2933"] = {["id"] = 38930, ["type"] = "item"},
		["2934"] = {["id"] = 38931, ["type"] = "item"},
		["2935"] = {["id"] = 38932, ["type"] = "item"},
		["684"] = {["id"] = 38933, ["type"] = "item"},
		["1594"] = {["id"] = 38934, ["type"] = "item"},
		["2937"] = {["id"] = 38935, ["type"] = "item"},
		["2322"] = {["id"] = 38936, ["type"] = "item"},
		["369"] = {["id"] = 38937, ["type"] = "item"},
		["1593"] = {["id"] = 38938, ["type"] = "item"},
		["2938"] = {["id"] = 38939, ["type"] = "item"},
		["368"] = {["id"] = 38940, ["type"] = "item"},
		["1257"] = {["id"] = 38941, ["type"] = "item"},
		["1441"] = {["id"] = 38942, ["type"] = "item"},
		["2939"] = {["id"] = 38943, ["type"] = "item"},
		["2940"] = {["id"] = 38944, ["type"] = "item"},
		["1071"] = {["id"] = 38945, ["type"] = "item"},
		["3846"] = {["id"] = 38946, ["type"] = "item"},
		["3222"] = {["id"] = 38947, ["type"] = "item"},
		["3225"] = {["id"] = 38948, ["type"] = "item"},
		["3229"] = {["id"] = 38949, ["type"] = "item"},
		["3230"] = {["id"] = 38950, ["type"] = "item"},
		["3231"] = {["id"] = 38951, ["type"] = "item"},
		["3234"] = {["id"] = 38953, ["type"] = "item"},
		["1952"] = {["id"] = 38954, ["type"] = "item"},
		["3236"] = {["id"] = 38955, ["type"] = "item"},
		["1400"] = {["id"] = 38956, ["type"] = "item"},
		["983"] = {["id"] = 38959, ["type"] = "item"},
		["3238"] = {["id"] = 38960, ["type"] = "item"},
		["1147"] = {["id"] = 38961, ["type"] = "item"},
		["2381"] = {["id"] = 38962, ["type"] = "item"},
		["3844"] = {["id"] = 38963, ["type"] = "item"},
		["3829"] = {["id"] = 38964, ["type"] = "item"},
		["3239"] = {["id"] = 38965, ["type"] = "item"},
		["1075"] = {["id"] = 38966, ["type"] = "item"},
		["3222"] = {["id"] = 38967, ["type"] = "item"},
		["1119"] = {["id"] = 38968, ["type"] = "item"},
		["1354"] = {["id"] = 38969, ["type"] = "item"},
		["1600"] = {["id"] = 38971, ["type"] = "item"},
		["3241"] = {["id"] = 38972, ["type"] = "item"},
		["3243"] = {["id"] = 38973, ["type"] = "item"},
		["3244"] = {["id"] = 38974, ["type"] = "item"},
		["3245"] = {["id"] = 38975, ["type"] = "item"},
		["983"] = {["id"] = 38976, ["type"] = "item"},
		["1446"] = {["id"] = 38977, ["type"] = "item"},
		["1951"] = {["id"] = 38978, ["type"] = "item"},
		["3246"] = {["id"] = 38979, ["type"] = "item"},
		["1147"] = {["id"] = 38980, ["type"] = "item"},
		["3247"] = {["id"] = 38981, ["type"] = "item"},
		["1262"] = {["id"] = 38982, ["type"] = "item"},
		["3231"] = {["id"] = 38984, ["type"] = "item"},
		["3826"] = {["id"] = 38986, ["type"] = "item"},
		["2661"] = {["id"] = 38987, ["type"] = "item"},
		["3251"] = {["id"] = 38988, ["type"] = "item"},
		["3252"] = {["id"] = 38989, ["type"] = "item"},
		["3253"] = {["id"] = 38990, ["type"] = "item"},
		["3830"] = {["id"] = 38991, ["type"] = "item"},
		["3828"] = {["id"] = 38992, ["type"] = "item"},
		["3256"] = {["id"] = 38993, ["type"] = "item"},
		["1103"] = {["id"] = 38995, ["type"] = "item"},
		["2326"] = {["id"] = 38997, ["type"] = "item"},
		["3273"] = {["id"] = 38998, ["type"] = "item"},
		["1951"] = {["id"] = 38999, ["type"] = "item"},
		["2648"] = {["id"] = 39000, ["type"] = "item"},
		["3294"] = {["id"] = 39001, ["type"] = "item"},
		["1953"] = {["id"] = 39002, ["type"] = "item"},
		["3831"] = {["id"] = 39003, ["type"] = "item"},
		["3296"] = {["id"] = 39004, ["type"] = "item"},
		["3297"] = {["id"] = 39005, ["type"] = "item"},
		["3232"] = {["id"] = 39006, ["type"] = "item"},
		["3607"] = {["id"] = 41146, ["type"] = "item"},
		["3608"] = {["id"] = 41167, ["type"] = "item"},
		["3718"] = {["id"] = 41601, ["type"] = "item"},
		["3719"] = {["id"] = 41602, ["type"] = "item"},
		["3720"] = {["id"] = 41603, ["type"] = "item"},
		["3721"] = {["id"] = 41604, ["type"] = "item"},
		["3729"] = {["id"] = 41611, ["type"] = "item"},
		["3731"] = {["id"] = 41976, ["type"] = "item"},
		["3748"] = {["id"] = 42500, ["type"] = "item"},
		["3790"] = {["id"] = 43987, ["type"] = "item"},
		["3793"] = {["id"] = 44067, ["type"] = "item"},
		["3794"] = {["id"] = 44068, ["type"] = "item"},
		["3795"] = {["id"] = 44069, ["type"] = "item"},
		["3797"] = {["id"] = 44075, ["type"] = "item"},
		["3806"] = {["id"] = 44129, ["type"] = "item"},
		["3807"] = {["id"] = 44130, ["type"] = "item"},
		["3875"] = {["id"] = 44131, ["type"] = "item"},
		["3876"] = {["id"] = 44132, ["type"] = "item"},
		["3808"] = {["id"] = 44133, ["type"] = "item"},
		["3809"] = {["id"] = 44134, ["type"] = "item"},
		["3810"] = {["id"] = 44135, ["type"] = "item"},
		["3811"] = {["id"] = 44136, ["type"] = "item"},
		["3812"] = {["id"] = 44137, ["type"] = "item"},
		["3813"] = {["id"] = 44138, ["type"] = "item"},
		["3814"] = {["id"] = 44139, ["type"] = "item"},
		["3815"] = {["id"] = 44140, ["type"] = "item"},
		["3816"] = {["id"] = 44141, ["type"] = "item"},
		["3817"] = {["id"] = 44149, ["type"] = "item"},
		["3818"] = {["id"] = 44150, ["type"] = "item"},
		["3819"] = {["id"] = 44152, ["type"] = "item"},
		["3820"] = {["id"] = 44159, ["type"] = "item"},
		["3824"] = {["id"] = 44449, ["type"] = "item"},
		["1606"] = {["id"] = 44453, ["type"] = "item"},
		["1128"] = {["id"] = 44455, ["type"] = "item"},
		["3825"] = {["id"] = 44456, ["type"] = "item"},
		["1099"] = {["id"] = 44457, ["type"] = "item"},
		["1603"] = {["id"] = 44458, ["type"] = "item"},
		["3827"] = {["id"] = 44463, ["type"] = "item"},
		["3832"] = {["id"] = 44465, ["type"] = "item"},
		["3833"] = {["id"] = 44466, ["type"] = "item"},
		["3834"] = {["id"] = 44467, ["type"] = "item"},
		["1597"] = {["id"] = 44469, ["type"] = "item"},
		["2332"] = {["id"] = 44470, ["type"] = "item"},
		["3789"] = {["id"] = 44493, ["type"] = "item"},
		["3788"] = {["id"] = 44497, ["type"] = "item"},
		["3759"] = {["id"] = 44559, ["type"] = "item"},
		["3760"] = {["id"] = 44560, ["type"] = "item"},
		["3761"] = {["id"] = 44561, ["type"] = "item"},
		["3762"] = {["id"] = 44562, ["type"] = "item"},
		["3763"] = {["id"] = 44563, ["type"] = "item"},
		["3842"] = {["id"] = 44701, ["type"] = "item"},
		["3842"] = {["id"] = 44702, ["type"] = "item"},
		["3843"] = {["id"] = 44739, ["type"] = "item"},
		["3845"] = {["id"] = 44815, ["type"] = "item"},
		["3849"] = {["id"] = 44936, ["type"] = "item"},
		["3850"] = {["id"] = 44947, ["type"] = "item"},
		["3852"] = {["id"] = 44957, ["type"] = "item"},
		["3853"] = {["id"] = 44963, ["type"] = "item"},
		["3854"] = {["id"] = 45056, ["type"] = "item"},
		["3855"] = {["id"] = 45060, ["type"] = "item"},
		["3858"] = {["id"] = 45628, ["type"] = "item"},
		["3869"] = {["id"] = 46026, ["type"] = "item"},
		["3870"] = {["id"] = 46098, ["type"] = "item"},
		["3808"] = {["id"] = 50335, ["type"] = "item"},
		["3809"] = {["id"] = 50336, ["type"] = "item"},
		["3811"] = {["id"] = 50337, ["type"] = "item"},
		["3810"] = {["id"] = 50338, ["type"] = "item"},
		["3817"] = {["id"] = 50367, ["type"] = "item"},
		["3820"] = {["id"] = 50368, ["type"] = "item"},
		["3818"] = {["id"] = 50369, ["type"] = "item"},
		["3819"] = {["id"] = 50370, ["type"] = "item"},
		["3842"] = {["id"] = 50372, ["type"] = "item"},
		["3842"] = {["id"] = 50373, ["type"] = "item"},
		["846"] = {["id"] = 50816, ["type"] = "item"},
		["4061"] = {["id"] = 52687, ["type"] = "item"},
		["4062"] = {["id"] = 52743, ["type"] = "item"},
		["4063"] = {["id"] = 52744, ["type"] = "item"},
		["4064"] = {["id"] = 52745, ["type"] = "item"},
		["4065"] = {["id"] = 52746, ["type"] = "item"},
		["4066"] = {["id"] = 52747, ["type"] = "item"},
		["4067"] = {["id"] = 52748, ["type"] = "item"},
		["4068"] = {["id"] = 52749, ["type"] = "item"},
		["4069"] = {["id"] = 52750, ["type"] = "item"},
		["4070"] = {["id"] = 52751, ["type"] = "item"},
		["4071"] = {["id"] = 52752, ["type"] = "item"},
		["4072"] = {["id"] = 52753, ["type"] = "item"},
		["4073"] = {["id"] = 52754, ["type"] = "item"},
		["4074"] = {["id"] = 52755, ["type"] = "item"},
		["4075"] = {["id"] = 52756, ["type"] = "item"},
		["4076"] = {["id"] = 52757, ["type"] = "item"},
		["4077"] = {["id"] = 52758, ["type"] = "item"},
		["4082"] = {["id"] = 52759, ["type"] = "item"},
		["4083"] = {["id"] = 52760, ["type"] = "item"},
		["4084"] = {["id"] = 52761, ["type"] = "item"},
		["4085"] = {["id"] = 52762, ["type"] = "item"},
		["4086"] = {["id"] = 52763, ["type"] = "item"},
		["4087"] = {["id"] = 52764, ["type"] = "item"},
		["4088"] = {["id"] = 52765, ["type"] = "item"},
		["4089"] = {["id"] = 52766, ["type"] = "item"},
		["4090"] = {["id"] = 52767, ["type"] = "item"},
		["4091"] = {["id"] = 52768, ["type"] = "item"},
		["4092"] = {["id"] = 52769, ["type"] = "item"},
		["4093"] = {["id"] = 52770, ["type"] = "item"},
		["4094"] = {["id"] = 52771, ["type"] = "item"},
		["4095"] = {["id"] = 52772, ["type"] = "item"},
		["4096"] = {["id"] = 52773, ["type"] = "item"},
		["4097"] = {["id"] = 52774, ["type"] = "item"},
		["4098"] = {["id"] = 52775, ["type"] = "item"},
		["4099"] = {["id"] = 52776, ["type"] = "item"},
		["4100"] = {["id"] = 52777, ["type"] = "item"},
		["4101"] = {["id"] = 52778, ["type"] = "item"},
		["4102"] = {["id"] = 52779, ["type"] = "item"},
		["4103"] = {["id"] = 52780, ["type"] = "item"},
		["4105"] = {["id"] = 52781, ["type"] = "item"},
		["4104"] = {["id"] = 52782, ["type"] = "item"},
		["4106"] = {["id"] = 52783, ["type"] = "item"},
		["4107"] = {["id"] = 52784, ["type"] = "item"},
		["4108"] = {["id"] = 52785, ["type"] = "item"},
		["4111"] = {["id"] = 54447, ["type"] = "item"},
		["4112"] = {["id"] = 54448, ["type"] = "item"},
		["4109"] = {["id"] = 54449, ["type"] = "item"},
		["4110"] = {["id"] = 54450, ["type"] = "item"},
		["3729"] = {["id"] = 55054, ["type"] = "item"},
		["4215"] = {["id"] = 55055, ["type"] = "item"},
		["4216"] = {["id"] = 55056, ["type"] = "item"},
		["4217"] = {["id"] = 55057, ["type"] = "item"},
		["4120"] = {["id"] = 56477, ["type"] = "item"},
		["4122"] = {["id"] = 56502, ["type"] = "item"},
		["4124"] = {["id"] = 56503, ["type"] = "item"},
		["4121"] = {["id"] = 56517, ["type"] = "item"},
		["4126"] = {["id"] = 56550, ["type"] = "item"},
		["4127"] = {["id"] = 56551, ["type"] = "item"},
		["4175"] = {["id"] = 59594, ["type"] = "item"},
		["4176"] = {["id"] = 59595, ["type"] = "item"},
		["4177"] = {["id"] = 59596, ["type"] = "item"},
		["4197"] = {["id"] = 62321, ["type"] = "item"},
		["4198"] = {["id"] = 62333, ["type"] = "item"},
		["4199"] = {["id"] = 62342, ["type"] = "item"},
		["4200"] = {["id"] = 62343, ["type"] = "item"},
		["4201"] = {["id"] = 62344, ["type"] = "item"},
		["4202"] = {["id"] = 62345, ["type"] = "item"},
		["4204"] = {["id"] = 62346, ["type"] = "item"},
		["4205"] = {["id"] = 62347, ["type"] = "item"},
		["4206"] = {["id"] = 62366, ["type"] = "item"},
		["4207"] = {["id"] = 62367, ["type"] = "item"},
		["4208"] = {["id"] = 62368, ["type"] = "item"},
		["4209"] = {["id"] = 62369, ["type"] = "item"},
		["4208"] = {["id"] = 62422, ["type"] = "item"},
		["4227"] = {["id"] = 68134, ["type"] = "item"},
		["4204"] = {["id"] = 68714, ["type"] = "item"},
		["4200"] = {["id"] = 68715, ["type"] = "item"},
		["4202"] = {["id"] = 68716, ["type"] = "item"},
		["4198"] = {["id"] = 68717, ["type"] = "item"},
		["4206"] = {["id"] = 68718, ["type"] = "item"},
		["4207"] = {["id"] = 68719, ["type"] = "item"},
		["4208"] = {["id"] = 68720, ["type"] = "item"},
		["4209"] = {["id"] = 68721, ["type"] = "item"},
		["4208"] = {["id"] = 68722, ["type"] = "item"},
		["4208"] = {["id"] = 68763, ["type"] = "item"},
		["4206"] = {["id"] = 68764, ["type"] = "item"},
		["4207"] = {["id"] = 68765, ["type"] = "item"},
		["4209"] = {["id"] = 68766, ["type"] = "item"},
		["4208"] = {["id"] = 68767, ["type"] = "item"},
		["4247"] = {["id"] = 68768, ["type"] = "item"},
		["4246"] = {["id"] = 68769, ["type"] = "item"},
		["4245"] = {["id"] = 68770, ["type"] = "item"},
		["4248"] = {["id"] = 68772, ["type"] = "item"},
		["4249"] = {["id"] = 68773, ["type"] = "item"},
		["4250"] = {["id"] = 68774, ["type"] = "item"},
		["4258"] = {["id"] = 68784, ["type"] = "item"},
		["4256"] = {["id"] = 68785, ["type"] = "item"},
		["4257"] = {["id"] = 68786, ["type"] = "item"},
		["4259"] = {["id"] = 68796, ["type"] = "item"},
		["4250"] = {["id"] = 68815, ["type"] = "item"},
		["4267"] = {["id"] = 70139, ["type"] = "item"},
		["427"] = {["id"] = 71720, ["type"] = "item"},
		["4192"] = {["id"] = 85010, ["type"] = "spell"},
		["3723"] = {["id"] = 55641, ["type"] = "spell"},
		["3717"] = {["id"] = 55628, ["type"] = "spell"},
		["4079"] = {["id"] = 74216, ["type"] = "spell"},
		["4081"] = {["id"] = 74218, ["type"] = "spell"},
		["4080"] = {["id"] = 74217, ["type"] = "spell"},
		["4078"] = {["id"] = 74215, ["type"] = "spell"},
		["3839"] = {["id"] = 44645, ["type"] = "spell"},
		["3840"] = {["id"] = 44636, ["type"] = "spell"},
		["3791"] = {["id"] = 59636, ["type"] = "spell"},
		["4196"] = {["id"] = 86403, ["type"] = "spell"},
		["4195"] = {["id"] = 86402, ["type"] = "spell"},
		["4194"] = {["id"] = 86401, ["type"] = "spell"},
		["3835"] = {["id"] = 61117, ["type"] = "spell"},
		["3836"] = {["id"] = 61118, ["type"] = "spell"},
		["3837"] = {["id"] = 61119, ["type"] = "spell"},
		["3838"] = {["id"] = 61120, ["type"] = "spell"},
		["4193"] = {["id"] = 86375, ["type"] = "spell"},
		["3728"] = {["id"] = 55769, ["type"] = "spell"},
		["4116"] = {["id"] = 75175, ["type"] = "spell"},
		["3722"] = {["id"] = 55642, ["type"] = "spell"},
		["4115"] = {["id"] = 75172, ["type"] = "spell"},
		["3730"] = {["id"] = 55777, ["type"] = "spell"},
		["4118"] = {["id"] = 75178, ["type"] = "spell"},
		["2747"] = {["id"] = 31430, ["type"] = "spell"},
		["3873"] = {["id"] = 56034, ["type"] = "spell"},
		["4113"] = {["id"] = 75154, ["type"] = "spell"},
		["3872"] = {["id"] = 56039, ["type"] = "spell"},
		["4114"] = {["id"] = 75155, ["type"] = "spell"},
		["3720"] = {["id"] = 55632, ["type"] = "spell"},
		["4111"] = {["id"] = 75151, ["type"] = "spell"},
		["4109"] = {["id"] = 75149, ["type"] = "spell"},
		["3718"] = {["id"] = 55630, ["type"] = "spell"},
	}
end

