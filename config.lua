Config = Config or {}

Config.AlertCooldown = 10000 -- 10 seconds
Config.PoliceAlertChance = 0.75 -- Chance of alerting police during the day
Config.PoliceNightAlertChance = 0.50 -- Chance of alerting police at night (times:01-06)
Config.Cooldown = 5 -- In minutes
Config.Chance = 30 -- What % chance to succeed in steeling something?
Config.Weapon = "weapon_bat" -- What weapon NPC should wield ?
Config.Translations = {
    Target = "Shoplift",
    PoliceAlertMessage = "Ongoing shoplifting",
    AlreadyShoplifted = "You have recently shoplifted",
    ShopliftProgressbar = "Trying to steal something...",
    canceled = "Canceled",
    NothingFound = "You did not find anything speciall to steal...",
}
--- The coords are the shelves in the stores. Currently only 2 stores pre-made ---
Config.TargetLocations = {
        ["Shop1"] = {
            ["coords"] = vector4(30.94, -1345.33, 29.51, 271.66),
        },
        ["Shop2"] = {
            ["coords"] = vector4(28.21, -1345.191, 29.51, 271.66),
        },
        ["Shop3"] = {
            ["coords"] = vector4(-709.75, -912.34, 19.26, 131.63),
        },
        ["Shop4"] = {
            ["coords"] = vector4(-713.7043, -913.0905, 19.28019, 131.63),
            ["ped"] = 'mp_m_shopkeep_01',
        },
        ["Shop5"] = {
            ["coords"] = vector4(-712.2653, -911.6414, 19.2957, 131.63),
        },
        ["Shop6"] = {
            ["coords"] = vector4(-715.6313, -911.6693, 19.29983, 131.63),
        },

}

Config.Rewards = {
    "sandwich",
    "water_bottle",
    "tosti",
    "twerks_candy",
    "snikkel_candy",
}