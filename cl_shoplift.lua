local QBCore = exports['qb-core']:GetCoreObject()
local timeOut = false

local function InitZones()
    for k,v in pairs(Config.TargetLocations) do
        exports["qb-target"]:AddBoxZone("snatta_"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 1.7, 1.0, {
            name = "snatta_"..k,
            heading = v.coords.w,
            minZ = v.coords.z - 1,
            maxZ = v.coords.z + 1,
            debugPoly = false,
        }, {
            options = {
                {
                    icon = 'fas fa-user-secret',
                    label = Config.Translations.Target,
                    event = "sw-shoplift:client:startShoplift",
                },
            },
            distance = 1.5
        })
    end
end

local function AttemptPoliceAlert()
    if not AlertSend then
        local chance = Config.PoliceAlertChance
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = Config.PoliceNightAlertChance
        end
        if math.random() <= chance then
            TriggerServerEvent('police:server:policeAlert', Config.Translations.PoliceAlertMessage)
        end
        AlertSend = true
        SetTimeout(Config.AlertCooldown, function()
            AlertSend = false
        end)
    end
end


AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    InitZones()
end)

AddEventHandler('sw-shoplift:server:setTimeout', function()
    if timeOut then return end
    timeOut = true
    CreateThread(function()
        SetTimeout(60000 * Config.Cooldown, function()
            timeOut = false
        end)
    end)
end)

AddEventHandler('sw-shoplift:client:startShoplift', function()
        if timeOut then QBCore.Functions.Notify( Config.Translations.AlreadyShoplifted, "error", 3500) return end
        AttemptPoliceAlert("steal")
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
        QBCore.Functions.Progressbar("shoplifting", Config.Translations.ShopliftProgressbar, 12500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
        local chance = math.random(100)
        if chance <= Config.Chance then
            local current = "mp_m_shopkeep_01"
            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
            x = x +  math.random(-10, 10)
            y = y +  math.random(-10, 10)
            AngryPed = CreatePed(26, current, x, y, z-1, 90.0, true, true)
            NetworkRegisterEntityAsNetworked(AngryPed)
            networkID = NetworkGetNetworkIdFromEntity(AngryPed)
            SetNetworkIdCanMigrate(networkID, true)
            SetNetworkIdExistsOnAllMachines(networkID, true)
            SetPedRandomComponentVariation(AngryPed)
            SetPedRandomProps(AngryPed)
            SetEntityAsMissionEntity(AngryPed)
            SetEntityVisible(AngryPed, true)
            SetPedRelationshipGroupHash(AngryPed)
            SetPedAccuracy(AngryPed)
            SetPedArmour(AngryPed)
            SetPedCanSwitchWeapon(AngryPed, true)
            SetPedDropsWeaponsWhenDead(AngryPed,false)
            SetPedFleeAttributes(AngryPed, false)
            GiveWeaponToPed(AngryPed, Config.Weapon, 1, false, true)
            TaskCombatPed(AngryPed, PlayerPedId(), 0, 16)
            SetPedCombatAttributes(AngryPed, 46, true)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('sw-shoplift:server:giveItem')
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('sw-shoplift:server:giveItem')
        end
    end, function() -- Cancel
        timeOut = false
        QBCore.Functions.Notify(Config.Translations.canceled, "error")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
    TriggerEvent('sw-shoplift:server:setTimeout')
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
      Wait(100)
      InitZones()
   end
end)