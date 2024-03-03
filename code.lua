local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local host = Players:FindFirstChild(_G.script_host)
local players, replicatedStorage = game:GetService("Players"), game:GetService("ReplicatedStorage");
local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents");
local onMessageDoneFiltering = defaultChatSystemChatEvents:FindFirstChild("OnMessageDoneFiltering");

loadstring(game:HttpGet('https://raw.githubusercontent.com/luca5432/Roblox-ANTI-AFK-SCRIPT/main/Script'))()

function chat(msg) 
    ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
    print(msg)
end

function teleport_to_host()
    if host and host.Character then
        local humanoidRootPart = host.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position)
            chat('Teleported to ' .. _G.script_host .. '! 😭🤖')
        else
            chat("Host's character does not have a HumanoidRootPart!")
        end
    else
        chat("Host's character not found!")
    end
end

onMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
    local speaker, message = players[messageData.FromSpeaker], messageData.Message

    if speaker.Name == _G.script_host then
        if message == _G.prefix..'togfarm' then
            print('command sent')
            if _G.teleport == false then
                _G.teleport = true
                chat('Auto Farming has been ENABLED! ✅')
            else
                _G.teleport = false
                chat('Auto Farming has been DISABLED! ❌')
            end
        elseif message == _G.prefix..'ping' then
            chat('Pong!')
        elseif message == _G.prefix..'tp' then
            teleport_to_host()
        elseif message == _G.prefix..'cmds' then
            chat('Commands: togfarm, ping, tp, cmds')
        elseif message == _G.prefix..'disconnect' then
            teleport_to_host()
            chat('We hear that you don\'t need us anymore, we\'ll be on our way sir/ma\'am!')
            task.wait(3)
            player:Kick('Host requested disconnection!')
        end
    end
end)

if host then
    chat('Farming script has been executed successfully! ✅')
    
    teleport_to_host()
    
    player.CharacterAdded:Connect(function(character)
        if host and _G.teleport then
            character:WaitForChild('HumanoidRootPart')
            teleport_to_host()
        end
    end)
else
    print('Host not found! ❌')
    chat('Host not found! ❌')
end
