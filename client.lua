local kostino_showIDs = false

RegisterCommand("kostino_toggleIDs", function()
    kostino_showIDs = not kostino_showIDs
end)

RegisterKeyMapping("kostino_toggleIDs", "Mostra/Nascondi ID giocatori", "keyboard", "F9")

CreateThread(function()
    while true do
        Wait(0)
        if kostino_showIDs then
            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)

            for _, player in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(player)
                local coords = GetEntityCoords(ped)

                local distance = #(myCoords - coords)
                if distance <= 20.0 and not IsEntityInAir(ped) and not IsPedFalling(ped) and not IsPedRagdoll(ped) then
                    local zOffset = (player == PlayerId()) and 1.4 or 1.2
                    kostino_DrawText3D(coords.x, coords.y, coords.z + zOffset, tostring(GetPlayerServerId(player)))
                end
            end
        end
    end
end)

function kostino_DrawText3D(x, y, z, text)
    SetDrawOrigin(x, y, z, 0)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.6, 0.6)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextOutline()
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end
