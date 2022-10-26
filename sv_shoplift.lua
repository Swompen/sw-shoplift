local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("sw-shoplift:server:giveItem",function()
    local chance = math.random(100)
    if chance <= 30 then TriggerClientEvent('QBCore:Notify', source, Config.Translations.NothingFound, "error") return end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randomItem = Config.Rewards[math.random(1, #Config.Rewards)]
    local amount = math.random(1, 4)
    Player.Functions.AddItem(randomItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], "add")
end)