function CheckMessage(source, message)
    local lower = message:lower()

    for _, word in ipairs(Config.BlacklistWords) do
        if string.find(lower, word) then
            return true
        else
            return false
        end
    end
end

function CheckJob(source, type)
    local xPlayer = GetPlayer(source);

    if type == 'promote' then
        for _, promote in pairs(Config.Advertisement.Jobs) do
            if xPlayer.job.name == promote.job then
                return true
            end
        end
    elseif type == 'alert' then
        for _, alert in pairs(Config.Alert.Jobs) do
            if xPlayer.job.name == alert.job then
                return true
            end
        end
    end

    return false
end

function CheckGrade(source, type)
    local xPlayer = GetPlayer(source);

    if type == 'promote' then
        for _, promote in pairs(Config.Advertisement.Jobs) do
            if xPlayer.job.grade == promote.grade then
                return true
            end
        end
    elseif type == 'alert' then
        for _, alert in pairs(Config.Alert.Jobs) do
            if xPlayer.job.grade == alert.grade then
                return true
            end
        end
    end

    return false
end

function CheckCash(source, account, amount)
    local xPlayer = GetPlayer(source);
    local Account = GetAccount(source, account).money

    if Account >= amount then
        RemoveAccountMoney(source, account, amount)
        return true
    else
        return false
    end
end

function Integration(source, message)
    local xPlayer = GetPlayer(source);
    local Username = GetPlayerName(source);

    if Config.Advertisement.Integration.Birdy then
        return exports['lb-phone']:NotifyEveryone('online', { app = 'Twitter', title = Username .. ' - ' .. xPlayer.job.label, content = message })
    elseif Config.Advertisement.Integration.InstaPic then
        return exports['lb-phone']:NotifyEveryone('online', { app = 'Instagram', title = Username .. ' - ' .. xPlayer.job.label, content = message })
    elseif Config.Advertisement.Integration.Pages then
        return exports['lb-phone']:NotifyEveryone('online', { app = 'YellowPages', title = Username .. ' - ' .. xPlayer.job.label, content = message })
    elseif Config.Advertisement.Integration.MarketPlace then
        return exports['lb-phone']:NotifyEveryone('online', { app = 'MarketPlace', title = Username .. ' - ' .. xPlayer.job.label, content = message })
    elseif Config.Advertisement.Integration.Mail then
        return exports['lb-phone']:NotifyEveryone('online', { app = 'Mail', title = Username .. ' - ' .. xPlayer.job.label, content = message })
    end
end

RegisterCommand(Config.Advertisement.Command, function(source, args, rawCommand)
    local xPlayer = GetPlayer(source);
    local Account = GetAccount(source, 'money').money
    local Username = GetPlayerName(source);
    local message = table.concat(args, ' ');

    if GlobalState.Cooldown then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.advert_title, Config.Strings.wait_cooldown, 'business-time', 'error')
    else
        GlobalState.Cooldown = true

        SetTimeout(Config.Cooldown, function()
            GlobalState.Cooldown = false
        end)
    end

    if CheckMessage(source, message) then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.advert_title, Config.Strings.blacklisted_word, 'business-time', 'error')
    end

    if string.len(message) <= 0 then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.advert_title, Config.Strings.not_enough_words, 'business-time', 'error')
    end

    if not CheckJob(source, 'promote') then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.advert_title, Config.Strings.insufficient_access_job, 'business-time', 'error')
    end

    if not CheckGrade(source, 'promote') then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.advert_title, Config.Strings.insufficient_access_grade, 'business-time', 'error')
    end

    if not CheckCash(source, 'money', Config.Advertisement.Cost) then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.advert_title, Config.Strings.insufficient_funds, 'business-time', 'error')
    end

    if Config.Advertisement.Notify == 'ox_lib' then
        return TriggerClientEvent('bandit_bridge:client:notification', -1, Config.Strings.advert_title .. ' - ' .. xPlayer.job.label, Username .. '\n\n' .. Config.Strings.job_title .. xPlayer.job.label .. '\n' .. '- ' .. message, 'rectangle-ad', 'warning')
    elseif Config.Advertisement.Notify == 'chat' then
        return TriggerClientEvent('chat:addMessage', -1, { template = '<div class="chat-message"> <span style="color: #179b03">[Advertisement] {0} ({1}): {2}</div>', args = { Username, xPlayer.job.label, message } })
    end

    return Integration(source, message)
end)

RegisterCommand(Config.Alert.Command, function(source, args, rawCommand)
    local xPlayer = GetPlayer(source);
    local message = table.concat(args, ' ');

    if GlobalState.Cooldown then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.alert_title, Config.Strings.wait_cooldown, 'business-time', 'error')
    else
        GlobalState.Cooldown = true

        SetTimeout(Config.Cooldown, function()
            GlobalState.Cooldown = false
        end)
    end

    if CheckMessage(source, message) then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.alert_title, Config.Strings.blacklisted_word, 'business-time', 'error')
    end

    if string.len(message) <= 0 then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.alert_title, Config.Strings.not_enough_words, 'business-time', 'error')
    end

    if not CheckJob(source, 'alert') then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.alert_title, Config.Strings.insufficient_access_alert, 'business-time', 'error')
    end

    if not CheckGrade(source, 'alert') then
        return TriggerClientEvent('bandit_bridge:client:notification', source, Config.Strings.alert_title, Config.Strings.insufficient_access_alert, 'business-time', 'error')
    end

    return exports['lb-phone']:EmergencyNotification(-1, { title = Config.Strings.alert_title, content = message, icon = 'warning' })
end)