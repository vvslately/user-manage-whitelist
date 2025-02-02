_G.key = "death3"
_G.hwid = gethwid()

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local notificationFrame = Instance.new("Frame")
notificationFrame.Size = UDim2.new(0, 0, 0, 50)
notificationFrame.Position = UDim2.new(0.5, -200, 0, 20)
notificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
notificationFrame.BackgroundTransparency = 0.5
notificationFrame.BorderSizePixel = 0
notificationFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = notificationFrame

local notificationText = Instance.new("TextLabel")
notificationText.Size = UDim2.new(1, -20, 1, -10)
notificationText.Position = UDim2.new(0, 10, 0, 5)
notificationText.BackgroundTransparency = 1
notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
notificationText.TextSize = 24
notificationText.Font = Enum.Font.GothamSemibold
notificationText.Text = "Loading..."
notificationText.TextWrapped = true
notificationText.Parent = notificationFrame

local TweenService = game:GetService("TweenService")
local tweenInfoIn = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)

local function showNotification(text, bgColor)
    notificationText.Text = text
    notificationFrame.BackgroundColor3 = bgColor
    local tweenIn = TweenService:Create(notificationFrame, tweenInfoIn, {
        Position = UDim2.new(0.5, -200, 0, 20),
        Size = UDim2.new(0, 400, 0, 50)
    })
    tweenIn:Play()

    wait(0.5)
    wait(5)
    local tweenOut = TweenService:Create(notificationFrame, tweenInfoOut, {
        Position = UDim2.new(0.5, -200, 0, -60)
    })
    tweenOut:Play()

    tweenOut.Completed:Connect(function()
        notificationFrame:Destroy()
    end)
end

local url = "http://localhost/whitelist/?key=" .. _G.key .. "&hwid=" .. _G.hwid
local response = http_request({
    Url = url,
    Method = "GET"
})

if response and response.StatusCode == 200 then
    local body = response.Body

    if body == "You own it." then
        showNotification("✅ Access Granted!", Color3.fromRGB(0, 255, 0))



        local Fluent = loadstring(game:HttpGet(
            "https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
        local SaveManager = loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
        local InterfaceManager = loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

        local Window = Fluent:CreateWindow({
            Title = "Fluent " .. Fluent.Version,
            SubTitle = "by dawid",
            TabWidth = 160,
            Size = UDim2.fromOffset(580, 460),
            Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
            Theme = "Dark",
            MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
        })

        local Tabs = {
            Main = Window:AddTab({
                Title = "Main",
                Icon = ""
            }),
            Settings = Window:AddTab({
                Title = "Settings",
                Icon = "settings"
            })
        }

        local Options = Fluent.Options
        do


            Tabs.Main:AddParagraph({
                Title = "Paragraph",
                Content = "This is a paragraph.\nSecond line!"
            })

            Tabs.Main:AddButton({
                Title = "Button",
                Description = "Copy User Manager",
                Callback = function()
                    Window:Dialog({
                        Title = "Title",
                        Content = "This is a dialog",
                        Buttons = {{
                            Title = "Confirm",
                            Callback = function()
                                local urlclient = "http://localhost/whitelist/user_manager.php?key=" .. _G.key 

                                setclipboard(urlclient)
                            end
                        }, {
                            Title = "Cancel",
                        }}
                    })
                end
            })

        end

            
        while wait(5) do

            local name = game.Players.LocalPlayer.Name
            local gem = game:GetService("Players").LocalPlayer._stats.gem_amount.value
            local gold = game:GetService("Players").LocalPlayer._stats.gold_amount.value
            local star = game:GetService("Players").LocalPlayer._stats._resourceHolidayStars.value

            local url = "http://localhost/whitelist/client.php?name=" .. name .. "&gem=" .. gem .. "&key=" .. _G.key ..
                            "&gold=" .. gold .. "&star=" .. star

            local response = http_request({
                Url = url, -- The URL of the PHP script
                Method = "GET" -- The HTTP method (GET)
            })

            if response.StatusCode == 200 then
                local body = response.Body
                if body == "New player inserted." then
                    print("✅ Player inserted successfully!")
                elseif body == "Player's gems, gold, and star updated." then
                    print("✅ Player's data updated successfully!")
                else
                    print("❌ Unknown response: " .. body)
                end
            else
                print("❌ HTTP request failed! Status Code: " .. response.StatusCode)
            end

        end



    elseif body == "Invalid." then
        showNotification("❌ Invalid HWID!", Color3.fromRGB(255, 0, 0)) -- Red background
    elseif body == "Key is already in use." then
        showNotification("⚠️ Key already in use!", Color3.fromRGB(255, 165, 0)) -- Orange background
    elseif body == "Key not found." then
        showNotification("❌ Invalid Key!", Color3.fromRGB(255, 0, 0)) -- Red background
    else
        showNotification("❓ Unknown Response!", Color3.fromRGB(128, 128, 128)) -- Gray background
    end
else
    showNotification("🚨 HTTP Request Failed!", Color3.fromRGB(255, 0, 0)) -- Red background
end
