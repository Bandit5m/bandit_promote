if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function GetPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerName(source)
    local xPlayer = GetPlayer(source)

    return xPlayer.Functions.GetName();
end

--
-- Money Functions
--
function GetAccount(source, account)
    local xPlayer = GetPlayer(source)

    return xPlayer.Functions.GetMoney(account)
end

function RemoveAccountMoney(source, account, money)
    local xPlayer = GetPlayer(source)

    return xPlayer.Functions.RemoveMoney(account, money)
end