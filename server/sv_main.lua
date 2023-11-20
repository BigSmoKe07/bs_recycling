local Inventory = exports.ox_inventory
local resourceName = GetCurrentResourceName()
 
if resourceName ~= 'bs_recycling' then
    print('Stopping resource: ' .. resourceName)
    StopResource(resourceName)
return  end

--Functions
function getTotalRecycledItems(items)
    local totalRecycledItems = {}

    for itemName, itemCount in pairs(items) do
        local recycledItems = Config.recyclableItems[itemName] and Config.recyclableItems[itemName].recycledItem
        if recycledItems then
            for recycledItemName, recycledItemCount in pairs(recycledItems) do
                if not totalRecycledItems[recycledItemName] then
                    totalRecycledItems[recycledItemName] = 0
                end
                totalRecycledItems[recycledItemName] = totalRecycledItems[recycledItemName] + (recycledItemCount * itemCount)
            end
        end
    end
    --Removing 0 counts 
    for itemName, itemCount in pairs(totalRecycledItems) do
        if itemCount == 0 then
            totalRecycledItems[itemName] = nil
        end
    end

    return totalRecycledItems
end

--Events and Callbacks 
RegisterServerEvent('bs_recycling:openstash', function(stashid)
    TriggerClientEvent('ox_inventory:openInventory', source, 'stash', stashid)
end)

lib.callback.register('bs_recycling:createstash', function ()
    local options = {
        label = 'Recycler',
        slots = Config.stashSetting.slots,
        maxWeight = Config.stashSetting.maxWeight,
        owner = false
    }
    local recyclingStash = Inventory:CreateTemporaryStash(options)
    return recyclingStash
end)
--Item durability check
lib.callback.register('bs_recycling:checkbattery', function(source,stashid)
    local requireItem = Inventory:Search(stashid, 'slots', Config.battery.name)
    for A, B in pairs(requireItem) do
        requireItem = B
        break
    end
    if not requireItem.slot or requireItem.metadata.durability < Config.battery.removedurability then TriggerClientEvent('ox_lib:notify', source, Config.notify.nopower) return end
    requireItem.metadata.durability = requireItem.metadata.durability - Config.battery.removedurability
    Inventory:SetMetadata(stashid, requireItem.slot, requireItem.metadata)
    return true 
end)
--add items after progress done
RegisterNetEvent('bs_recycling:startmachine', function(stashid)
    local recyclableItems = {}
    for items, _ in pairs(Config.recyclableItems) do
        table.insert(recyclableItems, items)
    end
    local itemsCount = Inventory:Search(stashid, 'count', recyclableItems)
    local items = getTotalRecycledItems(itemsCount)
    for i, g in pairs(itemsCount) do 
        Inventory:RemoveItem(stashid, i, g)
        -- print('removed'..i..g)
    end  
    for k, v in pairs(items) do
        -- print('added'..k..v)
        Inventory:AddItem(stashid, k, v)  
    end
    TriggerClientEvent('ox_lib:notify', source, Config.notify.recycled)   
end)
