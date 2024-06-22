local RSGCore = exports['rsg-core']:GetCoreObject()

-- cigarette
RSGCore.Functions.CreateUseableItem("cigarette10", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette10', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette10', 1)
        Player.Functions.AddItem('cigarette9', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette9", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette9', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette9', 1)
        Player.Functions.AddItem('cigarette8', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette8", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette8', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette8', 1)
        Player.Functions.AddItem('cigarette7', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette7", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette7', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette7', 1)
        Player.Functions.AddItem('cigarette6', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette6", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette6', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette6', 1)
        Player.Functions.AddItem('cigarette5', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette5", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette5', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette5', 1)
        Player.Functions.AddItem('cigarette4', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette4", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette4', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette4', 1)
        Player.Functions.AddItem('cigarette3', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette3", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette3', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette3', 1)
        Player.Functions.AddItem('cigarette2', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette2", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette2', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette2', 1)
        Player.Functions.AddItem('cigarette1', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)

RSGCore.Functions.CreateUseableItem("cigarette1", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local hasItem1 = RSGCore.Functions.HasItem(src, 'cigarette1', 1)
    local hasItem2 = RSGCore.Functions.HasItem(src, 'matches', 1)
    if hasItem1 and hasItem2 then
        Player.Functions.RemoveItem('cigarette1', 1)
        TriggerClientEvent('rex-smoking:client:cigarette', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('server.lang_1'), type = 'inform', duration = 3000 })
    end
end)
