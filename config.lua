Config = {}

Config.recyclingMachineModel = "prop_planer_01"  -- Defines the model of the recycling machine

Config.battery ={  -- Settings for the battery used in the machine
    name =  "bigbattery", -- Name of the battery item
    removedurability = 20 -- Durability reduction per use
}

Config.machineLocation = { --Machine Location

    { position = vec4(2355.6492, 3033.6902, 47.1522, 86.0084) }, 
}

Config.stashSetting = { --stash setting of recycling machine
    slots = 16, -- Number of slots
    maxWeight = 70000, -- Maximum weight
}

Config.recyclableItems = { -- Definitions of recyclable items and their outcomes
    ['stopsign'] = {  --Input item
        recycledItem = {
            iron = 1,  ---- Amount of item obtained after recycling // itemName = count
            aluminum = 1
        }
    },      
}

Config.targetLabel = {
    tray = {
        label = "Open Recycling Tray",
        icon = 'fa-solid fa-recycle'
    },
    startmachine = {
        label = "Start Machine",
        icon = 'fa-solid fa-hourglass-start',
    }
}

Config.progressBar = {
    startmachine = {
    label = "Turning On Recycling Machine..",
    time = 4000
    },
    progresswaste = {
        label = "Processing waste..",
        time = 4000
    }
}

-- Notification
Config.notify = {
    nopower = {
        title = "Recycling Machine",
        description = 'Not enough batteries to power up the machine',
        icon = 'fa-solid fa-battery-empty',
        duration = 3500,
        style = {
            backgroundColor = '#ff5a47',
            color = '#2C2C2C',
                ['.description'] = {
                    color = '#2C2C2C',
                }
        },
    },
    recycled = {
        title = "Recycling Machine",
        description = 'recycling process is completed',
        icon = 'fa-solid fa-recycle',
        iconColor = '#2C2C2C',
        duration = 3500,
        style = {
            backgroundColor = '#72E68F',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#C1C2C5'
            }
        },
    },
}