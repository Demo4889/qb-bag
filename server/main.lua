local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("duffel-bag", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('qb-items:client:use:duffel-bag', source, item.info.bagid)
    end
end)

-- Purchase Events for Bag to add bagid
-- Trigger this event in a client menu etc...
RegisterServerEvent('qb-items:server:buy_duffelbag', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    info = {bagid = math.random(11111,99999)}
    local BagPrice = 500
    if Player.PlayerData.money.cash >= BagPrice then
        Player.Functions.RemoveMoney('cash', BagPrice)
        Player.Functions.AddItem("duffel-bag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["duffel-bag"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You purchased a laptop for "..BagPrice, "success", 3000)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash.", "error", 3000)
    end
end)