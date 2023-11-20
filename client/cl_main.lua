local Inventory = exports.ox_inventory

-- Functions
function SpawnProp(model, coords)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local obj = CreateObject(modelHash, coords.x, coords.y, coords.z, false, true, false)
    SetEntityHeading(obj, coords.w)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj,true)
    SetModelAsNoLongerNeeded(modelHash)
    return obj
end


function addtarget(object)
    local recyclingstashid = lib.callback('bs_recycling:createstash')
    local options = {
        label = Config.targetLabel.tray.label,
        name = 'recyclingstash',
        icon = Config.targetLabel.tray.icon,
        distance = 1.5,
        onSelect = function(data)
            if Inventory:openInventory('stash', recyclingstashid) == false then
                recyclingstashid = lib.callback('bs_recycling:createstash')
            end
        end

    }

    exports.ox_target:addLocalEntity(object, options)
    local option = {
        label = Config.targetLabel.startmachine.label,
        name = 'recyclingstash',
        icon = Config.targetLabel.startmachine.icon,
        distance = 1.5,
        onSelect = function(data)
            if lib.progressCircle({
                duration = Config.progressBar.startmachine.time,
                position = 'middle',
                label = Config.progressBar.startmachine.label,
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                    move = true,
                },
                anim = {
                    dict = 'mini@repair',
                    clip = 'fixing_a_ped'
                },
            }) then 
                lib.callback('bs_recycling:checkbattery',false, function(success)
                    if not success then return end 
                    if lib.progressBar({
                        duration = Config.progressBar.progresswaste.time,
                        label = Config.progressBar.progresswaste.label,
                        useWhileDead = false,
                        canCancel = false,
                        disable = {
                            car = true,
                        },
                        
                    }) then TriggerServerEvent('bs_recycling:startmachine', recyclingstashid)  end
                end, recyclingstashid)
            end
            
        end

    }

    exports.ox_target:addLocalEntity(object, option)
end

--Main Thread
CreateThread(function()
    for _, data in ipairs(Config.machineLocation) do
        local machine = SpawnProp(Config.recyclingMachineModel, data.position)
        addtarget(machine,data.name)
    end
end)


