if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function GetPlayer(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerName(source)
    local xPlayer = GetPlayer(source)

    return Player.Functions.GetName();
end

--
-- Money Functions
--
function GetAccount(source, account)
    local xPlayer = GetPlayer(source)

    return Player.Functions.GetMoney(account)
end

function RemoveAccountMoney(source, account, money)
    local xPlayer = GetPlayer(source)

    return Player.Functions.RemoveMoney(account, money)
end