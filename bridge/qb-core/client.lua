if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('bandit_bridge:client:notification', function(title, message, icon, type)
    return Config.Notify(title, message, icon, type)
end)