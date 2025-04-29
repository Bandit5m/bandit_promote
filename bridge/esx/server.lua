if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function GetPlayer(source)
    return ESX.GetPlayerFromId(source)
end

function GetPlayerName(source)
    local Player = GetPlayer(source)

    return Player.getName();
end

--
-- Money Functions
--
function GetAccount(source, account)
    local Player = GetPlayer(source)

    return Player.getAccount(account)
end

function RemoveAccountMoney(source, account, money)
    local Player = GetPlayer(source)

    return Player.removeAccountMoney(account, money)
end