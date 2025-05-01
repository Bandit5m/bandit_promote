Config = {
    Cooldown = 0, -- Cooldown in miliseconds.

    Advertisement = { -- Advertisment Configuration.
        Command = 'promote', -- Name of advertisement command.
        Notify = 'ox_lib', -- Options: ox_lib and chat.
        Cost = 150, -- Cost of how much to run the command is.

        Integration = { -- We recommend to enable one of these applications.
            Birdy = false,
            InstaPic = false,
            Pages = false,
            MarketPlace = false,
            Mail = false,
        },

        Jobs = { -- List of Jobs that is allowed to use the command.
            [1] = { job = 'realtor', grade = 0 },
            [2] = { job = 'mechanic', grade = 0 },
        },
    },

    Alert = { -- Amber Alert Configuration.
        Command = 'alert', -- Name of amber alert command.
        Jobs = { -- List of Jobs that is allowed to use the command.
            [1] = { job = 'police', grade = 0 },
            [2] = { job = 'ambulance', grade = 0 },
        },
    },

    BlacklistWords = { -- List of Words that is blacklisted when entered.
        'nigger',
        'nig',
        'negro',
        'n8gger',
        'faggot',
        'fag',
    },

    Strings = {
        -- Title String(s)
        advert_title = 'Business Promotion',
        alert_title = 'Amber Alert',
        job_title = 'Job: ',

        -- Advertisement String(s)
        insufficient_access_job = 'You are not allowed to promote your business.',
        insufficient_access_grade = 'You do not have the required job grade to promote your business.',
        insufficient_funds = 'You do not have enough money to promote your business.',

        -- Amber Alert String(s)
        insufficient_access_alert = 'You do not have the required job or grade to use the amber alert.',

        -- Misc String(s)
        wait_cooldown = 'Please wait before promoting your business again.',
        not_enough_words = 'You have entered an empty message. Please write something!',
        blacklisted_word = 'Your message contains a blacklisted-word.',
    },

    Notify = function(title, message, icon, type)
        lib.notify({
            title = title,
            description = message,
            icon = icon,
            type = type or 'inform',
        })
    end
}

return Config