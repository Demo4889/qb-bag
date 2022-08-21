local QBCore = exports['qb-core']:GetCoreObject()

local item = "duffel-bag"
local clothingitem = false
local maxweight = 18000

RegisterNetEvent('qb-bag:client:use:duffel-bag', function(BagId)
	local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_bag", "Opening Bag...", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
		RequestAnimDict(dict)
		TaskPlayAnim(ped, "clothingtie", "try_tie_negative_a", 3.0, 3.0, 2000, 51, 0, false, false, false)
		Wait (600)
		ClearPedSecondaryTask(ped)
		TriggerServerEvent("inventory:server:OpenInventory", "stash", 'bag_'..BagId, {maxweight = maxweight, slots = 10})
		TriggerEvent("inventory:client:SetCurrentStash", 'bag_'..BagId)
	end)
	Wait(1000)
end)

CreateThread(function()
	while true do
		Wait(0)
		if LocalPlayer.state.isLoggedIn then
			local bag = math.random(1, #Config.BagTextures)
			for k,v in pairs(Config.BagTextures) do
				currentBag = k
				if currentBag == bag then
					bagId = v.bagId
					textureId = v.textureId
				end
			end
			break
		end
	end
end)

CreateThread(function()
	while true do
		Wait(3000)
		if LocalPlayer.state.isLoggedIn then
			local ped = PlayerPedId()

			QBCore.Functions.HasItem(item, function(result)
				if result then
					SetPedComponentVariation(ped, 5, bagId, textureId, 2)
				else
					SetPedComponentVariation(ped, 5, 0, 0, 2)
				end
			end)
		end
	end
end)
