local RSGCore = exports['rsg-core']:GetCoreObject()

function FPrompt(text, button, hold)
    Citizen.CreateThread(function()
        proppromptdisplayed = false
        PropPrompt = nil
        local str = Config.DropLable
        local buttonhash = RSGCore.Shared.Keybinds[Config.DropPrompt]
        local holdbutton = hold or false
        PropPrompt = PromptRegisterBegin()
        PromptSetControlAction(PropPrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PropPrompt, str)
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
        PromptSetHoldMode(PropPrompt, holdbutton)
        PromptRegisterEnd(PropPrompt)
    end)
end

function LMPrompt(text, button, hold)
    Citizen.CreateThread(function()
        UsePrompt = nil
        local str = Config.SmokeLable
        local buttonhash = RSGCore.Shared.Keybinds[Config.SmokePrompt]
        local holdbutton = hold or false
        UsePrompt = PromptRegisterBegin()
        PromptSetControlAction(UsePrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(UsePrompt, str)
        PromptSetEnabled(UsePrompt, false)
        PromptSetVisible(UsePrompt, false)
        PromptSetHoldMode(UsePrompt, holdbutton)
        PromptRegisterEnd(UsePrompt)
    end)
end

function EPrompt(text, button, hold)
    Citizen.CreateThread(function()
        ChangeStance = nil
        local str = Config.ChangePosLable
        local buttonhash = RSGCore.Shared.Keybinds[Config.ChangePosPrompt]
        local holdbutton = hold or false
        ChangeStance = PromptRegisterBegin()
        PromptSetControlAction(ChangeStance, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ChangeStance, str)
        PromptSetEnabled(ChangeStance, false)
        PromptSetVisible(ChangeStance, false)
        PromptSetHoldMode(ChangeStance, holdbutton)
        PromptRegisterEnd(ChangeStance)
    end)
end

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
    Citizen.CreateThread(function()
        RequestAnimDict(dict)
        local dur = duration or -1
        local flag = flags or 1
        local intro = tonumber(introtiming) or 1.0
        local exit = tonumber(exittiming) or 1.0
        timeout = 5
        while (not HasAnimDictLoaded(dict) and timeout > 0) do
            timeout = timeout - 1
            if timeout == 0 then
                print(Lang:t('client.lang_1'))
            end
            Citizen.Wait(300)
        end
        TaskPlayAnim(actor, dict, body, intro, exit, dur, flag --[[1 for repeat--]], 1, false, false, false, 0, true)
    end)
end

function StopAnim(dict, body)
    Citizen.CreateThread(function()
        StopAnimTask(PlayerPedId(), dict, body, 1.0)
    end)
end

-- cigarette
RegisterNetEvent('rex-smoking:client:cigarette')
AddEventHandler('rex-smoking:client:cigarette', function()
    FPrompt(Config.Drop, RSGCore.Shared.Keybinds[Config.DropPrompt], false)
    LMPrompt(Config.Smoke, RSGCore.Shared.Keybinds[Config.SmokePrompt], false)
    EPrompt(Config.Change, RSGCore.Shared.Keybinds[Config.ChangePosPrompt], false)
    ExecuteCommand('close')
    local ped = PlayerPedId()
    local male = IsPedMale(ped)
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local cigarette = CreateObject(GetHashKey('P_CIGARETTE01X'), x, y, z + 0.2, true, true, true)
    local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
    local mouth = GetEntityBoneIndexByName(ped, "skel_head")

    if male then
        AttachEntityToEntity(cigarette, ped, mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        Anim(ped, "amb_rest@world_human_smoking@male_c@stand_enter", "enter_back_rf", 5400, 0)
        Wait(1000)
        AttachEntityToEntity(cigarette, ped, righthand, 0.03, -0.01, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1,
            true)
        Wait(1000)
        AttachEntityToEntity(cigarette, ped, mouth, -0.017, 0.1, -0.01, 0.0, 90.0, -90.0, true, true, false, true, 1,
            true)
        Wait(3000)
        AttachEntityToEntity(cigarette, ped, righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1,
            true)
        Wait(1000)
        Anim(ped, "amb_rest@world_human_smoking@male_c@base", "base", -1, 30)
        RemoveAnimDict("amb_rest@world_human_smoking@male_c@stand_enter")
        Wait(1000)
    else --female
        AttachEntityToEntity(cigarette, ped, mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        Anim(ped, "amb_rest@world_human_smoking@female_c@base", "base", -1, 30)
        Wait(1000)
        AttachEntityToEntity(cigarette, ped, righthand, 0.01, 0.0, 0.01, 0.0, -160.0, -130.0, true, true, false, true, 1,
            true)
        Wait(2500)
    end

    local stance = "c"

    if proppromptdisplayed == false then
        PromptSetEnabled(PropPrompt, true)
        PromptSetVisible(PropPrompt, true)
        PromptSetEnabled(UsePrompt, true)
        PromptSetVisible(UsePrompt, true)
        PromptSetEnabled(ChangeStance, true)
        PromptSetVisible(ChangeStance, true)
        proppromptdisplayed = true
    end

    if male then
        while IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_c@base", "base", 3)
            or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", 3)
            or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_d@base", "base", 3)
            or IsEntityPlayingAnim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", 3) do
            Wait(5)
            if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.DropPrompt]) then
                PromptSetEnabled(PropPrompt, false)
                PromptSetVisible(PropPrompt, false)
                PromptSetEnabled(UsePrompt, false)
                PromptSetVisible(UsePrompt, false)
                PromptSetEnabled(ChangeStance, false)
                PromptSetVisible(ChangeStance, false)
                proppromptdisplayed = false

                ClearPedSecondaryTask(ped)
                Anim(ped, "amb_rest@world_human_smoking@male_a@stand_exit", "exit_back", -1, 1)
                Wait(2800)
                DetachEntity(cigarette, true, true)
                SetEntityVelocity(cigarette, 0.0, 0.0, -1.0)
                Wait(1500)
                ClearPedSecondaryTask(ped)
                ClearPedTasks(ped)
                Wait(10)
            end
            if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.ChangePosPrompt]) then
                if stance == "c" then
                    Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "b"
                elseif stance == "b" then
                    Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_d@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "d"
                elseif stance == "d" then
                    Anim(ped, "amb_rest@world_human_smoking@male_d@trans", "d_trans_a", -1, 30)
                    Wait(4000)
                    Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                    while not IsEntityPlayingAnim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "a"
                else --stance=="a"
                    Anim(ped, "amb_rest@world_human_smoking@male_a@trans", "a_trans_c", -1, 30)
                    Wait(4233)
                    Anim(ped, "amb_rest@world_human_smoking@male_c@base", "base", -1, 30, 0)
                    while not IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_c@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "c"
                end
            end

            if stance == "c" then
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@male_c@idle_a", "idle_b", -1, 30, 0)
                        Wait(21166)
                        Anim(ped, "amb_rest@world_human_smoking@male_c@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@male_c@idle_a", "idle_a", -1, 30, 0)
                        Wait(8500)
                        Anim(ped, "amb_rest@world_human_smoking@male_c@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            elseif stance == "b" then
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@idle_c", "idle_g", -1, 30, 0)
                        Wait(13433)
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a", "idle_a", -1, 30, 0)
                        Wait(3199)
                        Anim(ped, "amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            elseif stance == "d" then
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@male_d@idle_a", "idle_b", -1, 30, 0)
                        Wait(7366)
                        Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@male_d@idle_c", "idle_g", -1, 30, 0)
                        Wait(7866)
                        Anim(ped, "amb_rest@world_human_smoking@male_d@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            else --stance=="a"
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@male_a@idle_a", "idle_b", -1, 30, 0)
                        Wait(12533)
                        Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                        Wait(100)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@male_a@idle_a", "idle_a", -1, 30, 0)
                        Wait(8200)
                        Anim(ped, "amb_wander@code_human_smoking_wander@male_a@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            end
        end
    else --if female
        while IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@female_c@base", "base", 3)
            or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@female_b@base", "base", 3)
            or IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@female_a@base", "base", 3) do
            Wait(5)
            if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.DropPrompt]) then
                PromptSetEnabled(PropPrompt, false)
                PromptSetVisible(PropPrompt, false)
                PromptSetEnabled(UsePrompt, false)
                PromptSetVisible(UsePrompt, false)
                PromptSetEnabled(ChangeStance, false)
                PromptSetVisible(ChangeStance, false)
                proppromptdisplayed = false

                ClearPedSecondaryTask(ped)
                Anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_fire_stand_a", -1, 1)
                Wait(3800)
                DetachEntity(cigarette, true, true)
                Wait(800)
                ClearPedSecondaryTask(ped)
                ClearPedTasks(ped)
                Wait(10)
            end
            if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.ChangePosPrompt]) then
                if stance == "c" then
                    Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@female_b@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "b"
                elseif stance == "b" then
                    Anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_a", -1, 30)
                    Wait(5733)
                    Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                    while not IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@female_a@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "a"
                else --stance=="a"
                    Anim(ped, "amb_rest@world_human_smoking@female_c@base", "base", -1, 30)
                    Wait(1000)
                    while not IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@female_c@base", "base", 3) do
                        Wait(100)
                    end
                    stance = "c"
                end
            end

            if stance == "c" then
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@female_c@idle_a", "idle_a", -1, 30, 0)
                        Wait(9566)
                        Anim(ped, "amb_rest@world_human_smoking@female_c@base", "base", -1, 30, 0)
                        Wait(100)
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@female_c@idle_b", "idle_f", -1, 30, 0)
                        Wait(8133)
                        Anim(ped, "amb_rest@world_human_smoking@female_c@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            elseif stance == "b" then
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@female_b@idle_b", "idle_f", -1, 30, 0)
                        Wait(8033)
                        Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30, 0)
                        Wait(100)
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@female_b@idle_a", "idle_b", -1, 30, 0)
                        Wait(4266)
                        Anim(ped, "amb_rest@world_human_smoking@female_b@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            else --stance=="a"
                if IsControlJustReleased(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                    TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    Wait(500)
                    if IsControlPressed(0, RSGCore.Shared.Keybinds[Config.SmokePrompt]) then
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                        Anim(ped, "amb_rest@world_human_smoking@female_a@idle_b", "idle_d", -1, 30, 0)
                        Wait(14566)
                        Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                        Wait(100)
                        TriggerServerEvent('hud:server:RelieveStress', Config.RelieveStress)
                    else
                        Anim(ped, "amb_rest@world_human_smoking@female_a@idle_a", "idle_b", -1, 30, 0)
                        Wait(6100)
                        Anim(ped, "amb_rest@world_human_smoking@female_a@base", "base", -1, 30, 0)
                        Wait(100)
                    end
                end
            end
        end
    end

    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    PromptSetEnabled(UsePrompt, false)
    PromptSetVisible(UsePrompt, false)
    PromptSetEnabled(ChangeStance, false)
    PromptSetVisible(ChangeStance, false)
    proppromptdisplayed = false

    DetachEntity(cigarette, true, true)
    ClearPedSecondaryTask(ped)
    RemoveAnimDict("amb_wander@code_human_smoking_wander@male_a@base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_a@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@base")
    RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@nervous_stressed@male_b@idle_g")
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@idle_c")
    RemoveAnimDict("amb_rest@world_human_smoking@male_a@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@male_d@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@female_a@base")
    RemoveAnimDict("amb_rest@world_human_smoking@female_a@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@female_a@idle_b")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@base")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@idle_b")
    RemoveAnimDict("amb_rest@world_human_smoking@female_c@base")
    RemoveAnimDict("amb_rest@world_human_smoking@female_c@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@female_c@idle_b")
    RemoveAnimDict("amb_rest@world_human_smoking@female_b@trans")
    Wait(100)
    ClearPedTasks(ped)
end)
