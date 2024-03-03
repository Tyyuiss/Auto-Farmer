local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local host = Players:FindFirstChild(_G.script_host)

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
