local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local host = Players:FindFirstChild(_G.script_host)
local players, replicatedStorage = game:GetService("Players"), game:GetService("ReplicatedStorage");
local defaultChatSystemChatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents");
local onMessageDoneFiltering = defaultChatSystemChatEvents:FindFirstChild("OnMessageDoneFiltering");

loadstring(game:HttpGet('https://raw.githubusercontent.com/luca5432/Roblox-ANTI-AFK-SCRIPT/main/Script'))()

function chat(msg) 
    if _G.messages then
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
        print(msg)
    end
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

    if speaker.Name == _G.script_host or table.find(_G.whitelisted_users, speaker.Name) then
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
            chat('Commands: togfarm, ping, tp, disconnect, reset, togmessage, cmds')
        elseif message == _G.prefix..'disconnect' then
            teleport_to_host()
            chat('We hear that you don\'t need us anymore, we\'ll be on our way sir/ma\'am!')
            task.wait(3)
            player:Kick('Host requested disconnection!')
        elseif message == _G.prefix..'reset' then
            teleport_to_host()
            task.wait(1)
            chat('Resetting in 1 second! 🩸')
            task.wait(1)
            player.Character.Humanoid.Health = 0
        elseif message == _G.prefix..'togmessage' then
            if _G.messages == true then
                chat('Messages have been DISABLED! ❌')
                _G.messages = false
            else
                _G.messages = true
                chat('Messages have been ENABLED! ✅')
            end
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

-- GUI DOWN BELOW DONT TOUCH

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TITLE = Instance.new("TextLabel")
local ALT = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 1, 0)

TITLE.Name = "TITLE"
TITLE.Parent = Frame
TITLE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TITLE.BackgroundTransparency = 1.000
TITLE.BorderColor3 = Color3.fromRGB(0, 0, 0)
TITLE.BorderSizePixel = 0
TITLE.Position = UDim2.new(0.235753313, 0, 0.312030077, 0)
TITLE.Size = UDim2.new(0.527712703, 0, 0.172932327, 0)
TITLE.Font = Enum.Font.FredokaOne
TITLE.Text = "DevRenix's Alt Control"
TITLE.TextColor3 = Color3.fromRGB(255, 255, 255)
TITLE.TextScaled = true
TITLE.TextSize = 14.000
TITLE.TextWrapped = true

ALT.Name = "ALT"
ALT.Parent = Frame
ALT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ALT.BackgroundTransparency = 1.000
ALT.BorderColor3 = Color3.fromRGB(0, 0, 0)
ALT.BorderSizePixel = 0
ALT.Position = UDim2.new(0.235753313, 0, 0.463659108, 0)
ALT.Size = UDim2.new(0.527712703, 0, 0.0726817027, 0)
ALT.Font = Enum.Font.FredokaOne
ALT.Text = "BOT USERNAME"
ALT.TextColor3 = Color3.fromRGB(255, 166, 12)
ALT.TextScaled = true
ALT.TextSize = 14.000
ALT.TextWrapped = true

local function OLARAYA_fake_script()
	local script = Instance.new('LocalScript', Frame)

	script.Parent.ALT.Text = game:GetService('Players').LocalPlayer.Name .. ' | ' .. game:GetService('Players').LocalPlayer.UserId
end
coroutine.wrap(OLARAYA_fake_script)()
