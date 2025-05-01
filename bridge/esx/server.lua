if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function GetPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerName(source)
    local xPlayer = GetPlayer(source)

    return xPlayer.getName();
end

--
-- Money Functions
--
function GetAccount(source, account)
    local xPlayer = GetPlayer(source)

    return xPlayer.getAccount(account)
end

function RemoveAccountMoney(source, account, money)
    local xPlayer = GetPlayer(source)

    return xPlayer.removeAccountMoney(account, money)
end