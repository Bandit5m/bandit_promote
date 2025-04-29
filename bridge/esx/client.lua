if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('bandit_bridge:client:notification', function(title, message, icon, type)
    return Config.Notify(title, message, icon, type)
end)