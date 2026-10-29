---- Modern Mor-Siyah ESP GUI - Sekmeli Versiyon
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")


-- Key System Variables
local keyCorrect = false
local CORRECT_KEY = "WhoisTop1" -- Buraya istediğin key'i yaz

local premiumUsers = {
    -- nothing 
    -- using luarmor

}

local function isPremiumUser()
    return true
end

-- Key System GUI
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
KeyGui.Name = "KeySystem_GUI"

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
KeyFrame.Size = UDim2.new(0, 400, 0, 320)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 13, 23)
KeyFrame.Active = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 15)


-- Responsive access panel: keep text and controls at native, readable sizes.
KeyGui.ResetOnSpawn = false
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.Position = UDim2.fromScale(0.5, 0.5)
local function fitKeyPanel()
    KeyFrame.Size = UDim2.fromOffset(math.min(400, math.max(240, KeyGui.AbsoluteSize.X - 24)), 320)
end
KeyGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitKeyPanel)
fitKeyPanel()
-- Key system dragging
local keyDragging = false
local keyDragStart = nil
local keyStartPos = nil

KeyFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        keyDragging = true
        keyDragStart = input.Position
        keyStartPos = KeyFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                keyDragging = false
            end
        end)
    end
end)


-- Key Title
local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 60)
KeyTitle.BackgroundColor3 = Color3.fromRGB(31, 24, 62)
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.Text = "ACNE - Key System"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 24
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0, 15)

-- Key TextBox
local KeyTextBox = Instance.new("TextBox", KeyFrame)
KeyTextBox.Position = UDim2.new(0, 20, 0, 80)
KeyTextBox.Size = UDim2.new(1, -40, 0, 50)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
KeyTextBox.TextColor3 = Color3.new(1, 1, 1)
KeyTextBox.PlaceholderText = "Enter your key..."
KeyTextBox.Font = Enum.Font.Gotham
KeyTextBox.TextSize = 16
KeyTextBox.Text = ""
Instance.new("UICorner", KeyTextBox).CornerRadius = UDim.new(0, 10)

-- Check Key Button
local CheckKeyButton = Instance.new("TextButton", KeyFrame)
CheckKeyButton.Position = UDim2.new(0, 20, 0, 150)
CheckKeyButton.Size = UDim2.new(1, -40, 0, 50)
CheckKeyButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
CheckKeyButton.TextColor3 = Color3.new(1, 1, 1)
CheckKeyButton.Text = "Check Key"
CheckKeyButton.Font = Enum.Font.GothamBold
CheckKeyButton.TextSize = 18
CheckKeyButton.AutoButtonColor = false
Instance.new("UICorner", CheckKeyButton).CornerRadius = UDim.new(0, 10)

-- Get Key Button
local GetKeyButton = Instance.new("TextButton", KeyFrame)
GetKeyButton.Position = UDim2.new(0, 20, 0, 210)
GetKeyButton.Size = UDim2.new(1, -40, 0, 40)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218) -- Discord mavi rengi
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.Text = "Get Key (Join Discord)"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 16
GetKeyButton.AutoButtonColor = false
Instance.new("UICorner", GetKeyButton).CornerRadius = UDim.new(0, 10)

-- Status Label
local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Position = UDim2.new(0, 20, 0, 260)
StatusLabel.Size = UDim2.new(1, -40, 0, 30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Please enter your key..."
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextWrapped = true

-- Key validation function
local function validateKey(inputKey)
    if not inputKey or inputKey == "" then
        return false, "Please enter a key!"
    end
    
    -- Key'leri temizle (whitespace'leri kaldır)
    inputKey = string.gsub(inputKey, "%s+", "")
    local correctKey = string.gsub(CORRECT_KEY, "%s+", "")
    
    -- Key kontrolü
    if inputKey == correctKey then
        return true, "Key verified successfully!\nWelcome to ACNE!"
    else
        return false, "Wrong key!\nPlease check your key and try again."
    end
end

-- Check Key Event
CheckKeyButton.MouseButton1Click:Connect(function()
    local inputKey = KeyTextBox.Text
    
    CheckKeyButton.Text = "Checking..."
    CheckKeyButton.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.Text = "Validating key..."
    
    task.spawn(function()
        local isValid, message = validateKey(inputKey)
        
        if isValid then
            -- Başarılı
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            StatusLabel.Text = message
            CheckKeyButton.Text = "Success!"
            CheckKeyButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            
            keyCorrect = true
            
            -- Başarı animasyonu
            TweenService:Create(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            task.wait(0.5)
            KeyGui:Destroy()
            
            -- Ana GUI'yi hemen başlat
            loadMainGUI()
        else
            -- Hatalı
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            StatusLabel.Text = message
            CheckKeyButton.Text = "Wrong Key!"
            CheckKeyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            
            -- Hata animasyonu
            local originalPos = KeyFrame.Position
            TweenService:Create(KeyFrame, TweenInfo.new(0.1), {Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset - 10, originalPos.Y.Scale, originalPos.Y.Offset)}):Play()
            task.wait(0.1)
            TweenService:Create(KeyFrame, TweenInfo.new(0.1), {Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + 10, originalPos.Y.Scale, originalPos.Y.Offset)}):Play()
            task.wait(0.1)
            TweenService:Create(KeyFrame, TweenInfo.new(0.1), {Position = originalPos}):Play()
            
            task.wait(2)
            CheckKeyButton.Text = "Check Key"
            CheckKeyButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        end
    end)
end)

-- Get Key Event
GetKeyButton.MouseButton1Click:Connect(function()
    -- Discord davet linkini clipboard'a kopyala ve açmaya çalış
    local discordLink = "https://discord.gg/dumbs"
    
    -- Clipboard'a kopyala
    pcall(function()
        setclipboard(discordLink)
    end)
    
    -- Buton animasyonu
    GetKeyButton.Text = "Link Copied! Opening Discord..."
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    
    -- Discord linkini açmaya çalış (bazı executorlarda çalışır)
    pcall(function()
        if syn and syn.request then
            syn.request({
                Url = discordLink,
                Method = "GET"
            })
        elseif http_request then
            http_request({
                Url = discordLink,
                Method = "GET"
            })
        elseif request then
            request({
                Url = discordLink,
                Method = "GET"
            })
        end
    end)
    
    task.spawn(function()
        task.wait(3)
        GetKeyButton.Text = "Get Key (Join Discord)"
        GetKeyButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
    end)
    
    -- Bilgilendirme mesajı
    StatusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    StatusLabel.Text = "Discord link copied! Join the server to get your key."
end)

-- ENTER tuşu ile key kontrolü
KeyTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        CheckKeyButton.MouseButton1Click:Fire()
    end
end)

-- Key GUI açılış animasyonu
KeyFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(KeyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 400, 0, 320)
}):Play()


-- Ana GUI fonksiyonu
function loadMainGUI()
    if not keyCorrect then return end
    
    -- Anti-AFK System - 19 dakikada bir küçük hareket
    local antiAfkEnabled = true
    local lastMovementTime = tick()
    local movementInterval = 19 * 60 -- 19 dakika (sabit)
    
    local function performAntiAfkMovement()
        if not antiAfkEnabled then return end
        
        local player = game.Players.LocalPlayer
        if not player.Character then return end
        
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and humanoidRootPart then
            -- Rastgele hareket türü seç (1-4 arası)
            local movementType = math.random(1, 4)
            local currentCFrame = humanoidRootPart.CFrame
            
            if movementType == 1 then
                -- Tip 1: Küçük ileri hareket
                local moveDirection = currentCFrame.LookVector * 0.1
                humanoidRootPart.CFrame = currentCFrame + moveDirection
                task.wait(0.1)
                humanoidRootPart.CFrame = currentCFrame
                
            elseif movementType == 2 then
                -- Tip 2: Küçük sağa-sola hareket
                local moveDirection = currentCFrame.RightVector * (math.random() > 0.5 and 0.1 or -0.1)
                humanoidRootPart.CFrame = currentCFrame + moveDirection
                task.wait(0.1)
                humanoidRootPart.CFrame = currentCFrame
                
            elseif movementType == 3 then
                -- Tip 3: Küçük dönüş hareketi
                local rotationAngle = math.rad(math.random(-5, 5))
                humanoidRootPart.CFrame = currentCFrame * CFrame.Angles(0, rotationAngle, 0)
                task.wait(0.1)
                humanoidRootPart.CFrame = currentCFrame
                
            elseif movementType == 4 then
                -- Tip 4: Çok küçük zıplama
                local originalJumpPower = humanoid.JumpPower
                humanoid.JumpPower = 3
                humanoid.Jump = true
                task.wait(0.1)
                humanoid.JumpPower = originalJumpPower
            end
            
            -- Mouse hareket simülasyonu (kamera hafif hareket)
            local camera = workspace.CurrentCamera
            if camera then
                local currentCameraCFrame = camera.CFrame
                local smallRotation = CFrame.Angles(math.rad(math.random(-1, 1)), math.rad(math.random(-1, 1)), 0)
                camera.CFrame = currentCameraCFrame * smallRotation
                task.wait(0.1)
                camera.CFrame = currentCameraCFrame
            end
            
            print("Anti-AFK: Hareket tipi " .. movementType .. " yapıldı")
        end
    end
    
    -- Anti-AFK toggle key (Ctrl+Shift+A)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.A then
            local ctrlPressed = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
            local shiftPressed = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
            
            if ctrlPressed and shiftPressed then
                antiAfkEnabled = not antiAfkEnabled
                local status = antiAfkEnabled and "Açık" or "Kapalı"
                print("Anti-AFK sistemi: " .. status)
                
                -- Bildirim göster
                local notification = Instance.new("ScreenGui", game.CoreGui)
                local frame = Instance.new("Frame", notification)
                frame.Size = UDim2.new(0,300,0,60)
                frame.Position = UDim2.new(0.5,-150,0,50)
                frame.BackgroundColor3 = antiAfkEnabled and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                
                local label = Instance.new("TextLabel", frame)
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = "Anti-AFK: " .. status
                label.TextColor3 = Color3.new(1,1,1)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                
                task.spawn(function()
                    task.wait(3)
                    pcall(function() notification:Destroy() end)
                end)
            end
        end
    end)
    
    -- Anti-AFK timer
    task.spawn(function()
        while antiAfkEnabled do
            local currentTime = tick()
            if currentTime - lastMovementTime >= movementInterval then
                performAntiAfkMovement()
                lastMovementTime = currentTime
                print("Anti-AFK: Sonraki hareket 19 dakika sonra")
            end
            task.wait(30) -- Her 30 saniyede kontrol et
        end
    end)
    
    -- Araç kategorileri
    local carTiers = {
        ["S-Tier"] = {"Vemca K5 E","Merquis SLX","Vemca K8","Chule Curgete","Vemca K3 F","Skami Truck","Porx Bareira RF","Toyoda AFF67","Leskus FP 50","Fia-Te 10026p","Four Mustank Relby SP500","Merquis F55","Holde Proluiz","DOGO Carrega","Holde TipeRar","Ratos Rotos Esporte"}, -- 0-0.9%
        ["A-Tier"] = {"Merquis Z73","Lokswag Golo GT","Vemca K3 e92","Matsu Lanca","Chule Camarao","Vemca K5 e39","Lokswag Cissoko F","Raguer XisR","Toyoda Yapp","Ganley Continente FP","Ontel Astron","Merquis 190F EVOLUCAO II","Renas Mugano","Fia-Te Alberto 300","Fotos Exigente Cura","Matsu Lanca Evolucao","Mamibac FZ5-B","Four Rex","Vovo F60 Polo"}, -- 1-5%
        ["B-Tier"] = {"Vemca k3 E", "Leskus not200","Four Traffic","Lokswag Golo MK5","Merquis C203","Toyoda Hellox","Holde Inteiro","Sigma Roma Broeiro","Lokswag Tourette","Four Party","Lion JF-S"}, -- 6-10%
        ["C-Tier"] = {"Lokswag Passar", "Sacode Oitava","Lokswag Golo MK4","Holde Ciwiq","Ontel Pontus Neta","Peujo 400e6","Matsu Elipz FZX","Peujo 258 F5","Lokswag Nype 1","Vovo Sr60","Toyoda Perseguidor JFX100"}, -- 11-20%
        ["D-Tier"] = {"Siath Lion", "Peujo 200e6", "Fia-Te Ponto", "Ontel Costa","Renas Kapturado","Lokswag Golo","Xitro J3","Peujo 200e5","Sabes Muito","Renas Suino"} -- 21-50%
    }

    local headlightMeshMap = {
        ["rbxassetid://89884886746213"] = "Xitro J3",
        ["rbxassetid://73672843162416"] = "Peujo 200e5",
        ["rbxassetid://108631594916182"] = "Ontel Pontus Neta",
        ["rbxassetid://133040441862536"] = "Vemca K5 e39",
        ["rbxassetid://105704668265695"] = "Vemca K5 e39",
        ["rbxassetid://124774767819816"] = "Sabes Muito",
        ["rbxassetid://104340067733307"] = "Peujo 400e6",
        ["rbxassetid://99151522117674"] = "Peujo 400e6",
        ["rbxassetid://71896119413197"] = "Lokswag Cissoko F",
        ["rbxassetid://81685800636067"] = "Raguer XisR",
        ["rbxassetid://125807929370787"] = "Renas Suino",
        ["rbxassetid://95780221331577"] = "Matsu Elipz FZX",
        ["rbxassetid://114238137153485"] = "Toyoda Yapp",
        ["rbxassetid://97524128021733"] = "Ganley Continente FP",
        ["rbxassetid://130563344757842"] = "Peujo 258 F5",
        ["rbxassetid://98779166124451"] = "Ontel Astron",
        ["rbxassetid://81283029627823"] = "Ontel Astron",
        ["rbxassetid://92416268407399"] = "Sigma Roma Broeiro",
        ["rbxassetid://125295153597317"] = "Lokswag Nype 1",
        ["rbxassetid://103226919008518"] = "Vovo Sr60",
        ["rbxassetid://120940882653506"] = "Merquis 190F EVOLUCAO II",
        ["rbxassetid://131959887044303"] = "Renas Mugano",
        ["rbxassetid://107992367591363"] = "Toyoda Perseguidor JFX100",
        ["rbxassetid://116758094967865"] = "Lokswag Tourette",
        ["rbxassetid://91675228109325"] = "Fia-Te Alberto 300",
        ["rbxassetid://127715583982808"] = "Four Party",
        ["rbxassetid://112245266900488"] = "Vemca k3 E",
        ["rbxassetid://137920739179379"] = "Lion JF-S",
        ["rbxassetid://80758395932486"] = "Porx Bareira RF",
        ["rbxassetid://115740494899701"] = "Toyoda AFF67",
        ["rbxassetid://129534847656124"] = "Leskus FP 50",
        ["rbxassetid://100403413349943"] = "Fotos Exigente Cura",
        ["rbxassetid://80714988650878"] = "Matsu Lanca Evolucao",
        ["rbxassetid://98270607238163"] = "Mamibac FZ5-B",
        ["rbxassetid://100245856309678"] = "Fia-Te 10026p",
        ["rbxassetid://122824998239242"] = "Fia-Te 10026p",
        ["rbxassetid://119103774040069"] = "Four Mustank Relby SP500",
        ["rbxassetid://112985933390338"] = "Merquis F55",
        ["rbxassetid://84158845710246"] = "Four Rex",
        ["rbxassetid://127319621726279"] = "Four Rex",
        ["rbxassetid://112655131914264"] = "Vovo F60 Polo",
        ["rbxassetid://92407805448863"] = "Holde Proluiz",
        ["rbxassetid://128268197631356"] = "DOGO Carrega",
        ["rbxassetid://72697111119559"] = "Holde TipeRar",
        ["rbxassetid://85342836421793"] = "Ratos Rotos Esporte",
        ["rbxassetid://81154220701558"] = "Ratos Rotos Esporte",
        ["rbxassetid://129888430241447"] = "Ratos Rotos Esporte",
        ["rbxassetid://9337775438"] = "Siath Lion",
        ["rbxassetid://15672956285"] = "Peujo 200e6",
        ["rbxassetid://6029192239"] = "Fia-Te Ponto",
        ["rbxassetid://1241602063"] = "Ontel Costa",
        ["rbxassetid://5420337729"] = "Renault Captur",
        ["rbxassetid://71362826184718"] = "Lokswag Passar",
        ["rbxassetid://18578562078"] = "Holde Inteiro",
        ["rbxassetid://1248899310"] = "Vemca K3",
        ["rbxassetid://1126579298"] = "Lokswag Golo",
        ["rbxassetid://78945793271314"] = "Leskus not200",
        ["rbxassetid://118584901955307"] = "Toyoda Hellox",
        ["rbxassetid://86849926181650"] = "Sacode Oitava",
        ["rbxassetid://5013749758"] = "Holde Ciwiq",
        ["rbxassetid://1248900514"] = "Vemca K3 e92",
        ["rbxassetid://138794755943800"] = "Vemca K5 E",
        ["rbxassetid://139537573146018"] = "Chule Curgete",
        ["rbxassetid://118883952377358"] = "Chule Curgete",
        ["rbxassetid://104703777198996"] = "Lokswag Golo GT",
        ["rbxassetid://70870196189213"] = "Lokswag Golo GT",
        ["rbxassetid://85967216139917"] = "Vemca K8",
        ["rbxassetid://117846568688142"] = "Four Traffic",
        ["rbxassetid://17496672146"] = "Merquis Z73",
        ["rbxassetid://17496679363"] = "Merquis Z73", 
        ["rbxassetid://138826202263502"] = "Merquis SLX",
        ["rbxassetid://85074801552523"] = "Merquis SLX",
        ["rbxassetid://135051334751805"] = "Lokswag Golo MK5",
        ["rbxassetid://110236203591104"] = "Merquis C203",
        ["rbxassetid://101805428394287"] = "Merquis C203",
        ["rbxassetid://130431001876040"] = "Matsu Lanca",
        ["rbxassetid://139045411750787"] = "Matsu Lanca",
        ["rbxassetid://138974632841815"] = "Lokswag Golo MK4",
        ["rbxassetid://91225561384870"] = "Lokswag Golo MK4",
        ["rbxassetid://82552763167057"] = "Vemca K3 F",
        ["rbxassetid://100299353319577"] = "Vemca K3 F",
        ["rbxassetid://91849293393970"] = "Skami Truck",
        ["rbxassetid://127282509333536"] = "Skami Truck",
        ["rbxassetid://78160148446922"] = "Skami Truck",
        ["rbxassetid://99180799513236"] = "rs3 sedan",
        ["rbxassetid://98186509641008"] = "rs3 sedan",
        ["rbxassetid://114627523692521"] = "Chule Camarao",
        ["rbxassetid://102551712593774"] = "Chule Camarao",
    }

    local reverselightsMeshMap = {
        --["rbxassetid://74360401841713"] = "Auidy V5",

    }


    -- Variables (en üste ekle)
    local selectedAutoTpCars = {}
    local carStates = {} -- Araçların durumları: nil=normal, "autofarm"=auto farm, "onlybuy"=only buy
    local autoTpEnabled = false
    
    -- Mesh ID'den araç modelini getiren yardımcı fonksiyon
    local function getVehicleModelFromMeshId(vehicle)
        if not vehicle then return nil end
        
        local body = vehicle:FindFirstChild("Body")
        if not body then return nil end
        
        -- Headlights klasöründen mesh ID'yi bul
        local headlights = body:FindFirstChild("Headlights")
        if headlights then
            for _, light in ipairs(headlights:GetChildren()) do
                local meshId = nil
                
                -- Güvenli MeshId kontrolü
                local success, result = pcall(function()
                    return light.MeshId
                end)
                
                if success and result then
                    meshId = result
                else
                    -- MeshId yoksa SpecialMesh kontrolü
                    local specialMesh = light:FindFirstChildWhichIsA("SpecialMesh")
                    if specialMesh then
                        local success2, result2 = pcall(function()
                            return specialMesh.MeshId
                        end)
                        if success2 and result2 then
                            meshId = result2
                        end
                    end
                end
                
                if meshId and headlightMeshMap[meshId] then
                    return headlightMeshMap[meshId]
                end
            end
        end
        
        -- ReverseLights klasöründen mesh ID'yi bul (fallback)
        local reverseLights = body:FindFirstChild("ReverseLights")
        if reverseLights then
            for _, light in ipairs(reverseLights:GetChildren()) do
                local meshId = nil
                
                -- Güvenli MeshId kontrolü
                local success, result = pcall(function()
                    return light.MeshId
                end)
                
                if success and result then
                    meshId = result
                else
                    -- MeshId yoksa SpecialMesh kontrolü
                    local specialMesh = light:FindFirstChildWhichIsA("SpecialMesh")
                    if specialMesh then
                        local success2, result2 = pcall(function()
                            return specialMesh.MeshId
                        end)
                        if success2 and result2 then
                            meshId = result2
                        end
                    end
                end
                
                if meshId and reverselightsMeshMap[meshId] then
                    return reverselightsMeshMap[meshId]
                end
            end
        end
        
        return nil
    end
    
    -- Eski fonksiyonu da güncelle (backward compatibility için)
    local function getVehicleModel(vehicle)
        return getVehicleModelFromMeshId(vehicle)
    end
    local teleportedToCars = {}
    local carNameTracker = {}
    local espEnabled = false
    local activeESP = {}
    local carButtons = {}
    local categoryLabels = {}
    local espConnections = {}
    local autoTpConnections = {}
    local currentTab = "ESP"
    local currentTeleportedCar = nil
    local guiVisible = true
    local guiMinimized = false
    local toggleKey = Enum.KeyCode.Insert -- Yeni değişken
    local isListening = false -- Yeni değişken
    local autoBuyEnabled = false
    local currentBuyTarget = nil
    local lockedToBuyTarget = false
    local buyConnections = {}
    local autoFarmFirstPurchaseCompleted = false -- YENİ: İlk satın alım tamamlandı mı?
    local autoFarmTpLocked = false -- YENİ: Auto Farm için TP kilidi
    local autoFarmLockedCar = nil -- YENİ: Kilitlendiği araç
    
    -- AUTO TP KİLİT SİSTEMİ: Auto TP bir araca TP attığında o araca kilitlenir
    local autoTpLocked = false -- Auto TP kilidi aktif mi?
    local autoTpLockedCar = nil -- Auto TP'nin kilitlendiği araç

    -- UI oluştur
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "SiathESP_GUI"

    -- TP to Own Car Button (Ekranın orta üstünde)
    local TpToOwnCarButton = Instance.new("TextButton", ScreenGui)
    TpToOwnCarButton.Position = UDim2.new(0.5, -75, 0, 10) -- Orta üst
    TpToOwnCarButton.Size = UDim2.new(0, 150, 0, 40)
    TpToOwnCarButton.BackgroundColor3 = Color3.fromRGB(31, 24, 62) -- GUI renklerimiz (mor)
    TpToOwnCarButton.TextColor3 = Color3.new(1, 1, 1)
    TpToOwnCarButton.Text = "🚗 TP to Own Car"
    TpToOwnCarButton.Font = Enum.Font.GothamBold
    TpToOwnCarButton.TextSize = 14
    TpToOwnCarButton.AutoButtonColor = false
    TpToOwnCarButton.Active = true -- Dragging için gerekli
    Instance.new("UICorner", TpToOwnCarButton).CornerRadius = UDim.new(0, 10)

    -- TP to Own Car Button dragging değişkenleri
    local tpCarButtonDragging = false
    local tpCarButtonDragStart = nil
    local tpCarButtonStartPos = nil

    -- TP to Own Car Button dragging fonksiyonalitesi
    TpToOwnCarButton.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            tpCarButtonDragging = true
            tpCarButtonDragStart = input.Position
            tpCarButtonStartPos = TpToOwnCarButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    tpCarButtonDragging = false
                end
            end)
        end
    end)

    -- GUI boyut hafızası değişkenleri
    local savedMainFrameSize = UDim2.new(0, 700, 0, 600) -- Varsayılan boyut
    local savedMainFramePosition = UDim2.new(0.05, 0, 0.1, 0) -- Varsayılan pozisyon

    -- Ana Frame boyutunu güncelle
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Position = savedMainFramePosition
    MainFrame.Size = savedMainFrameSize -- Başlangıçta doğru boyutta göster
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 13, 23)
    MainFrame.Active = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

    -- Mini GUI (Yuvarlak)
    local MiniFrame = Instance.new("Frame", ScreenGui)
    MiniFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
    MiniFrame.Size = UDim2.new(0, 80, 0, 80)
    MiniFrame.BackgroundColor3 = Color3.fromRGB(31, 24, 62)
    MiniFrame.Active = true
    MiniFrame.Visible = false
    Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0.5, 0)

    local MiniLabel = Instance.new("TextLabel", MiniFrame)
    MiniLabel.Size = UDim2.new(1, 0, 1, 0)
    MiniLabel.BackgroundTransparency = 1
    MiniLabel.Text = "ACNE"
    MiniLabel.TextColor3 = Color3.new(1, 1, 1)
    MiniLabel.Font = Enum.Font.GothamBold
    MiniLabel.TextSize = 16
    MiniLabel.TextScaled = true

    -- Dragging değişkenlerini tanımla (TAŞINDI - EN ÜSTE)
    -- Dragging değişkenlerini tanımla
    local dragging = false
    local dragStart = nil
    local startPos = nil

    -- Mini GUI dragging değişkenleri
    local miniDragging = false
    local miniDragStart = nil
    local miniStartPos = nil

    -- Resizing değişkenleri
    local resizing = false
    local resizeStart = nil
    local startSize = nil

    -- Mini GUI dragging
    MiniFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            miniDragging = true
            miniDragStart = input.Position
            miniStartPos = MiniFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    miniDragging = false
                end
            end)
        end
    end)

    local MiniButton = Instance.new("TextButton", MiniFrame)
    MiniButton.Size = UDim2.new(1, 0, 1, 0)
    MiniButton.BackgroundTransparency = 1
    MiniButton.Text = ""
    MiniButton.AutoButtonColor = false

    MiniButton.MouseButton1Click:Connect(function()
        if miniDragging then return end
        
        -- Mini GUI'yi gizle ve ana GUI'yi göster
        guiMinimized = false
        
        -- Mini GUI pozisyonunu ana GUI için kaydet
        savedMainFramePosition = MiniFrame.Position
        
        TweenService:Create(MiniFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        task.spawn(function()
            task.wait(0.1)
            MainFrame.Visible = true
            MainFrame.Position = savedMainFramePosition
            MainFrame.Size = UDim2.new(0, 0, 0, 0) -- 0'dan başlat
            
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = savedMainFrameSize -- Kaydedilen boyuta animasyon
            }):Play()
            
            task.wait(0.4)
            MiniFrame.Visible = false
            MiniFrame.Size = UDim2.new(0, 80, 0, 80) -- Reset boyut
        end)
    end)

    -- Başlık
    local Title = Instance.new("TextLabel", MainFrame)
    Title.Size = UDim2.new(1,0,0,40)
    Title.BackgroundColor3 = Color3.fromRGB(31, 24, 62)
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Text = "ACNE"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0,12)


    -- Küçültme Butonu
    local MinimizeButton = Instance.new("TextButton", Title)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -35, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    MinimizeButton.TextColor3 = Color3.new(1,1,1)
    MinimizeButton.Text = "_"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 20
    MinimizeButton.AutoButtonColor = false
    Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 6)

    -- Dragging events (DÜZENLE - Title objesi oluşturulduktan sonra)
    Title.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and input.Position.X < MinimizeButton.AbsolutePosition.X then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    -- Yeni pozisyonu kaydet
                    savedMainFramePosition = MainFrame.Position
                    print("Dragging ended - New saved position:", savedMainFramePosition) -- Debug
                end
            end)
        end
    end)

    -- Minimize Button Event (DÜZENLE)
    MinimizeButton.MouseButton1Click:Connect(function()
        guiMinimized = true
        
        -- Mevcut boyut ve pozisyonu kaydet
        savedMainFrameSize = MainFrame.Size
        savedMainFramePosition = MainFrame.Position
        
        print("Minimizing - Saved size:", savedMainFrameSize, "Saved position:", savedMainFramePosition) -- Debug
        
        -- Ana GUI'yi gizle
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        -- Mini GUI'yi MainFrame pozisyonuna getir ve göster
        MiniFrame.Position = MainFrame.Position
        MiniFrame.Visible = true
        MiniFrame.Size = UDim2.new(0, 0, 0, 0)
        
        task.spawn(function()
            task.wait(0.1)
            TweenService:Create(MiniFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 80, 0, 80)
            }):Play()
            
            task.wait(0.3)
            MainFrame.Visible = false
        end)
    end)

    -- INSERT tuşu toggle sistemi (DÜZENLE)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if isListening then return end
        
        if input.KeyCode == toggleKey then
            guiVisible = not guiVisible
            
            if guiVisible then
                -- GUI'yi göster
                ScreenGui.Enabled = true
                
                if guiMinimized then
                    -- Mini GUI'yi göster
                    MiniFrame.Position = savedMainFramePosition
                    MiniFrame.Visible = true
                    MiniFrame.Size = UDim2.new(0, 0, 0, 0)
                    TweenService:Create(MiniFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, 80, 0, 80)
                    }):Play()
                else
                    -- Ana GUI'yi göster
                    MainFrame.Position = savedMainFramePosition
                    MainFrame.Visible = true
                    MainFrame.Size = UDim2.new(0, 0, 0, 0)
                    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = savedMainFrameSize
                    }):Play()
                end
            else
                -- GUI'yi gizle
                if guiMinimized then
                    -- Mevcut pozisyonu kaydet
                    savedMainFramePosition = MiniFrame.Position
                    
                    TweenService:Create(MiniFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = UDim2.new(0, 0, 0, 0)
                    }):Play()
                    task.spawn(function()
                        task.wait(0.3)
                        MiniFrame.Visible = false
                        ScreenGui.Enabled = false
                        MiniFrame.Size = UDim2.new(0, 80, 0, 80) -- Reset
                    end)
                else
                    -- Mevcut boyut ve pozisyonu kaydet
                    savedMainFrameSize = MainFrame.Size
                    savedMainFramePosition = MainFrame.Position
                    
                    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = UDim2.new(0, 0, 0, 0)
                    }):Play()
                    task.spawn(function()
                        task.wait(0.3)
                        MainFrame.Visible = false
                        ScreenGui.Enabled = false
                    end)
                end
            end
        end
    end)

    -- Resize handle (Title ve diğer elementler oluşturulduktan sonra)
    local ResizeHandle = Instance.new("Frame", MainFrame)
    ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
    ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
    ResizeHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    ResizeHandle.BackgroundTransparency = 0.3
    Instance.new("UICorner", ResizeHandle).CornerRadius = UDim.new(0, 8)

    local ResizeIcon = Instance.new("TextLabel", ResizeHandle)
    ResizeIcon.Size = UDim2.new(1, 0, 1, 0)
    ResizeIcon.BackgroundTransparency = 1
    ResizeIcon.Text = "↘"
    ResizeIcon.TextColor3 = Color3.new(1, 1, 1)
    ResizeIcon.TextScaled = true
    ResizeIcon.Font = Enum.Font.GothamBold

    -- Resizing sistem
    ResizeHandle.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not guiMinimized then
            resizing = true
            resizeStart = input.Position
            startSize = MainFrame.Size
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                    -- Yeni boyutu kaydet
                    savedMainFrameSize = MainFrame.Size
                    print("Resizing ended - New saved size:", savedMainFrameSize) -- Debug
                end
            end)
        end
    end)


    -- Tab Frame
    local TabFrame = Instance.new("ScrollingFrame", MainFrame)
    TabFrame.Position = UDim2.new(0,10,0,50)
    TabFrame.Size = UDim2.new(1,-20,0,40)
    TabFrame.BackgroundColor3 = Color3.fromRGB(13, 19, 32)
    TabFrame.ScrollBarThickness = 6
    TabFrame.ScrollingDirection = Enum.ScrollingDirection.X 
    Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0,8)
    
    -- UIListLayout
    local TabLayout = Instance.new("UIListLayout", TabFrame)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left 
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 6)

    -- update Size for Scrolling
    local function updateCanvasSize()
    TabFrame.CanvasSize = UDim2.new(0, TabLayout.AbsoluteContentSize.X + 10, 0, 0)
end
TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
updateCanvasSize()

    -- Tab Frame - Doğru sıralama ve konumlar
    local ESPTab = Instance.new("TextButton", TabFrame)
    ESPTab.Position = UDim2.new(0,5,0,5)
    ESPTab.Size = UDim2.new(0, 100, 1, -10)
    ESPTab.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    ESPTab.TextColor3 = Color3.new(1,1,1)
    ESPTab.Text = "ESP"
    ESPTab.Font = Enum.Font.GothamBold
    ESPTab.TextSize = 14
    ESPTab.AutoButtonColor = false
    Instance.new("UICorner", ESPTab).CornerRadius = UDim.new(0,6)

    local AutoTPTab = Instance.new("TextButton", TabFrame)
    AutoTPTab.Position = UDim2.new(0.16,0,0,5)
    AutoTPTab.Size = UDim2.new(0, 80, 1, -10)
    AutoTPTab.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    AutoTPTab.TextColor3 = Color3.new(1,1,1)
    AutoTPTab.Text = "Auto TP"
    AutoTPTab.Font = Enum.Font.GothamBold
    AutoTPTab.TextSize = 14
    AutoTPTab.AutoButtonColor = false
    Instance.new("UICorner", AutoTPTab).CornerRadius = UDim.new(0,6)

    local PlayerTab = Instance.new("TextButton", TabFrame)
    PlayerTab.Position = UDim2.new(0.32,0,0,5)
    PlayerTab.Size = UDim2.new(0, 80, 1, -10)
    PlayerTab.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    PlayerTab.TextColor3 = Color3.new(1,1,1)
    PlayerTab.Text = "Player"
    PlayerTab.Font = Enum.Font.GothamBold
    PlayerTab.TextSize = 14
    PlayerTab.AutoButtonColor = false
    Instance.new("UICorner", PlayerTab).CornerRadius = UDim.new(0,6)

    local VisualTab = Instance.new("TextButton", TabFrame)
    VisualTab.Position = UDim2.new(0.48,0,0,5)
    VisualTab.Size = UDim2.new(0, 80, 1, -10)
    VisualTab.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    VisualTab.TextColor3 = Color3.new(1,1,1)
    VisualTab.Text = "Visual"
    VisualTab.Font = Enum.Font.GothamBold
    VisualTab.TextSize = 14
    VisualTab.AutoButtonColor = false
    Instance.new("UICorner", VisualTab).CornerRadius = UDim.new(0,6)

    local TeleportsTab = Instance.new("TextButton", TabFrame)
    TeleportsTab.Position = UDim2.new(0.64,0,0,5)
    TeleportsTab.Size = UDim2.new(0, 80, 1, -10)
    TeleportsTab.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    TeleportsTab.TextColor3 = Color3.new(1,1,1)
    TeleportsTab.Text = "Teleports"
    TeleportsTab.Font = Enum.Font.GothamBold
    TeleportsTab.TextSize = 14
    TeleportsTab.AutoButtonColor = false
    Instance.new("UICorner", TeleportsTab).CornerRadius = UDim.new(0,6)

    local MiscTab = Instance.new("TextButton", TabFrame)
    MiscTab.Position = UDim2.new(0.80,3,0,5)
    MiscTab.Size = UDim2.new(0, 80, 1, -10)
    MiscTab.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    MiscTab.TextColor3 = Color3.new(1,1,1)
    MiscTab.Text = "Misc"
    MiscTab.Font = Enum.Font.GothamBold
    MiscTab.TextSize = 14
    MiscTab.AutoButtonColor = false
    Instance.new("UICorner", MiscTab).CornerRadius = UDim.new(0, 6)

    local SettingsTab = Instance.new("TextButton", TabFrame)
    SettingsTab.Position = UDim2.new(0.96,0,0,5)
    SettingsTab.Size = UDim2.new(0, 80, 1, -10)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    SettingsTab.TextColor3 = Color3.new(1,1,1)
    SettingsTab.Text = "Settings"
    SettingsTab.Font = Enum.Font.GothamBold
    SettingsTab.TextSize = 14
    SettingsTab.AutoButtonColor = false
    Instance.new("UICorner", SettingsTab).CornerRadius = UDim.new(0,6)  


    -- Content Frame
    local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
    ContentFrame.Position = UDim2.new(0,10,0,100)
    ContentFrame.Size = UDim2.new(1,-20,1,-110)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 6
    ContentFrame.CanvasSize = UDim2.new(0,0,0,800) -- Paint dropdown için yeterli alan
    ContentFrame.BorderSizePixel = 0

    --Misc Content
    local MiscContent = Instance.new("Frame", ContentFrame)
    MiscContent.Size = UDim2.new(1,0,1,0)
    MiscContent.BackgroundTransparency = 1
    MiscContent.Visible = false
    

    local MiscTitle = Instance.new("TextLabel", MiscContent)
    MiscTitle.Position = UDim2.new(0,10,0,10)
    MiscTitle.Size = UDim2.new(1,-20,0,30)
    MiscTitle.BackgroundTransparency = 1
    MiscTitle.TextColor3 = Color3.fromRGB(107, 224, 242)
    MiscTitle.Text = "Misc"
    MiscTitle.TextXAlignment = Enum.TextXAlignment.Left
    MiscTitle.Font = Enum.Font.GothamBold
    MiscTitle.TextSize = 20

    local AutoKMSButton = Instance.new("TextButton", MiscContent)
    AutoKMSButton.Position = UDim2.new(0,10,0,50)
    AutoKMSButton.Size = UDim2.new(0, 180, 0, 40)
    AutoKMSButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    AutoKMSButton.TextColor3 = Color3.new(1, 1, 1)
    AutoKMSButton.Text = "Auto KMs: OFF"
    AutoKMSButton.Font = Enum.Font.GothamBold
    AutoKMSButton.TextSize = 18
    AutoKMSButton.AutoButtonColor = false
    Instance.new("UICorner", AutoKMSButton).CornerRadius = UDim.new(0,10)

    local RejoinButton = Instance.new("TextButton", MiscContent)
    RejoinButton.Position = UDim2.new(0,205,0,105)
    RejoinButton.Size = UDim2.new(0, 180, 0, 40)
    RejoinButton.BackgroundColor3 = Color3.fromRGB(100,150,255)
    RejoinButton.TextColor3 = Color3.new(1, 1, 1)
    RejoinButton.Text = "Rejoin Server"
    RejoinButton.Font = Enum.Font.GothamBold
    RejoinButton.TextSize = 18
    RejoinButton.AutoButtonColor = false
    Instance.new("UICorner", RejoinButton).CornerRadius = UDim.new(0,10)
        
    local JoinServerButton = Instance.new("TextButton", MiscContent)
    JoinServerButton.Position = UDim2.new(0,205,0,50)
    JoinServerButton.Size = UDim2.new(0,180,0,40)
    JoinServerButton.BackgroundColor3 = Color3.fromRGB(100,150,255)
    JoinServerButton.TextColor3 = Color3.new(1,1,1)
    JoinServerButton.Text = "Hop to Lowest Server"
    JoinServerButton.Font = Enum.Font.GothamBold
    JoinServerButton.TextSize = 16
    JoinServerButton.AutoButtonColor = false
    Instance.new("UICorner", JoinServerButton).CornerRadius = UDim.new(0,10)

    -- Repair Car Button - Join Random Server'ın yanında
    local RepairCarButton = Instance.new("TextButton", MiscContent)
    RepairCarButton.Position = UDim2.new(0,400,0,50) -- Join Random Server'ın sağında
    RepairCarButton.Size = UDim2.new(0,180,0,40)
    RepairCarButton.BackgroundColor3 = Color3.fromRGB(255,100,50) -- Turuncu renk
    RepairCarButton.TextColor3 = Color3.new(1,1,1)
    RepairCarButton.Text = "🔧 Repair Car"
    RepairCarButton.Font = Enum.Font.GothamBold
    RepairCarButton.TextSize = 16
    RepairCarButton.AutoButtonColor = false
    Instance.new("UICorner", RepairCarButton).CornerRadius = UDim.new(0,10)

    -- Randomize Color Checkbox (RepairCarButton'un altında)
    local randomizeColorEnabled = false
    
    local RandomizeColorFrame = Instance.new("Frame", MiscContent)
    RandomizeColorFrame.Position = UDim2.new(0,400,0,95) -- RepairCarButton'un 5 piksel altında
    RandomizeColorFrame.Size = UDim2.new(0,180,0,20)
    RandomizeColorFrame.BackgroundTransparency = 1
    
    local RandomizeColorCheckbox = Instance.new("TextButton", RandomizeColorFrame)
    RandomizeColorCheckbox.Position = UDim2.new(0,0,0,0)
    RandomizeColorCheckbox.Size = UDim2.new(0,16,0,16)
    RandomizeColorCheckbox.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    RandomizeColorCheckbox.BorderSizePixel = 1
    RandomizeColorCheckbox.BorderColor3 = Color3.fromRGB(100,100,120)
    RandomizeColorCheckbox.Text = ""
    RandomizeColorCheckbox.AutoButtonColor = false
    Instance.new("UICorner", RandomizeColorCheckbox).CornerRadius = UDim.new(0,2)
    
    local RandomizeColorLabel = Instance.new("TextLabel", RandomizeColorFrame)
    RandomizeColorLabel.Position = UDim2.new(0,22,0,0)
    RandomizeColorLabel.Size = UDim2.new(0,158,0,16)
    RandomizeColorLabel.BackgroundTransparency = 1
    RandomizeColorLabel.Text = "Randomize Color"
    RandomizeColorLabel.TextColor3 = Color3.fromRGB(180,180,180) -- Soluk gri renk
    RandomizeColorLabel.Font = Enum.Font.Gotham
    RandomizeColorLabel.TextSize = 12
    RandomizeColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Checkbox işlevselliği
    local function updateRandomizeColorCheckbox()
        if randomizeColorEnabled then
            RandomizeColorCheckbox.BackgroundColor3 = Color3.fromRGB(100,200,100)
            RandomizeColorCheckbox.Text = "✓"
            RandomizeColorCheckbox.TextColor3 = Color3.new(1,1,1)
            RandomizeColorCheckbox.Font = Enum.Font.GothamBold
            RandomizeColorCheckbox.TextSize = 12
        else
            RandomizeColorCheckbox.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
            RandomizeColorCheckbox.Text = ""
        end
    end
    
    RandomizeColorCheckbox.MouseButton1Click:Connect(function()
        randomizeColorEnabled = not randomizeColorEnabled
        updateRandomizeColorCheckbox()
        print("🎨 Randomize Color:", randomizeColorEnabled and "ENABLED" or "DISABLED")
    end)
    
    -- Başlangıçta checkbox'u güncelle
    updateRandomizeColorCheckbox()

    -- ESP Content
    local ESPContent = Instance.new("Frame", ContentFrame)
    ESPContent.Size = UDim2.new(1,0,1,0)
    ESPContent.BackgroundTransparency = 1
    ESPContent.Visible = true

    

    local ESPButton = Instance.new("TextButton", ESPContent)
    ESPButton.Position = UDim2.new(0,10,0,10)
    ESPButton.Size = UDim2.new(0,180,0,40)
    ESPButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111) -- Mor (kapalı)
    ESPButton.TextColor3 = Color3.new(1,1,1)
    ESPButton.Text = "ESP: OFF"
    ESPButton.Font = Enum.Font.GothamBold
    ESPButton.TextSize = 18
    ESPButton.AutoButtonColor = false
    Instance.new("UICorner", ESPButton).CornerRadius = UDim.new(0,10)

    local TeleportTitle = Instance.new("TextLabel", ESPContent)
    TeleportTitle.Position = UDim2.new(0,10,0,65)
    TeleportTitle.Size = UDim2.new(1,-20,0,25)
    TeleportTitle.BackgroundTransparency = 1
    TeleportTitle.TextColor3 = Color3.fromRGB(107, 224, 242)
    TeleportTitle.Text = "Teleport to Cars"
    TeleportTitle.TextXAlignment = Enum.TextXAlignment.Left
    TeleportTitle.Font = Enum.Font.GothamBold
    TeleportTitle.TextSize = 20

    local CarList = Instance.new("ScrollingFrame", ESPContent)
    CarList.Position = UDim2.new(0,10,0,100)
    CarList.Size = UDim2.new(1,-20,1,-110)
    CarList.BackgroundColor3 = Color3.fromRGB(16, 22, 36)
    CarList.ScrollBarThickness = 8
    CarList.CanvasSize = UDim2.new(0,0,0,0)
    Instance.new("UICorner", CarList).CornerRadius = UDim.new(0,10)

    local respawnBox = Instance.new("TextLabel", ESPContent)
    respawnBox.Size = UDim2.new(0,240,0,40)
    respawnBox.Position = UDim2.new(0,200,0,10) 
    respawnBox.BackgroundColor3 = Color3.fromRGB(16, 22, 36)
    respawnBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    respawnBox.TextSize = 18
    respawnBox.Font = Enum.Font.GothamBold
    respawnBox.Text = ""
    respawnBox.Name = "RespawnTimeBox"
    respawnBox.Visible = false
    respawnBox.BorderSizePixel = 0
    respawnBox.BackgroundTransparency = 0

    local function cleanRespawnText(text)
        return text:gsub("%[PRIVATE SERVER%]%s*", "")
    end

    local function updateRespawnTime()
        local junkyardRespawn = workspace.Map:FindFirstChild("FirstCity")
                and workspace.Map.FirstCity:FindFirstChild("Junkyard")
                        and workspace.Map.FirstCity.Junkyard:FindFirstChild("JunkyardRespawn")
                            if not junkyardRespawn then return end

                            local screen = junkyardRespawn:FindFirstChild("Screen")
                                if not screen then return end

                                local surfaceGui = screen:FindFirstChild("SurfaceGui")
                                    if not surfaceGui then return end

                                    local textLabel = surfaceGui:FindFirstChild("TextLabel")
                                    if textLabel and textLabel.Text then
                                        respawnBox.Text = cleanRespawnText(textLabel.Text)
                                    end
                                end

                                game:GetService("RunService").RenderStepped:Connect(updateRespawnTime)


    -- Auto TP Content
    local AutoTPContent = Instance.new("Frame", ContentFrame)
    AutoTPContent.Size = UDim2.new(1,0,1,0)
    AutoTPContent.BackgroundTransparency = 1
    AutoTPContent.Visible = false

    local AutoTPButton = Instance.new("TextButton", AutoTPContent)
    AutoTPButton.Position = UDim2.new(0,10,0,10)
    AutoTPButton.Size = UDim2.new(0,150,0,35)
    AutoTPButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111) -- Mor (kapalı)
    AutoTPButton.TextColor3 = Color3.new(1,1,1)
    AutoTPButton.Text = "Auto TP: OFF"
    AutoTPButton.Font = Enum.Font.GothamBold
    AutoTPButton.TextSize = 16
    AutoTPButton.AutoButtonColor = false
    Instance.new("UICorner", AutoTPButton).CornerRadius = UDim.new(0,8)

    local AutoBuyButton = Instance.new("TextButton", AutoTPContent)
    AutoBuyButton.Position = UDim2.new(0,280,0,10)
    AutoBuyButton.Size = UDim2.new(0,150,0,35)
    AutoBuyButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111) -- Mor (kapalı)
    AutoBuyButton.TextColor3 = Color3.new(1,1,1)
    AutoBuyButton.Text = "Auto Buy: OFF"
    AutoBuyButton.Font = Enum.Font.GothamBold
    AutoBuyButton.TextSize = 16
    AutoBuyButton.AutoButtonColor = false
    Instance.new("UICorner", AutoBuyButton).CornerRadius = UDim.new(0,8)

    local AutoFarmButton = Instance.new("TextButton", AutoTPContent)
    AutoFarmButton.Position = UDim2.new(0,10,0,310)
    AutoFarmButton.Size = UDim2.new(0,150,0,35)
    AutoFarmButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111) -- Mor (kapalı)
    AutoFarmButton.TextColor3 = Color3.new(1,1,1)
    AutoFarmButton.Text = "Auto Farm: OFF"
    AutoFarmButton.Font = Enum.Font.GothamBold
    AutoFarmButton.TextSize = 16
    AutoFarmButton.AutoButtonColor = false
    Instance.new("UICorner", AutoFarmButton).CornerRadius = UDim.new(0,8)

    local CountBox = Instance.new("TextBox", AutoTPContent)
    CountBox.Position = UDim2.new(0,170,0,312)
    CountBox.Size = UDim2.new(0, 80, 0, 30)
    CountBox.PlaceholderText = "1-10"
    CountBox.Text = "1"
    CountBox.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    CountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    CountBox.Font = Enum.Font.SourceSansBold
    CountBox.TextSize = 22
    Instance.new("UICorner", CountBox).CornerRadius = UDim.new(0,8)

    local CountBoxStatusLabel = Instance.new("TextLabel", AutoTPContent)
    CountBoxStatusLabel.Position = UDim2.new(0,170,0,337)
    CountBoxStatusLabel.Size = UDim2.new(1,-230,0,40)
    CountBoxStatusLabel.BackgroundTransparency = 1
    CountBoxStatusLabel.Text = "Put the Number that\nyou want to Autofarm in a Round"
    CountBoxStatusLabel.TextColor3 = Color3.fromRGB(150,150,150)
    CountBoxStatusLabel.Font = Enum.Font.Gotham
    CountBoxStatusLabel.TextSize = 14
    CountBoxStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    CountBoxStatusLabel.TextWrapped = true

    local ClearButton = Instance.new("TextButton", AutoTPContent)
    ClearButton.Position = UDim2.new(0,170,0,10)
    ClearButton.Size = UDim2.new(0,100,0,35)
    ClearButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
    ClearButton.TextColor3 = Color3.new(1,1,1)
    ClearButton.Text = "Clear All"
    ClearButton.Font = Enum.Font.GothamBold
    ClearButton.TextSize = 16
    ClearButton.AutoButtonColor = false
    Instance.new("UICorner", ClearButton).CornerRadius = UDim.new(0,8)

    local DropdownFrame = Instance.new("Frame", AutoTPContent)
    DropdownFrame.Position = UDim2.new(0,10,0,55)
    DropdownFrame.Size = UDim2.new(1,-20,0,35)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0,8)

    local DropdownButton = Instance.new("TextButton", DropdownFrame)
    DropdownButton.Size = UDim2.new(1,-25,1,0)
    DropdownButton.Position = UDim2.new(0,0,0,0)
    DropdownButton.BackgroundTransparency = 1
    DropdownButton.Text = "Select Cars for Auto TP (Multi-select enabled)"
    DropdownButton.TextColor3 = Color3.new(1,1,1)
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.TextSize = 14
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left

    local DropdownArrow = Instance.new("TextLabel", DropdownFrame)
    DropdownArrow.Size = UDim2.new(0,25,1,0)
    DropdownArrow.Position = UDim2.new(1,-25,0,0)
    DropdownArrow.BackgroundTransparency = 1
    DropdownArrow.Text = "▼"
    DropdownArrow.TextColor3 = Color3.new(1,1,1)
    DropdownArrow.Font = Enum.Font.GothamBold
    DropdownArrow.TextSize = 14

    local DropdownList = Instance.new("ScrollingFrame", AutoTPContent)
    DropdownList.Position = UDim2.new(0,10,0,95)
    DropdownList.Size = UDim2.new(1,-20,0,0)
    DropdownList.BackgroundColor3 = Color3.fromRGB(13, 19, 32)
    DropdownList.ScrollBarThickness = 6
    DropdownList.Visible = false
    DropdownList.CanvasSize = UDim2.new(0,0,0,0)
    Instance.new("UICorner", DropdownList).CornerRadius = UDim.new(0,8)

    local dropdownOpen = false

    local VisualContent = Instance.new("Frame", ContentFrame)
    VisualContent.Size = UDim2.new(1,0,1,0)
    VisualContent.BackgroundTransparency = 1
    VisualContent.Visible = false

    -- Seçilen araç değişkeni
    local selectedCar = nil
    local selectedPaintColor = Color3.new(1, 0, 0)

    local VisualTitle = Instance.new("TextLabel", VisualContent)
    VisualTitle.Position = UDim2.new(0,10,0,10)
    VisualTitle.Size = UDim2.new(1,-20,0,30)
    VisualTitle.BackgroundTransparency = 1
    VisualTitle.TextColor3 = Color3.fromRGB(107, 224, 242)
    VisualTitle.Text = "Visual Features"
    VisualTitle.TextXAlignment = Enum.TextXAlignment.Left
    VisualTitle.Font = Enum.Font.GothamBold
    VisualTitle.TextSize = 20

    -- Paint Dropdown Frame
    local PaintDropdownFrame = Instance.new("Frame", VisualContent)
    PaintDropdownFrame.Position = UDim2.new(0,10,0,50)
    PaintDropdownFrame.Size = UDim2.new(1,-20,0,45)
    PaintDropdownFrame.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    Instance.new("UICorner", PaintDropdownFrame).CornerRadius = UDim.new(0,8)

    -- Paint Dropdown Header Button
    local PaintDropdownButton = Instance.new("TextButton", PaintDropdownFrame)
    PaintDropdownButton.Size = UDim2.new(1,-35,1,0)
    PaintDropdownButton.Position = UDim2.new(0,5,0,0)
    PaintDropdownButton.BackgroundTransparency = 1
    PaintDropdownButton.Text = "🎨 Vehicle Paint Tool"
    PaintDropdownButton.TextColor3 = Color3.new(1,1,1)
    PaintDropdownButton.Font = Enum.Font.GothamBold
    PaintDropdownButton.TextSize = 16
    PaintDropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    PaintDropdownButton.AutoButtonColor = false

    -- Paint Dropdown Arrow
    local PaintDropdownArrow = Instance.new("TextLabel", PaintDropdownFrame)
    PaintDropdownArrow.Size = UDim2.new(0,30,1,0)
    PaintDropdownArrow.Position = UDim2.new(1,-30,0,0)
    PaintDropdownArrow.BackgroundTransparency = 1
    PaintDropdownArrow.Text = "▼"
    PaintDropdownArrow.TextColor3 = Color3.new(1,1,1)
    PaintDropdownArrow.Font = Enum.Font.GothamBold
    PaintDropdownArrow.TextSize = 14

    -- Paint Content Frame (Hidden by default)
    local PaintContentFrame = Instance.new("Frame", VisualContent)
    PaintContentFrame.Position = UDim2.new(0,10,0,105)
    PaintContentFrame.Size = UDim2.new(1,-20,0,0) -- Başlangıçta kapalı
    PaintContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,45)
    PaintContentFrame.Visible = false
    Instance.new("UICorner", PaintContentFrame).CornerRadius = UDim.new(0,8)

    -- Paint dropdown state
    local paintDropdownOpen = false

    -- Paint içeriği - Araç listesi frame (Optimize edilmiş boyut)
    local CarListFrame = Instance.new("Frame", PaintContentFrame)
    CarListFrame.Position = UDim2.new(0,8,0,8)
    CarListFrame.Size = UDim2.new(0.48,-8,1,-16)
    CarListFrame.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    Instance.new("UICorner", CarListFrame).CornerRadius = UDim.new(0,8)

    local CarListTitle = Instance.new("TextLabel", CarListFrame)
    CarListTitle.Position = UDim2.new(0,8,0,5)
    CarListTitle.Size = UDim2.new(1,-16,0,22)
    CarListTitle.BackgroundTransparency = 1
    CarListTitle.Text = "Your Vehicles (2 studs)"
    CarListTitle.TextColor3 = Color3.fromRGB(255,255,255)
    CarListTitle.Font = Enum.Font.GothamBold
    CarListTitle.TextSize = 12
    CarListTitle.TextXAlignment = Enum.TextXAlignment.Left

    local CarListPaint = Instance.new("ScrollingFrame", CarListFrame)
    CarListPaint.Position = UDim2.new(0,4,0,30)
    CarListPaint.Size = UDim2.new(1,-8,1,-35)
    CarListPaint.BackgroundColor3 = Color3.fromRGB(13, 19, 32)
    CarListPaint.ScrollBarThickness = 4
    CarListPaint.CanvasSize = UDim2.new(0,0,0,0)
    CarListPaint.BorderSizePixel = 0
    Instance.new("UICorner", CarListPaint).CornerRadius = UDim.new(0,6)

    -- Paint Controls Frame
    local PaintControlsFrame = Instance.new("Frame", PaintContentFrame)
    PaintControlsFrame.Position = UDim2.new(0.52, 0, 0, 8)
    PaintControlsFrame.Size = UDim2.new(0.48, -8, 1, -16)
    PaintControlsFrame.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    Instance.new("UICorner", PaintControlsFrame).CornerRadius = UDim.new(0, 8)

    local PaintTitle = Instance.new("TextLabel", PaintControlsFrame)
    PaintTitle.Position = UDim2.new(0, 8, 0, 5)
    PaintTitle.Size = UDim2.new(1, -16, 0, 22)
    PaintTitle.BackgroundTransparency = 1
    PaintTitle.Text = "Paint Controls"
    PaintTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    PaintTitle.Font = Enum.Font.GothamBold
    PaintTitle.TextSize = 12
    PaintTitle.TextXAlignment = Enum.TextXAlignment.Left

    local SelectedCarLabel = Instance.new("TextLabel", PaintControlsFrame)
    SelectedCarLabel.Position = UDim2.new(0, 8, 0, 30)
    SelectedCarLabel.Size = UDim2.new(1, -16, 0, 25)
    SelectedCarLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    SelectedCarLabel.TextColor3 = Color3.new(1, 1, 1)
    SelectedCarLabel.Text = "No vehicle selected"
    SelectedCarLabel.Font = Enum.Font.Gotham
    SelectedCarLabel.TextSize = 10
    SelectedCarLabel.TextWrapped = true
    Instance.new("UICorner", SelectedCarLabel).CornerRadius = UDim.new(0, 6)

    -- Renk paleti frame
    local ColorPaletteFrame = Instance.new("Frame", PaintControlsFrame)
    ColorPaletteFrame.Position = UDim2.new(0, 8, 0, 60)
    ColorPaletteFrame.Size = UDim2.new(1, -16, 0, 110)
    ColorPaletteFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Instance.new("UICorner", ColorPaletteFrame).CornerRadius = UDim.new(0, 8)

    -- Renk paleti başlığı
    local PaletteTitle = Instance.new("TextLabel", ColorPaletteFrame)
    PaletteTitle.Position = UDim2.new(0, 6, 0, 3)
    PaletteTitle.Size = UDim2.new(1, -12, 0, 18)
    PaletteTitle.BackgroundTransparency = 1
    PaletteTitle.Text = "Color Palette"
    PaletteTitle.TextColor3 = Color3.new(1, 1, 1)
    PaletteTitle.Font = Enum.Font.GothamBold
    PaletteTitle.TextSize = 10
    PaletteTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Renk paleti canvas
    local PaletteCanvas = Instance.new("Frame", ColorPaletteFrame)
    PaletteCanvas.Position = UDim2.new(0, 6, 0, 24)
    PaletteCanvas.Size = UDim2.new(0.65, -6, 0, 80)
    PaletteCanvas.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", PaletteCanvas).CornerRadius = UDim.new(0, 6)

    -- Renk seçici imleç
    local ColorCursor = Instance.new("Frame", PaletteCanvas)
    ColorCursor.Size = UDim2.new(0, 8, 0, 8)
    ColorCursor.BackgroundColor3 = Color3.new(0, 0, 0)
    ColorCursor.BackgroundTransparency = 0.5
    Instance.new("UICorner", ColorCursor).CornerRadius = UDim.new(0, 4)

    -- Seçilen renk preview
    local ColorPreview = Instance.new("Frame", ColorPaletteFrame)
    ColorPreview.Position = UDim2.new(0.68, 0, 0, 24)
    ColorPreview.Size = UDim2.new(0.32, -6, 0, 80)
    ColorPreview.BackgroundColor3 = selectedPaintColor
    Instance.new("UICorner", ColorPreview).CornerRadius = UDim.new(0, 6)

    local PreviewLabel = Instance.new("TextLabel", ColorPreview)
    PreviewLabel.Size = UDim2.new(1, 0, 1, 0)
    PreviewLabel.BackgroundTransparency = 1
    PreviewLabel.Text = "Selected\nColor"
    PreviewLabel.TextColor3 = Color3.new(1, 1, 1)
    PreviewLabel.Font = Enum.Font.Gotham
    PreviewLabel.TextSize = 8
    PreviewLabel.TextWrapped = true

    -- Color presets frame
    local ColorPresetsFrame = Instance.new("Frame", PaintControlsFrame)
    ColorPresetsFrame.Position = UDim2.new(0, 8, 0, 175)
    ColorPresetsFrame.Size = UDim2.new(1, -16, 0, 65)
    ColorPresetsFrame.BackgroundTransparency = 1

    -- Status label
    local StatusLabelPaint = Instance.new("TextLabel", PaintControlsFrame)
    StatusLabelPaint.Position = UDim2.new(0, 8, 0, 245)
    StatusLabelPaint.Size = UDim2.new(1, -16, 0, 25)
    StatusLabelPaint.BackgroundTransparency = 1
    StatusLabelPaint.TextColor3 = Color3.new(1, 1, 1)
    StatusLabelPaint.Text = "Select a vehicle from the list"
    StatusLabelPaint.Font = Enum.Font.Gotham
    StatusLabelPaint.TextSize = 9
    StatusLabelPaint.TextWrapped = true
    StatusLabelPaint.TextYAlignment = Enum.TextYAlignment.Top

    -- Paint butonu
    local PaintButton = Instance.new("TextButton", PaintControlsFrame)
    PaintButton.Position = UDim2.new(0, 8, 0, 275)
    PaintButton.Size = UDim2.new(1, -16, 0, 35)
    PaintButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    PaintButton.TextColor3 = Color3.new(1, 1, 1)
    PaintButton.Text = "Paint Vehicle"
    PaintButton.Font = Enum.Font.GothamBold
    PaintButton.TextSize = 14
    PaintButton.AutoButtonColor = false
    Instance.new("UICorner", PaintButton).CornerRadius = UDim.new(0, 8)

-- Visual Content bölümüne Parts ESP ekleyelim (Paint Dropdown'dan sonra)

-- ...existing code... (önceki kod aynı kalıyor)

-- Visual Content bölümüne Parts ESP ekleyelim (Paint Dropdown'dan sonra)

    local PARTS_ESP_BASE_Y = 105            -- Dropdown kapalı iken
    local PARTS_ESP_DROPDOWN_EXTRA = 320 + 10 -- Açılınca (içerik yüksekliği + boşluk)

    local PartsESPButton = Instance.new("TextButton", VisualContent)
    PartsESPButton.Position = UDim2.new(0,10,0,PARTS_ESP_BASE_Y)
    PartsESPButton.Size = UDim2.new(0,200,0,40)
    PartsESPButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    PartsESPButton.TextColor3 = Color3.new(1,1,1)
    PartsESPButton.Text = "Parts ESP: OFF"
    PartsESPButton.Font = Enum.Font.GothamBold
    PartsESPButton.TextSize = 16
    PartsESPButton.AutoButtonColor = false
    Instance.new("UICorner", PartsESPButton).CornerRadius = UDim.new(0,10)

    -- Parts ESP Variables
    local partsESPEnabled = false
    local activePartsESP = {}
    local partsESPConnections = {}

_G.acne_findAdornee = function(model)
    if model.PrimaryPart and model.PrimaryPart:IsA("BasePart") then
        return model.PrimaryPart
    end
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            return v
        end
    end
    return nil
end

-- Billboard oluştur
_G.acne_createBillboard = function(model, adornee)
    if model:FindFirstChild("WearBillboard") then
        return model.WearBillboard, model.WearBillboard:FindFirstChild("TextLabel")
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "WearBillboard"
    billboard.Size = UDim2.new(0, 120, 0, 36)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true -- ESP için true
    billboard.Adornee = adornee
    billboard.Parent = model

    local label = Instance.new("TextLabel")
    label.Name = "TextLabel"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.TextStrokeTransparency = 0.4
    label.Text = ""
    label.Parent = billboard

    return billboard, label
end

-- Modeli güncelle
-- Modeli güncelle
_G.acne_updatePartsModel = function(model)
    if not partsESPEnabled then return end

    local wear = model:GetAttribute("Wear")
    local owner = model:GetAttribute("Owner")

    if not wear or not owner then return end
    if owner ~= LocalPlayer.Name then return end

    local adornee = _G.acne_findAdornee(model)
    if not adornee then return end

    -- Mesafe hesapla
    local distance = math.huge
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        distance = (LocalPlayer.Character.HumanoidRootPart.Position - adornee.Position).Magnitude
    end

    local billboard, label = _G.acne_createBillboard(model, adornee)
    local highlight = model:FindFirstChild("Highlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.Parent = model
    end

    -- Aktif listede her zaman olsun
    activePartsESP[model] = { billboard = billboard, highlight = highlight }

    -- 50 stud kontrolü
    if distance > 100 then
        billboard.Enabled = false
        highlight.Enabled = false
        return
    else
        billboard.Enabled = true
        highlight.Enabled = true
    end

    -- Yazı ve highlight güncelle
    if wear > 0 then
        label.Text = string.format("Wear %%%d\n%.1f studs", wear, distance)
        label.TextColor3 = Color3.fromRGB(255, 0, 0)

        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 50, 50)
        highlight.FillTransparency = 0.5
    else
        label.Text = string.format("Wear %%0\n%.1f studs", distance)
        label.TextColor3 = Color3.fromRGB(0, 255, 0)

        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(50, 255, 50)
        highlight.FillTransparency = 0.5
    end
end


-- ESP temizle
_G.acne_clearAllPartsESP = function()
    for model, data in pairs(activePartsESP) do
        if data.billboard then pcall(function() data.billboard:Destroy() end) end
        if data.highlight then pcall(function() data.highlight:Destroy() end) end
    end
    activePartsESP = {}
end

-- Parts ESP başlat
_G.acne_enablePartsESP = function()
    local moveableParts = workspace:FindFirstChild("MoveableParts")
    if not moveableParts then return end

    -- Mevcut modeller
    for _, model in ipairs(moveableParts:GetChildren()) do
        if model:IsA("Model") then
            _G.acne_updatePartsModel(model)

            if not partsESPConnections[model] then
                partsESPConnections[model] = {}
            end

            partsESPConnections[model].wearConn = model:GetAttributeChangedSignal("Wear"):Connect(function()
                _G.acne_updatePartsModel(model)
            end)
            partsESPConnections[model].ownerConn = model:GetAttributeChangedSignal("Owner"):Connect(function()
                _G.acne_updatePartsModel(model)
            end)
        end
    end

    -- Yeni eklenenler
    partsESPConnections.childAddedConn = moveableParts.ChildAdded:Connect(function(model)
        if model:IsA("Model") then
            task.wait(0.1)
            _G.acne_updatePartsModel(model)

            if not partsESPConnections[model] then
                partsESPConnections[model] = {}
            end

            partsESPConnections[model].wearConn = model:GetAttributeChangedSignal("Wear"):Connect(function()
                _G.acne_updatePartsModel(model)
            end)
            partsESPConnections[model].ownerConn = model:GetAttributeChangedSignal("Owner"):Connect(function()
                _G.acne_updatePartsModel(model)
            end)
        end
    end)

    -- Silinenler
    partsESPConnections.childRemovedConn = moveableParts.ChildRemoved:Connect(function(model)
        if activePartsESP[model] then
            if activePartsESP[model].billboard then activePartsESP[model].billboard:Destroy() end
            if activePartsESP[model].highlight then activePartsESP[model].highlight:Destroy() end
            activePartsESP[model] = nil
        end
        if partsESPConnections[model] then
            if partsESPConnections[model].wearConn then partsESPConnections[model].wearConn:Disconnect() end
            if partsESPConnections[model].ownerConn then partsESPConnections[model].ownerConn:Disconnect() end
            partsESPConnections[model] = nil
        end
    end)

    -- Render loop
    partsESPConnections.renderSteppedConn = RunService.RenderStepped:Connect(function()
        if not partsESPEnabled then return end
        for model, _ in pairs(activePartsESP) do
            if model and model:IsDescendantOf(workspace) then
                _G.acne_updatePartsModel(model)
            end
        end
    end)
end

-- Parts ESP kapat
_G.acne_disablePartsESP = function()
    _G.acne_clearAllPartsESP()

    for model, connections in pairs(partsESPConnections) do
        if type(connections) == "table" then
            if connections.wearConn then connections.wearConn:Disconnect() end
            if connections.ownerConn then connections.ownerConn:Disconnect() end
        end
    end
    if partsESPConnections.childAddedConn then partsESPConnections.childAddedConn:Disconnect() end
    if partsESPConnections.childRemovedConn then partsESPConnections.childRemovedConn:Disconnect() end
    if partsESPConnections.renderSteppedConn then partsESPConnections.renderSteppedConn:Disconnect() end

    partsESPConnections = {}
end

-- // Buton event (senin GUI’ne uyacak şekilde bırakıyorum)

    -- AutoKMs Functions
    local TweenService = game:GetService("TweenService")
    local player = game.Players.LocalPlayer


    local function getLowestY(model)
        local lowestY = math.huge
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                local y = part.Position.Y - (part.Size.Y/1.5)
                if y < lowestY then
                    lowestY = y
                end
            end
        end
        return lowestY
    end

    local function getGroundedCFrame(model, targetCFrame)
        local lowestY = getLowestY(model)
        local offsetY = targetCFrame.Y - lowestY
        return CFrame.new(targetCFrame.X, targetCFrame.Y + offsetY, targetCFrame.Z) * CFrame.Angles(0,targetCFrame:ToEulerAnglesYXZ())
    end

    local startCFrame = CFrame.new(-2218, 0, 3013)
    local endCFrame = CFrame.new(-9920, 0, 2388)

    local function getPlayerVehicleModel()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local seatPart = humanoid.SeatPart
        if seatPart and seatPart:IsA("VehicleSeat") then
            return seatPart.Parent
        end
        return nil
    end

    local function autoSetPrimaryPart(model)
        if model.PrimaryPart then return true end
        for _, part in ipairs(model:GetChildren()) do
            if part:IsA("BasePart") then
                model.PrimaryPart = part
                return true
            end
        end
        return false
    end

    local isRunning = false
    local tweenLoop = nil

    local function starttweenLoop(vehicleModel)
        if not autoSetPrimaryPart(vehicleModel) then return end
        local cframeValue = Instance.new("CFrameValue")
        cframeValue.Value = getGroundedCFrame(vehicleModel, startCFrame)
        cframeValue:GetPropertyChangedSignal("Value"):Connect(function()
            vehicleModel:PivotTo(cframeValue.Value)
        end)
        local tweenInfo = TweenInfo.new(35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true)
        tweenLoop = TweenService:Create(
        cframeValue, tweenInfo,
        {Value = getGroundedCFrame(vehicleModel, endCFrame)})tweenLoop:Play()
    end

    local function stoptweenLoop()
        if tweenLoop then
            tweenLoop:Cancel()
            tweenLoop = nil
        end
    end

    -- Time Stamps Gui Auto KMs
    _G.CoreGui = game:GetService("CoreGui")

    _G.timerGui = Instance.new("ScreenGui")
    _G.timerGui.Name = "FarmKM_TimerGui"
    _G.timerGui.Parent = _G.CoreGui

    _G.farmKMFrame = Instance.new("Frame")
    _G.farmKMFrame.Size = UDim2.new(0, 230, 0, 62)
    _G.farmKMFrame.Position = UDim2.new(0.5, -115, 0, 20)
    _G.farmKMFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    _G.farmKMFrame.Parent = _G.timerGui
    _G.farmKMFrame.Visible = false

    _G.farmKMCorner = Instance.new("UICorner")
    _G.farmKMCorner.CornerRadius = UDim.new(0, 12)
    _G.farmKMCorner.Parent = _G.farmKMFrame

    _G.farmKMTimerLabel = Instance.new("TextLabel")
    _G.farmKMTimerLabel.Size = UDim2.new(1,0,0.5,0)
    _G.farmKMTimerLabel.Position = UDim2.new(0,0,0,0)
    _G.farmKMTimerLabel.BackgroundTransparency = 1
    _G.farmKMTimerLabel.Font = Enum.Font.GothamBold
    _G.farmKMTimerLabel.TextSize = 20
    _G.farmKMTimerLabel.TextColor3 = Color3.new(1,1,1)
    _G.farmKMTimerLabel.Text = "Time: 0:00"
    _G.farmKMTimerLabel.Parent = _G.farmKMFrame

    _G.farmKMCountLabel = Instance.new("TextLabel")
    _G.farmKMCountLabel.Size = UDim2.new(1,0,0.5,0)
    _G.farmKMCountLabel.Position = UDim2.new(0,0,0.5,0)
    _G.farmKMCountLabel.BackgroundTransparency = 1
    _G.farmKMCountLabel.Font = Enum.Font.GothamBold
    _G.farmKMCountLabel.TextSize = 20
    _G.farmKMCountLabel.TextColor3 = Color3.new(1,1,1)
    _G.farmKMCountLabel.Text = "Farmed KMs: 0.0"
    _G.farmKMCountLabel.Parent = _G.farmKMFrame

    _G.farmKMTimer = 0
    _G.farmKMStartValue = 0.0
    _G.farmKMActive = false

    function _G.toggleFarmKM(active)
        _G.farmKMActive = active
        local plr = game:GetService("Players").LocalPlayer
        local status = plr:FindFirstChild("PlayerData") and plr.PlayerData:FindFirstChild("Status")
        local kmStat = status and status:FindFirstChild("KMs")
        if active then
            _G.farmKMTimer = 0
            _G.farmKMStartValue = kmStat and tonumber(kmStat.Value) or 0.0
            _G.farmKMTimerLabel.Text = "Time: 0:00"
            _G.farmKMCountLabel.Text = "Farmed KMs: 0.0"
            _G.farmKMFrame.Visible = true
        else
            _G.farmKMFrame.Visible = false
        end
    end
    --== end of auto kms ==--

    --== autofarm functions ==--
    local tierOrder = {"S-Tier", "A-Tier", "B-Tier", "C-Tier", "D-Tier"}

    -- ConfirmationEvent
    function setupAutoConfirm()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local success, ConfirmationEvent = pcall(function()
            return ReplicatedStorage:WaitForChild("Events",5):WaitForChild("HUD",5):WaitForChild("Confirmation",5)
        end)
    
        if success and ConfirmationEvent then
            ConfirmationEvent.OnClientInvoke = function(message)
                return true
            end
        else
            warn("can't find ConfirmationEvent in ReplicatedStorage.Events.HUD.Confirmation")
        end
    end

    -- Search Meshid
    local function detectCarNameFromMesh(body)
        if not body then return nil end
        local found = false
        local carName
        local obj = body:FindFirstChild("Headlights")
        if obj then
            for _, light in ipairs(obj:GetChildren()) do
                local meshId = nil
                
                -- Güvenli MeshId kontrolü
                local success, result = pcall(function()
                    return light.MeshId
                end)
                
                if success and result then
                    meshId = result
                else
                    local specialMesh = light:FindFirstChildWhichIsA("SpecialMesh")
                    if specialMesh then
                        local success2, result2 = pcall(function()
                            return specialMesh.MeshId
                        end)
                        if success2 and result2 then
                            meshId = result2
                        end
                    end
                end
                
                if meshId and headlightMeshMap[meshId] then
                    carName = headlightMeshMap[meshId]
                    found = true
                    break
                end
            end
        end

        if not found then
            obj = body:FindFirstChild("ReverseLights")
            if obj then
                for _, light in ipairs(obj:GetChildren()) do
                    local meshId = nil
                    
                    -- Güvenli MeshId kontrolü
                    local success, result = pcall(function()
                        return light.MeshId
                    end)
                    
                    if success and result then
                        meshId = result
                    else
                        local specialMesh = light:FindFirstChildWhichIsA("SpecialMesh")
                        if specialMesh then
                            local success2, result2 = pcall(function()
                                return specialMesh.MeshId
                            end)
                            if success2 and result2 then
                                meshId = result2
                            end
                        end
                    end
                    
                    if meshId and reverselightsMeshMap[meshId] then
                        carName = reverselightsMeshMap[meshId]
                        found = true
                        break
                    end
                end
            end
        end
        return carName 
    end


    -- find highest cars (GELIŞTIRILMIŞ VERSİYON - TIER PRİORITESİ GARANTİLİ)
    -- Belirli bir araç ismini arar
    function findSpecificCar(targetCarName)
        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then 
            print("❌ Vehicles folder bulunamadı!")
            return nil 
        end

        print("🔍 " .. targetCarName .. " aranıyor. Toplam araç sayısı:", #Vehicles:GetChildren())
        
        -- Workspace'in tam yüklenmesini bekle
        wait(0.5)
        
        for _, model in ipairs(Vehicles:GetChildren()) do
            if model:GetAttribute("Junkyard") == true then
                local Body = model:FindFirstChild("Body")
                if Body then
                    local carName = detectCarNameFromMesh(Body)
                    if carName then
                        print("🚗 Bulundu:", carName, "(Aranan:", targetCarName .. ")")
                    end
                    if carName and carName == targetCarName then
                        -- Araç sahipli mi kontrol et
                        local isOwned = false
                        for _, bodyPart in ipairs(Body:GetChildren()) do
                            local ownerAttr = bodyPart:GetAttribute("owner")
                            if ownerAttr and ownerAttr ~= "" then
                                isOwned = true
                                break
                            end
                        end
                        
                        if not isOwned then
                            print("✅ Hedef araç bulundu:", targetCarName, "- Model:", model.Name)
                            return model
                        else
                            print("⚠️ Araç bulundu ama sahipli:", targetCarName)
                        end
                    end
                end
            end
        end
        
        return nil
    end

    function findHighestTierCar()
        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then 
            print("❌ Vehicles folder bulunamadı!")
            return nil 
        end

        local foundCars = {}  -- Her tier için bulunan araçları sakla
        
        -- Önce tüm uygun araçları kategorize et
        for _, model in ipairs(Vehicles:GetChildren()) do
            if model:GetAttribute("Junkyard") == true then
                local Body = model:FindFirstChild("Body")
                if Body then
                    local carName = detectCarNameFromMesh(Body)
                    if carName then
                        -- Araç sahipli mi kontrol et
                        local isOwned = false
                        for _, bodyPart in ipairs(Body:GetChildren()) do
                            local ownerAttr = bodyPart:GetAttribute("owner")
                            if ownerAttr and ownerAttr ~= "" then
                                isOwned = true
                                break
                            end
                        end
                        
                        if not isOwned then
                            -- Hangi tier'da olduğunu bul
                            for tier, tierCars in pairs(carTiers) do
                                for _, tierCar in ipairs(tierCars) do
                                    if carName == tierCar then
                                        if not foundCars[tier] then
                                            foundCars[tier] = {}
                                        end
                                        table.insert(foundCars[tier], model)
                                        print("🚗 Bulundu:", tier, "-", carName, "- Model:", model.Name)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        -- Tier sırasına göre en yüksek seviyeli araçları seç
        for _, tier in ipairs(tierOrder) do
            if foundCars[tier] and #foundCars[tier] > 0 then
                local selectedCar = foundCars[tier][1]  -- İlk uygun aracı seç
                print("✅ SEÇILEN ARAÇ:", tier, "- Model:", selectedCar.Name)
                return selectedCar
            end
        end
        
        -- Debug: Hangi araçlar bulunduğunu göster
        print("❌ Hiç uygun araç bulunamadı!")
        print("📊 BULUNAN ARAÇLAR ÖZETİ:")
        local totalFound = 0
        for tier, cars in pairs(foundCars) do
            if cars and #cars > 0 then
                print("  " .. tier .. ": " .. #cars .. " araç")
                totalFound = totalFound + #cars
            end
        end
        
        if totalFound == 0 then
            print("  ⚠️ Hiçbir tier'da araç bulunamadı - Tüm araçlar sahipli olabilir")
        end
        
        return nil
    end

    local randomizeColor = true
    local repairedCarList = {}

    -- Randomize Color toggle fonksiyonu
    function setRandomizeColor(enabled)
        randomizeColor = enabled
        print("🎨 Randomize Color:", enabled and "ENABLED" or "DISABLED")
    end

    local function getNearestClickDetector(machineName, childName, maxDistance)
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    local nearestDetector
    local nearestDistance = math.huge

    for _, detector in ipairs(workspace:GetDescendants()) do
        if detector:IsA("ClickDetector") then

            local parent = detector.Parent
            local machine = parent and parent.Parent

            if machine
            and machine.Name == machineName
            and parent.Name == childName then

                local part = parent:IsA("BasePart") and parent
                    or parent:FindFirstChildWhichIsA("BasePart")

                if part then
                    local dist = (hrp.Position - part.Position).Magnitude

                    if dist < nearestDistance and dist <= maxDistance then
                        nearestDistance = dist
                        nearestDetector = detector
                    end
                end
            end
        end
    end

    return nearestDetector
end

if detector then
    print(detector:GetFullName())
    print(distance)

    fireclickdetector(detector)
end

-- Ana repair fonksiyonu
function justRepairVehicle()
    --print("🔧 JUST REPAIR: Repair işlemi başlatılıyor...")
    
    -- Karakter kontrolü
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        --print("❌ Repair: Karakter veya HumanoidRootPart bulunamadı")
        return false, "Character error"
    end

    local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
    local vehicles = workspace:FindFirstChild("Vehicles")

    if not vehicles then
        --print("❌ Repair: Vehicles folder bulunamadı")
        return false, "Vehicles folder not found"
    end

    local nearbyVehicle = nil
    local minDistance = math.huge

    for _, vehicle in pairs(vehicles:GetChildren()) do
        if vehicle:IsA("Model") then
            if vehicle:GetAttribute("Owner") == LocalPlayer.Name then

                local part = vehicle.PrimaryPart or vehicle:FindFirstChildWhichIsA("BasePart")

                if part then
                    local dist = (playerPos - part.Position).Magnitude

                    if dist <= 20 and dist < minDistance then
                        minDistance = dist
                        nearbyVehicle = vehicle
                    end
                end
            end
        end
    end

    if not nearbyVehicle then
        --print("❌ ไม่พบรถ")
        return false, "No vehicle nearby"
    end

    --print("✅ พบรถ :", nearbyVehicle.Name)
    --print("Distance :", minDistance)

    table.insert(repairedCarList, nearbyVehicle.Name)

    --print("🚗 Opening Hood...")

    local success, err = pcall(function()

        local hoodDetector = nearbyVehicle.Misc.Hood.Detector.ClickDetector

        --print("Detector :", hoodDetector:GetFullName())

        fireclickdetector(hoodDetector)

    end)

    if not success then
         warn(err)
         return false, err
        end
        
        --print("✅ Hood Clicked")

        task.wait(1)
    
    -- Eğer araçta oturuyorsa çık (hood açıldıktan sonra)
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if humanoid and humanoid.SeatPart then
        --print("🚗 Araçtan çıkılıyor...")
        
        -- Araçtan çık
        humanoid.Sit = false
        task.wait(0.1)
        humanoid.Sit = false
        task.wait(0.2)
        
        -- Araçtan uzaklaş (sağ tarafa)
        if hrp then
            local rightVector = hrp.CFrame.RightVector
            hrp.CFrame = hrp.CFrame + (rightVector * 8)
            --print("📍 Araçtan uzaklaşıldı")
        end
        
        task.wait(0.3)
    else
        --print("✅ Zaten araçta oturmuyor")
    end
    
    -- Repair station'a teleport
    --print("🔧 Repair station'a gidiliyor...")
    local repairCFrame = CFrame.new(-1091.0303955078125, 4.532293796539307, -416.7520751953125) * CFrame.Angles(math.rad(12.78), math.rad(89.94), math.rad(0.00))
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = repairCFrame
        --print("📍 Repair station'a teleport edildi")
        task.wait(1) -- Repair'e teleport sonrası stabilizasyon
    end
    
    --print("⚙️ Repair işlemleri başlatılıyor...")
    
    -- Sadece Repair için özel fonksiyon (satış YOK)
    task.spawn(function()
        --print("🔧 REPAIR CAR: Machine 1 operation BAŞLADI:", nearbyVehicle.Name)
        
        -- Makine 1'e teleport
        local machine1CFrame = CFrame.new(-1084.472412109375, 6.978442668914795, -433.9539489746094) * CFrame.Angles(math.rad(0.00), math.rad(-112.58), math.rad(-0.00))
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = machine1CFrame
            --print("📍 REPAIR CAR: Makine 1'e teleport edildi")
            
            task.wait(0.5)
            
            -- RemovePart eventi gönder
            local success, result = pcall(function()
                local args = {
                    [1] = "RemovePart";
                    [2] = "CylinderHead";
                }
                workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                --print("🔧 RemovePart CylinderHead gönderildi:", nearbyVehicle.Name)
                return true
            end)
            
            if success then
                task.wait(1)
                
                -- Makine 1 click detector
                local machine1Success = pcall(function()
                    local detector = getNearestClickDetector("GrindingMachine", "Button", 15)
                    if detector then
                        fireclickdetector(detector)
                    end
                    --print("⚙️ Makine 1 click detector tetiklendi")
                    return true
                end)
                
                if machine1Success then
                    task.wait(1)
                    
                    -- Makine 2'ye teleport
                    local machine2CFrame = CFrame.new(-1079.5108642578125, 6.9884161949157715, -436.1452331542969) * CFrame.Angles(math.rad(0.00), math.rad(-43.44), math.rad(0.00))
                    LocalPlayer.Character.HumanoidRootPart.CFrame = machine2CFrame
                    --print("📍 Makine 2'ye teleport edildi")
                    
                    task.wait(1)
                    
                    local machine2RemoveSuccess = pcall(function()
                        local args = {
                            [1] = "RemovePart";
                            [2] = "ExhaustManifold";
                        }
                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                        --print("🔧 RemovePart ExhaustManifold gönderildi:", nearbyVehicle.Name)
                        return true
                    end)
                    
                    if machine2RemoveSuccess then
                        task.wait(1)
                        
                        local machine2ClickSuccess = pcall(function()
                            local detector = getNearestClickDetector("GrindingMachine", "Button", 15)
                            if detector then
                                fireclickdetector(detector)
                            end
                            --print("⚙️ Makine 2 click detector tetiklendi")
                            return true
                        end)
                        
                        if machine2ClickSuccess then
                            task.wait(1)
                            
                            -- Batarya
                            local batteryCFrame = CFrame.new(-1073.449951171875, 6.427865982055664, -439.61962890625) * CFrame.Angles(math.rad(0.00), math.rad(-79.57), math.rad(0.00))
                            LocalPlayer.Character.HumanoidRootPart.CFrame = batteryCFrame
                            --print("📍 Batarya istasyonuna teleport edildi")
                            
                            task.wait(1)
                            
                            local batteryRemoveSuccess = pcall(function()
                                local args = {
                                    [1] = "RemovePart";
                                    [2] = "Battery";
                                }
                                workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                --print("🔧 RemovePart Battery gönderildi:", nearbyVehicle.Name)
                                return true
                            end)
                            
                            if batteryRemoveSuccess then
                                task.wait(1.5)
                                
                                local batteryClickSuccess = pcall(function()
                                    local detector = getNearestClickDetector("BatteryCharger","Button", 15)
                                    if detector then
                                        fireclickdetector(detector)
                                    end
                                    --print("⚙️ Batarya click detector tetiklendi")
                                    return true
                                end)
                                
                                if batteryClickSuccess then
                                    task.wait(1)

                                    local machine2CFrame = CFrame.new(-1106.1907958984375, 6.9884161949157715, -424.15252685546875) * CFrame.Angles(math.rad(0.00), math.rad(-43.44), math.rad(0.00))
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = machine2CFrame
                                    --print("📍 Makine 2'ye teleport edildi")

                                    task.wait(1)

                                    local machine2RemoveSuccess = pcall(function()
                                        local args = {
                                            [1] = "RemovePart";
                                            [2] = "Transmission";
                                        }
                                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                        --print("🔧 RemovePart ExhaustManifold gönderildi:", nearbyVehicle.Name)
                                        return true
                                    end)

                                    if machine2RemoveSuccess then
                                        task.wait(1)

                                        local machine2ClickSuccess = pcall(function()
                                            local detector = getNearestClickDetector("GrindingMachine", "Button", 15)
                                            if detector then
                                                fireclickdetector(detector)
                                            end
                                            --print("⚙️ Makine 2 click detector tetiklendi")
                                            return true
                                        end)
                                        
                                        if machine2ClickSuccess then
                                            task.wait(1)    

                                            
                                    -- Su istasyonuna
                                    local waterCFrame = CFrame.new(-1089.7998046875, 6.497609615325928, -432.1319885253906) * CFrame.Angles(math.rad(-0.00), math.rad(-80.44), math.rad(-0.00))
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = waterCFrame
                                    --print("📍 Su istasyonuna teleport edildi")
                                    
                                    task.wait(1)

                                    local airIntakeRemoveSuccess = pcall(function()
                                        local args = {
                                                [1] = "RemovePart";
                                                [2] = "AirIntake";
                                            }
                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                            --print("🔧 RemovePart AirIntake gönderildi:", nearbyVehicle.Name)
                                            return true
                                        end)
                                        
                                        if airIntakeRemoveSuccess then
                                            task.wait(1)
                                        end
                                    
                                    -- Su final click
                                    local finalWaterClickSuccess = pcall(function()
                                        local detector = getNearestClickDetector("PartsWasher", "Faucet", 15)
                                        if detector then
                                            fireclickdetector(detector)
                                        end
                                        --print("⚙️ Su final click detector tetiklendi")
                                        return true
                                    end)
                                    
                                    if finalWaterClickSuccess then
                                        task.wait(1.5)
                                        
                                        -- Özel parçalar için ayrı işlemler (Injectors, Sparkplugs, TimingBelt)
                                        local specialCFrame = CFrame.new(-1092.9224853515625, 14.453957557678223, -403.27752685546875) * CFrame.Angles(math.rad(0.00), math.rad(-22.41), math.rad(-0.00))
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = specialCFrame
                                        --print("🔧 Özel parçalar çıkarılıyor: Injectors, Sparkplugs, TimingBelt")
                                        
                                        task.wait(1)
                                        
                                        -- Injectors çıkar
                                        local injectorsRemoveSuccess = pcall(function()
                                            local args = {
                                                [1] = "RemovePart";
                                                [2] = "Injectors";
                                            }
                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                            --print("🔧 RemovePart Injectors gönderildi:", nearbyVehicle.Name)
                                            return true
                                        end)
                                        
                                        if injectorsRemoveSuccess then
                                            task.wait(0.5)
                                        end
                                        
                                        -- Sparkplugs çıkar
                                        local sparkplugsRemoveSuccess = pcall(function()
                                            local args = {
                                                [1] = "RemovePart";
                                                [2] = "Sparkplugs";
                                            }
                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                            --print("🔧 RemovePart Sparkplugs gönderildi:", nearbyVehicle.Name)
                                            return true
                                        end)
                                        
                                        if sparkplugsRemoveSuccess then
                                            task.wait(0.5)
                                        end
                                        
                                        -- TimingBelt çıkar
                                        local timingBeltRemoveSuccess = pcall(function()
                                            local args = {
                                                [1] = "RemovePart";
                                                [2] = "TimingBelt";
                                            }
                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                            --print("🔧 RemovePart TimingBelt gönderildi:", nearbyVehicle.Name)
                                            return true
                                        end)
                                        
                                        if timingBeltRemoveSuccess then
                                            task.wait(0.5)
                                        end
                                        
                                        -- Şimdi Makine 1'e geri teleport (ikinci işlem için)
                                        task.wait(1)
                                        
                                        local machine1CFrame = CFrame.new(-1111.560302734375, 6.9884161949157715, -421.7259216308594) * CFrame.Angles(math.rad(0.00), math.rad(-112.58), math.rad(-0.00))
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = machine1CFrame
                                        --print("📍 Makine 1'e geri teleport edildi (EngineBlock işlemi için)")
                                        
                                        -- 2 saniye bekle sonra EngineBlock çıkar
                                        task.wait(1)
                                        
                                        local engineBlockRemoveSuccess = pcall(function()
                                            local args = {
                                                [1] = "RemovePart";
                                                [2] = "EngineBlock";
                                            }
                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                            --print("🔧 RemovePart EngineBlock gönderildi:", nearbyVehicle.Name)
                                            return true
                                        end)
                                        
                                        if engineBlockRemoveSuccess then
                                            -- 2 saniye bekle sonra Makine 1 click detector tetikle
                                            task.wait(1)
                                            
                                            local finalMachine1ClickSuccess = pcall(function()
                                                local detector = getNearestClickDetector("GrindingMachine", "Button", 15)
                                                if detector then
                                                    fireclickdetector(detector)
                                                end
                                                --print("⚙️ Makine 1 final click detector tetiklendi")
                                                return true
                                            end)
                                            
                                            if finalMachine1ClickSuccess then
                                                -- Makine 1 final tamamlandı, 6 saniye bekle sonra Su'ya geri dön
                                                task.wait(3)
                                                
                                                -- Su istasyonuna geri teleport
                                                local waterCFrame = CFrame.new(-1089.708740234375, 6.497610569000244, -432.3533935546875) * CFrame.Angles(math.rad(-0.00), math.rad(-80.44), math.rad(-0.00))
                                                LocalPlayer.Character.HumanoidRootPart.CFrame = waterCFrame
                                                --print("📍 Su istasyonuna geri teleport edildi")
                                                
                                                -- 2 saniye bekle sonra Radiator çıkar
                                                task.wait(1)
                                                
                                                local radiatorRemoveSuccess = pcall(function()
                                                    local args = {
                                                        [1] = "RemovePart";
                                                        [2] = "Radiator";
                                                    }
                                                    
                                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                    --print("🔧 RemovePart Radiator gönderildi:", nearbyVehicle.Name)
                                                    return true
                                                end)
                                                
                                                if radiatorRemoveSuccess then
                                                    -- 2 saniye bekle sonra Su click detector final tetikle
                                                    task.wait(1)
                                                    
                                                    local finalWaterClickSuccess2 = pcall(function()
                                                        local detector = getNearestClickDetector("PartsWasher", "Faucet", 15)
                                                        if detector then
                                                            fireclickdetector(detector)
                                                        end
                                                        --print("⚙️ Su final click detector tetiklendi")
                                                        return true
                                                    end)
                                                    
                                                    if finalWaterClickSuccess2 then
                                                        -- Final su tamamlandı, 10 saniye bekle sonra reapply işlemlerini başlat
                                                        task.wait(13)
                                                        --print("🔧 Starting reapply operations...")
                                                        
                                                        --print("🔍 REPAIR CAR: 25 stud yakınındaki parçalar aranıyor...")
                                                        
                                                        -- 25 stud yakınındaki MoveableParts'ları bul
                                                        local nearbyParts = {}
                                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
                                            local moveableParts = workspace:FindFirstChild("MoveableParts")
                                            
                                            if moveableParts then
                                                for _, part in pairs(moveableParts:GetChildren()) do
                                                    if part:IsA("Model") then
                                                        local owner = part:GetAttribute("Owner")
                                                        if owner == LocalPlayer.Name then
                                                            local centerPart = part.PrimaryPart or part:FindFirstChildWhichIsA("BasePart")
                                                            if centerPart then
                                                                local distance = (playerPos - centerPart.Position).Magnitude
                                                                if distance <= 100 then
                                                                    table.insert(nearbyParts, part)
                                                                    --print("✅ Yakında parça bulundu:", part.Name, "Mesafe:", math.floor(distance), "stud")
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    
                                
                                        
                                        --print("🔍 Toplam", #nearbyParts, "yakın parça bulundu")
                                        
                                        -- Reapply sıralaması
                                        local reapplyOrder = {"EngineBlock", "Battery", "Radiator", "Injectors", "CylinderHead","Alternator", "AirIntake", "ExhaustManifold","Transmission","7-Speed DCT","8-Speed DCT","8-Speed TC","6-Speed Manual","5-Speed Manual", "Sparkplugs", "TimingBelt"}
                                        
                                        -- Yakındaki parçaları sıralı reapply et
                                        local reappliedCount = 0
                                        for _, partName in ipairs(reapplyOrder) do
                                            local foundPart = nil
                                            for _, part in ipairs(nearbyParts) do
                                                if part.Name == partName then
                                                    foundPart = part
                                                    break
                                                end
                                            end
                                            
                                            if foundPart then
                                                local reapplySuccess = pcall(function()
                                                    local args = {
                                                        [1] = "ReapplyPart";
                                                        [2] = foundPart;
                                                    }
                                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                    --print("🔧 ReapplyPart", foundPart.Name, "gönderildi (sıra:", reappliedCount + 1 .. "):", nearbyVehicle.Name)
                                                    return true
                                                end)
                                                
                                                if reapplySuccess then
                                                    reappliedCount = reappliedCount + 1
                                                else
                                                    --print("❌", foundPart.Name, "reapply işlemi başarısız")
                                                end
                                                
                                                -- Son parça değilse bekle
                                                if reappliedCount < #nearbyParts then
                                                    task.wait(1)
                                                end
                                            else
                                                --print("⚠️", partName, "yakında bulunamadı, atlandı")
                                            end
                                        end
                                        
                                        --print("✅ REPAIR CAR: Tüm reapply işlemleri tamamlandı! (" .. reappliedCount .. "/" .. #nearbyParts .. " parts)")
                                        
                                        task.wait(2)
                                        
                                        -- DriveSeat'e TP at ve işlemi bitir
                                        --print("🚗 REPAIR CAR: DriveSeat'e teleport ediliyor...")
                                        
                                        local driveSeat = nil
                                        if nearbyVehicle and nearbyVehicle:IsDescendantOf(workspace) then
                                            -- DriveSeat'i bul
                                            for _, desc in pairs(nearbyVehicle:GetDescendants()) do
                                                if desc:IsA("VehicleSeat") and desc.Name == "DriveSeat" then
                                                    driveSeat = desc
                                                    break
                                                end
                                            end
                                            
                                            -- DriveSeat bulunamadıysa herhangi bir VehicleSeat'i kullan
                                            if not driveSeat then
                                                driveSeat = nearbyVehicle:FindFirstChildOfClass("VehicleSeat")
                                            end
                                        end
                                        
                                        if driveSeat and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            -- DriveSeat'e otur (araç sürmek için)
                                            LocalPlayer.Character.HumanoidRootPart.CFrame = driveSeat.CFrame + (driveSeat.CFrame.RightVector * 10)
                                            task.wait(0.2) -- Pozisyon stabilizasyonu için
                                            
                                            -- Humanoid'i DriveSeat'e oturtur
                                            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                            if humanoid then
                                                task.wait(0.3)
                                                
                                                -- Oturma başarılı mı kontrol et
                                                if humanoid.SeatPart == driveSeat then
                                                    --print("✅ REPAIR CAR: DriveSeat'e başarıyla oturuldu")
                                                else
                                                    --print("⚠️ REPAIR CAR: DriveSeat'e oturulamadı, manuel deneme...")
                                                    -- Manuel oturma denemesi
                                                    for i = 1, 3 do
                                                        LocalPlayer.Character.HumanoidRootPart.CFrame = driveSeat.CFrame + (driveSeat.CFrame.RightVector * 10)
                                                        task.wait(0.1)
                                                        task.wait(0.2)
                                                        if humanoid.SeatPart == driveSeat then
                                                            --print("✅ REPAIR CAR: Manuel oturma başarılı!")
                                                            break
                                                        end
                                                    end
                                                end
                                            end
                                            
                                            --print("📍 REPAIR CAR: DriveSeat'e oturuldu ve araç kullanıma hazır")

                                            --print("🧽 Cleaning vehicle...")

                                            local cleanSuccess = pcall(function()
                                                local args = {
                                                    [1] = 0;
                                                }

                                                game:GetService("ReplicatedStorage"):WaitForChild("Events", 5):WaitForChild("Vehicles", 5):WaitForChild("SetDirt", 5):FireServer(unpack(args))
                                                return true
                                            end)

                                            if cleanSuccess then
                                                --print("🧽 ✅ Vehicle cleaned")
                                            else
                                                --print("🧽 ❌ Failed to clean vehicle")
                                            end
                                            task.wait(0.5)
                                            
                                            -- Randomize Color kontrolü
                                            if randomizeColor then
                                                --print("🎨 Randomize Color aktif, aracı boyamaya başlıyor...")
                                                task.wait(0.5) -- Stabilizasyon için bekle
                                                
                                                -- Rastgele renk oluştur (Autofarm'daki aynı format)
                                                local randomHue = math.random() * 360 -- 0-360 derece
                                                local randomSaturation = 0.7 + (math.random() * 0.3) -- 0.7-1.0 arası doygunluk
                                                local randomValue = 0.8 + (math.random() * 0.2) -- 0.8-1.0 arası parlaklık
                                                
                                                local randomColor = Color3.fromHSV(randomHue/360, randomSaturation, randomValue)
                                                
                                                --print("🎨 Rastgele boyama başlatılıyor - HSV:", math.floor(randomHue), math.floor(randomSaturation*100)/100, math.floor(randomValue*100)/100)
                                                --print("🎨 RGB değerleri:", math.floor(randomColor.R*255), math.floor(randomColor.G*255), math.floor(randomColor.B*255))
                                                
                                                -- Paint işlemini başlat (Autofarm'daki DOĞRU format)
                                                local paintSuccess = pcall(function()
                                                    local args = {
                                                        [1] = "Car", -- Araç objesi
                                                        [2] = nearbyVehicle,    -- Color3 değeri
                                                        [3] = randomColor,
                                                        [4] = "Normal"
                                                    }
                                                    
                                                    local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events", 5)
                                                    local VehiclesEvents = Events:WaitForChild("Vehicles", 5)
                                                    local SetPaintEvent = VehiclesEvents:WaitForChild("SetPaint", 5)
                                                    
                                                    SetPaintEvent:FireServer(unpack(args))
                                                    return true
                                                end)
                                                
                                                if paintSuccess then
                                                    --print("🎨 ✅ Araç başarıyla rastgele renge boyandı:", nearbyVehicle.Name)
                                                else
                                                    --print("🎨 ❌ Boyama eventi tetiklenemedi, devam ediliyor...")
                                                end
                                                
                                                task.wait(1) -- Boyama işlemi için ek bekleme
                                            else
                                                --print("🎨 Randomize Color kapalı, boyama atlanıyor")
                                            end
                                            
                                            --print("✅ REPAIR CAR: İşlem tamamen tamamlandı!")
                                            --print("🚗 REPAIR CAR: Araç tamiri bitti, DriveSeat'e oturuldu!")
                                            
                                            return true, "Repair completed successfully"
                                                        else
                                                            --print("❌ REPAIR CAR: DriveSeat bulunamadı veya karakter hatası")
                                                            return false, "DriveSeat error"
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
        
        --print("❌ Repair işlemi bir adımda başarısız oldu")
        return false, "Repair process failed"
    end)
    
    return true, "Repair process started"
end

-- functions tp+fireclick then repair
function teleportBuyAndRepair(carModel)
    if carModel:IsA("Model") and not carModel.PrimaryPart then
        local basePart = carModel:FindFirstChildWhichIsA("BasePart", true)
        if basePart then
            carModel.PrimaryPart = basePart
        else
            print("Part = nil")
            wait(3)
            return
        end
    end
    local lp = LocalPlayer
    if carModel.PrimaryPart and lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = carModel.PrimaryPart.CFrame + Vector3.new(-9,9,0)
        
        wait(1) -- รอให้ตัวละคร TP เสร็จ

        local playerPos = lp.Character.HumanoidRootPart.Position
        local vehicles = workspace:FindFirstChild("Vehicles")
        local nearbyVehicle = nil
        local minDistance = math.huge

        if vehicles then
            for _, vehicle in pairs(vehicles:GetChildren()) do
                if vehicle:IsA("Model") then
                    local part = vehicle.PrimaryPart or vehicle:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = (playerPos - part.Position).Magnitude
                        if dist <= 20 and dist < minDistance then
                            minDistance = dist
                            nearbyVehicle = vehicle
                        end
                    end
                end
            end
        end

        if nearbyVehicle then
            local success, err = pcall(function()
                -- หา ClickDetector สำหรับซื้อรถ
                local buyDetector = nearbyVehicle:FindFirstChildWhichIsA("ClickDetector")
                
                if not buyDetector then
                    -- สำรองกรณีไม่ได้อยู่ที่ root
                    buyDetector = nearbyVehicle:FindFirstChildWhichIsA("ClickDetector", true)
                end

                if buyDetector then
                    print("🖱 Detector :", buyDetector:GetFullName())
                    fireclickdetector(buyDetector)
                    wait(0.5)
                    fireclickdetector(buyDetector)
                else
                    print("❌ ไม่พบ ClickDetector ในรถ :", nearbyVehicle.Name)
                end
            end)

            if not success then
                warn(err)
            end
            
            wait(5) -- waiting for make sure
            justRepairVehicle() -- repair carrr
        else
            print("❌ ไม่พบรถใกล้ๆ หลังจาก TP")
        end
    else
        print("Can't TP")
    end
    wait(2)
end


function teleportToFinalDestination()
    local cfrm = CFrame.new(
        -1919.4267578125, 3.935683250427246, -789.127685546875, 
         0.280164272, 7.92696611e-08, 0.959952056,
         1.55734448e-08, 1, -8.71218333e-08,
        -0.959952056, 3.93581878e-08, 0.280164272
    )
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = cfrm
    end
end


function autoSellCar()
    local sellSuccess = false
    
    -- ProximityPrompt 
    local proximitySuccess = pcall(function()
        local sellPrompt = workspace.Utils.SellCar.Prompt:FindFirstChildWhichIsA("ProximityPrompt", true)
        if sellPrompt then
            fireproximityprompt(sellPrompt, 0)
            sellSuccess = true
        end
    end)

    -- if Proximity failed try ClickDetector
    if not sellSuccess then
        local clickSuccess = pcall(function()
            local sellClick = workspace.Utils.SellCar.Prompt:FindFirstChild("ClickDetector")
            if sellClick then
                fireClickDetector(sellClick)
                sellSuccess = true
            end
        end)
    end

    -- if failed loop ClickDetector in SellCar area
    if not sellSuccess then
        for _, child in pairs(workspace.Utils.SellCar:GetDescendants()) do
            if child:IsA("ClickDetector") then
                fireClickDetector(child)
                sellSuccess = true
                break
            end
        end
    end

    -- if failed hold E  VirtualInputManager
    if not sellSuccess then
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(3)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        sellSuccess = true
    end
end

function autoSellCarRepeat(uuid)
    local maxRetry = 500
    local retry = 0
    while workspace.Vehicles:FindFirstChild(uuid) and retry < maxRetry do
        print("sell:", uuid, "times", retry + 1)
        autoSellCar()
        retry = retry + 1
        wait(0.5)
    end
    if not workspace.Vehicles:FindFirstChild(uuid) then
        print("✅ sold:", uuid, "success")
    else
        print("❌ failed to sell", uuid, "times", maxRetry )
    end
end

function loadAndSellAllCars()
    for i = 1, #repairedCarList do
        local uuid = repairedCarList[i]
        local garage = game.Players.LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Garage")
        local garageCar = garage:FindFirstChild(uuid)
        if garageCar then
            local loadCFrame = CFrame.new(-1891.31982, 3.97528815, -776.28595, 0.986457527, -5.51490089e-08, -0.164016873, 4.48807e-08, 1, -6.63108821e-08, 0.164016873, 5.8051679e-08, 0.986457527)
            local args = {garageCar, loadCFrame}
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Vehicles"):WaitForChild("RemoteLoad"):InvokeServer(unpack(args))
            wait(2)
            autoSellCarRepeat(uuid)
            wait(2)
        end
    end
    repairedCarList = {}
end

    --== end of autofarm ==--
    
    function _G.acne_processMachine1WithVehicle(vehicleName)
        if _G.farmKMActive then
            local plr = game:GetService("Players").LocalPlayer
            local status = plr:FindFirstChild("PlayerData") and plr.PlayerData:FindFirstChild("Status")
            local kmStat = status and status:FindFirstChild("KMs")
            local currentKM = kmStat and tonumber(kmStat.Value) or _G.farmKMStartValue
            local sessionKM = currentKM - _G.farmKMStartValue
            if sessionKM < 0 then sessionKM = 0.0 end
             _G.farmKMCountLabel.Text = "Farmed KMs: " .. string.format("%.1f", sessionKM)
            end
            print("Process KM: Vehicle", vehicleName, "KM This Session:", string.format("%.1f", sessionKM))
        end
        
        spawn(function()
            while true do
                wait(1)
                if _G.farmKMActive then
                     _G.farmKMTimer = _G.farmKMTimer + 1
                     _G.farmKMTimerLabel.Text = string.format("Time: %d:%02d", math.floor(_G.farmKMTimer/60), _G.farmKMTimer%60)
                    end
                end
            end)

            local plr = game:GetService("Players").LocalPlayer
            local status = plr:WaitForChild("PlayerData"):WaitForChild("Status")
            local kmStat = status:WaitForChild("KMs")

            kmStat.Changed:Connect(function()
                if _G.farmKMActive then
                    local sessionKM = tonumber(kmStat.Value) - _G.farmKMStartValue
                    if sessionKM < 0 then sessionKM = 0.0 end
                    _G.farmKMCountLabel.Text = "Farmed KMs: " .. string.format("%.1f", sessionKM)
                end
            end)

-- ...existing code... (geri kalan kod aynı kalıyor)


    -- Paint Dropdown Toggle Function
    local function togglePaintDropdown()
        paintDropdownOpen = not paintDropdownOpen
        
        if paintDropdownOpen then
            PaintDropdownArrow.Text = "▲"
            PaintContentFrame.Visible = true
            PaintContentFrame.Size = UDim2.new(1,-20,0,0)

            TweenService:Create(PaintContentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1,-20,0,320)
            }):Play()

            -- Parts ESP butonunu aşağı indir
            TweenService:Create(PartsESPButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0,10,0, PARTS_ESP_BASE_Y + PARTS_ESP_DROPDOWN_EXTRA)
            }):Play()

            task.delay(0.32, updateContentCanvasSize)
        else
            PaintDropdownArrow.Text = "▼"
            TweenService:Create(PaintContentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(1,-20,0,0)
            }):Play()

            -- Parts ESP butonunu eski yerine getir
            TweenService:Create(PartsESPButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0,10,0, PARTS_ESP_BASE_Y)
            }):Play()

            task.spawn(function()
                task.wait(0.3)
                PaintContentFrame.Visible = false
                updateContentCanvasSize()
            end)
        end
    end


    -- Paint Dropdown Button Event
    PaintDropdownButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        togglePaintDropdown()
    end)




    -- HSV renk paleti oluşturma fonksiyonu - Daha yüksek çözünürlük
    local function createColorPalette()
        -- Paleti temizle
        for _, child in pairs(PaletteCanvas:GetChildren()) do
            if child ~= ColorCursor then
                child:Destroy()
            end
        end

        -- HSV gradyanı oluştur (daha yüksek çözünürlük)
        local resolution = 40  -- Artırılmış çözünürlük
        for x = 0, resolution - 1 do
            for y = 0, resolution - 1 do
                local pixel = Instance.new("Frame", PaletteCanvas)
                pixel.Size = UDim2.new(1 / resolution, 0, 1 / resolution, 0)
                pixel.Position = UDim2.new(x / resolution, 0, y / resolution, 0)
                pixel.BackgroundColor3 = Color3.fromHSV(x / resolution, 1 - y / resolution, 1)
                pixel.BorderSizePixel = 0
            end
        end
    end

    local function updateContentCanvasSize()
        local minHeight = 500
        local partsBtnY = PartsESPButton.Position.Y.Offset
        local bottom = partsBtnY + PartsESPButton.Size.Y.Offset + 40
        ContentFrame.CanvasSize = UDim2.new(0,0,0, math.max(minHeight, bottom))
    end

    -- Renk seçme fonksiyonu
    local function selectColor(mousePos)
        local canvasPos = PaletteCanvas.AbsolutePosition
        local canvasSize = PaletteCanvas.AbsoluteSize

        local relativeX = math.clamp((mousePos.X - canvasPos.X) / canvasSize.X, 0, 1)
        local relativeY = math.clamp((mousePos.Y - canvasPos.Y) / canvasSize.Y, 0, 1)

        -- HSV'den renk hesapla
        local hue = relativeX
        local saturation = 1 - relativeY
        local value = 1

        selectedPaintColor = Color3.fromHSV(hue, saturation, value) -- GLOBAL değişkeni güncelle
        ColorPreview.BackgroundColor3 = selectedPaintColor

        -- İmleci güncelle
        ColorCursor.Position = UDim2.new(relativeX, -5, relativeY, -5)

        -- RGB değerlerini göster (StatusLabelPaint tanımlandıktan sonra)
        if StatusLabelPaint then
            local r, g, b = selectedPaintColor.R, selectedPaintColor.G, selectedPaintColor.B
            StatusLabelPaint.Text = string.format("Selected Color: RGB(%.2f, %.2f, %.2f)", r, g, b)
        end
    end

    -- Genel uyarı gösterme fonksiyonu
    _G.acne_showWarning = function(message, title)
        title = title or "WARNING"
        
        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "Warning_" .. tostring(math.random(1,1e6))

        local frame = Instance.new("Frame", gui)
        frame.Position = UDim2.new(0.5, -200, 0.5, -90)
        frame.Size = UDim2.new(0, 400, 0, 180)
        frame.BackgroundColor3 = Color3.fromRGB(13, 19, 32)
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

        local titleLabel = Instance.new("TextLabel", frame)
        titleLabel.Size = UDim2.new(1,0,0,40)
        titleLabel.BackgroundColor3 = Color3.fromRGB(255,150,50)
        titleLabel.TextColor3 = Color3.new(1,1,1)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 18
        titleLabel.Text = title
        Instance.new("UICorner", titleLabel).CornerRadius = UDim.new(0,12)

        local msg = Instance.new("TextLabel", frame)
        msg.Position = UDim2.new(0,12,0,55)
        msg.Size = UDim2.new(1,-24,0,70)
        msg.BackgroundTransparency = 1
        msg.TextColor3 = Color3.new(1,1,1)
        msg.Font = Enum.Font.Gotham
        msg.TextSize = 14
        msg.TextWrapped = true
        msg.TextYAlignment = Enum.TextYAlignment.Top
        msg.Text = message

        local closeBtn = Instance.new("TextButton", frame)
        closeBtn.Position = UDim2.new(0.5, -50, 1, -50)
        closeBtn.Size = UDim2.new(0, 100, 0, 35)
        closeBtn.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
        closeBtn.TextColor3 = Color3.new(1,1,1)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 14
        closeBtn.Text = "OK"
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

        closeBtn.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)

        -- 10 saniye sonra otomatik kapat
        task.delay(10, function()
            if gui and gui.Parent then
                gui:Destroy()
            end
        end)
    end

    _G.acne_showPremiumWarning = function()
        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "PremiumWarning_" .. tostring(math.random(1,1e6))

        local frame = Instance.new("Frame", gui)
        frame.Position = UDim2.new(0.5, -200, 0.5, -90)
        frame.Size = UDim2.new(0, 400, 0, 180)
        frame.BackgroundColor3 = Color3.fromRGB(13, 19, 32)
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

        local title = Instance.new("TextLabel", frame)
        title.Size = UDim2.new(1,0,0,40)
        title.BackgroundColor3 = Color3.fromRGB(255,80,100)
        title.TextColor3 = Color3.new(1,1,1)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 18
        title.Text = "PREMIUM REQUIRED"
        Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

        local msg = Instance.new("TextLabel", frame)
        msg.Position = UDim2.new(0,12,0,55)
        msg.Size = UDim2.new(1,-24,0,70)
        msg.BackgroundTransparency = 1
        msg.TextColor3 = Color3.new(1,1,1)
        msg.Font = Enum.Font.Gotham
        msg.TextSize = 16
        msg.TextWrapped = true
        msg.TextYAlignment = Enum.TextYAlignment.Top
        msg.Text = "This feature is for Premium users only.\nBuy Premium from Discord"

        local closeBtn = Instance.new("TextButton", frame)
        closeBtn.Position = UDim2.new(0,12,1,-46)
        closeBtn.Size = UDim2.new(1,-24,0,34)
        closeBtn.BackgroundColor3 = Color3.fromRGB(90,90,110)
        closeBtn.TextColor3 = Color3.new(1,1,1)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 16
        closeBtn.Text = "Close"
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)

        -- Copy Discord Link button (Premium uyarı)
        local CopyLinkButton = Instance.new("TextButton", frame)
        CopyLinkButton.Position = UDim2.new(0,12,1,-90) -- Close butonunun üstünde
        CopyLinkButton.Size = UDim2.new(1,-24,0,34)
        CopyLinkButton.BackgroundColor3 = Color3.fromRGB(114,137,218) -- Discord rengi
        CopyLinkButton.TextColor3 = Color3.new(1,1,1)
        CopyLinkButton.Font = Enum.Font.GothamBold
        CopyLinkButton.TextSize = 16
        CopyLinkButton.AutoButtonColor = false
        CopyLinkButton.Text = "Copy Discord Link"
        Instance.new("UICorner", CopyLinkButton).CornerRadius = UDim.new(0,8)

        local DISCORD_LINK = "https://discord.gg/dumbs"

        CopyLinkButton.MouseButton1Click:Connect(function()
            local ok = pcall(function()
                setclipboard(DISCORD_LINK)
            end)
            TweenService:Create(CopyLinkButton, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(100,255,100)
            }):Play()
            CopyLinkButton.Text = ok and "Copied!" or "Copy failed"
            task.delay(2, function()
                CopyLinkButton.Text = "Copy Discord Link"
                TweenService:Create(CopyLinkButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(114,137,218)
                }):Play()
            end)
        end)

        frame.Size = UDim2.new(0,0,0,0)
        TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0,400,0,180)
        }):Play()

        local function close()
            TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0,0,0,0)
            }):Play()
            task.delay(0.25, function() pcall(function() gui:Destroy() end) end)
        end
        closeBtn.MouseButton1Click:Connect(close)
        task.delay(5, close)
    end

    -- Kendi aracımızı bulan fonksiyon (mesafe sınırsız)
    _G.acne_findOwnedVehicle = function()
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return nil
        end
        
        local vehicles = workspace:FindFirstChild("Vehicles")
        
        if not vehicles then
            print("⚠️ Vehicles folder bulunamadı")
            return nil
        end
        
        for _, vehicle in pairs(vehicles:GetChildren()) do
            if vehicle:IsA("Model") then
                local owner = vehicle:GetAttribute("Owner")
                if owner == LocalPlayer.Name then
                    print("✅ Kendi aracım bulundu (mesafe sınırsız):", vehicle.Name)
                    return vehicle
                end
            end
        end
        
        print("⚠️ Kendi aracım bulunamadı")
        return nil
    end

    -- Makine 1 işlem fonksiyonu
    _G.acne_processMachine1WithVehicle = function(vehicleName)
        task.spawn(function()
            print("🔧 AUTO FARM: Machine 1 operation BAŞLADI:", vehicleName)
            print("🔍 DEBUG: Karakter kontrolü yapılıyor...")
            
            -- Makine 1'e teleport
            local machine1CFrame = CFrame.new(-767.44, 6.87, -1303.07) * CFrame.Angles(math.rad(0.00), math.rad(-112.58), math.rad(-0.00))
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = machine1CFrame
                print("📍 AUTO FARM: Makine 1'e teleport edildi")
                
                -- Teleport sonrası kısa bekleme
                task.wait(0.5)
                print("⏰ AUTO FARM: 0.5 saniye beklendi, CylinderHead işlemi başlıyor...")
                
                -- RemovePart eventi gönder
                local success, result = pcall(function()
                    local args = {
                        [1] = "RemovePart";
                        [2] = "CylinderHead";
                    }
                    
                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                    print("🔧 RemovePart CylinderHead gönderildi:", vehicleName)
                    return true
                end)
                
                if success then
                    -- Makineye teleport sonrası 1 saniye bekle, sonra makineyi tetikle
                    task.wait(1)
                    
                    -- Makine 1'in click detector'ını direkt path ile tetikle
                    local machine1Success = pcall(function()
                        local machineClickDetector = workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector
                        fireClickDetector(workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector)
                        print("⚙️ Makine 1 click detector tetiklendi (direkt path)")
                        return true
                    end)
                    
                    if machine1Success then
                        -- Makine 1 tamamlandı, 2 saniye bekle sonra Makine 2'ye geç
                        task.wait(1)
                        
                        -- Makine 2'ye teleport
                        local machine2CFrame = CFrame.new(-767.13, 6.88, -1296.99) * CFrame.Angles(math.rad(0.00), math.rad(-43.44), math.rad(0.00))
                        LocalPlayer.Character.HumanoidRootPart.CFrame = machine2CFrame
                        print("📍 Makine 2'ye teleport edildi")
                        
                        -- 2 saniye bekle sonra RemovePart ExhaustManifold
                        task.wait(1)
                        
                        local machine2RemoveSuccess = pcall(function()
                            local args = {
                                [1] = "RemovePart";
                                [2] = "ExhaustManifold";
                            }
                            
                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                            print("🔧 RemovePart ExhaustManifold gönderildi:", vehicleName)
                            return true
                        end)
                        
                        if machine2RemoveSuccess then
                            -- 2 saniye bekle sonra Makine 2 click detector tetikle
                            task.wait(1)
                            
                            local machine2ClickSuccess = pcall(function()
                                local machine2ClickDetector = workspace.Map:GetChildren()[2542]:GetChildren()[12].Button.ClickDetector
                                fireClickDetector(workspace.Map:GetChildren()[2542]:GetChildren()[12].Button.ClickDetector)
                                print("⚙️ Makine 2 click detector tetiklendi")
                                return true
                            end)
                            
                            if machine2ClickSuccess then
                                -- Makine 2 tamamlandı, 2 saniye bekle sonra Batarya'ya geç
                                task.wait(1)
                                
                                -- Batarya CFrame'i doğru koordinatlarla
                                local batteryCFrame = CFrame.new(-766.37, 6.02, -1290.29) * CFrame.Angles(math.rad(0.00), math.rad(-79.57), math.rad(0.00))
                                LocalPlayer.Character.HumanoidRootPart.CFrame = batteryCFrame
                                print("📍 Batarya istasyonuna teleport edildi")
                                
                                -- 2 saniye bekle sonra RemovePart Battery
                                task.wait(1)
                                
                                local batteryRemoveSuccess = pcall(function()
                                    local args = {
                                        [1] = "RemovePart";
                                        [2] = "Battery";
                                    }
                                    
                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                    print("🔧 RemovePart Battery gönderildi:", vehicleName)
                                    return true
                                end)
                                
                                if batteryRemoveSuccess then
                                    -- 2 saniye bekle sonra Batarya click detector tetikle
                                    task.wait(1)
                                    
                                    local batteryClickSuccess = pcall(function()
                                        local batteryClickDetector = workspace.Map:GetChildren()[2542]:GetChildren()[14].Button.ClickDetector
                                        fireClickDetector(workspace.Map:GetChildren()[2542]:GetChildren()[14].Button.ClickDetector)
                                        print("⚙️ Batarya click detector tetiklendi")
                                        return true
                                    end)
                                    
                                    if batteryClickSuccess then
                                        -- Batarya tamamlandı, 2 saniye bekle sonra Su'ya geç
                                        task.wait(1)
                                        
                                        -- Su istasyonuna teleport
                                        local waterCFrame = CFrame.new(-766.30, 6.20, -1308.48) * CFrame.Angles(math.rad(-0.00), math.rad(-80.44), math.rad(-0.00))
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = waterCFrame
                                        print("📍 Su istasyonuna teleport edildi")
                                        
                                        -- 2 saniye bekle sonra RemovePart AirInTake
                                        task.wait(1)
                                        
                                        local waterRemoveSuccess = pcall(function()
                                            local args = {
                                                [1] = "RemovePart";
                                                [2] = "AirIntake";
                                            }
                                            
                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                            print("🔧 RemovePart AirIntake gönderildi:", vehicleName)
                                            return true
                                        end)
                                        
                                        if waterRemoveSuccess then
                                            -- 2 saniye bekle sonra Su click detector tetikle
                                            task.wait(1)
                                            
                                            local waterClickSuccess = pcall(function()
                                                local waterClickDetector = workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector
                                                fireClickDetector(workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector)
                                                print("⚙️ Su click detector tetiklendi")
                                                return true
                                            end)
                                            
                                            if waterClickSuccess then
                                                -- Su tamamlandı, önce özel pozisyona git ve Injectors/Sparkplugs çıkar
                                                task.wait(8)
                                                
                                                -- Özel pozisyona teleport: Position: (-775.41, 4.50, -1310.93) Rotation: (Pitch=0.00, Yaw=-22.41, Roll=-0.00)
                                                local specialCFrame = CFrame.new(-775.41, 4.50, -1310.93) * CFrame.Angles(math.rad(0.00), math.rad(-22.41), math.rad(-0.00))
                                                LocalPlayer.Character.HumanoidRootPart.CFrame = specialCFrame
                                                print("📍 Özel pozisyona teleport edildi (Injectors, Sparkplugs ve TimingBelt çıkarma için)")
                                                
                                                -- 2 saniye bekle sonra Injectors çıkar
                                                task.wait(1)
                                                
                                                local injectorsRemoveSuccess = pcall(function()
                                                    local args = {
                                                        [1] = "RemovePart";
                                                        [2] = "Injectors";
                                                    }
                                                    
                                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                    print("🔧 RemovePart Injectors gönderildi:", vehicleName)
                                                    return true
                                                end)
                                                
                                                -- 2 saniye bekle sonra Sparkplugs çıkar
                                                task.wait(1)
                                                
                                                local sparkplugsRemoveSuccess = pcall(function()
                                                    local args = {
                                                        [1] = "RemovePart";
                                                        [2] = "Sparkplugs";
                                                    }
                                                    
                                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                    print("🔧 RemovePart Sparkplugs gönderildi:", vehicleName)
                                                    return true
                                                end)
                                                
                                                -- 2 saniye bekle sonra TimingBelt çıkar
                                                task.wait(1)
                                                
                                                local timingBeltRemoveSuccess = pcall(function()
                                                    local args = {
                                                        [1] = "RemovePart";
                                                        [2] = "TimingBelt";
                                                    }
                                                    
                                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                    print("🔧 RemovePart TimingBelt gönderildi:", vehicleName)
                                                    return true
                                                end)
                                                
                                                print("✅ Özel parça çıkarma işlemi tamamlandı: Injectors, Sparkplugs ve TimingBelt")
                                                
                                                -- Şimdi Makine 1'e geri teleport (ikinci işlem için)
                                                task.wait(1)
                                                
                                                local machine1CFrame = CFrame.new(-767.44, 6.87, -1303.07) * CFrame.Angles(math.rad(0.00), math.rad(-112.58), math.rad(-0.00))
                                                LocalPlayer.Character.HumanoidRootPart.CFrame = machine1CFrame
                                                print("📍 Makine 1'e geri teleport edildi (EngineBlock işlemi için)")
                                                
                                                -- 2 saniye bekle sonra EngineBlock çıkar
                                                task.wait(1)
                                                
                                                local engineBlockRemoveSuccess = pcall(function()
                                                    local args = {
                                                        [1] = "RemovePart";
                                                        [2] = "EngineBlock";
                                                    }
                                                    
                                                    workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                    print("🔧 RemovePart EngineBlock gönderildi:", vehicleName)
                                                    return true
                                                end)
                                                
                                                if engineBlockRemoveSuccess then
                                                    -- 2 saniye bekle sonra Makine 1 click detector tetikle
                                                    task.wait(1)
                                                    
                                                    local finalMachine1ClickSuccess = pcall(function()
                                                        local machineClickDetector = workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector
                                                        fireClickDetector(workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector)
                                                        print("⚙️ Makine 1 final click detector tetiklendi")
                                                        return true
                                                    end)
                                                    
                                                    if finalMachine1ClickSuccess then
                                                        -- Makine 1 final tamamlandı, 6 saniye bekle sonra Su'ya geri dön
                                                        task.wait(6)
                                                        
                                                        -- Su istasyonuna geri teleport
                                                        local waterCFrame = CFrame.new(-766.30, 6.20, -1308.48) * CFrame.Angles(math.rad(-0.00), math.rad(-80.44), math.rad(-0.00))
                                                        LocalPlayer.Character.HumanoidRootPart.CFrame = waterCFrame
                                                        print("📍 Su istasyonuna geri teleport edildi")
                                                        
                                                        -- 2 saniye bekle sonra Radiator çıkar
                                                        task.wait(1)
                                                        
                                                        local radiatorRemoveSuccess = pcall(function()
                                                            local args = {
                                                                [1] = "RemovePart";
                                                                [2] = "Radiator";
                                                            }
                                                            
                                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                            print("🔧 RemovePart Radiator gönderildi:", vehicleName)
                                                            return true
                                                        end)
                                                        
                                                        if radiatorRemoveSuccess then
                                                            -- 2 saniye bekle sonra Su click detector final tetikle
                                                            task.wait(1)
                                                            
                                                            local finalWaterClickSuccess = pcall(function()
                                                                local waterClickDetector = workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector
                                                                fireClickDetector(workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector)
                                                                print("⚙️ Su final click detector tetiklendi")
                                                                return true
                                                            end)
                                                            
                                                            if finalWaterClickSuccess then
                                                                -- Final su tamamlandı, 10 saniye bekle sonra reapply işlemlerini başlat
                                                                task.wait(10)
                                                                print("🔧 Starting reapply operations...")
                                                                
                                                                -- 25 stud yakınındaki MoveableParts'ları bul
                                                                _G.acne_findNearbyMoveableParts = function()
                                                                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                        return {}
                                                                    end
                                                                    
                                                                    local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
                                                                    local moveableParts = workspace:FindFirstChild("MoveableParts")
                                                                    local nearbyParts = {}
                                                                    
                                                                    if not moveableParts then
                                                                        print("❌ MoveableParts bulunamadı")
                                                                        return {}
                                                                    end
                                                                    
                                                                    for _, part in pairs(moveableParts:GetChildren()) do
                                                                        if part:IsA("Model") then
                                                                            local owner = part:GetAttribute("Owner")
                                                                            if owner == LocalPlayer.Name then
                                                                                -- Parçanın pozisyonunu bul
                                                                                local partPosition = nil
                                                                                local centerPart = part.PrimaryPart or part:FindFirstChildWhichIsA("BasePart")
                                                                                if centerPart then
                                                                                    partPosition = centerPart.Position
                                                                                end
                                                                                
                                                                                if partPosition then
                                                                                    local distance = (playerPos - partPosition).Magnitude
                                                                                    if distance <= 25 then
                                                                                        table.insert(nearbyParts, part)
                                                                                        print("✅ Yakında parça bulundu:", part.Name, "Mesafe:", math.floor(distance), "stud")
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                    
                                                                    return nearbyParts
                                                                end
                                                                
                                                                local nearbyParts = _G.acne_findNearbyMoveableParts()
                                                                print("🔍 Toplam", #nearbyParts, "yakın parça bulundu")
                                                                
                                                                -- Reapply sıralaması tanımla
                                                                local reapplyOrder = {
                                                                    "EngineBlock",
                                                                    "Battery", 
                                                                    "Radiator",
                                                                    "Injectors",
                                                                    "CylinderHead",
                                                                    "AirIntake",
                                                                    "ExhaustManifold",
                                                                    "Sparkplugs",
                                                                    "TimingBelt"
                                                                }
                                                                
                                                                -- Yakındaki parçaları sıralı reapply et
                                                                local reappliedCount = 0
                                                                for _, partName in ipairs(reapplyOrder) do
                                                                    -- Bu isimde yakında parça var mı bul
                                                                    local foundPart = nil
                                                                    for _, part in ipairs(nearbyParts) do
                                                                        if part.Name == partName then
                                                                            foundPart = part
                                                                            break
                                                                        end
                                                                    end
                                                                    
                                                                    if foundPart then
                                                                        local reapplySuccess = pcall(function()
                                                                            local args = {
                                                                                [1] = "ReapplyPart";
                                                                                [2] = foundPart;
                                                                            }
                                                                            
                                                                            workspace:WaitForChild("Vehicles", 9e9):WaitForChild(vehicleName, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                                            print("🔧 ReapplyPart", foundPart.Name, "gönderildi (sıra:", reappliedCount + 1 .. "):", vehicleName)
                                                                            return true
                                                                        end)
                                                                        
                                                                        if reapplySuccess then
                                                                            reappliedCount = reappliedCount + 1
                                                                        else
                                                                            print("❌", foundPart.Name, "reapply işlemi başarısız")
                                                                        end
                                                                        
                                                                        -- 2 saniye bekle (son parça değilse)
                                                                        if reappliedCount < #nearbyParts then
                                                                            task.wait(1)
                                                                        end
                                                                    else
                                                                        print("⚠️", partName, "yakında bulunamadı, atlandı")
                                                                    end
                                                                end
                                                                
                                                                print("✅ All reapply operations completed! (" .. reappliedCount .. "/" .. #nearbyParts .. " parts)")
                                                                
                                                                -- Reapply tamamlandı, şimdi boyama işlemi başlat
                                                                task.wait(1)
                                                                print("🎨 Tüm reapply işlemleri tamamlandı, boyama işlemi başlatılıyor...")
                                                                
                                                                local paintSuccess = pcall(function()
                                                                    -- Kilitlendiğimiz aracı kullan (autoFarmLockedCar)
                                                                    local vehicleObject = autoFarmLockedCar
                                                                    
                                                                    print("🔍 BOYAMA DEBUG: autoFarmLockedCar =", vehicleObject and vehicleObject.Name or "NIL!")
                                                                    print("🔍 BOYAMA DEBUG: workspace'de mi =", vehicleObject and vehicleObject:IsDescendantOf(workspace) or false)
                                                                    
                                                                    if vehicleObject and vehicleObject:IsDescendantOf(workspace) then
                                                                        -- Aracın en büyük parçasını bul (daha güvenilir konum)
                                                                        local vehiclePart = nil
                                                                        local largestSize = 0
                                                                        
                                                                        for _, part in pairs(vehicleObject:GetDescendants()) do
                                                                            if part:IsA("BasePart") and part.Parent == vehicleObject then
                                                                                local size = part.Size.Magnitude
                                                                                if size > largestSize then
                                                                                    largestSize = size
                                                                                    vehiclePart = part
                                                                                end
                                                                            end
                                                                        end
                                                                        
                                                                        -- Eğer ana parça bulunamazsa alternative arama
                                                                        if not vehiclePart then
                                                                            vehiclePart = vehicleObject:FindFirstChildWhichIsA("BasePart") or 
                                                                                         vehicleObject:FindFirstChild("Body") and vehicleObject.Body:FindFirstChildWhichIsA("BasePart")
                                                                        end
                                                                        
                                                                        print("🔍 BOYAMA DEBUG: vehiclePart bulundu =", vehiclePart and vehiclePart.Name or "NIL!")
                                                                        print("🔍 BOYAMA DEBUG: vehiclePart boyutu =", vehiclePart and vehiclePart.Size or "N/A")
                                                                        
                                                                        if vehiclePart then
                                                                            -- Aracın yanına teleport (10 stud mesafe + 5 yükseklik)
                                                                            local vehiclePosition = vehiclePart.CFrame.Position
                                                                            local paintPosition = vehiclePosition + Vector3.new(10, 5, 0)
                                                                            
                                                                            print("🔧 BOYAMA TELEPORT: Araç pozisyonu =", vehiclePosition)
                                                                            print("🔧 BOYAMA TELEPORT: Hedef pozisyon =", paintPosition)
                                                                            
                                                                            -- Boyama için güvenli teleport - ÇİFTE GÜVENLİK
                                                                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                                -- İlk teleport denemesi
                                                                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(paintPosition)
                                                                                task.wait(0.2)
                                                                                
                                                                                -- İkinci güvenlik teleport
                                                                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(paintPosition)
                                                                                task.wait(0.2)
                                                                                
                                                                                -- Pozisyon doğrulama
                                                                                local currentPos = LocalPlayer.Character.HumanoidRootPart.Position
                                                                                local distance = (currentPos - paintPosition).Magnitude
                                                                                
                                                                                print("📍 BOYAMA TELEPORT SONUCU:")
                                                                                print("   - Hedef pozisyon:", paintPosition)
                                                                                print("   - Mevcut pozisyon:", currentPos)
                                                                                print("   - Mesafe farkı:", math.floor(distance * 100) / 100, "stud")
                                                                                
                                                                                if distance < 15 then
                                                                                    print("✅ BOYAMA TELEPORT BAŞARILI! Aracın yakınına varıldı:", vehicleObject.Name)
                                                                                else
                                                                                    print("⚠️ BOYAMA TELEPORT HATASI! Son deneme yapılıyor...")
                                                                                    -- Son deneme - farklı pozisyon
                                                                                    local alternatePaintPos = vehiclePosition + Vector3.new(8, 4, 8)
                                                                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(alternatePaintPos)
                                                                                    task.wait(0.2)
                                                                                    print("🔄 Alternatif pozisyon denendi:", alternatePaintPos)
                                                                                end
                                                                            else
                                                                                print("❌ Karakter veya HumanoidRootPart bulunamadı!")
                                                                                return false
                                                                            end
                                                                            
                                                                            -- Teleport stabilizasyonu
                                                                            task.wait(0.3)
                                                                            
                                                                            -- Rastgele renk oluştur
                                                                            local randomHue = math.random() * 360 -- 0-360 derece
                                                                            local randomSaturation = 0.7 + (math.random() * 0.3) -- 0.7-1.0 arası doygunluk
                                                                            local randomValue = 0.8 + (math.random() * 0.2) -- 0.8-1.0 arası parlaklık
                                                                            
                                                                            local randomColor = Color3.fromHSV(randomHue/360, randomSaturation, randomValue)
                                                                            
                                                                            print("🎨 Rastgele boyama başlatılıyor - HSV:", math.floor(randomHue), math.floor(randomSaturation*100)/100, math.floor(randomValue*100)/100)
                                                                            print("🎨 RGB değerleri:", math.floor(randomColor.R*255), math.floor(randomColor.G*255), math.floor(randomColor.B*255))
                                                                            
                                                                            -- SetPaint event'ini tetikle - GÜÇLÜ GÜVENLİK
                                                                            local paintEventSuccess = pcall(function()
                                                                                local args = {
                                                                                    [1] = vehicleObject,
                                                                                    [2] = randomColor
                                                                                }
                                                                                
                                                                                local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events", 5)
                                                                                local VehiclesEvents = Events:WaitForChild("Vehicles", 5)
                                                                                local SetPaintEvent = VehiclesEvents:WaitForChild("SetPaint", 5)
                                                                                
                                                                                SetPaintEvent:FireServer(unpack(args))
                                                                                return true
                                                                            end)
                                                                            
                                                                            if paintEventSuccess then
                                                                                print("🎨 ✅ Araç başarıyla rastgele renge boyandı:", vehicleObject.Name)
                                                                            else
                                                                                print("🎨 ❌ Boyama eventi tetiklenemedi, devam ediliyor...")
                                                                            end
                                                                            
                                                                            -- Boyama işlemi için bekleme
                                                                            task.wait(1)
                                                                            
                                                                            return true
                                                                        else
                                                                            print("❌ BOYAMA HATASI: Aracın hiçbir parçası bulunamadı!")
                                                                            print("🔍 DEBUG: Araç objesinin içindekiler:")
                                                                            for _, child in pairs(vehicleObject:GetChildren()) do
                                                                                print("   -", child.Name, ":", child.ClassName)
                                                                            end
                                                                            return false
                                                                        end
                                                                    else
                                                                        print("❌ BOYAMA HATASI: Araç objesi bulunamadı veya workspace'de değil!")
                                                                        print("🔍 DEBUG: autoFarmLockedCar durumu:", autoFarmLockedCar and autoFarmLockedCar.Name or "nil")
                                                                        return false
                                                                    end
                                                                end)
                                                                
                                                                if paintSuccess then
                                                                    print("✅ Boyama işlemi başarılı! Araca binilip araçla satış yerine gidiliyor...")
                                                                else
                                                                    print("⚠️ Boyama başarısız, yine de araca binip satış yerine gidiliyor...")
                                                                end
                                                                
                                                                print("🚗 Satış süreci başlatılıyor (araçla TP denenecek)...")
                                                                local sellCFrame = CFrame.new(-1908.95, 4.43, -778.30) * CFrame.Angles(math.rad(0.00), math.rad(1.82), math.rad(0.00))
                                                                
                                                                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                    local char = LocalPlayer.Character
                                                                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                                                                    local hrp = char:FindFirstChild("HumanoidRootPart")
                                                                    local vehicle = autoFarmLockedCar
                                                                    local boarded = false

                                                                    -- Yardımcı: DriveSeat bul (önce isim DriveSeat, yoksa ilk VehicleSeat)
                                                                    local function findDriveSeat(v)
                                                                        if not v then return nil end
                                                                        local fallback = nil
                                                                        for _, d in ipairs(v:GetDescendants()) do
                                                                            if d:IsA("VehicleSeat") then
                                                                                if d.Name == "DriveSeat" then
                                                                                    return d
                                                                                end
                                                                                if not fallback then fallback = d end
                                                                            end
                                                                        end
                                                                        return fallback
                                                                    end

                                                                    -- Yardımcı: Zorla oturt (birkaç deneme + konum ayarlama)
                                                                    local function forceSit(seat, hum, attempts)
                                                                        attempts = attempts or 8
                                                                        if not seat or not hum or not hrp then return false end
                                                                        for i=1, attempts do
                                                                            -- Eğer başka biri oturuyorsa kaldırmaya çalış
                                                                            if seat.Occupant and seat.Occupant ~= hum then
                                                                                pcall(function() seat.Occupant.Sit = false end)
                                                                                task.wait(0.1)
                                                                            end
                                                                            -- Karakteri koltuğun hemen üstüne/yanına yerleştir (küçük random offset anti stuck)
                                                                            local offset = CFrame.new( math.random(-2,2), 3 + (i*0.1), math.random(-2,2) )
                                                                            hrp.CFrame = seat.CFrame * offset
                                                                            task.wait(0.05)
                                                                            -- Oturmayı dene
                                                                            pcall(function() seat:Sit(hum) end)
                                                                            task.wait(0.15)
                                                                            if hum.SeatPart == seat or seat.Occupant == hum then
                                                                                return true
                                                                            end
                                                                        end
                                                                        return hum.SeatPart == seat
                                                                    end

                                                                    if vehicle and vehicle:IsDescendantOf(workspace) then
                                                                        local driveSeat = findDriveSeat(vehicle)
                                                                        if driveSeat and humanoid and hrp then
                                                                            print("🔎 DriveSeat bulundu:", driveSeat:GetFullName())
                                                                            boarded = forceSit(driveSeat, humanoid, 10)
                                                                            if boarded then
                                                                                print("✅ DriveSeat'e oturma BAŞARILI")
                                                                            else
                                                                                print("⚠️ DriveSeat'e oturulamadı (tüm denemeler başarısız) → karakter TP fallback")
                                                                            end
                                                                        else
                                                                            print("⚠️ DriveSeat veya Humanoid/HRP eksik → karakter TP fallback")
                                                                        end
                                                                    else
                                                                        print("⚠️ Araç bulunamadı veya workspace'te değil → karakter TP fallback")
                                                                    end
                                                                    
                                                                    -- Araçla TP (oturulduysa)
                                                                    if boarded and humanoid and humanoid.SeatPart then
                                                                        local vehModel = humanoid.SeatPart:FindFirstAncestorOfClass("Model")
                                                                        if vehModel then
                                                                            if not vehModel.PrimaryPart then
                                                                                local seatForPrimary = vehModel:FindFirstChildOfClass("VehicleSeat") or humanoid.SeatPart
                                                                                pcall(function() vehModel.PrimaryPart = seatForPrimary end)
                                                                            end
                                                                            if vehModel.PrimaryPart then
                                                                                local ok,err = pcall(function()
                                                                                    vehModel:SetPrimaryPartCFrame(sellCFrame)
                                                                                end)
                                                                                if ok then
                                                                                    print("📍 Araçla satış noktasına teleport edildi")
                                                                                else
                                                                                    print("❌ Araçla TP hata:", err)
                                                                                    if hrp then hrp.CFrame = sellCFrame end
                                                                                end
                                                                            else
                                                                                print("⚠️ PrimaryPart ayarlanamadı, karakter TP")
                                                                                if hrp then hrp.CFrame = sellCFrame end
                                                                            end
                                                                        else
                                                                            print("⚠️ Vehicle model alınamadı, karakter TP")
                                                                            if hrp then hrp.CFrame = sellCFrame end
                                                                        end
                                                                    else
                                                                        -- Normal karakter TP
                                                                        if hrp then
                                                                            hrp.CFrame = sellCFrame
                                                                            print("📍 Karakter satış noktasına teleport edildi")
                                                                        end
                                                                    end
                                                                    
                                                                    -- Araçtan çık (oturduysa)
                                                                    if boarded and humanoid then
                                                                        task.wait(0.5)
                                                                        humanoid.Sit = false
                                                                        task.wait(0.15)
                                                                        humanoid.Sit = false
                                                                        if hrp then
                                                                            -- Hafif yana kaydır
                                                                            task.delay(0.05,function()
                                                                                if hrp.Parent then
                                                                                    hrp.CFrame = hrp.CFrame + hrp.CFrame.RightVector * 8
                                                                                end
                                                                            end)
                                                                        end
                                                                        print("🚪 Araçtan çıkıldı, satış tetiklenecek")
                                                                    end
                                                                    
                                                                    -- Satış öncesi küçük bekleme
                                                                    task.wait(1)
                                                                    
                                                                    local sellSuccess = false
                                                                    
                                                                    -- Önce ProximityPrompt'u dene
                                                                    local proximitySuccess = pcall(function()
                                                                        local sellPrompt = workspace.Map.SellCar.Prompt.ProximityPrompt
                                                                        if sellPrompt then
                                                                            fireproximityprompt(sellPrompt, 0)
                                                                            print("💰 Araç satış promptu (ProximityPrompt) tetiklendi")
                                                                            sellSuccess = true
                                                                            return true
                                                                        end
                                                                    end)
                                                                    
                                                                    -- ProximityPrompt çalışmazsa ClickDetector'u dene
                                                                    if not sellSuccess then
                                                                        local clickSuccess = pcall(function()
                                                                            local sellClick = workspace.Map.SellCar.Prompt:FindFirstChild("ClickDetector")
                                                                            if sellClick then
                                                                                fireClickDetector(sellClick)
                                                                                print("💰 Araç satış promptu (ClickDetector) tetiklendi")
                                                                                sellSuccess = true
                                                                                return true
                                                                            end
                                                                        end)
                                                                    end
                                                                    
                                                                    -- Son çare: tüm ClickDetector'ları kontrol et
                                                                    if not sellSuccess then
                                                                        local allClickSuccess = pcall(function()
                                                                            for _, child in pairs(workspace.Map.SellCar:GetDescendants()) do
                                                                                if child:IsA("ClickDetector") then
                                                                                    fireClickDetector(child)
                                                                                    print("💰 Araç satış promptu (Alternatif ClickDetector) tetiklendi")
                                                                                    sellSuccess = true
                                                                                    break
                                                                                end
                                                                            end
                                                                        end)
                                                                    end
                                                                    
                                                                    -- Eğer hala başarısızsa, E tuşu simülasyonu dene (3 saniye basılı tut)
                                                                    if not sellSuccess then
                                                                        local keySuccess = pcall(function()
                                                                            local VirtualInputManager = game:GetService("VirtualInputManager")
                                                                            
                                                                            -- E tuşunu 3 saniye basılı tut
                                                                            print("💰 E tuşu 3 saniye basılı tutulacak...")
                                                                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                                                            task.wait(3) -- 3 saniye bekle
                                                                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                                                            print("💰 E key simulation completed (3 seconds)")
                                                                            sellSuccess = true
                                                                        end)
                                                                    end
                                                                    
                                                                    -- Son çare: ClickDetector ile birlikte E tuşu
                                                                    if not sellSuccess then
                                                                        local comboSuccess = pcall(function()
                                                                            -- Önce ClickDetector dene
                                                                            for _, child in pairs(workspace.Map.SellCar:GetDescendants()) do
                                                                                if child:IsA("ClickDetector") then
                                                                                    fireClickDetector(child)
                                                                                    break
                                                                                end
                                                                            end
                                                                            
                                                                            task.wait(0.5)
                                                                            
                                                                            -- Sonra E tuşunu 3 saniye basılı tut
                                                                            local VirtualInputManager = game:GetService("VirtualInputManager")
                                                                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                                                            task.wait(3)
                                                                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                                                            print("💰 ClickDetector + E tuşu kombinasyonu denendi")
                                                                            sellSuccess = true
                                                                        end)
                                                                    end
                                                                    
                                                                    if not sellSuccess then
                                                                        print("⚠️ Satış promptu tetiklenemedi! Manuel satış gerekebilir.")
                                                                        
                                                                        -- Debug: Satış alanındaki tüm objeleri listele
                                                                        print("🔍 DEBUG: SellCar alanındaki objeler:")
                                                                        local function debugSellArea()
                                                                            if workspace.Map and workspace.Map.SellCar then
                                                                                for _, child in pairs(workspace.Map.SellCar:GetDescendants()) do
                                                                                    if child:IsA("ProximityPrompt") or child:IsA("ClickDetector") then
                                                                                        print("   -", child.Name, ":", child.ClassName, "Parent:", child.Parent.Name)
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                        debugSellArea()
                                                                    end
                                                                    
                                                                    if sellSuccess then
                                                                        print("✅ Auto Farm cycle completed! Auto TP/Buy reactivated for new purchase.")
                                                                        print("🔄 LOOP: System ready for new vehicle purchase!")
                                                                        print("📊 Auto TP:", autoTpEnabled and "ACTIVE" or "OFF", "| Auto Buy:", autoBuyEnabled and "ACTIVE" or "OFF")
                                                                    else
                                                                        print("❌ Araç satış işlemi başarısız! Tekrar deneme sistemi başlatılıyor...")
                                                                        print("⏳ Satış başarılı olana kadar bekleniyor...")
                                                                        
                                                                        -- Satış başarılı olana kadar tekrar dene
                                                                        local sellRetryCount = 0
                                                                        local maxRetries = 10
                                                                        
                                                                        while not sellSuccess and sellRetryCount < maxRetries do
                                                                            sellRetryCount = sellRetryCount + 1
                                                                            print("🔄 Satış denemesi #" .. sellRetryCount .. "/" .. maxRetries)
                                                                            
                                                                            -- 2 saniye bekle sonra tekrar dene
                                                                            task.wait(2)
                                                                            
                                                                            -- Tekrar satış noktasına teleport
                                                                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                                LocalPlayer.Character.HumanoidRootPart.CFrame = sellCFrame
                                                                                print("📍 Satış noktasına tekrar teleport edildi (deneme #" .. sellRetryCount .. ")")
                                                                                task.wait(1)
                                                                            end
                                                                            
                                                                            -- Tüm satış yöntemlerini tekrar dene
                                                                            local retrySuccess = pcall(function()
                                                                                -- ProximityPrompt dene
                                                                                local sellPrompt = workspace.Map.SellCar.Prompt.ProximityPrompt
                                                                                if sellPrompt then
                                                                                    fireproximityprompt(sellPrompt, 0)
                                                                                    print("💰 Tekrar deneme: ProximityPrompt tetiklendi")
                                                                                    sellSuccess = true
                                                                                    return true
                                                                                end
                                                                                
                                                                                -- ClickDetector dene
                                                                                for _, child in pairs(workspace.Map.SellCar:GetDescendants()) do
                                                                                    if child:IsA("ClickDetector") then
                                                                                        fireClickDetector(child)
                                                                                        print("💰 Tekrar deneme: ClickDetector tetiklendi")
                                                                                        sellSuccess = true
                                                                                        break
                                                                                    end
                                                                                end
                                                                                
                                                                                -- E tuşu basılı tut
                                                                                if not sellSuccess then
                                                                                    local VirtualInputManager = game:GetService("VirtualInputManager")
                                                                                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                                                                    task.wait(3)
                                                                                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                                                                    print("💰 Tekrar deneme: E tuşu basıldı")
                                                                                    sellSuccess = true
                                                                                end
                                                                                
                                                                                return sellSuccess
                                                                            end)
                                                                            
                                                                            if sellSuccess then
                                                                                print("✅ Satış başarılı! (Deneme #" .. sellRetryCount .. ")")
                                                                                break
                                                                            else
                                                                                print("⚠️ Satış denemesi #" .. sellRetryCount .. " başarısız")
                                                                            end
                                                                        end
                                                                        
                                                                        -- Eğer tüm denemeler başarısızsa
                                                                        if not sellSuccess then
                                                                            print("❌ UYARI: " .. maxRetries .. " deneme sonrası satış hala başarısız!")
                                                                            print("🛑 Auto Farm döngüsü durduruluyor - Manuel müdahale gerekli")
                                                                            return -- Döngüyü durdur
                                                                        end
                                                                    end
                                                                    
                                                                    -- Satış başarılı olduğu kesin! Döngü devam etsin
                                                                    if sellSuccess then
                                                                        -- 300 saniye cooldown eklendi
                                                                        print("⏳ Cooldown: Satış sonrası 245 saniyelik bekleme başlıyor (~4 dk 5 sn)...")
                                                                        for remaining = 245,1,-1 do
                                                                            if remaining % 30 == 0 or remaining <= 10 then
                                                                                print("⏳ Cooldown kalan:", remaining, "sn")
                                                                            end
                                                                            task.wait(1)
                                                                        end
                                                                        print("✅ Cooldown bitti! Yeni cycle başlatılıyor...")
                                                                        
                                                                        -- Cycle reset işlemleri
                                                                        autoFarmFirstPurchaseCompleted = false
                                                                        autoFarmTpLocked = false
                                                                        autoFarmLockedCar = nil
                                                                        autoTpEnabled = true
                                                                        print("🔓 Durum resetlendi (flags temizlendi, autoTpEnabled = true)")
                                                                        
                                                                        -- AUTO TP yeniden
                                                                        if typeof(_G.acne_checkExistingCars) == "function" then
                                                                            task.spawn(function()
                                                                                task.wait(0.5)
                                                                                print("🔄 Restarting AUTO TP (cooldown sonrası)...")
                                                                                pcall(_G.acne_checkExistingCars)
                                                                            end)
                                                                        end
                                                                        
                                                                        -- Bilgi çıktısı
                                                                        print("📊 Durum | Auto TP:", autoTpEnabled and "ACTIVE" or "OFF", "| Auto Buy:", autoBuyEnabled and "ACTIVE" or "OFF", "| Auto Farm:", autoFarmEnabled and "ACTIVE" or "OFF")
                                                                    end
                                                                end
                                                            end
                                                            
                                                            -- Tüm işlemler gerçekten tamamlandı
                                                            print("✅ All machine operations completed: Machine 1 → Machine 2 → Battery → Water → Machine 1 (Final) → Water (Final) → Reapply")
                                                        else
                                                            print("❌ Radiator RemovePart işlemi başarısız")
                                                        end
                                                    end
                                                    
                                                else
                                                    print("❌ EngineBlock RemovePart işlemi başarısız")
                                                end
                                            end
                                        else
                                            print("❌ Su RemovePart işlemi başarısız")
                                        end
                                    else
                                        print("❌ Batarya click detector işlemi başarısız")
                                    end
                                else
                                    print("❌ Batarya RemovePart işlemi başarısız")
                                end
                            else
                                print("❌ Makine 2 click detector işlemi başarısız")
                            end
                        else
                            print("❌ Makine 2 RemovePart işlemi başarısız")
                        end
                    else
                        print("❌ Makine 1 click detector işlemi başarısız")
                    end
                    
                    -- Tüm işlemler tamamlandı (artık Su da dahil)
                    print("✅ All machine operations completed: Machine 1 → Machine 2 → Battery → Water")
                else
                    print("❌ RemovePart işlemi başarısız:", result)
                end
            end
        end)
    end

    -- Araçtan çıkma fonksiyonu (güncellenmiş) - Akıllı karakter durumu kontrollü
    _G.acne_forceExitJumpAndShiftLeft = function()
        print("🚪 AUTO FARM: forceExitJumpAndShiftLeft BAŞLADI")
        
        if not LocalPlayer.Character then 
            print("⚠️ Karakter bulunamadı, Auto Farm devam edecek")
            -- Auto Farm işlemlerini başlat
            task.delay(2, function()
                print("🔍 Karakter bulunamasa da Auto Farm başlıyor...")
                local ownedVehicle = _G.acne_findOwnedVehicle()
                
                if ownedVehicle then
                    print("✅ Araç bulundu:", ownedVehicle.Name)
                    
                    -- ONLY BUY kontrolü
                    local vehicleModel = getVehicleModel(ownedVehicle)
                    if vehicleModel and carStates[vehicleModel] == "onlybuy" then
                        print("🚫 DONT AUTO FARM modu aktif! Araç:", vehicleModel, "- Auto farm işlemleri atlanıyor, sadece satın alma yapıldı")
                        return -- Auto farm işlemlerini başlatma
                    end
                    
                    -- Hood detector'ını ateşle
                    local hoodDetectorSuccess = pcall(function()
                        local hoodDetector = ownedVehicle.Misc.Hood.Detector.ClickDetector
                        fireClickDetector(hoodDetector, LocalPlayer)
                        print("🚗 Hood detector ateşlendi:", ownedVehicle.Name)
                        return true
                    end)
                    
                    if hoodDetectorSuccess then
                        -- 1 saniye bekle sonra makine işlemlerini başlat
                        task.wait(1)
                        print("✅ Hood detector successful, starting Machine 1 operation:", ownedVehicle.Name)
                        _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                    else
                        print("❌ Hood detector ateşlenemedi, direkt makine işlemine geçiliyor")
                        _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                    end
                else
                    print("❌ Auto Farm: Kendi aracım bulunamadı")
                end
            end)
            return 
        end
        
        local char = LocalPlayer.Character
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if not humanoid or not hrp then 
            print("⚠️ Humanoid/HRP bulunamadı, Auto Farm devam edecek")
            -- Auto Farm işlemlerini başlat
            task.delay(2, function()
                print("🔍 Humanoid/HRP bulunamasa da Auto Farm başlıyor...")
                local ownedVehicle = _G.acne_findOwnedVehicle()
                
                if ownedVehicle then
                    print("✅ Araç bulundu:", ownedVehicle.Name)
                    
                    -- DONT AUTO FARM kontrolü
                    local vehicleModel = getVehicleModel(ownedVehicle)
                    if vehicleModel and dontAutoFarmCars[vehicleModel] then
                        print("🚫 DONT AUTO FARM modu aktif! Araç:", vehicleModel, "- Auto farm işlemleri atlanıyor, sadece satın alma yapıldı")
                        return -- Auto farm işlemlerini başlatma
                    end
                    
                    -- Hood detector'ını ateşle
                    local hoodDetectorSuccess = pcall(function()
                        local hoodDetector = ownedVehicle.Misc.Hood.Detector.ClickDetector
                        fireClickDetector(hoodDetector, LocalPlayer)
                        print("🚗 Hood detector ateşlendi:", ownedVehicle.Name)
                        return true
                    end)
                    
                    if hoodDetectorSuccess then
                        -- 1 saniye bekle sonra makine işlemlerini başlat
                        task.wait(1)
                        print("✅ Hood detector successful, starting Machine 1 operation:", ownedVehicle.Name)
                        _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                    else
                        print("❌ Hood detector ateşlenemedi, direkt makine işlemine geçiliyor")
                        _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                    end
                else
                    print("❌ Auto Farm: Kendi aracım bulunamadı")
                end
            end)
            return 
        end
        
        local function isSeated(humanoid)
            if not humanoid then return false end
            return humanoid.SeatPart ~= nil or humanoid:GetState() == Enum.HumanoidStateType.Seated
        end
        
        -- AKILLI KARAKTER DURUM KONTROLÜ
        if not isSeated(humanoid) then 
            print("✅ KARAKTER AYAKTA: Araçtan çıkma atlanıyor, direkt Auto Farm başlıyor")
            -- Karakter ayaktaysa direkt Auto Farm başlat (hiçbir şey yapma)
            task.spawn(function()
                print("🔍 Karakter ayaktayken Auto Farm başlıyor...")
                local ownedVehicle = _G.acne_findOwnedVehicle()
                
                if ownedVehicle then
                    print("✅ Araç bulundu:", ownedVehicle.Name)
                    
                    -- DONT AUTO FARM kontrolü
                    local vehicleModel = getVehicleModel(ownedVehicle)
                    if vehicleModel and dontAutoFarmCars[vehicleModel] then
                        print("🚫 DONT AUTO FARM modu aktif! Araç:", vehicleModel, "- Auto farm işlemleri atlanıyor, sadece satın alma yapıldı")
                        return -- Auto farm işlemlerini başlatma
                    end
                    
                    -- Hood detector'ını ateşle
                    local hoodDetectorSuccess = pcall(function()
                        local hoodDetector = ownedVehicle.Misc.Hood.Detector.ClickDetector
                        fireClickDetector(hoodDetector, LocalPlayer)
                        print("🚗 Hood detector ateşlendi:", ownedVehicle.Name)
                        return true
                    end)
                    
                    if hoodDetectorSuccess then
                        -- 1 saniye bekle sonra makine işlemlerini başlat
                        task.wait(1)
                        print("✅ Hood detector successful, starting Machine 1 operation:", ownedVehicle.Name)
                        _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                    else
                        print("❌ Hood detector ateşlenemedi, direkt makine işlemine geçiliyor")
                        _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                    end
                else
                    print("❌ Auto Farm: Kendi aracım bulunamadı")
                end
            end)
            return 
        end

        print("🚗 KARAKTER ARABADA: Araçtan çıkma işlemi başlıyor...")
        
        -- Araçtan çık
        humanoid.Sit = false
        task.wait(0.05)
        humanoid.Sit = false

        -- Zıplat
        local jumpPower = 150
        hrp.Velocity = Vector3.new(hrp.Velocity.X, math.max(jumpPower, hrp.Velocity.Y + 10), hrp.Velocity.Z)
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

        -- Küçük gecikmeden sonra sağ tarafa teleport
        task.delay(0.1, function()
            if hrp and hrp.Parent then
                local cf = hrp.CFrame
                local rightVector = cf.RightVector -- sağ yön
                local offset = rightVector * 20 -- 15 stud sağ
                hrp.CFrame = cf + offset
            end
        end)
        
        -- Araçtan çıktıktan sonra yakındaki aracı bul ve hood detector'ını ateşle
        task.delay(2, function()
            print("🔍 AUTO FARM: 2 saniye sonra kendi aracım aranıyor...")
            local ownedVehicle = _G.acne_findOwnedVehicle()
            
            if ownedVehicle then
                print("✅ AUTO FARM: Araç bulundu:", ownedVehicle.Name)
                
                -- DONT AUTO FARM kontrolü
                local vehicleModel = getVehicleModel(ownedVehicle)
                if vehicleModel and dontAutoFarmCars[vehicleModel] then
                    print("🚫 DONT AUTO FARM modu aktif! Araç:", vehicleModel, "- Auto farm işlemleri atlanıyor, sadece satın alma yapıldı")
                    return -- Auto farm işlemlerini başlatma
                end
                
                -- Hood detector'ını ateşle
                local hoodDetectorSuccess = pcall(function()
                    local hoodDetector = ownedVehicle.Misc.Hood.Detector.ClickDetector
                    fireClickDetector(hoodDetector, LocalPlayer)
                    print("🚗 AUTO FARM: Hood detector ateşlendi:", ownedVehicle.Name)
                    return true
                end)
                
                if hoodDetectorSuccess then
                    -- 1 saniye bekle sonra makine işlemlerini başlat
                    task.wait(1)
                    print("✅ AUTO FARM: Hood detector başarılı, Machine 1 işlemi başlatılıyor:", ownedVehicle.Name)
                    _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                else
                    print("❌ Hood detector ateşlenemedi, direkt makine işlemine geçiliyor")
                    _G.acne_processMachine1WithVehicle(ownedVehicle.Name)
                end
            else
                print("❌ Yakında kendi aracım bulunamadı, Makine 1 işlemi atlandı")
            end
        end)
    end

    -- Auto Buy sürecinde repair teleport ve araçtan çıkma işlemi
    local function handleAutoBuySuccess(carName)
        task.spawn(function()
            print("🛒 Auto Buy başarılı:", carName)
            
            -- AUTO FARM KONTROLÜ: Auto Farm açıksa Auto Farm işlemlerini yap
            if autoFarmEnabled then
                print("🚜 AUTO FARM AKTİF: Auto Farm işlemleri HEMEN başlatılıyor...")
                
                -- ⚡ AUTO FARM: İlk satın alım tamamlandı olarak işaretle (TP kilidi sonra yapılacak)
                autoFarmFirstPurchaseCompleted = true
                
                print("🔒 AUTO FARM: İlk araç satın alındı, farm işlemi başlayacak...")
                
                print("⚡ HIZLI KİLİTLEME: Araç satın alındı, ANINDA kilitleniyor...")
                
                -- AUTO FARM KİLİDİ: Satın alınan aracı HEMEN bul ve kilitle (MESAFE KONTROLSÜZ)
                local foundOwnedVehicle = nil
                
                -- HIZLI ARAMA: 0.1 saniye bekle, sonra hemen ara
                task.wait(0.1)
                
                if workspace:FindFirstChild("Vehicles") then
                    for _, vehicle in pairs(workspace.Vehicles:GetChildren()) do
                        if vehicle:IsA("Model") then
                            local owner = vehicle:GetAttribute("Owner")
                            if owner == LocalPlayer.Name then
                                foundOwnedVehicle = vehicle
                                print("⚡⚡ SÜPER HIZLI: Kendi aracım bulundu:", vehicle.Name)
                                break -- İlk bulduğunu hemen kilitle
                            end
                        end
                    end
                end
                
                if foundOwnedVehicle then
                    autoFarmTpLocked = true
                    autoFarmLockedCar = foundOwnedVehicle
                    print("🔒🔒🔒 AUTO FARM KİLİTLEME AKTİF 🔒🔒🔒")
                    print("🔒 Kilitli araç:", foundOwnedVehicle.Name)
                    print("🔒 Artık başka araçlara TP ATİLMAYACAK!")
                    print("🔒 Auto Buy işlemleri için sadece bu araç!")
                    print("🔒 Auto Farm HEMEN başlıyor!")
                else
                    print("❌ AUTO FARM: Owner kontrolünde kendi aracım bulunamadı")
                end
                
                -- HIZLI BAŞLATMA: 0.5 saniye bekle (eskiden 2 saniyeydi)
                task.wait(0.5)
                print("⚡ Repair'e TP öncesi hızlı bekleme: 0.5 saniye")
                
                -- Repair frame'ine teleport et
                local repairCFrame = CFrame.new(-783.90, 3.35, -1300.51) * CFrame.Angles(math.rad(12.78), math.rad(89.94), math.rad(0.00))
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local char = LocalPlayer.Character
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    
                    -- Eğer araçtaysak araçla beraber teleport et
                    if humanoid and humanoid.SeatPart then
                        local vehicle = humanoid.SeatPart:FindFirstAncestorOfClass("Model")
                        if vehicle then
                            print("🚗 Araçla beraber repair'e teleport ediliyor...")
                            
                            if not vehicle.PrimaryPart then
                                local seat = vehicle:FindFirstChildOfClass("VehicleSeat")
                                if seat then
                                    vehicle.PrimaryPart = seat
                                end
                            end
                            
                            if vehicle.PrimaryPart then
                                vehicle:SetPrimaryPartCFrame(repairCFrame)
                            end
                        end
                    else
                        -- Araçta değilse normal teleport
                        hrp.CFrame = repairCFrame
                    end
                    
                    print("📍 Repair frame'ine teleport edildi")
                end
                
                -- Auto Farm bildirim
                local notification = Instance.new("ScreenGui", game.CoreGui)
                local frame = Instance.new("Frame", notification)
                frame.Size = UDim2.new(0,350,0,60)
                frame.Position = UDim2.new(0.5,-175,0,180)
                frame.BackgroundColor3 = Color3.fromRGB(100,200,255)
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                
                local label = Instance.new("TextLabel", frame)
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = "🚜 Auto Farm: Repair'e teleport edildi"
                label.TextColor3 = Color3.new(1,1,1)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                
                task.spawn(function()
                    task.wait(3)
                    pcall(function() notification:Destroy() end)
                end)
                
                -- AUTO FARM DÖNGÜSÜNÜ BAŞLAT: Repair'e teleport sonrası Auto Farm işlemlerini başlat
                task.spawn(function()
                    task.wait(2) -- Repair'e teleport sonrası kısa bekleme
                    print("🚜 AUTO FARM: Repair'e teleport tamamlandı, araçtan çıkma ve Auto Farm başlatılıyor...")
                    print("🔍 DEBUG: autoFarmEnabled =", autoFarmEnabled)
                    print("🔍 DEBUG: autoFarmTpLocked =", autoFarmTpLocked)
                    print("🔍 DEBUG: autoFarmLockedCar =", autoFarmLockedCar and autoFarmLockedCar.Name or "nil")
                    
                    -- DONT AUTO FARM kontrolü - Kilitlenmiş araç için kontrol et
                    if autoFarmLockedCar then
                        local vehicleModel = getVehicleModel(autoFarmLockedCar)
                        if vehicleModel and dontAutoFarmCars[vehicleModel] then
                            print("🚫 DONT AUTO FARM modu aktif! Araç:", vehicleModel, "- Auto farm işlemleri atlanıyor, sadece satın alma yapıldı")
                            
                            -- Auto farm döngüsünü başlatma, sadece bildirim göster
                            local notification = Instance.new("ScreenGui", game.CoreGui)
                            local frame = Instance.new("Frame", notification)
                            frame.Size = UDim2.new(0,400,0,80)
                            frame.Position = UDim2.new(0.5,-200,0,250)
                            frame.BackgroundColor3 = Color3.fromRGB(255,100,100)
                            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                            
                            local label = Instance.new("TextLabel", frame)
                            label.Size = UDim2.new(1,0,1,0)
                            label.BackgroundTransparency = 1
                            label.Text = "🚫 DONT AUTO FARM: " .. vehicleModel .. " - only purchased"
                            label.TextColor3 = Color3.new(1,1,1)
                            label.Font = Enum.Font.GothamBold
                            label.TextSize = 16
                            
                            task.spawn(function()
                                task.wait(5)
                                pcall(function() notification:Destroy() end)
                            end)
                            
                            return -- Auto farm işlemlerini başlatma
                        end
                    end
                    
                    -- Araçtan çıkma işlemini çalıştır (Auto Farm döngüsünü başlatacak)
                    _G.acne_forceExitJumpAndShiftLeft()
                    print("🔄 AUTO FARM: forceExitJumpAndShiftLeft çalıştırıldı - Auto Farm döngüsü başlatıldı!")
                end)
                
            else
                -- AUTO FARM KAPALI: Sadece satın alma yap, repair'e götürme
                print("💰 AUTO FARM KAPALI: Sadece araç satın alındı, repair işlemi yapılmayacak")
                
                -- Sadece satın alma bildirimi
                local notification = Instance.new("ScreenGui", game.CoreGui)
                local frame = Instance.new("Frame", notification)
                frame.Size = UDim2.new(0,300,0,60)
                frame.Position = UDim2.new(0.5,-150,0,180)
                frame.BackgroundColor3 = Color3.fromRGB(100,255,100)
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                
                local label = Instance.new("TextLabel", frame)
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = "💰 Auto Buy: " .. carName .. " purchased"
                label.TextColor3 = Color3.new(1,1,1)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                
                task.spawn(function()
                    task.wait(3)
                    pcall(function() notification:Destroy() end)
                end)
            end
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                
                -- Eğer araçtaysak araçla beraber teleport et
                if humanoid and humanoid.SeatPart then
                    local vehicle = humanoid.SeatPart:FindFirstAncestorOfClass("Model")
                    if vehicle then
                        print("🚗 Araçla beraber repair'e teleport ediliyor...")
                        
                        if not vehicle.PrimaryPart then
                            local seat = vehicle:FindFirstChildOfClass("VehicleSeat")
                            if seat then
                                vehicle.PrimaryPart = seat
                            end
                        end
                        
                        if vehicle.PrimaryPart then
                            vehicle:SetPrimaryPartCFrame(repairCFrame)
                        end
                    end
                else
                    -- Araçta değilse normal teleport
                    hrp.CFrame = repairCFrame
                end
                
                print("📍 Repair frame'ine teleport edildi")
                
                -- Bildirim göster
                local notification = Instance.new("ScreenGui", game.CoreGui)
                local frame = Instance.new("Frame", notification)
                frame.Size = UDim2.new(0,350,0,60)
                frame.Position = UDim2.new(0.5,-175,0,180)
                frame.BackgroundColor3 = Color3.fromRGB(100,200,255)
                Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                
                local label = Instance.new("TextLabel", frame)
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = "🔧 Teleported to Repair with vehicle"
                label.TextColor3 = Color3.new(1,1,1)
                label.Font = Enum.Font.GothamBold
                label.TextSize = 16
                
        end)
    end

    local function setupAutoBuyLoop()
        -- Eski connection'ı temizle
        if buyConnections.mainLoop then
            if type(buyConnections.mainLoop) == "thread" then
                task.cancel(buyConnections.mainLoop)
            else
                pcall(function() buyConnections.mainLoop:Disconnect() end)
            end
            buyConnections.mainLoop = nil
        end
        
        buyConnections.mainLoop = task.spawn(function()
            while autoBuyEnabled do  -- true yerine autoBuyEnabled kontrolü
                task.wait(1) -- 1 saniye sabit bekleme
                
                -- ⚡ AUTO FARM SÜPER KİLİT KONTROLÜ (EN YÜKSEK ÖNCELİK)
                if autoFarmEnabled and autoFarmFirstPurchaseCompleted then
                    print(" 🔒🔒 AUTO FARM SÜPER KİLİT: Auto Buy tamamen durduruldu!")
                    continue
                end
                
                -- DEBUG: Auto Farm durumunu sürekli kontrol et
                if autoFarmEnabled then
                    print("🔍 AUTO FARM DEBUG: autoFarmFirstPurchaseCompleted =", autoFarmFirstPurchaseCompleted)
                    print("  AUTO FARM DEBUG: autoFarmTpLocked =", autoFarmTpLocked)
                    print("🔍 AUTO FARM DEBUG: autoBuyEnabled =", autoBuyEnabled)
                    print("🔍 AUTO FARM DEBUG: autoTpEnabled =", autoTpEnabled)
                end
                
                -- Auto Farm modu başlangıcında debug bilgisi
                if autoFarmEnabled and not autoFarmFirstPurchaseCompleted then
                    print("🔄 AUTO FARM: Auto Buy loop running...")
                end
                
                if autoBuyEnabled and autoTpEnabled then
                    local vehicles = workspace:FindFirstChild("Vehicles")
                    if not vehicles then 
                        continue
                    end

                    -- Eğer şu anda bir araca kitliysek ve hala workspace'deyse
                    if lockedToBuyTarget and currentBuyTarget and currentBuyTarget:IsDescendantOf(workspace) then
                        local cd = currentBuyTarget:FindFirstChild("ClickDetector")
                        if cd then
                            fireClickDetector(cd, LocalPlayer)
                            print("🛒 Aynı araca tekrar click gönderildi:", currentBuyTarget.Name)
                        end
                        continue
                    else
                        lockedToBuyTarget = false
                        currentBuyTarget = nil
                    end

                    -- AUTO FARM KİLİDİ: Auto Farm aktifken sadece TP engellenir, satın alma devam eder
                    local skipTeleport = false
                    if autoFarmEnabled then
                        if autoFarmTpLocked and autoFarmLockedCar then
                            skipTeleport = true
                            print("🔒 AUTO FARM KİLİT: TP atlanacak ama satın alma devam")
                            print("🔒 Kilitli araç:", autoFarmLockedCar.Name)
                        elseif currentTeleportedCar and not autoFarmFirstPurchaseCompleted then
                            skipTeleport = true
                            print("🔒 AUTO FARM: İlk satın alım bitmedi, TP atlanacak ama satın alma devam")
                            print("🔒 Mevcut araç:", currentTeleportedCar.Name)
                        end
                    end

                    -- En iyi tier araç bul (AUTO FARM KİLİT KONTROLÜ İLE)
                    local foundCar = nil
                    
                    -- Eğer Auto Farm kilidi aktifse sadece kilitli araca odaklan
                    if autoFarmEnabled and autoFarmTpLocked and autoFarmLockedCar then
                        if autoFarmLockedCar:IsDescendantOf(workspace) and autoFarmLockedCar:FindFirstChild("ClickDetector") then
                            -- Kilitli araç hala satın alınabilir durumda mı kontrol et
                            local owner = autoFarmLockedCar:GetAttribute("Owner")
                            if not owner then
                                foundCar = autoFarmLockedCar
                                print("🔒 AUTO FARM: Kilitli araca odaklanıyor:", foundCar.Name)
                            else
                                print("🔒 AUTO FARM: Kilitli araç zaten satın alınmış, kilit temizleniyor")
                                autoFarmTpLocked = false
                                autoFarmLockedCar = nil
                            end
                        else
                            print("🔒 AUTO FARM: Kilitli araç bulunamadı, kilit temizleniyor")
                            autoFarmTpLocked = false
                            autoFarmLockedCar = nil
                        end
                    end
                    
                    -- Normal araç arama (kilit yoksa veya kilitli araç bulunamadıysa)
                    if not foundCar then
                        for _, vehicleModel in pairs(vehicles:GetChildren()) do
                            if vehicleModel:IsA("Model") then
                                -- Owner attribute'u varsa satın alınmış araç, atla
                                local owner = vehicleModel:GetAttribute("Owner")
                                if not owner then
                                    -- Mesh ID'den araç ismini bul
                                    local carName = getVehicleModelFromMeshId(vehicleModel)
                                    
                                    if carName and selectedAutoTpCars[carName] then
                                        -- ClickDetector kontrolü
                                        if vehicleModel:FindFirstChild("ClickDetector") then
                                            if currentTeleportedCar == vehicleModel or not teleportedToCars[vehicleModel] then
                                                local tier = getCarTier(carName)
                                                foundCar = vehicleModel
                                                print("🎯 AUTO BUY: Hedef araç bulundu:", vehicleModel.Name, "Model:", carName, "Tier:", tier)
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    if foundCar then
                        local cd = foundCar:FindFirstChild("ClickDetector")
                        local tpPart = foundCar:FindFirstChildWhichIsA("BasePart")
                        
                        if cd and tpPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - tpPart.Position).Magnitude
                            
                            -- TP'yi sadece gerektiğinde ve Auto Farm kilidi yoksa yap - Aracın yanına teleport et
                            if distance > 10 and not skipTeleport then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = tpPart.CFrame + Vector3.new(15, 3, 0)
                                
                                -- Karakterin otomatik olarak araca oturmasını engelle
                                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                                if humanoid then
                                    humanoid.Sit = false
                                    task.wait(0.1)
                                    humanoid.Sit = false
                                end
                                
                                task.wait(0.3)
                                print("📍 Araca teleport edildi:", foundCar.Name)
                            elseif skipTeleport then
                                print("🔒 AUTO FARM: TP atlandı, sadece satın alma yapılacak:", foundCar.Name)
                            end

                            -- Satın alma işlemini başlat (TP olmasa da)
                            fireClickDetector(cd, LocalPlayer)
                            print("🛒 ClickDetector tetiklendi:", foundCar.Name)
                            
                            -- ClickDetector sonrası kısa bekleme ve confirm kontrolü
                            task.wait(0.1)
                            
                            -- Auto Buy aktifse confirmation'ı otomatik true döndür
                            if autoBuyEnabled then
                                -- ReplicatedStorage'daki confirmation event'ini yakala
                                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                                local success, ConfirmationEvent = pcall(function()
                                    return ReplicatedStorage:WaitForChild("Events", 2)
                                        :WaitForChild("HUD", 2)
                                        :WaitForChild("Confirmation", 2)
                                end)
                                
                                if success and ConfirmationEvent then
                                    -- Hook'u aktif et ve true döndür
                                    ConfirmationEvent.OnClientInvoke = function(message)
                                        if autoBuyEnabled then
                                            print("🛒 Auto Buy: Otomatik onaylandı:", message)
                                            return true
                                        else
                                            return nil
                                        end
                                    end
                                end
                            end
                            
                            -- AUTO FARM İÇİN ANINDA KİLİTLEME - ClickDetector'dan hemen sonra
                            if autoFarmEnabled then
                                autoFarmTpLocked = true
                                autoFarmLockedCar = foundCar
                                print("🔒⚡ AUTO FARM ANINDA KİLİTLENDİ:", foundCar.Name)
                                print("🔒⚡ Auto TP TAMAMEN DURDURULDU!")
                                print("🔒⚡ Başka araçlara TP ENGELLENDI!")
                                
                                -- Auto TP sistemini geçici olarak devre dışı bırak
                                autoTpEnabled = false
                                print("🔒⚡ autoTpEnabled = false yapıldı!")
                            end
                            
                            -- HIZLI OWNER KONTROLÜ: 0.3 saniye bekle ve kontrol et (confirm için daha fazla süre)
                            task.wait(0.3)
                            local quickOwnerCheck = foundCar:GetAttribute("Owner")
                            if quickOwnerCheck and quickOwnerCheck == LocalPlayer.Name then
                                print("⚡ HIZLI SATIN ALMA BAŞARILI:", foundCar.Name)
                            end
                            
                            -- Mesh ID'den araç modelini bul
                            local carModelName = getVehicleModelFromMeshId(foundCar) or "Unknown"
                            
                            print("🛒 Satın alma denendi:", foundCar.Name, "Model:", carModelName)

                            currentBuyTarget = foundCar
                            lockedToBuyTarget = true
                            
                            -- HIZLI SATIN ALMA: 0.5 saniye bekle (eskiden 2 saniyeydi)
                            task.wait(0.5)
                            print("⚡ Hızlı satın alma: 0.5 saniye beklendi")
                            
                            -- AUTO FARM KİLİDİNİ HEMEN AKTİF ET (satın alma başarılıysa)
                            if autoFarmEnabled then
                                -- Araç satın alındı mı kontrol et (Owner attribute)
                                local owner = foundCar:GetAttribute("Owner")
                                if owner and owner == LocalPlayer.Name then
                                    autoFarmTpLocked = true
                                    autoFarmLockedCar = foundCar
                                    print("🔒⚡ AUTO FARM KİLİT ANINDA AKTİF: ", foundCar.Name)
                                    print("🔒⚡ Artık başka araçlara TP atılmayacak!")
                                end
                            end
                            
                            -- Auto Buy başarılı olduğunda repair teleport sistemini başlat
                            handleAutoBuySuccess(carModelName)
                            
                            -- Bildirim göster
                            local notification = Instance.new("ScreenGui", game.CoreGui)
                            local frame = Instance.new("Frame", notification)
                            frame.Size = UDim2.new(0,300,0,60)
                            frame.Position = UDim2.new(0.5,-150,0,120)
                            frame.BackgroundColor3 = Color3.fromRGB(255,150,50)
                            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                            
                            local label = Instance.new("TextLabel", frame)
                            label.Size = UDim2.new(1,0,1,0)
                            label.BackgroundTransparency = 1
                            label.Text = "🛒 Auto Buy: " .. carModelName
                            label.TextColor3 = Color3.new(1,1,1)
                            label.Font = Enum.Font.GothamBold
                            label.TextSize = 16
                            
                            task.spawn(function()
                                task.wait(3)
                                pcall(function() notification:Destroy() end)
                            end)
                        end
                    else
                        -- DEBUG: Araç bulunamadığında detaylı bilgi (YENİ YAPI)
                        print("❌ AUTO BUY DEBUG: Araç bulunamadı!")
                        print("🔍 selectedAutoTpCars:", selectedAutoTpCars)
                        print("🔍 currentTeleportedCar:", currentTeleportedCar and currentTeleportedCar.Name or "nil")
                        if workspace:FindFirstChild("Vehicles") then
                            local vehicleCount = #workspace.Vehicles:GetChildren()
                            local ownedCount = 0
                            local availableCount = 0
                            for _, vehicleModel in pairs(workspace.Vehicles:GetChildren()) do
                                if vehicleModel:IsA("Model") then
                                    local owner = vehicleModel:GetAttribute("Owner")
                                    if owner then
                                        ownedCount = ownedCount + 1
                                    else
                                        availableCount = availableCount + 1
                                        -- Mesh ID'den araç modelini kontrol et
                                        local carModel = getVehicleModelFromMeshId(vehicleModel)
                                        if carModel then
                                            local tier = getCarTier(carModel)
                                            print("🚗 Mevcut araç:", vehicleModel.Name, "Model:", carModel, "Tier:", tier, "Selected:", selectedAutoTpCars[carModel] and "YES" or "NO")
                                        end
                                    end
                                end
                            end
                            print("🔍 Toplam araç:", vehicleCount, "| Sahipli:", ownedCount, "| Müsait:", availableCount)
                        end
                    end
                elseif autoBuyEnabled and not autoTpEnabled then
                    autoBuyEnabled = false
                    AutoBuyButton.Text = "Auto Buy: OFF"
                    TweenService:Create(AutoBuyButton, TweenInfo.new(0.3), {
                        BackgroundColor3 = Color3.fromRGB(65, 52, 111)
                    }):Play()
                    print("Auto TP kapandığı için Auto Buy devre dışı bırakıldı")
                    break  -- Loop'u bitir
                end
            end
            
            -- Loop bittiğinde temizlik yap
            print("🛒 Auto Buy loop ended")
        end)
    end    local function updateAutoFarmButtonState()
    local canEnable = autoBuyEnabled and autoTpEnabled and isPremiumUser()
    
    if autoFarmEnabled and canEnable then
        AutoFarmButton.Text = "Auto Farm: ON"
        AutoFarmButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    else
        AutoFarmButton.Text = "Auto Farm: OFF"
        AutoFarmButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    end
end
    
local function checkAutoFarmDependencies()
    if autoFarmEnabled and (not autoBuyEnabled or not autoTpEnabled) then
        autoFarmEnabled = false
        updateAutoFarmButtonState()
        print("Auto Farm disabled: Auto Buy or Auto TP is off!")
        
        -- Bildirim göster
        local notification = Instance.new("ScreenGui", game.CoreGui)
        local frame = Instance.new("Frame", notification)
        frame.Size = UDim2.new(0,350,0,60)
        frame.Position = UDim2.new(0.5,-175,0,120)
        frame.BackgroundColor3 = Color3.fromRGB(255,150,50)
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
        
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = "⚠️ Auto Farm disabled: Missing dependency"
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        
        task.spawn(function()
            task.wait(3)
            pcall(function() notification:Destroy() end)
        end)
    end
    updateAutoFarmButtonState()
end

local function startAutoFarm()
    -- Basit bildirim göster
    local notification = Instance.new("ScreenGui", game.CoreGui)
    local frame = Instance.new("Frame", notification)
    frame.Size = UDim2.new(0,300,0,60)
    frame.Position = UDim2.new(0.5,-150,0,120)
    frame.BackgroundColor3 = Color3.fromRGB(100,255,100)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = "🚜 Auto Farm Started"
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    
    task.spawn(function()
        task.wait(3)
        pcall(function() notification:Destroy() end)
    end)
    
    -- TODO: Auto farm logic buraya eklenecek
end

local function stopAutoFarm()
    -- Auto farm durduruldu, bildirim yok
end

    AutoBuyButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Premium kontrolü ekle
        if not isPremiumUser() then
            _G.acne_showPremiumWarning()
            return
        end

        -- Auto TP açık olup olmadığını kontrol et
        if not autoTpEnabled then
            -- Uyarı göster (mevcut kod aynı)
            local warningGui = Instance.new("ScreenGui", game.CoreGui)
            warningGui.Name = "AutoBuyWarning_" .. tostring(math.random(1,1e6))
            
            local warningFrame = Instance.new("Frame", warningGui)
            warningFrame.Position = UDim2.new(0.5, -200, 0.5, -80)
            warningFrame.Size = UDim2.new(0, 400, 0, 160)
            warningFrame.BackgroundColor3 = Color3.fromRGB(13, 19, 32)
            Instance.new("UICorner", warningFrame).CornerRadius = UDim.new(0,12)
            
            local warningTitle = Instance.new("TextLabel", warningFrame)
            warningTitle.Size = UDim2.new(1,0,0,40)
            warningTitle.BackgroundColor3 = Color3.fromRGB(255,150,50)
            warningTitle.TextColor3 = Color3.new(1,1,1)
            warningTitle.Font = Enum.Font.GothamBold
            warningTitle.TextSize = 18
            warningTitle.Text = "AUTO TP REQUIRED"
            Instance.new("UICorner", warningTitle).CornerRadius = UDim.new(0,12)
            
            local warningMsg = Instance.new("TextLabel", warningFrame)
            warningMsg.Position = UDim2.new(0,12,0,55)
            warningMsg.Size = UDim2.new(1,-24,0,60)
            warningMsg.BackgroundTransparency = 1
            warningMsg.TextColor3 = Color3.new(1,1,1)
            warningMsg.Font = Enum.Font.Gotham
            warningMsg.TextSize = 16
            warningMsg.TextWrapped = true
            warningMsg.TextYAlignment = Enum.TextYAlignment.Top
            warningMsg.Text = "Auto Buy requires Auto TP to be enabled first.\nPlease enable Auto TP and select cars."
            
            local warningClose = Instance.new("TextButton", warningFrame)
            warningClose.Position = UDim2.new(0,12,1,-46)
            warningClose.Size = UDim2.new(1,-24,0,34)
            warningClose.BackgroundColor3 = Color3.fromRGB(90,90,110)
            warningClose.TextColor3 = Color3.new(1,1,1)
            warningClose.Font = Enum.Font.GothamBold
            warningClose.TextSize = 16
            warningClose.Text = "OK"
            Instance.new("UICorner", warningClose).CornerRadius = UDim.new(0,8)
            
            warningFrame.Size = UDim2.new(0,0,0,0)
            TweenService:Create(warningFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0,400,0,160)
            }):Play()
            
            local function closeWarning()
                TweenService:Create(warningFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0,0,0,0)
                }):Play()
                task.delay(0.25, function() pcall(function() warningGui:Destroy() end) end)
            end
            
            warningClose.MouseButton1Click:Connect(closeWarning)
            task.delay(5, closeWarning)
            
            return
        end
        
        autoBuyEnabled = not autoBuyEnabled
        
        TweenService:Create(AutoBuyButton, TweenInfo.new(0.3), {
            BackgroundColor3 = autoBuyEnabled and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111)
        }):Play()
        
        AutoBuyButton.Text = autoBuyEnabled and "Auto Buy: ON" or "Auto Buy: OFF"

        checkAutoFarmDependencies()
        
        -- YENİ YAKLAŞIM: Hook'u tamamen kaldırmak yerine aktif/pasif yap
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local success, ConfirmationEvent = pcall(function()
            return ReplicatedStorage:WaitForChild("Events", 5)
                :WaitForChild("HUD", 5)
                :WaitForChild("Confirmation", 5)
        end)

        if success and ConfirmationEvent then
            if autoBuyEnabled then
                -- Auto Buy açıksa hook'u aktif et
                ConfirmationEvent.OnClientInvoke = function(message)
                    if autoBuyEnabled then  -- Çift kontrol
                        print("🛒 Auto Buy active - automatically confirmed:", message)
                        return true
                    else
                        -- Auto Buy kapalıysa normal oyun davranışını döndür
                        print("🎮 Auto Buy off - normal GUI will be shown")
                        return nil  -- Normal GUI'nin açılmasına izin ver
                    end
                end
                print("✅ Auto Buy confirmation hook activated")
            else
                -- Auto Buy kapalıysa hook'u pasif yap (tamamen kaldırma)
                ConfirmationEvent.OnClientInvoke = function(message)
                    if autoBuyEnabled then
                        print("🛒 Auto Buy active - automatically confirmed:", message)
                        return true
                    else
                        -- Oyunun orijinal davranışını geri döndür
                        print("🎮 Normal purchase - GUI will be shown:", message)
                        return nil  -- Hiçbir şey döndürme, oyunun kendi sistemini kullan
                    end
                end
                print("❌ Auto Buy disabled - normal game behavior active")
            end
        else
            print("⚠️ Confirmation event bulunamadı")
        end
        
        if autoBuyEnabled then
            print("🛒 Auto Buy enabled")
            setupAutoBuyLoop()
        else
            print("🛒 Auto Buy disabled")
            lockedToBuyTarget = false
            currentBuyTarget = nil
            if buyConnections.mainLoop then
                if type(buyConnections.mainLoop) == "thread" then
                    task.cancel(buyConnections.mainLoop)
                else
                    pcall(function() buyConnections.mainLoop:Disconnect() end)
                end
                buyConnections.mainLoop = nil
            end
        end
    end)


    local AutoFarmEnabled = false

    AutoFarmButton.MouseButton1Click:Connect(function()
    if guiMinimized then return end
    
    -- Premium kontrolü
    if not isPremiumUser() then
        _G.acne_showPremiumWarning()
        return
    end
    
        -- AutoFarm için seçili araçları kontrol et (her döngüde yenile)
        local function getSelectedCars()
            local cars = {}
            for carName, state in pairs(carStates) do
                if state == "autofarm" then
                    table.insert(cars, carName)
                end
            end
            return cars
        end
        
        local selectedCars = getSelectedCars()
        
        if #selectedCars == 0 then
            print("❌ HATA: AutoFarm için hiçbir araç seçilmedi!")
            print("💡 İPUCU: Dropdown'dan araçlara sağ tıklayarak AUTO FARM moduna alın")
            
            -- Ekran uyarısı göster
            _G.acne_showWarning("You must select at least 1 vehicle for AutoFarm!\nRight-click vehicles in dropdown to enable AUTO FARM mode.")
            return
        end
    
    AutoFarmEnabled = not AutoFarmEnabled
    
    TweenService:Create(AutoFarmButton, TweenInfo.new(0.3), {
        BackgroundColor3 = AutoFarmEnabled and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111)
    }):Play()
    
    AutoFarmButton.Text = AutoFarmEnabled and "Auto Farm: ON" or "Auto Farm: OFF"
    
    while AutoFarmEnabled do
        setupAutoConfirm()
        repairedCarList = {}
        local targetRoundCount = tonumber(CountBox.Text) or 1
        targetRoundCount = math.clamp(targetRoundCount, 1, 10)
        
        print("🚜 AUTOFARM ROUND BAŞLADI")
        print("📋 Seçili araçlar: " .. table.concat(selectedCars, ", "))
        print("🎯 Hedef round: " .. targetRoundCount .. " araç")
        
        -- Round sistemi: Tüm seçili araçları alana kadar bekle
        local roundCars = {}
        local roundCount = 0
        
        while roundCount < targetRoundCount and AutoFarmEnabled do
            print("📍 ROUND " .. (roundCount + 1) .. "/" .. targetRoundCount .. " - Seçili araçlardan birini arıyor...")
            
            -- Her round'da seçili araçları güncelle (yeni eklenmişse)
            selectedCars = getSelectedCars()
            
            -- Seçili araçlardan birini bul
            local foundCar = nil
            print("🔍 Aranan araçlar:", table.concat(selectedCars, ", "))
            
            for _, carName in ipairs(selectedCars) do
                print("🔎 Arıyor:", carName)
                local car = findSpecificCar(carName)
                if car then
                    foundCar = car
                    print("✅ ARAÇ BULUNDU: " .. carName)
                    break
                else
                    print("❌ Bulunamadı:", carName)
                end
            end
            
            if foundCar then
                print("🚗 Araç alınıyor ve tamir ediliyor...")
                teleportBuyAndRepair(foundCar)
                table.insert(roundCars, foundCar)
                roundCount = roundCount + 1
                print("✅ Round " .. roundCount .. " tamamlandı!")
                wait(60)
            else
                print("❌ Seçili araçlardan hiçbiri bulunamadı! Yeni spawn bekleniyor...")
                
                -- Workspace'i yenile ve biraz bekle
                wait(5)  -- İlk kısa bekleyiş
                
                -- İkinci deneme - workspace yenilenmiş olabilir
                print("🔄 İkinci arama denemesi yapılıyor...")
                for _, carName in ipairs(selectedCars) do
                    local car = findSpecificCar(carName)
                    if car then
                        foundCar = car
                        print("✅ İKİNCİ DENEMEDE BULUNDU: " .. carName)
                        break
                    end
                end
                
                if foundCar then
                    print("🚗 İkinci denemede bulunan araç alınıyor...")
                    teleportBuyAndRepair(foundCar)
                    table.insert(roundCars, foundCar)
                    roundCount = roundCount + 1
                    print("✅ Round " .. roundCount .. " tamamlandı!")
                    wait(60)
                else
                    print("⏳ Hala bulunamadı, daha uzun bekleme...")
                    wait(10)  -- Daha uzun bekle
                end
            end
        end
        
        if roundCount >= targetRoundCount then
            print("🎉 TÜM ROUND TAMAMLANDI! (" .. roundCount .. " araç alındı)")
            print("📍 Final destinasyonuna TP yapılıyor...")
            wait(1)
            teleportToFinalDestination()
            
            local cooldown = 105
            print("⏳ Cooldown başlıyor: " .. cooldown .. " saniye")
            wait(cooldown)
            
            print("💰 Araç satış işlemi başlatılıyor")
            loadAndSellAllCars()
            wait(2)
            print("🔄 Yeni round için hazırlanıyor...")
        else
            print("🛑 AutoFarm devre dışı bırakıldı, döngü durduruluyor")
        end
    end
    print("AutoFarm Disabled")
end)

-- Rejoin Button
RejoinButton.MouseButton1Click:Connect(function()
    if guiMinimized then return end

    TweenService:Create(RejoinButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50,100,200)}):Play()
    RejoinButton.Text = "Rejoining..."
        
    repeat
        wait()
    until game:IsLoaded()
    game:GetService('TeleportService')
    :TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

-- AutoKMS BUTTON

AutoKMSButton.MouseButton1Click:Connect(function()
    if guiMinimized then return end

    if not isPremiumUser() then
        _G.acne_showPremiumWarning()
        return
    end

    isRunning = not isRunning

    TweenService:Create(
        AutoKMSButton,
        TweenInfo.new(0.3),
        {BackgroundColor3 =isRunning and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111)}
    ):Play()
    AutoKMSButton.Text = isRunning and "Auto KMs: ON" or "Auto KMs: OFF"

    if isRunning then
        print("AutoKMs Enabled")
        local vehicleModel = getPlayerVehicleModel()
        if vehicleModel then
            _G.toggleFarmKM(true)
            starttweenLoop(vehicleModel)
        else
            isRunning = false
            AutoKMSButton.Text = "Auto KMs: OFF"
            AutoKMSButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
        end
    else
        stoptweenLoop()
        _G.toggleFarmKM(false)
        print("AutoKMs Disabled")
    end
end)


-- PartESP Button
PartsESPButton.MouseButton1Click:Connect(function()
    if guiMinimized then return end

    -- Premium kontrolü ekle
    if not isPremiumUser() then
        _G.acne_showPremiumWarning()
        return
    end

    partsESPEnabled = not partsESPEnabled

    TweenService:Create(PartsESPButton, TweenInfo.new(0.3), {
        BackgroundColor3 = partsESPEnabled and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111)
    }):Play()

    PartsESPButton.Text = partsESPEnabled and "Parts ESP: ON" or "Parts ESP: OFF"

    if partsESPEnabled then
        _G.acne_enablePartsESP()
        print("Parts ESP enabled")
    else
        _G.acne_disablePartsESP()
        print("Parts ESP disabled - All visuals cleared")
    end
end)
    -- Mouse olayları
    local isSelectingColor = false

    PaletteCanvas.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            isSelectingColor = true
            selectColor(input.Position)
        end
    end)

    PaletteCanvas.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            isSelectingColor = false
        end
    end)


    -- Paleti oluştur
    createColorPalette()
        local ColorPresetsFrame = Instance.new("Frame", PaintControlsFrame)
    ColorPresetsFrame.Position = UDim2.new(0, 8, 0, 175)  -- ColorPaletteFrame'den sonra (60+110+5 = 175)
    ColorPresetsFrame.Size = UDim2.new(1, -16, 0, 65)  -- Yükseklik azaltıldı
    ColorPresetsFrame.BackgroundTransparency = 1

    -- Status label - Preset butonlardan sonra
    local StatusLabelPaint = Instance.new("TextLabel", PaintControlsFrame)
    StatusLabelPaint.Position = UDim2.new(0, 8, 0, 245)  -- ColorPresetsFrame'den sonra (175+65+5 = 245)
    StatusLabelPaint.Size = UDim2.new(1, -16, 0, 25)  -- Yükseklik azaltıldı
    StatusLabelPaint.BackgroundTransparency = 1
    StatusLabelPaint.TextColor3 = Color3.new(1, 1, 1)
    StatusLabelPaint.Text = "Select a vehicle from the list"
    StatusLabelPaint.Font = Enum.Font.Gotham
    StatusLabelPaint.TextSize = 9  -- Font boyutu küçültüldü
    StatusLabelPaint.TextWrapped = true
    StatusLabelPaint.TextYAlignment = Enum.TextYAlignment.Top

    -- Paint butonu - Status label'den sonra
    local PaintButton = Instance.new("TextButton", PaintControlsFrame)
    PaintButton.Position = UDim2.new(0, 8, 0, 275)  -- StatusLabel'den sonra (245+25+5 = 275)
    PaintButton.Size = UDim2.new(1, -16, 0, 35)  -- Yükseklik azaltıldı, tam genişlik
    PaintButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    PaintButton.TextColor3 = Color3.new(1, 1, 1)
    PaintButton.Text = "Paint Vehicle"
    PaintButton.Font = Enum.Font.GothamBold
    PaintButton.TextSize = 14  -- Font boyutu küçültüldü
    PaintButton.AutoButtonColor = false
    Instance.new("UICorner", PaintButton).CornerRadius = UDim.new(0, 8)

    -- Color presets - Preset Frame'e ekle
    local colors = {
        {"Red", Color3.new(1, 0, 0)},
        {"Green", Color3.new(0, 1, 0)},
        {"Blue", Color3.new(0, 0, 1)},
        {"Yellow", Color3.new(1, 1, 0)},
        {"Purple", Color3.new(0.5, 0, 0.5)},
        {"Orange", Color3.new(1, 0.5, 0)},
        {"Pink", Color3.new(1, 0.75, 0.8)},
        {"Cyan", Color3.new(0, 1, 1)},
        {"Black", Color3.new(0, 0, 0)},
        {"White", Color3.new(1, 1, 1)}
    }

    -- Color presets butonlarını da güncelle
    for i, colorData in ipairs(colors) do
        local colorName, colorValue = unpack(colorData)
        local ColorButton = Instance.new("TextButton", ColorPresetsFrame)

        -- 2 sıra halinde dizme - 5'er 5'er, boyutlar küçültüldü
        local row = math.floor((i - 1) / 5)
        local col = (i - 1) % 5

        ColorButton.Size = UDim2.new(0.18, 0, 0.45, 0)
        ColorButton.Position = UDim2.new(col * 0.2, 0, row * 0.5, 0)
        ColorButton.BackgroundColor3 = colorValue
        ColorButton.Text = ""
        ColorButton.AutoButtonColor = false
        Instance.new("UICorner", ColorButton).CornerRadius = UDim.new(0, 4)

        -- Tooltip için
        local ToolTip = Instance.new("TextLabel", ColorButton)
        ToolTip.Size = UDim2.new(1, 0, 1, 0)
        ToolTip.BackgroundTransparency = 1
        ToolTip.Text = colorName
        ToolTip.TextColor3 = (colorValue.r + colorValue.g + colorValue.b > 1.5) and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
        ToolTip.Font = Enum.Font.Gotham
        ToolTip.TextSize = 6
        ToolTip.TextScaled = true

        ColorButton.MouseButton1Click:Connect(function()
            selectedPaintColor = colorValue -- GLOBAL değişkeni güncelle
            ColorPreview.BackgroundColor3 = selectedPaintColor

            -- RGB değerlerini göster
            if StatusLabelPaint then
                local r, g, b = selectedPaintColor.R, selectedPaintColor.G, selectedPaintColor.B
                StatusLabelPaint.Text = string.format("Selected Color: RGB(%.2f, %.2f, %.2f)", r, g, b)
            end

            -- Buton animasyonu
            local originalSize = ColorButton.Size
            TweenService:Create(ColorButton, TweenInfo.new(0.1), {
                Size = originalSize + UDim2.new(0, 2, 0, 2)
            }):Play()
            task.spawn(function()
                task.wait(0.1)
                TweenService:Create(ColorButton, TweenInfo.new(0.1), {
                    Size = originalSize
                }):Play()
            end)
        end)
    end

    -- Car finding function - 20 stud mesafesinde araçları bulur
    local function findPlayerVehicles()
        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then return {} end
        
        if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            return {}
        end
        local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
        
        local nearbyVehicles = {}
        
        for _, vehicle in pairs(Vehicles:GetChildren()) do
            if vehicle:IsA("Model") then
                -- YENİ: Owner attribute kontrolü
                local ownerAttr = vehicle:GetAttribute("Owner")
                if ownerAttr == LocalPlayer.Name then
                    local root = vehicle.PrimaryPart or vehicle:FindFirstChild("HumanoidRootPart") or vehicle:FindFirstChildWhichIsA("BasePart")
                    if root then
                        local distance = (playerPos - root.Position).Magnitude
                        if distance <= 2 then
                            table.insert(nearbyVehicles, {vehicle = vehicle, distance = distance})
                        end
                    end
                end
            end
        end
        
        table.sort(nearbyVehicles, function(a,b) return a.distance < b.distance end)
        return nearbyVehicles
    end

    local function refreshCarList()
        -- Eski elemanları temizle
        for _, child in pairs(CarListPaint:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        local nearbyVehicles = findPlayerVehicles()
        local y = 0
        
        if #nearbyVehicles > 0 then
            for i, vehicleData in ipairs(nearbyVehicles) do
                local vehicle = vehicleData.vehicle
                local distance = vehicleData.distance
                
                local CarButton = Instance.new("TextButton", CarListPaint)
                CarButton.Size = UDim2.new(1,-8,0,35)  -- Yükseklik azaltıldı
                CarButton.Position = UDim2.new(0,4,0,y)  -- Padding azaltıldı
                CarButton.BackgroundColor3 = selectedCar == vehicle and Color3.fromRGB(100,150,255) or Color3.fromRGB(24, 32, 49)
                CarButton.TextColor3 = Color3.new(1,1,1)
                
                -- Araç adını kısalt ve distance ekle
                local displayName = vehicle.Name
                if #displayName > 18 then  -- Limit azaltıldı
                    displayName = string.sub(displayName, 1, 15) .. "..."
                end
                
                CarButton.Text = string.format("%s\n%.1f studs", displayName, distance)
                CarButton.Font = Enum.Font.Gotham
                CarButton.TextSize = 9  -- Font boyutu küçültüldü
                CarButton.TextWrapped = true
                Instance.new("UICorner", CarButton).CornerRadius = UDim.new(0,6)
                
                CarButton.MouseButton1Click:Connect(function()
                    selectedCar = vehicle
                    SelectedCarLabel.Text = "Selected: " .. vehicle.Name
                    refreshCarList()
                    
                    -- Seçim bildirimi
                    StatusLabelPaint.TextColor3 = Color3.fromRGB(100,255,100)
                    StatusLabelPaint.Text = "Vehicle selected! Choose a color and paint."
                end)
                
                y = y + 40  -- Spacing azaltıldı
            end
        else
            local NoCarLabel = Instance.new("TextLabel", CarListPaint)
            NoCarLabel.Size = UDim2.new(1,-8,0,70)  -- Yükseklik azaltıldı
            NoCarLabel.Position = UDim2.new(0,4,0,y)
            NoCarLabel.BackgroundTransparency = 1
            NoCarLabel.Text = "No vehicles found within 1.2 studs!\n\nSpawn a car or get closer to existing vehicles."  -- Mesaj güncellendi
            NoCarLabel.TextColor3 = Color3.fromRGB(255,100,100)
            NoCarLabel.Font = Enum.Font.Gotham
            NoCarLabel.TextSize = 10  -- Font boyutu küçültüldü
            NoCarLabel.TextWrapped = true
            NoCarLabel.TextYAlignment = Enum.TextYAlignment.Top
            y = y + 75
        end
        
        CarListPaint.CanvasSize = UDim2.new(0,0,0,y)
    end

    PaintButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Premium kontrolü
        if not isPremiumUser() then
            _G.acne_showPremiumWarning()
            return
        end
        
        if not selectedCar or not selectedCar:IsDescendantOf(workspace) then
            StatusLabelPaint.TextColor3 = Color3.fromRGB(255, 100, 100)
            StatusLabelPaint.Text = "Please select a vehicle first!"
            return
        end
        
        -- Seçilen rengi al (GLOBAL selectedPaintColor'u kullan)
        local selectedColor = selectedPaintColor -- DOĞRU REFERANS
        
        -- Debug: Renk bilgisini konsola yazdır
        print("Selected color for painting:", selectedColor)
        print("RGB values:", selectedColor.R, selectedColor.G, selectedColor.B)
        
        -- Boyama işlemi
        PaintButton.Text = "Painting..."
        TweenService:Create(PaintButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local success, message = pcall(function()
            -- Boyama event'ini tetikle
            local args = {
                    [1] = "Car",
                        [2] = selectedCar,
                            [3] = selectedColor,
                                [4] = "Normal"
                            }
            
            local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events", 5)
            if not Events then
                error("Events folder not found!")
            end
            
            local VehiclesEvents = Events:WaitForChild("Vehicles", 5)
            if not VehiclesEvents then
                error("Vehicles events folder not found!")
            end
            
            local SetPaintEvent = VehiclesEvents:WaitForChild("SetPaint", 5)
            if not SetPaintEvent then
                error("SetPaint event not found!")
            end
            
            SetPaintEvent:FireServer(unpack(args))
            
            return "Vehicle painted successfully!"
        end)
        
        if success then
            StatusLabelPaint.TextColor3 = Color3.fromRGB(100, 255, 100)
            StatusLabelPaint.Text = message
            PaintButton.Text = "Success!"
            TweenService:Create(PaintButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            }):Play()
        else
            StatusLabelPaint.TextColor3 = Color3.fromRGB(255, 100, 100)
            StatusLabelPaint.Text = "Error: " .. (message or "Unknown error")
            PaintButton.Text = "Failed!"
            TweenService:Create(PaintButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            }):Play()
        end
        
        -- Butonu resetle
        task.spawn(function()
            task.wait(2)
            PaintButton.Text = "Paint Vehicle"
            TweenService:Create(PaintButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(65, 52, 111)
            }):Play()
        end)
    end)
    
    local ColorPaletteFrame = Instance.new("Frame", PaintControlsFrame)
    ColorPaletteFrame.Position = UDim2.new(0, 8, 0, 60)  -- Pozisyon yukarı alındı
    ColorPaletteFrame.Size = UDim2.new(1, -16, 0, 110)  -- Yükseklik azaltıldı
    ColorPaletteFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Instance.new("UICorner", ColorPaletteFrame).CornerRadius = UDim.new(0, 8)

    -- Renk paleti başlığı
    local PaletteTitle = Instance.new("TextLabel", ColorPaletteFrame)
    PaletteTitle.Position = UDim2.new(0, 6, 0, 3)  -- Padding azaltıldı
    PaletteTitle.Size = UDim2.new(1, -12, 0, 18)  -- Yükseklik azaltıldı
    PaletteTitle.BackgroundTransparency = 1
    PaletteTitle.Text = "Color Palette"  -- Metin kısaltıldı
    PaletteTitle.TextColor3 = Color3.new(1, 1, 1)
    PaletteTitle.Font = Enum.Font.GothamBold
    PaletteTitle.TextSize = 10  -- Font boyutu küçültüldü
    PaletteTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Renk paleti canvas - Mobil için optimize edilmiş boyut
    local PaletteCanvas = Instance.new("Frame", ColorPaletteFrame)
    PaletteCanvas.Position = UDim2.new(0, 6, 0, 24)  -- Pozisyon ayarlandı
    PaletteCanvas.Size = UDim2.new(0.65, -6, 0, 80)  -- Boyut azaltıldı
    PaletteCanvas.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", PaletteCanvas).CornerRadius = UDim.new(0, 6)

    -- Renk seçici imleç
    local ColorCursor = Instance.new("Frame", PaletteCanvas)
    ColorCursor.Size = UDim2.new(0, 8, 0, 8)  -- Boyut küçültüldü
    ColorCursor.BackgroundColor3 = Color3.new(0, 0, 0)
    ColorCursor.BackgroundTransparency = 0.5
    Instance.new("UICorner", ColorCursor).CornerRadius = UDim.new(0, 4)

    -- Seçilen renk preview - Mobil için optimize edilmiş
    local ColorPreview = Instance.new("Frame", ColorPaletteFrame)
    ColorPreview.Position = UDim2.new(0.68, 0, 0, 24)  -- Pozisyon ayarlandı
    ColorPreview.Size = UDim2.new(0.32, -6, 0, 80)  -- Boyut azaltıldı
    ColorPreview.BackgroundColor3 = selectedPaintColor
    Instance.new("UICorner", ColorPreview).CornerRadius = UDim.new(0, 6)

    local PreviewLabel = Instance.new("TextLabel", ColorPreview)
    PreviewLabel.Size = UDim2.new(1, 0, 1, 0)
    PreviewLabel.BackgroundTransparency = 1
    PreviewLabel.Text = "Selected\nColor"
    PreviewLabel.TextColor3 = Color3.new(1, 1, 1)
    PreviewLabel.Font = Enum.Font.Gotham
    PreviewLabel.TextSize = 8  -- Font boyutu küçültüldü
    PreviewLabel.TextWrapped = true

    -- HSV renk paleti oluşturma fonksiyonu - Daha yüksek çözünürlük
    local function createColorPalette()
        -- Paleti temizle
        for _, child in pairs(PaletteCanvas:GetChildren()) do
            if child ~= ColorCursor then
                child:Destroy()
            end
        end

        -- HSV gradyanı oluştur (daha yüksek çözünürlük)
        local resolution = 40  -- Artırılmış çözünürlük
        for x = 0, resolution - 1 do
            for y = 0, resolution - 1 do
                local pixel = Instance.new("Frame", PaletteCanvas)
                pixel.Size = UDim2.new(1 / resolution, 0, 1 / resolution, 0)
                pixel.Position = UDim2.new(x / resolution, 0, y / resolution, 0)
                pixel.BackgroundColor3 = Color3.fromHSV(x / resolution, 1 - y / resolution, 1)
                pixel.BorderSizePixel = 0
            end
        end
    end

    -- Renk seçme fonksiyonu
    local function selectColor(mousePos)
        local canvasPos = PaletteCanvas.AbsolutePosition
        local canvasSize = PaletteCanvas.AbsoluteSize

        local relativeX = math.clamp((mousePos.X - canvasPos.X) / canvasSize.X, 0, 1)
        local relativeY = math.clamp((mousePos.Y - canvasPos.Y) / canvasSize.Y, 0, 1)

        -- HSV'den renk hesapla
        local hue = relativeX
        local saturation = 1 - relativeY
        local value = 1

        selectedPaintColor = Color3.fromHSV(hue, saturation, value)
        ColorPreview.BackgroundColor3 = selectedPaintColor

        -- İmleci güncelle
        ColorCursor.Position = UDim2.new(relativeX, -5, relativeY, -5)

        -- RGB değerlerini göster
        local r, g, b = selectedPaintColor.R, selectedPaintColor.G, selectedPaintColor.B
        StatusLabelPaint.Text = string.format("Selected Color: RGB(%.2f, %.2f, %.2f)", r, g, b)
    end

    -- Mouse olayları
    local isSelectingColor = false

    PaletteCanvas.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            isSelectingColor = true
            selectColor(input.Position)
        end
    end)

    PaletteCanvas.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            isSelectingColor = false
        end
    end)

    -- Paleti oluştur
    createColorPalette()
    

    -- Auto-refresh car list - 1 saniyede bir güncelle
    task.spawn(function()
        while true do
            if currentTab == "Visual" and VisualContent.Visible and not guiMinimized then
                refreshCarList()
            end
            task.wait(1)
        end
    end)

    -- İlk yükleme
    task.spawn(function()
        task.wait(0.5)
        if currentTab == "Visual" then
            refreshCarList()
        end
    end)

    -- Settings Content güncellemesi
    local SettingsContent = Instance.new("Frame", ContentFrame)
    SettingsContent.Size = UDim2.new(1,0,1,0)
    SettingsContent.BackgroundTransparency = 1
    SettingsContent.Visible = false

    -- Toggle Key Değiştirme Butonu
    local ToggleKeyButton = Instance.new("TextButton", SettingsContent)
    ToggleKeyButton.Position = UDim2.new(0,10,0,10)
    ToggleKeyButton.Size = UDim2.new(0,200,0,40)
    ToggleKeyButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    ToggleKeyButton.TextColor3 = Color3.new(1,1,1)
    ToggleKeyButton.Text = "Toggle Key: INSERT"
    ToggleKeyButton.Font = Enum.Font.GothamBold
    ToggleKeyButton.TextSize = 16
    ToggleKeyButton.AutoButtonColor = false
    Instance.new("UICorner", ToggleKeyButton).CornerRadius = UDim.new(0,10)


    -- Key listening event
    ToggleKeyButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        if isListening then return end
        
        isListening = true
        ToggleKeyButton.Text = "Listening..."
        ToggleKeyButton.BackgroundColor3 = Color3.fromRGB(255,200,100)
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                -- Yeni tuşu ayarla
                toggleKey = input.KeyCode
                local keyName = input.KeyCode.Name
                
                -- Buton metnini güncelle
                ToggleKeyButton.Text = "Toggle Key: " .. keyName
                ToggleKeyButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
                
                isListening = false
                connection:Disconnect()
                
                -- Başarı animasyonu
                TweenService:Create(ToggleKeyButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(100,255,100)
                }):Play()
                
                task.spawn(function()
                    task.wait(1)
                    TweenService:Create(ToggleKeyButton, TweenInfo.new(0.3), {
                        BackgroundColor3 = Color3.fromRGB(124, 92, 255)
                    }):Play()
                end)
                
                print("Toggle key changed to:", keyName)
            end
        end)
        
        -- 10 saniye sonra otomatik iptal
        task.spawn(function()
            task.wait(10)
            if isListening then
                isListening = false
                ToggleKeyButton.Text = "Toggle Key: " .. toggleKey.Name
                ToggleKeyButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
                connection:Disconnect()
            end
        end)
    end)

    local RedeemCodesButton = Instance.new("TextButton", MiscContent)
    RedeemCodesButton.Position = UDim2.new(0,10,0,105) -- InfoLabel'in altına
    RedeemCodesButton.Size = UDim2.new(0,180,0,40)
    RedeemCodesButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    RedeemCodesButton.TextColor3 = Color3.new(1,1,1)
    RedeemCodesButton.Text = "🎁 Redeem Codes"
    RedeemCodesButton.Font = Enum.Font.GothamBold
    RedeemCodesButton.TextSize = 16
    RedeemCodesButton.AutoButtonColor = false
    Instance.new("UICorner", RedeemCodesButton).CornerRadius = UDim.new(0,10)

    -- Codes Status Label
    local CodesStatusLabel = Instance.new("TextLabel", MiscContent)
    CodesStatusLabel.Position = UDim2.new(0,10,0,140)
    CodesStatusLabel.Size = UDim2.new(1,-230,0,40)
    CodesStatusLabel.BackgroundTransparency = 1
    CodesStatusLabel.Text = "Click to redeem all saved codes"
    CodesStatusLabel.TextColor3 = Color3.fromRGB(150,150,150)
    CodesStatusLabel.Font = Enum.Font.Gotham
    CodesStatusLabel.TextSize = 14
    CodesStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    CodesStatusLabel.TextWrapped = true

    -- Local kod listesi (Settings sekmesi için)
    local savedCodes = {
        "100M",
        "RENASCAPTURADO"
            -- Buraya daha fazla kod ekleyebilirsiniz
    }

    -- Kod girme fonksiyonu
    local function redeemCode(code)
        local success, result = pcall(function()
            local args = {
                [1] = code
            }
            return game:GetService("ReplicatedStorage"):WaitForChild("Events", 9e9):WaitForChild("HUD", 9e9):WaitForChild("UseCode", 9e9):InvokeServer(unpack(args))
        end)
        
        -- Eğer başarılı ise result'ı kontrol et
        if success and result then
            -- "Invalid Code" veya benzeri hata mesajları için kontrol
            if type(result) == "string" and (
                string.find(string.lower(result), "invalid") or 
                string.find(string.lower(result), "expired") or 
                string.find(string.lower(result), "used") or
                string.find(string.lower(result), "error")
            ) then
                return false -- Invalid kod
            end
            return true -- Geçerli kod
        end
        
        return success -- Eğer pcall başarısızsa false döner
    end

    -- Redeem Codes Button Event - Güncellenmiş
    RedeemCodesButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        if #savedCodes == 0 then
            CodesStatusLabel.Text = "No codes to redeem!"
            CodesStatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
            task.wait(3)
            CodesStatusLabel.Text = "Click to redeem all saved codes"
            CodesStatusLabel.TextColor3 = Color3.fromRGB(150,150,150)
            return
        end
        
        -- Buton animasyonu
        RedeemCodesButton.Text = "Redeeming..."
        RedeemCodesButton.BackgroundColor3 = Color3.fromRGB(255,200,100)
        
        local successCount = 0
        local invalidCount = 0
        local totalCodes = #savedCodes
        
        -- Tüm kodları hızlıca gir (gecikme yok)
        for i, code in ipairs(savedCodes) do
            CodesStatusLabel.Text = "Redeeming " .. i .. "/" .. totalCodes .. ": " .. code
            CodesStatusLabel.TextColor3 = Color3.fromRGB(100,150,255)
            
            local success = redeemCode(code)
            if success then
                successCount = successCount + 1
            else
                invalidCount = invalidCount + 1
                print("Invalid/Failed code:", code)
            end
            
            -- Gecikme yok, hızlıca devam et
        end
        
        -- Sonuç göster
        RedeemCodesButton.Text = "🎁 Redeem Codes"
        RedeemCodesButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        
        -- Detaylı sonuç mesajı
        local resultText = string.format("Completed! %d/%d codes redeemed successfully", successCount, totalCodes)
        if invalidCount > 0 then
            resultText = resultText .. string.format(" (%d invalid/expired)", invalidCount)
        end
        
        CodesStatusLabel.Text = resultText
        
        -- Renk belirleme (başarı oranına göre)
        if successCount == totalCodes then
            CodesStatusLabel.TextColor3 = Color3.fromRGB(100,255,100) -- Tümü başarılı: yeşil
        elseif successCount > totalCodes / 2 then
            CodesStatusLabel.TextColor3 = Color3.fromRGB(255,200,100) -- Yarıdan fazla: sarı
        else
            CodesStatusLabel.TextColor3 = Color3.fromRGB(255,150,100) -- Yarıdan az: turuncu
        end
        
        task.wait(5)
        CodesStatusLabel.Text = "Click to redeem all saved codes"
        CodesStatusLabel.TextColor3 = Color3.fromRGB(150,150,150)
    end)


    local InfoLabel = Instance.new("TextLabel", SettingsContent)
    InfoLabel.Position = UDim2.new(0,10,0,70)
    InfoLabel.Size = UDim2.new(1,-20,0,210)
    InfoLabel.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    InfoLabel.TextColor3 = Color3.new(1,1,1)
    InfoLabel.Text = "\nACNE v2.3\n\nFeatures:\n• Auto Farm\n• ESP with distance\n• Multi-car Auto TP\n• Multi-car Auto Buy\n• Smart car tracking\n• Resizable window\n• Customizable toggle key\n• Mini GUI mode"
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.TextSize = 16
    InfoLabel.TextWrapped = true
    InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
    Instance.new("UICorner", InfoLabel).CornerRadius = UDim.new(0,8)

-- PLAYER TAB İÇERİĞİ (AutoTPContent ve SettingsContent oluşturulduktan sonra ekle)
-- ...existing code...
    -- Player Content (YENİ)
    -- Player Content (YENİ)
    local PlayerContent = Instance.new("Frame", ContentFrame)
    PlayerContent.Size = UDim2.new(1,0,1,0)
    PlayerContent.BackgroundTransparency = 1
    PlayerContent.Visible = false

    local currentSpeed = 16
    local minSpeed, maxSpeed = 16, 200
    local sliderDragging = false
    local speedConn
    local flyEnabled = false  -- YENİ: Fly durumu
    local flyConnections = {}  -- YENİ: Fly bağlantıları

    local SpeedTitle = Instance.new("TextLabel", PlayerContent)
    SpeedTitle.Position = UDim2.new(0,10,0,10)
    SpeedTitle.Size = UDim2.new(1,-20,0,30)
    SpeedTitle.BackgroundTransparency = 1
    SpeedTitle.Text = "Player Settings"  -- Başlığı değiştirdim
    SpeedTitle.TextColor3 = Color3.fromRGB(107, 224, 242)
    SpeedTitle.Font = Enum.Font.GothamBold
    SpeedTitle.TextSize = 20
    SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Speed Frame
    local SpeedFrame = Instance.new("Frame", PlayerContent)
    SpeedFrame.Position = UDim2.new(0,10,0,50)
    SpeedFrame.Size = UDim2.new(1,-20,0,120)  -- 80'den 120'ye yükseltildi
    SpeedFrame.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    Instance.new("UICorner", SpeedFrame).CornerRadius = UDim.new(0,10)

    local SpeedLabel = Instance.new("TextLabel", SpeedFrame)
    SpeedLabel.Position = UDim2.new(0,10,0,8)
    SpeedLabel.Size = UDim2.new(1,-20,0,25)
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.Text = "Walk Speed: 16"
    SpeedLabel.TextColor3 = Color3.new(1,1,1)
    SpeedLabel.Font = Enum.Font.GothamBold
    SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    SpeedLabel.TextSize = 16

    local SliderFrame = Instance.new("Frame", SpeedFrame)
    SliderFrame.Position = UDim2.new(0,10,0,40)
    SliderFrame.Size = UDim2.new(1,-20,0,25)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0,8)

    local SliderBar = Instance.new("Frame", SliderFrame)
    SliderBar.Size = UDim2.new(0.0,0,1,0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(0,8)

    local SliderKnob = Instance.new("TextButton", SliderFrame)
    SliderKnob.Size = UDim2.new(0,20,1,0)
    SliderKnob.Position = UDim2.new(0,-10,0,0)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    SliderKnob.Text = ""
    SliderKnob.AutoButtonColor = false
    Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(0,10)

    -- Fly Frame - YENİ
    local FlyFrame = Instance.new("Frame", PlayerContent)
    FlyFrame.Position = UDim2.new(0,10,0,180)  -- 140'dan 150'ye değiştirildi (ResetButton için yer açıldı)
    FlyFrame.Size = UDim2.new(1,-20,0,120)
    FlyFrame.BackgroundColor3 = Color3.fromRGB(22, 30, 46)
    Instance.new("UICorner", FlyFrame).CornerRadius = UDim.new(0,10)

    local FlyTitle = Instance.new("TextLabel", FlyFrame)
    FlyTitle.Position = UDim2.new(0,10,0,8)
    FlyTitle.Size = UDim2.new(1,-20,0,25)
    FlyTitle.BackgroundTransparency = 1
    FlyTitle.Text = "Fly Controls"
    FlyTitle.TextColor3 = Color3.new(1,1,1)
    FlyTitle.Font = Enum.Font.GothamBold
    FlyTitle.TextXAlignment = Enum.TextXAlignment.Left
    FlyTitle.TextSize = 16

    local FlyButton = Instance.new("TextButton", FlyFrame)
    FlyButton.Position = UDim2.new(0,10,0,40)
    FlyButton.Size = UDim2.new(0,140,0,35)
    FlyButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    FlyButton.TextColor3 = Color3.new(1,1,1)
    FlyButton.Text = "Fly: OFF"
    FlyButton.Font = Enum.Font.GothamBold
    FlyButton.TextSize = 16
    FlyButton.AutoButtonColor = false
    Instance.new("UICorner", FlyButton).CornerRadius = UDim.new(0,8)

    local FlyInfoLabel = Instance.new("TextLabel", FlyFrame)
    FlyInfoLabel.Position = UDim2.new(0,160,0,40)
    FlyInfoLabel.Size = UDim2.new(1,-170,0,35)
    FlyInfoLabel.BackgroundTransparency = 1
    FlyInfoLabel.Text = "Controls: WASD + Space/Shift"
    FlyInfoLabel.TextColor3 = Color3.fromRGB(200,200,200)
    FlyInfoLabel.Font = Enum.Font.Gotham
    FlyInfoLabel.TextSize = 12
    FlyInfoLabel.TextWrapped = true
    FlyInfoLabel.TextYAlignment = Enum.TextYAlignment.Top

    local FlySpeedLabel = Instance.new("TextLabel", FlyFrame)
    FlySpeedLabel.Position = UDim2.new(0,10,0,85)
    FlySpeedLabel.Size = UDim2.new(1,-20,0,25)
    FlySpeedLabel.BackgroundTransparency = 1
    FlySpeedLabel.Text = "Fly Speed: 50"
    FlySpeedLabel.TextColor3 = Color3.new(1,1,1)
    FlySpeedLabel.Font = Enum.Font.GothamBold
    FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
    FlySpeedLabel.TextSize = 14

    -- Fly Speed Slider
    local FlySliderFrame = Instance.new("Frame", FlyFrame)
    FlySliderFrame.Position = UDim2.new(0.3,0,0,85)
    FlySliderFrame.Size = UDim2.new(0.65,0,0,25)
    FlySliderFrame.BackgroundColor3 = Color3.fromRGB(24, 32, 49)
    Instance.new("UICorner", FlySliderFrame).CornerRadius = UDim.new(0,8)

    local FlySliderBar = Instance.new("Frame", FlySliderFrame)
    FlySliderBar.Size = UDim2.new(0.5,0,1,0)
    FlySliderBar.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    Instance.new("UICorner", FlySliderBar).CornerRadius = UDim.new(0,8)

    local FlySliderKnob = Instance.new("TextButton", FlySliderFrame)
    FlySliderKnob.Size = UDim2.new(0,20,1,0)
    FlySliderKnob.Position = UDim2.new(0.5,-10,0,0)
    FlySliderKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    FlySliderKnob.Text = ""
    FlySliderKnob.AutoButtonColor = false
    Instance.new("UICorner", FlySliderKnob).CornerRadius = UDim.new(0,10)

    -- Fly değişkenleri
    local flySpeed = 50
    local minFlySpeed, maxFlySpeed = 10, 500
    local flySliderDragging = false
    local bodyVelocity = nil

    -- Speed fonksiyonları
    local function applySpeed()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = currentSpeed
        end
    end

    local function setSlider(v)
        v = math.clamp(v,0,1)
        SliderBar.Size = UDim2.new(v,0,1,0)
        SliderKnob.Position = UDim2.new(v,-10,0,0)
        currentSpeed = math.floor(minSpeed + (maxSpeed-minSpeed)*v + 0.5)
        SpeedLabel.Text = "Walk Speed: " .. currentSpeed
        applySpeed()
    end

    -- Fly Speed fonksiyonları
    local function setFlySlider(v)
        v = math.clamp(v,0,1)
        FlySliderBar.Size = UDim2.new(v,0,1,0)
        FlySliderKnob.Position = UDim2.new(v,-10,0,0)
        flySpeed = math.floor(minFlySpeed + (maxFlySpeed-minFlySpeed)*v + 0.5)
        FlySpeedLabel.Text = "Fly Speed: " .. flySpeed
    end

    local function enableFly()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = char.HumanoidRootPart
        local humanoid = char:FindFirstChild("Humanoid")
        
        -- BodyVelocity oluştur
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart
        
        -- BodyAngularVelocity ekle (yuvarlanmayı engellemek için)
        local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity.Parent = rootPart
        
        -- BodyPosition ekle (pozisyon stabilitesi için)
        local bodyPosition = Instance.new("BodyPosition")
        bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyPosition.Position = rootPart.Position
        bodyPosition.P = 3000
        bodyPosition.D = 500
        bodyPosition.Parent = rootPart
        
        -- Humanoid durumunu ayarla
        if humanoid then
            humanoid.PlatformStand = true
            humanoid.Sit = false
        end
        
        -- Kontrol sistemi
        local keys = {
            W = false, A = false, S = false, D = false,
            Space = false, LeftShift = false
        }
        
        -- Input başlangıcı
        flyConnections.InputBegan = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == Enum.KeyCode.W then keys.W = true
            elseif input.KeyCode == Enum.KeyCode.A then keys.A = true
            elseif input.KeyCode == Enum.KeyCode.S then keys.S = true
            elseif input.KeyCode == Enum.KeyCode.D then keys.D = true
            elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = true
            elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.LeftShift = true
            end
        end)
        
        -- Input bitişi
        flyConnections.InputEnded = UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then keys.W = false
            elseif input.KeyCode == Enum.KeyCode.A then keys.A = false
            elseif input.KeyCode == Enum.KeyCode.S then keys.S = false
            elseif input.KeyCode == Enum.KeyCode.D then keys.D = false
            elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = false
            elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.LeftShift = false
            end
        end)
        
        -- Hareket güncelleme
        flyConnections.Heartbeat = RunService.Heartbeat:Connect(function()
            if not bodyVelocity or not bodyVelocity.Parent then return end
            if not bodyPosition or not bodyPosition.Parent then return end
            
            local camera = workspace.CurrentCamera
            local moveVector = Vector3.new(0, 0, 0)
            
            -- İleri/geri hareket
            if keys.W then
                moveVector = moveVector + camera.CFrame.LookVector
            end
            if keys.S then
                moveVector = moveVector - camera.CFrame.LookVector
            end
            
            -- Sol/sağ hareket
            if keys.A then
                moveVector = moveVector - camera.CFrame.RightVector
            end
            if keys.D then
                moveVector = moveVector + camera.CFrame.RightVector
            end
            
            -- Yukarı/aşağı hareket
            if keys.Space then
                moveVector = moveVector + Vector3.new(0, 1, 0)
            end
            if keys.LeftShift then
                moveVector = moveVector + Vector3.new(0, -1, 0)
            end
            
            -- Hızı uygula
            bodyVelocity.Velocity = moveVector * flySpeed
            
            -- Pozisyonu güncelle (yumuşak hareket için)
            if moveVector.Magnitude > 0 then
                bodyPosition.Position = rootPart.Position + (moveVector * flySpeed * 0.1)
            else
                bodyPosition.Position = rootPart.Position
            end
            
            -- Rotasyonu sabit tut (yuvarlanmayı engelle)
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            
            -- CFrame'i sabit tut (sadece pozisyon değişsin, rotasyon kalmasın)
            local currentPos = rootPart.Position
            rootPart.CFrame = CFrame.new(currentPos, currentPos + camera.CFrame.LookVector * Vector3.new(1, 0, 1))
        end)
        
        -- Fly nesnelerini kaydet (temizlik için)
        flyConnections.bodyVelocity = bodyVelocity
        flyConnections.bodyAngularVelocity = bodyAngularVelocity
        flyConnections.bodyPosition = bodyPosition
    end

    local function disableFly()
        -- Bağlantıları temizle
        for name, conn in pairs(flyConnections) do
            if name == "InputBegan" or name == "InputEnded" or name == "Heartbeat" then
                if conn then conn:Disconnect() end
            elseif name == "bodyVelocity" or name == "bodyAngularVelocity" or name == "bodyPosition" then
                if conn then conn:Destroy() end
            end
        end
        flyConnections = {}
        
        -- BodyVelocity'yi kaldır
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        
        -- Humanoid durumunu sıfırla
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
            char.Humanoid.Sit = false
        end
    end

    -- Event bağlantıları
    SliderKnob.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            sliderDragging = true
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    sliderDragging = false
                end
            end)
        end
    end)

    SliderFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = (input.Position.X - SliderFrame.AbsolutePosition.X)/SliderFrame.AbsoluteSize.X
            setSlider(rel)
        end
    end)

    -- Fly Speed Slider Events
    FlySliderKnob.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            flySliderDragging = true
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    flySliderDragging = false
                end
            end)
        end
    end)

    FlySliderFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = (input.Position.X - FlySliderFrame.AbsolutePosition.X)/FlySliderFrame.AbsoluteSize.X
            setFlySlider(rel)
        end
    end)

    -- Fly Button Event
    FlyButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        flyEnabled = not flyEnabled
        
        TweenService:Create(FlyButton, TweenInfo.new(0.3), {
            BackgroundColor3 = flyEnabled and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111)
        }):Play()
        
        FlyButton.Text = flyEnabled and "Fly: ON" or "Fly: OFF"
        
        if flyEnabled then
            enableFly()
        else
            disableFly()
        end
    end)


    local ResetButton = Instance.new("TextButton", SpeedFrame)
    ResetButton.Position = UDim2.new(0,10,0,75)  -- SliderFrame'den sonra (40+25+10 = 75)
    ResetButton.Size = UDim2.new(0,140,0,35)
    ResetButton.BackgroundColor3 = Color3.fromRGB(124, 92, 255)
    ResetButton.TextColor3 = Color3.new(1,1,1)
    ResetButton.Text = "Reset Speed"
    ResetButton.Font = Enum.Font.GothamBold
    ResetButton.TextSize = 16
    ResetButton.AutoButtonColor = false
    Instance.new("UICorner", ResetButton).CornerRadius = UDim.new(0,8)

    ResetButton.MouseButton1Click:Connect(function()
        setSlider(0)
        TweenService:Create(ResetButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(100,255,100)}):Play()
        task.delay(0.8,function()
            TweenService:Create(ResetButton, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(124, 92, 255)}):Play()
        end)
    end)

    -- Respawn sonrası işlemler
    if speedConn then speedConn:Disconnect() end
    speedConn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.3)
        applySpeed()
        
        -- Fly açıksa yeniden aktifleştir
        if flyEnabled then
            task.wait(0.5)
            disableFly()
            task.wait(0.1)
            enableFly()
        end
    end)

    setSlider(0) -- varsayılan 16
    setFlySlider(0.4) -- varsayılan fly speed 50

    -- Teleports Content - Güncellenmiş versiyon
    local TeleportsContent = Instance.new("Frame", ContentFrame)
    TeleportsContent.Size = UDim2.new(1,0,1,0)
    TeleportsContent.BackgroundTransparency = 1
    TeleportsContent.Visible = false

    -- Başlık
    local TeleportTitle = Instance.new("TextLabel", TeleportsContent)
    TeleportTitle.Position = UDim2.new(0,10,0,10)
    TeleportTitle.Size = UDim2.new(1,-20,0,30)
    TeleportTitle.BackgroundTransparency = 1
    TeleportTitle.TextColor3 = Color3.fromRGB(107, 224, 242)
    TeleportTitle.Text = "Quick Teleports"
    TeleportTitle.TextXAlignment = Enum.TextXAlignment.Left
    TeleportTitle.Font = Enum.Font.GothamBold
    TeleportTitle.TextSize = 20

    -- Part Shop Button (Küçük, sol)
    local PartShopButton = Instance.new("TextButton", TeleportsContent)
    PartShopButton.Position = UDim2.new(0,10,0,50)
    PartShopButton.Size = UDim2.new(0.3,0,0,40)
    PartShopButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    PartShopButton.TextColor3 = Color3.new(1,1,1)
    PartShopButton.Text = "📍 Part Shop"
    PartShopButton.Font = Enum.Font.GothamBold
    PartShopButton.TextSize = 14
    PartShopButton.AutoButtonColor = false
    Instance.new("UICorner", PartShopButton).CornerRadius = UDim.new(0,8)

    -- Repair Station Button (Küçük, orta)
    local RepairButton = Instance.new("TextButton", TeleportsContent)
    RepairButton.Position = UDim2.new(0.35,0,0,50)
    RepairButton.Size = UDim2.new(0.3,0,0,40)
    RepairButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    RepairButton.TextColor3 = Color3.new(1,1,1)
    RepairButton.Text = "🔧 Repair"
    RepairButton.Font = Enum.Font.GothamBold
    RepairButton.TextSize = 14
    RepairButton.AutoButtonColor = false
    Instance.new("UICorner", RepairButton).CornerRadius = UDim.new(0,8)

    -- Paint Shop Button (Küçük, sağ) - Teleports sekmesindeki
    local PaintShopButton = Instance.new("TextButton", TeleportsContent)
    PaintShopButton.Position = UDim2.new(0.7,0,0,50)
    PaintShopButton.Size = UDim2.new(0.3,-10,0,40)
    PaintShopButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    PaintShopButton.TextColor3 = Color3.new(1,1,1)
    PaintShopButton.Text = "🎨 Paint"
    PaintShopButton.Font = Enum.Font.GothamBold
    PaintShopButton.TextSize = 14
    PaintShopButton.AutoButtonColor = false
    Instance.new("UICorner", PaintShopButton).CornerRadius = UDim.new(0,8)



    -- Gas Station Button (2. satır, sol)
    local GasStationButton = Instance.new("TextButton", TeleportsContent)
    GasStationButton.Position = UDim2.new(0,10,0,100)
    GasStationButton.Size = UDim2.new(0.3,0,0,40)
    GasStationButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    GasStationButton.TextColor3 = Color3.new(1,1,1)
    GasStationButton.Text = "⛽ Gas Station"
    GasStationButton.Font = Enum.Font.GothamBold
    GasStationButton.TextSize = 14
    GasStationButton.AutoButtonColor = false
    Instance.new("UICorner", GasStationButton).CornerRadius = UDim.new(0,8)

    -- Pit Wheels Button (2. satır, orta)
    local PitWheelsButton = Instance.new("TextButton", TeleportsContent)
    PitWheelsButton.Position = UDim2.new(0.35,0,0,100)
    PitWheelsButton.Size = UDim2.new(0.3,0,0,40)
    PitWheelsButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    PitWheelsButton.TextColor3 = Color3.new(1,1,1)
    PitWheelsButton.Text = "🏁 Pit Wheels"
    PitWheelsButton.Font = Enum.Font.GothamBold
    PitWheelsButton.TextSize = 14
    PitWheelsButton.AutoButtonColor = false
    Instance.new("UICorner", PitWheelsButton).CornerRadius = UDim.new(0,8)

    -- Sell Cars Button (2. satır, sağ)
    local SellCarsButton = Instance.new("TextButton", TeleportsContent)
    SellCarsButton.Position = UDim2.new(0.7,0,0,100)
    SellCarsButton.Size = UDim2.new(0.3,-10,0,40)
    SellCarsButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    SellCarsButton.TextColor3 = Color3.new(1,1,1)
    SellCarsButton.Text = "💰 Sell Cars"
    SellCarsButton.Font = Enum.Font.GothamBold
    SellCarsButton.TextSize = 14
    SellCarsButton.AutoButtonColor = false
    Instance.new("UICorner", SellCarsButton).CornerRadius = UDim.new(0,8)

    -- Car Shop Button (3. satır, ortada tek) -> 3. satır, sol
    local CarShopButton = Instance.new("TextButton", TeleportsContent)
    CarShopButton.Position = UDim2.new(0,10,0,150)
    CarShopButton.Size = UDim2.new(0.3,0,0,40)
    CarShopButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    CarShopButton.TextColor3 = Color3.new(1,1,1)
    CarShopButton.Text = "🚗 Junk Yard"
    CarShopButton.Font = Enum.Font.GothamBold
    CarShopButton.TextSize = 14
    CarShopButton.AutoButtonColor = false
    Instance.new("UICorner", CarShopButton).CornerRadius = UDim.new(0,8)

        -- Dyno Tune Button (3. satır, orta) - YENİ
    local DynoTuneButton = Instance.new("TextButton", TeleportsContent)
    DynoTuneButton.Position = UDim2.new(0.35,0,0,150)
    DynoTuneButton.Size = UDim2.new(0.3,0,0,40)
    DynoTuneButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    DynoTuneButton.TextColor3 = Color3.new(1,1,1)
    DynoTuneButton.Text = "⚙️ Dyno Tune"
    DynoTuneButton.Font = Enum.Font.GothamBold
    DynoTuneButton.TextSize = 14
    DynoTuneButton.AutoButtonColor = false
    Instance.new("UICorner", DynoTuneButton).CornerRadius = UDim.new(0,8)

    -- Body Parts Button (3. satır, sağ) - YENİ
    local BodyPartsButton = Instance.new("TextButton", TeleportsContent)
    BodyPartsButton.Position = UDim2.new(0.7,0,0,150)
    BodyPartsButton.Size = UDim2.new(0.3,-10,0,40)
    BodyPartsButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    BodyPartsButton.TextColor3 = Color3.new(1,1,1)
    BodyPartsButton.Text = "🔧 Body Parts"
    BodyPartsButton.Font = Enum.Font.GothamBold
    BodyPartsButton.TextSize = 14
    BodyPartsButton.AutoButtonColor = false
    Instance.new("UICorner", BodyPartsButton).CornerRadius = UDim.new(0,8)

    -- Garage Button
    local GarageButton = Instance.new("TextButton", TeleportsContent)
    GarageButton.Position = UDim2.new(0,10,0,200)
    GarageButton.Size = UDim2.new(0.3,0,0,40)
    GarageButton.BackgroundColor3 = Color3.fromRGB(65, 52, 111)
    GarageButton.TextColor3 = Color3.new(1,1,1)
    GarageButton.Text = "🏠 Garages"
    GarageButton.Font = Enum.Font.GothamBold
    GarageButton.TextSize = 14
    GarageButton.AutoButtonColor = false
    Instance.new("UICorner", GarageButton).CornerRadius = UDim.new(0,8)

    local function teleportToLocation(cframe, name)
        task.spawn(function()
            local success = pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    local hrp = character:FindFirstChild("HumanoidRootPart")

                    if humanoid and humanoid.SeatPart then
                        local vehicle = humanoid.SeatPart:FindFirstAncestorOfClass("Model")
                        if vehicle then
                            
                            if not vehicle.PrimaryPart then
                                local seat = vehicle:FindFirstChildOfClass("VehicleSeat")
                                if seat then
                                    vehicle.PrimaryPart = seat
                                    end
                                end
                                
                                if vehicle.PrimaryPart then
                                    vehicle:SetPrimaryPartCFrame(cframe)
                                end
                            end
                        elseif hrp then
                            hrp.CFrame = cframe
                        end
                    
                    -- Auto TP tarzı bildirim (yeşil, modern)
                    local notification = Instance.new("ScreenGui", game.CoreGui)
                    local frame = Instance.new("Frame", notification)
                    frame.Size = UDim2.new(0,300,0,60)
                    frame.Position = UDim2.new(0.5,-150,0,50)
                    frame.BackgroundColor3 = Color3.fromRGB(50,200,50) -- Auto TP ile aynı yeşil
                    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                    
                    local label = Instance.new("TextLabel", frame)
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.Text = "Teleported to: " .. name
                    label.TextColor3 = Color3.new(1,1,1)
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 16
                    
                    task.spawn(function()
                        task.wait(3)
                        pcall(function() notification:Destroy() end)
                    end)
                end
            end)
            
            if not success then
                print("Teleport failed to:", name)
            end
        end)
    end

    local garageMap = {
    ["RobuxGarage"] = CFrame.new(-1140, -65, 198),
    ["RobuxGarage2"] = CFrame.new(-1915, -83, 6),
    ["40Slots"] = CFrame.new(-1087.8736572265625, -26.73097801208496, 95.16602325439453),
    ["24Slots"] = CFrame.new(-2029, -106, -1014),
    ["10Slots"] = CFrame.new(-1780.9815673828125, -6.55192756652832, -1376.1888427734375),
    ["8Slots"] = CFrame.new(-1531, -50, 98),
    ["6Slots"] = CFrame.new(-1230, -26, -692),
    ["4Slots"] = CFrame.new(-1230, -26, -692),
    ["Default"] = CFrame.new(-1923, -14, -580)
}


    -- Button Events - CFrame koordinatları ile güncellenmiş
    PartShopButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Buton animasyonu
        local originalColor = PartShopButton.BackgroundColor3
        PartShopButton.Text = "Teleporting..."
        TweenService:Create(PartShopButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        -- Part Shop CFrame
        local partShopCFrame = CFrame.new(
            -1492, 5, -519
        ) * CFrame.Angles(math.rad(0.00), math.rad(178.13), math.rad(0.00))
        
        teleportToLocation(partShopCFrame, "Part Shop")
        
        task.spawn(function()
            task.wait(1)
            PartShopButton.Text = "📍 Part Shop"
            TweenService:Create(PartShopButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    -- Garage Button Event
    GarageButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Buton animasyonu
        local originalColor = GarageButton.BackgroundColor3
        GarageButton.Text = "Teleporting..."
        TweenService:Create(GarageButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        -- Garage Check
        local garageValue = player.PlayerData.GarageModel.Value
        local cf

        if string.find(string.lower(garageValue), "robux") then
            cf = garageMap["RobuxGarage"]
        elseif string.find(garageValue, "10") then
            cf = garageMap["10Slots"]
        elseif string.find(garageValue, "8") then
            cf = garageMap["8Slots"]
        elseif string.find(garageValue, "6") then
            cf = garageMap["6Slots"]
        elseif string.find(garageValue, "4") then
            cf = garageMap["4Slots"]
        else
            cf = garageMap["Default"]
        end

        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and cf then
            hrp.CFrame = cf
        end
        
        task.spawn(function()
            task.wait(1)
            GarageButton.Text = "🏠 Garges"
            TweenService:Create(GarageButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)
    
    -- Paint Shop Button Event (Teleports sekmesi için)
    PaintShopButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = PaintShopButton.BackgroundColor3
        PaintShopButton.Text = "Teleporting..."
        TweenService:Create(PaintShopButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        -- Paint Shop CFrame (koordinatları ekle)
        local paintShopCFrame = CFrame.new(
            -1023, 5, -376
            
        )* CFrame.Angles(math.rad(12.79), math.rad(-61.03), math.rad(0.00))
        
        teleportToLocation(paintShopCFrame, "Paint Shop")
        
        task.spawn(function()
            task.wait(1)
            PaintShopButton.Text = "🎨 Paint"
            TweenService:Create(PaintShopButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    RepairButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Buton animasyonu
        local originalColor = RepairButton.BackgroundColor3
        RepairButton.Text = "Teleporting..."
        TweenService:Create(RepairButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        -- Repair Station CFrame - Y koordinatını yükselttik
        local repairCFrame = CFrame.new(
            -1084.8236083984375, 4.532297611236572, -349.72467041015625
        ) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0.00))
        
        teleportToLocation(repairCFrame, "Repair Station")
        
        task.spawn(function()
            task.wait(1)
            RepairButton.Text = "🔧 Repair"
            TweenService:Create(RepairButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)


    -- Gas Station Button (2. satır, sol)
    GasStationButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = GasStationButton.BackgroundColor3
        GasStationButton.Text = "Teleporting..."
        TweenService:Create(GasStationButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local gasStationCFrame = CFrame.new(
            -1399, 5, -670,
            0.771228433, -8.75848127e-05, 0.636558473,
            -8.75848127e-05, 0.99999994, 0.000243705363,
            -0.636558473, -0.000243705363, 0.771228433
        )
        
        teleportToLocation(gasStationCFrame, "Gas Station")
        
        task.spawn(function()
            task.wait(1)
            GasStationButton.Text = "⛽ Gas Station"
            TweenService:Create(GasStationButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    PitWheelsButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = PitWheelsButton.BackgroundColor3
        PitWheelsButton.Text = "Teleporting..."
        TweenService:Create(PitWheelsButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local pitWheelsCFrame = CFrame.new(
            -1420.93848, 4.4206481, 
            -1555.98291, 0.0300566778, 
            -9.4497878e-08, -0.999548197, 
            -3.07934371e-08, 1, 
            -9.54665609e-08, 0.999548197,
            3.36489343e-08, 0.0300566778
        )
        
        teleportToLocation(pitWheelsCFrame, "Pit Wheels")
        
        task.spawn(function()
            task.wait(1)
            PitWheelsButton.Text = "🏁 Pit Wheels"
            TweenService:Create(PitWheelsButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    SellCarsButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = SellCarsButton.BackgroundColor3
        SellCarsButton.Text = "Teleporting..."
        TweenService:Create(SellCarsButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local sellCarsCFrame = CFrame.new(
            -1902.8335, 10.777283013, -760.692993,
            -0.997250795, 0, 0.0740996227,
            0, 1, 0,
            -0.0740996227, 0, -0.997250795
        )
        
        teleportToLocation(sellCarsCFrame, "Sell Cars")
        
        task.spawn(function()
            task.wait(1)
            SellCarsButton.Text = "💰 Sell Cars"
            TweenService:Create(SellCarsButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    CarShopButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = CarShopButton.BackgroundColor3
        CarShopButton.Text = "Teleporting..."
        TweenService:Create(CarShopButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local carShopCFrame = CFrame.new(
            -1666, 8, -335,
            0.763743758, 0.0282309689, 0.644901931,
            -0.036942441, 0.999317408, 4.43309546e-06,
            -0.644461572, -0.0238276348, 0.764265358
        )
        
        teleportToLocation(carShopCFrame, "Car Shop")
        
        task.spawn(function()
            task.wait(1)
            CarShopButton.Text = "🚗 Car Shop"
            TweenService:Create(CarShopButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    -- Dyno Tune Button Event - YENİ
    DynoTuneButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = DynoTuneButton.BackgroundColor3
        DynoTuneButton.Text = "Teleporting..."
        TweenService:Create(DynoTuneButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local dynoTuneCFrame = CFrame.new(
            -11692.3809, 4.05518389, 5755.15039, -0.0475334711,
            -1.82453679e-08, 0.998869658, 
            -3.28814531e-09, 1, 1.81095405e-08, -0.998869658, -2.42361931e-09, -0.0475334711
        )
        
        teleportToLocation(dynoTuneCFrame, "Dyno Tune")
        
        task.spawn(function()
            task.wait(1)
            DynoTuneButton.Text = "⚙️ Dyno Tune"
            TweenService:Create(DynoTuneButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    -- Body Parts Button Event - YENİ
    BodyPartsButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        local originalColor = BodyPartsButton.BackgroundColor3
        BodyPartsButton.Text = "Teleporting..."
        TweenService:Create(BodyPartsButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(124, 92, 255)
        }):Play()
        
        local bodyPartsCFrame = CFrame.new(
            -10865.5352, 4.05845881, 5760.09033, 0.955804288, -1.38725236e-08, 0.294003755, -2.37667201e-08, 1, 1.24450295e-07, -0.294003755, -1.25937632e-07, 0.955804288
        )
        
        teleportToLocation(bodyPartsCFrame, "Body Parts")
        
        task.spawn(function()
            task.wait(1)
            BodyPartsButton.Text = "🔧 Body Parts"
            TweenService:Create(BodyPartsButton, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end)

    -- Tab switch fonksiyonunu güncelle (Visual tab ekle)
    local function switchTab(tabName)
        currentTab = tabName
        
        -- Update tab colors
        ESPTab.BackgroundColor3 = (tabName == "ESP") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        AutoTPTab.BackgroundColor3 = (tabName == "AutoTP") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        PlayerTab.BackgroundColor3 = (tabName == "Player") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        VisualTab.BackgroundColor3 = (tabName == "Visual") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        TeleportsTab.BackgroundColor3 = (tabName == "Teleports") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        SettingsTab.BackgroundColor3 = (tabName == "Settings") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        MiscTab.BackgroundColor3 = (tabName == "Misc") and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(24, 32, 49)
        
        -- Show/hide content
        ESPContent.Visible = (tabName == "ESP")
        AutoTPContent.Visible = (tabName == "AutoTP")
        PlayerContent.Visible = (tabName == "Player")
        VisualContent.Visible = (tabName == "Visual")
        TeleportsContent.Visible = (tabName == "Teleports")
        MiscContent.Visible = (tabName == "Misc")
        SettingsContent.Visible = (tabName == "Settings")
    end

        ESPTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("ESP") end end)
        AutoTPTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("AutoTP") end end)
        PlayerTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("Player") end end)
        TeleportsTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("Teleports") end end)
        SettingsTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("Settings") end end)
        VisualTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("Visual") end end)
        MiscTab.MouseButton1Click:Connect(function() if not guiMinimized then switchTab("Misc") end end)

    -- Helper Functions
    local function getOriginalCarName(currentName)
        for tier, cars in pairs(carTiers) do
            for _, carName in pairs(cars) do
                if string.find(currentName, carName) then
                    return carName
                end
            end
        end
        return currentName
    end

    local function getCarTier(carName)
        for tier, cars in pairs(carTiers) do
            if table.find(cars, carName) then
                return tier
            end
        end
        -- Eğer carTiers'da yoksa, headlightMeshMap'te olduğu için D-Tier olarak varsayalım
        if carName and headlightMeshMap then
            for meshId, mapCarName in pairs(headlightMeshMap) do
                if mapCarName == carName then
                    return "D-Tier" -- Yeni mesh'ler varsayılan D-Tier
                end
            end
            for meshId, mapCarName in pairs(reverselightsMeshMap) do
                if mapCarName == carName then
                    return "D-Tier"
                end
            end
        end
        return "Unknown"
    end

    -- Tier önceliği S > A > B > C > D
    local tierPriority = {
        ["S-Tier"] = 1,
        ["A-Tier"] = 2,
        ["B-Tier"] = 3,
        ["C-Tier"] = 4,
        ["D-Tier"] = 5
    }
    
    -- AUTO FARM Round Sistemi
    local autoFarmTargetCount = 3 -- CountBox'tan gelecek

    local function findNextAvailableCar(originalCarName)
        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then return nil end
        
        for _, model in ipairs(Vehicles:GetChildren()) do
            if model:IsA("Model") then
                local modelOriginalName = getOriginalCarName(model.Name)
                if modelOriginalName == originalCarName and not teleportedToCars[model] then
                    return model
                end
            end
        end
        return nil
    end

    UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        -- Key system dragging
        if keyDragging then
            local delta = input.Position - keyDragStart
            local newPos = UDim2.new(keyStartPos.X.Scale, keyStartPos.X.Offset + delta.X, keyStartPos.Y.Scale, keyStartPos.Y.Offset + delta.Y)
            TweenService:Create(KeyFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = newPos
            }):Play()
        -- Ana GUI dragging
        elseif dragging then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = newPos
            }):Play()
        -- Mini GUI dragging
        elseif miniDragging then
            local delta = input.Position - miniDragStart
            local newPos = UDim2.new(miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X, miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y)
            TweenService:Create(MiniFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = newPos
            }):Play()
        -- TP to Own Car Button dragging
        elseif tpCarButtonDragging then
            local delta = input.Position - tpCarButtonDragStart
            local newPos = UDim2.new(tpCarButtonStartPos.X.Scale, tpCarButtonStartPos.X.Offset + delta.X, tpCarButtonStartPos.Y.Scale, tpCarButtonStartPos.Y.Offset + delta.Y)
            TweenService:Create(TpToOwnCarButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = newPos
            }):Play()
        -- Resizing
        elseif resizing and not guiMinimized then
            local delta = input.Position - resizeStart
            local newWidth = math.clamp(startSize.X.Offset + delta.X, math.min(360, ScreenGui.AbsoluteSize.X - 24), ScreenGui.AbsoluteSize.X - 24)
            local newHeight = math.clamp(startSize.Y.Offset + delta.Y, math.min(320, ScreenGui.AbsoluteSize.Y - 80), ScreenGui.AbsoluteSize.Y - 80)
            
            TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, newWidth, 0, newHeight)
            }):Play()
        -- Speed slider dragging
        elseif sliderDragging then
            local rel = (input.Position.X - SliderFrame.AbsolutePosition.X)/SliderFrame.AbsoluteSize.X
            setSlider(rel)
        -- Fly speed slider dragging
        elseif flySliderDragging then
            local rel = (input.Position.X - FlySliderFrame.AbsolutePosition.X)/FlySliderFrame.AbsoluteSize.X
            setFlySlider(rel)
        -- Color palette dragging - DÜZELTİLDİ
        elseif isSelectingColor then
            selectColor(input.Position)
        end
    end
end)

    local function findHighestPriorityCar()
        -- AUTO FARM KİLİT KONTROLÜ
        if autoFarmEnabled and autoFarmTpLocked and autoFarmLockedCar then
            if autoFarmLockedCar:IsDescendantOf(workspace) then
                print("🔒 AUTO FARM: findHighestPriorityCar - Kilitli araç döndürülüyor")
                return autoFarmLockedCar
            else
                autoFarmTpLocked = false
                autoFarmLockedCar = nil
                print("🔓 AUTO FARM: findHighestPriorityCar - Kilitli araç kayboldu")
            end
        end
        
        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then return nil end
        
        print("🔍 SEARCHING FOR HIGHEST PRIORITY CAR...")
        
        local bestCar = nil
        local bestPriority = 999
        
        for _, model in ipairs(Vehicles:GetChildren()) do
            if model:IsA("Model") then
                -- Owner attribute'u varsa satın alınmış araç, atla
                local owner = model:GetAttribute("Owner")
                if not owner then
                    -- Mesh ID'den araç ismini bul
                    local carName = getVehicleModelFromMeshId(model)
                    
                    if carName and selectedAutoTpCars[carName] and not teleportedToCars[model] then
                        local tier = getCarTier(carName)
                        local priority = tierPriority[tier] or 999
                        
                        print("🔍 TIER CHECK:", carName, "→", tier, "→ Priority:", priority, "vs Current Best:", bestPriority)
                        
                        if priority < bestPriority then
                            bestPriority = priority
                            bestCar = model
                            print("✅ NEW BEST CAR:", carName, "Tier:", tier, "Priority:", priority)
                        end
                    end
                end
            end
        end
        
        return bestCar
    end

    _G.acne_updateDropdownText = function()
        local count = 0
        for _ in pairs(selectedAutoTpCars) do count = count + 1 end
        
        if count == 0 then
            DropdownButton.Text = "Select Cars for Auto TP (Multi-select enabled)"
        elseif count == 1 then
            for carName in pairs(selectedAutoTpCars) do
                DropdownButton.Text = carName .. " selected"
                break
            end
        else
            DropdownButton.Text = count .. " cars selected"
        end
    end

    -- Auto TP Functions
    _G.acne_autoTeleportToCar = function(model, isNewSpawn)
        if not autoTpEnabled then return end
        
        -- AUTO TP KİLİT KONTROLÜ (EN ÖNCELİKLİ) - Auto TP kilitliyse sadece kilitli araca TP atabilir
        if autoTpLocked and autoTpLockedCar then
            if autoTpLockedCar:IsDescendantOf(workspace) then
                -- Kilitli araç hala workspace'de var mı kontrol et
                local owner = autoTpLockedCar:GetAttribute("Owner")
                if owner then
                    -- Kilitli araç satılmış, kilidi kaldır
                    print("🔓 AUTO TP: Kilitli araç satıldı, kilit kaldırıldı:", autoTpLockedCar.Name)
                    autoTpLocked = false
                    autoTpLockedCar = nil
                else
                    -- Kilitli araç hala satılık, başka araca TP atmaya izin verme
                    if model ~= autoTpLockedCar then
                        print("🔒 AUTO TP KİLİTLİ: Başka araca TP atılmayacak!")
                        print("🔒 Kilitli araç:", autoTpLockedCar.Name)
                        print("🔒 Yeni araç atlandı:", model.Name)
                        return -- HEMEN ÇIK
                    end
                end
            else
                -- Kilitli araç workspace'den kaybolmuş, kilidi temizle
                print("🔓 AUTO TP: Kilitli araç kayboldu, kilit temizlendi")
                autoTpLocked = false
                autoTpLockedCar = nil
            end
        end
        
        -- AUTO FARM SÜPER KİLİT KONTROLÜ (İKİNCİL)
        if autoFarmEnabled then
            if autoFarmTpLocked and autoFarmLockedCar then
                if autoFarmLockedCar:IsDescendantOf(workspace) then
                    print("🔒 AUTO FARM: SÜPER KİLİT AKTİF - Başka araca TP atılmayacak!")
                    print("🔒 Kilitli araç:", autoFarmLockedCar.Name)
                    print("🔒 Yeni araç atlandı:", model.Name)
                    return -- HEMEN ÇIK
                else
                    -- Kilitli araç yok olmuşsa kilidi temizle
                    print("🔓 AUTO FARM: Kilitli araç kayboldu, kilit temizlendi")
                    autoFarmTpLocked = false
                    autoFarmLockedCar = nil
                end
            end
            
            -- Auto Farm aktifken ve ilk satın alım tamamlandıysa Auto TP işlemleri durdur
            if autoFarmFirstPurchaseCompleted then
                print("🔒 AUTO FARM: İlk satın alım tamamlandı, yeni araç atlanıyor:", model.Name)
                return
            end
        end
        
        -- Yeni spawn olan araçları kontrol et - daha yüksek tier varsa hemen TP at
        if isNewSpawn and currentTeleportedCar then
            local currentCarName = getVehicleModelFromMeshId(currentTeleportedCar)
            local newCarName = getVehicleModelFromMeshId(model)
            
            if currentCarName and newCarName then
                local currentTier = getCarTier(currentCarName)
                local newTier = getCarTier(newCarName)
                local currentPriority = tierPriority[currentTier] or 999
                local newPriority = tierPriority[newTier] or 999
                
                if newPriority >= currentPriority then
                    print("❌ NEW CAR LOWER/EQUAL TIER - SKIPPING:", model.Name, "→", newCarName, "(", newTier, "- Priority:", newPriority, ")")
                    print("   Current:", currentTeleportedCar.Name, "→", currentCarName, "(", currentTier, "- Priority:", currentPriority, ")")
                    return
                else
                    -- Daha yüksek tier araç geldi, eski araca TP atıldığını işaretle ve yenisine geç
                    print("🔄 DAHA YÜKSEK TİER SPAWN! Switching from", currentTeleportedCar.Name, "(", currentCarName, "-", currentTier, ") to", model.Name, "(", newCarName, "-", newTier, ")")
                    teleportedToCars[currentTeleportedCar] = true
                    -- Auto TP kilidini temizle çünkü daha yüksek tier'a geçiyoruz
                    if autoTpLocked and autoTpLockedCar == currentTeleportedCar then
                        autoTpLocked = false
                        autoTpLockedCar = nil
                        print("🔓 AUTO TP KİLİDİ TEMİZLENDİ: Daha yüksek tier'a geçiş için")
                    end
                end
            end
        end
        
        -- Şu anda başka bir araca TP atılmışsa ama daha düşük tier ise, geçiş yap
        if currentTeleportedCar and currentTeleportedCar:IsDescendantOf(workspace) and not isNewSpawn then
            local currentCarName = getVehicleModelFromMeshId(currentTeleportedCar)
            local newCarName = getVehicleModelFromMeshId(model)
            
            if currentCarName and newCarName then
                local currentTier = getCarTier(currentCarName)
                local newTier = getCarTier(newCarName)
                local currentPriority = tierPriority[currentTier] or 999
                local newPriority = tierPriority[newTier] or 999
                
                if newPriority >= currentPriority then
                    print("❌ ALREADY HIGHER/EQUAL TIER - SKIPPING:", currentTeleportedCar.Name, "→", currentCarName, "(", currentTier, "- Priority:", currentPriority, ") vs New:", model.Name, "→", newCarName, "(", newTier, "- Priority:", newPriority, ")")
                    return
                else
                    print("🔄 YÜKSEK TİER GEÇİŞ! Switching from", currentTeleportedCar.Name, "(", currentCarName, "-", currentTier, ") to", model.Name, "(", newCarName, "-", newTier, ")")
                    teleportedToCars[currentTeleportedCar] = true
                    -- Auto TP kilidini temizle çünkü daha yüksek tier'a geçiyoruz
                    if autoTpLocked and autoTpLockedCar == currentTeleportedCar then
                        autoTpLocked = false
                        autoTpLockedCar = nil
                        print("🔓 AUTO TP KİLİDİ TEMİZLENDİ: Yüksek tier'a geçiş için")
                    end
                end
            end
        end
        
        if isNewSpawn then
            task.wait(1)
        end
        
        local root = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
        if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            -- AUTO TP KİLİTLEME SİSTEMİ (EN ÖNCELİKLİ) - Sadece Auto Farm yoksa ve Auto Buy açıksa kilitle
            if not autoFarmEnabled and autoBuyEnabled then
                autoTpLocked = true
                autoTpLockedCar = model
                print("🔒 AUTO TP + BUY KİLİTLENDİ:", model.Name)
                print("🔒 Bu araç satın alınana kadar başka araçlara TP atılmayacak!")
            elseif not autoFarmEnabled and not autoBuyEnabled then
                -- Auto Buy kapalıysa kilit yapma, sürekli yüksek tier arayacak
                print("🔓 AUTO TP: Auto Buy kapalı, kilit yapılmayacak - sürekli yüksek tier aranacak")
            end
            
            -- AUTO FARM SÜPER KİLİT (TP ÖNCESİ HEMEN AKTİFLEŞTİR)
            if autoFarmEnabled then
                autoFarmTpLocked = true
                autoFarmLockedCar = model
                print("🔒⚡ AUTO FARM: TP ÖNCEDEN KİLİTLEME!")
                print("🔒⚡ Kilitli Araç:", model.Name)
                print("🔒⚡ Artık hiçbir araca TP atılmayacak!")
            end
            
            -- Karakteri aracın yanına teleport et (içine değil)
            LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(15, 3, 0)
            
            -- Karakterin otomatik olarak araca oturmasını engelle
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Sit = false
                -- Biraz bekleyip tekrar kontrol et (oyun otomatik oturtuyor olabilir)
                task.wait(0.1)
                humanoid.Sit = false
            end
            
            local carName = getVehicleModelFromMeshId(model)
            
            teleportedToCars[model] = true
            carNameTracker[model] = carName
            currentTeleportedCar = model
            
            print("⚡ SÜPER HIZLI TP:", model.Name, "Tier:", getCarTier(carName))
            
            -- TP SONRASI HEMEN AUTO BUY ÇALIŞTİR
            if autoBuyEnabled then
                task.spawn(function()
                    task.wait(0.5) -- TP sonrası kısa bekleme
                    
                    local cd = model:FindFirstChild("ClickDetector")
                    if cd then
                        -- ReplicatedStorage'daki confirmation event'ini yakala
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")
                        local success, ConfirmationEvent = pcall(function()
                            return ReplicatedStorage:WaitForChild("Events", 2)
                                :WaitForChild("HUD", 2)
                                :WaitForChild("Confirmation", 2)
                        end)
                        
                        if success and ConfirmationEvent then
                            -- Hook'u aktif et ve true döndür
                            ConfirmationEvent.OnClientInvoke = function(message)
                                if autoBuyEnabled then
                                    print("🛒 TP SONRASI AUTO BUY: Otomatik onaylandı:", message)
                                    return true
                                else
                                    return nil
                                end
                            end
                        end
                        
                        -- ClickDetector'u tetikle
                        fireClickDetector(cd, LocalPlayer)
                        print("🛒 TP SONRASI AUTO BUY: ClickDetector tetiklendi:", model.Name)
                        
                        -- Satın alma sonrası owner kontrolü
                        task.wait(0.5)
                        local owner = model:GetAttribute("Owner")
                        if owner and owner == LocalPlayer.Name then
                            print("✅ TP SONRASI AUTO BUY BAŞARILI:", model.Name)
                            -- Araç satın alındıysa handleAutoBuySuccess çağır
                            handleAutoBuySuccess(carName)
                        end
                    end
                end)
            end
            
            -- AUTO FARM KİLİT ONAY (ÇİFT GÜVENLİK)
            if autoFarmEnabled then
                autoFarmTpLocked = true
                autoFarmLockedCar = model
                print("🔒🔒🔒 AUTO FARM KİLİT ONAYI!")
                print("🔒🔒🔒 autoFarmTpLocked =", autoFarmTpLocked)
                print("🔒🔒🔒 autoFarmLockedCar =", autoFarmLockedCar.Name)
            end
            
            -- Notification
            local notification = Instance.new("ScreenGui", game.CoreGui)
            local frame = Instance.new("Frame", notification)
            frame.Size = UDim2.new(0,300,0,60)
            frame.Position = UDim2.new(0.5,-150,0,50)
            frame.BackgroundColor3 = Color3.fromRGB(50,200,50)
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
            
            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1,0,1,0)
            label.BackgroundTransparency = 1
            label.Text = "Auto Teleported to: " .. model.Name .. " [" .. getCarTier(carName) .. "]"
            label.TextColor3 = Color3.new(1,1,1)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 16
            
            task.spawn(function()
                task.wait(3)
                pcall(function() notification:Destroy() end)
            end)
            
            -- Name change tracking
            local nameChangeConn
            nameChangeConn = model:GetPropertyChangedSignal("Name"):Connect(function()
                task.spawn(function()
                    task.wait(1)
                    local nextCar = findNextAvailableCar(carNameTracker[model])
                    if nextCar then
                        autoTeleportToCar(nextCar, false)
                    end
                end)
                nameChangeConn:Disconnect()
            end)
            
            -- Cleanup tracking
            local cleanupConn
            cleanupConn = model.AncestryChanged:Connect(function()
                if not model:IsDescendantOf(workspace) then
                    teleportedToCars[model] = nil
                    carNameTracker[model] = nil
                    if currentTeleportedCar == model then
                        currentTeleportedCar = nil
                    end
                    
                    -- AUTO TP KİLİT TEMİZLEME - Kilitli araç kaybolursa kilidi kaldır
                    if autoTpLocked and autoTpLockedCar == model then
                        autoTpLocked = false
                        autoTpLockedCar = nil
                        print("🔓 AUTO TP: Kilitli araç kayboldu, kilit kaldırıldı:", model.Name)
                    end
                    
                    -- AUTO FARM KİLİT TEMİZLEME
                    if autoFarmEnabled and autoFarmTpLocked and autoFarmLockedCar == model then
                        autoFarmTpLocked = false
                        autoFarmLockedCar = nil
                        print("🔓 AUTO FARM: Kilitli araç kayboldu, kilit kaldırıldı:", model.Name)
                    end
                    
                    if nameChangeConn then nameChangeConn:Disconnect() end
                    cleanupConn:Disconnect()
                    
                    print("Car removed:", model.Name, "- Looking for next best car")
                    
                    task.spawn(function()
                        task.wait(0.5)
                        local nextCar = findHighestPriorityCar()
                        if nextCar then
                            autoTeleportToCar(nextCar, false)
                        end
                    end)
                end
            end)
        end
    end

    -- Auto TP fonksiyonunu premium ile sarmala
    _G.acne_original_autoTeleportToCar = _G.acne_autoTeleportToCar
    autoTeleportToCar = function(model, isNewSpawn)
        if not isPremiumUser() then
            _G.acne_showPremiumWarning()
            return
        end
        return _G.acne_original_autoTeleportToCar(model, isNewSpawn)
    end
    
    -- Global wrapper fonksiyonu da ekle
    _G.acne_autoTeleportToCarWrapped = autoTeleportToCar

    _G.acne_checkExistingCars = function()
        if not autoTpEnabled then return end
        
        -- AUTO TP KİLİT KONTROLÜ (EN ÖNCELİKLİ) 
        if autoTpLocked and autoTpLockedCar then
            if autoTpLockedCar:IsDescendantOf(workspace) then
                local owner = autoTpLockedCar:GetAttribute("Owner")
                if owner then
                    -- Kilitli araç satılmış, kilidi kaldır ve yeni araç ara
                    print("🔓 AUTO TP: checkExistingCars - Kilitli araç satıldı, kilit kaldırıldı:", autoTpLockedCar.Name)
                    autoTpLocked = false
                    autoTpLockedCar = nil
                else
                    -- Kilitli araç hala satılık ama daha yüksek tier var mı kontrol et
                    local bestCar = findHighestPriorityCar()
                    if bestCar and bestCar ~= autoTpLockedCar then
                        -- Mesh ID'den isimleri bul
                        local lockedCarName = getVehicleModelFromMeshId(autoTpLockedCar)
                        local bestCarName = getVehicleModelFromMeshId(bestCar)
                        
                        local lockedTier = getCarTier(lockedCarName)
                        local bestTier = getCarTier(bestCarName)
                        local lockedPriority = tierPriority[lockedTier] or 999
                        local bestPriority = tierPriority[bestTier] or 999
                        
                        if bestPriority < lockedPriority then
                            print("  AUTO TP: Daha yüksek tier bulundu, kilit temizleniyor!")
                            print("    Locked:", lockedCarName, "(", lockedTier, ") → Best:", bestCarName, "(", bestTier, ")")
                            autoTpLocked = false
                            autoTpLockedCar = nil
                        else
                            print("🔒 AUTO TP: Kilit aktif, daha yüksek tier yok:", autoTpLockedCar.Name)
                            return
                        end
                    else
                        print("🔒 AUTO TP: Kilit aktif, başka araç aranmayacak:", autoTpLockedCar.Name)
                        return
                    end
                end
            else
                -- Kilitli araç workspace'den kaybolmuş, kilidi temizle
                print("🔓 AUTO TP: checkExistingCars - Kilitli araç kayboldu, kilit kaldırıldı")
                autoTpLocked = false
                autoTpLockedCar = nil
            end
        end
        
        -- AUTO FARM SÜPER KİLİT KONTROLÜ (İKİNCİL)
        if autoFarmEnabled and autoFarmTpLocked and autoFarmLockedCar then
            if autoFarmLockedCar:IsDescendantOf(workspace) then
                print("🔒 AUTO FARM: checkExistingCars - Kilit aktif, araç aranmayacak!")
                return
            else
                autoFarmTpLocked = false
                autoFarmLockedCar = nil
                print("🔓 AUTO FARM: checkExistingCars - Kilitli araç kayboldu")
            end
        end
        
        -- Auto Farm aktifken ve ilk satın alım tamamlandıysa Auto TP işlemleri durdur
        if autoFarmEnabled and autoFarmFirstPurchaseCompleted then
            return
        end
        
        print("Checking existing cars...")
        
        local bestCar = findHighestPriorityCar()
        if bestCar then
            -- Yeni yapıda araç ismini bul
            local carName = "Unknown"
            local bodyPart = bestCar:FindFirstChild("Body")
            if bodyPart then
                for tier, cars in pairs(carTiers) do
                    for _, carModel in ipairs(cars) do
                        if bodyPart:FindFirstChild(carModel) then
                            carName = carModel
                            break
                        end
                    end
                    if carName ~= "Unknown" then break end
                end
            end
            
            print("🏆 BEST CAR FOUND:", bestCar.Name, "Model:", carName, "Tier:", getCarTier(carName), "Priority:", tierPriority[getCarTier(carName)] or 999)
            autoTeleportToCar(bestCar, false)
        else
            print("❌ No selected cars found in Auto TP list")
        end
    end

    -- Auto TP için ayrı event listener sistemi
    _G.acne_setupAutoTPEvents = function()
        -- Eski connection'ları temizle
        for _, conn in pairs(autoTpConnections) do
            if conn then conn:Disconnect() end
        end
        autoTpConnections = {}
        
        if autoTpEnabled then
            local Vehicles = workspace:FindFirstChild("Vehicles")
            if Vehicles then
                print("Setting up Auto TP events...")
                
                -- Yeni spawn olan araçlar için - hemen kontrol et
                autoTpConnections["ChildAdded"] = Vehicles.ChildAdded:Connect(function(child) 
                    if child:IsA("Model") then
                        print("New car spawned:", child.Name)
                        task.spawn(function()
                            -- AUTO TP KİLİT KONTROLÜ (EN ÖNCELİKLİ) - Yeni araç spawn olduğunda tier kontrolü
                            if autoTpLocked and autoTpLockedCar then
                                if autoTpLockedCar:IsDescendantOf(workspace) then
                                    local owner = autoTpLockedCar:GetAttribute("Owner")
                                    if not owner then
                                        -- Kilitli araç hala satılık ama yeni araç daha yüksek tier mi kontrol et
                                        local carName = getVehicleModelFromMeshId(child)
                                        if carName and selectedAutoTpCars[carName] then
                                            local lockedCarName = getVehicleModelFromMeshId(autoTpLockedCar)
                                            local newTier = getCarTier(carName)
                                            local lockedTier = getCarTier(lockedCarName)
                                            local newPriority = tierPriority[newTier] or 999
                                            local lockedPriority = tierPriority[lockedTier] or 999
                                            
                                            if newPriority < lockedPriority then
                                                print("🔄 YÜKSEK TİER SPAWN! Kilit temizleniyor:")
                                                print("    Locked:", lockedCarName, "(", lockedTier, ") → New:", carName, "(", newTier, ")")
                                                autoTpLocked = false
                                                autoTpLockedCar = nil
                                            else
                                                print("🔒 AUTO TP KİLİTLİ: Yeni araç daha düşük/eşit tier, atlanıyor!")
                                                print("🔒 Locked:", lockedCarName, "(", lockedTier, ") vs New:", carName, "(", newTier, ")")
                                                print("🔒 Yeni araç atlandı:", child.Name)
                                                return
                                            end
                                        else
                                            print("🔒 AUTO TP KİLİTLİ: Yeni araç spawn oldu ama seçili değil, atlanıyor:", child.Name)
                                            return
                                        end
                                    else
                                        -- Kilitli araç satılmış, kilidi kaldır ve devam et
                                        print("🔓 AUTO TP: Kilitli araç satıldı, kilit kaldırıldı:", autoTpLockedCar.Name)
                                        autoTpLocked = false
                                        autoTpLockedCar = nil
                                    end
                                else
                                    -- Kilitli araç workspace'den kaybolmuş, kilidi temizle
                                    print("🔓 AUTO TP: Kilitli araç kayboldu, kilit kaldırıldı")
                                    autoTpLocked = false
                                    autoTpLockedCar = nil
                                end
                            end
                            
                            -- ⛔ Auto Farm aktifken TP kilidi varsa hiçbir şey yapma (mevcut araç farm ediliyor)
                            if autoFarmEnabled and autoFarmTpLocked then
                                print("🔒 AUTO FARM TP KİLİTLİ: Yeni araç spawn oldu ama mevcut araç farm ediliyor, TP atılmayacak")
                                return
                            end
                            
                            -- Auto Farm aktifken ve ilk satın alım tamamlandıysa Auto TP işlemleri durdur
                            if autoFarmEnabled and autoFarmFirstPurchaseCompleted then
                                return
                            end
                            
                            -- Owner attribute'u varsa satın alınmış araç, atla
                            local owner = child:GetAttribute("Owner")
                            if owner then
                                return
                            end
                            
                            -- Mesh ID'den araç ismini bul
                            local carName = getVehicleModelFromMeshId(child)
                            
                            if carName and selectedAutoTpCars[carName] then
                                local newTier = getCarTier(carName)
                                local newPriority = tierPriority[newTier] or 999
                                
                                print("🆕 NEW CAR SPAWN:", carName, "→", newTier, "→ Priority:", newPriority)
                                
                                -- Eğer şu anda bir araca TP atılmışsa ve yeni araç daha yüksek tier ise
                                if currentTeleportedCar and currentTeleportedCar:IsDescendantOf(workspace) then
                                    -- Mesh ID'den mevcut araç ismini bul
                                    local currentCarName = getVehicleModelFromMeshId(currentTeleportedCar)
                                    
                                    local currentTier = getCarTier(currentCarName)
                                    local currentPriority = tierPriority[currentTier] or 999
                                    
                                    print("⚖️ TIER COMPARISON: Current:", currentCarName, "(", currentTier, "- Priority:", currentPriority, ") vs New:", carName, "(", newTier, "- Priority:", newPriority, ")")
                                    
                                    if newPriority < currentPriority then
                                        print("🔄 YÜKSEK TİER SPAWN - HEMEn GEÇİŞ! From:", currentCarName, "(", currentTier, ") to:", carName, "(", newTier, ")")
                                        -- Eski Auto TP kilidini temizle
                                        if autoTpLocked and autoTpLockedCar == currentTeleportedCar then
                                            autoTpLocked = false
                                            autoTpLockedCar = nil
                                            print("🔓 AUTO TP KİLİDİ TEMİZLENDİ: Yeni yüksek tier'a geçiş için")
                                        end
                                        autoTeleportToCar(child, true)
                                        return
                                    end
                                end
                                
                                -- Normal kontrol
                                autoTeleportToCar(child, true)
                            end
                        end)
                    end
                end)
                
                -- Silinen araçlar için tracking temizliği
                autoTpConnections["ChildRemoved"] = Vehicles.ChildRemoved:Connect(function(child) 
                    if teleportedToCars[child] then
                        print("Car removed, cleaning tracking:", child.Name)
                        teleportedToCars[child] = nil
                        carNameTracker[child] = nil
                        if currentTeleportedCar == child then
                            currentTeleportedCar = nil
                        end
                        
                        -- AUTO TP KİLİT TEMİZLEME - Silinen araç kilitli araçsa kilidi kaldır
                        if autoTpLocked and autoTpLockedCar == child then
                            autoTpLocked = false
                            autoTpLockedCar = nil
                            print("🔓 AUTO TP: Kilitli araç silindi, kilit kaldırıldı:", child.Name)
                        end
                        
                        -- AUTO FARM KİLİT TEMİZLEME
                        if autoFarmEnabled and autoFarmTpLocked and autoFarmLockedCar == child then
                            autoFarmTpLocked = false
                            autoFarmLockedCar = nil
                            print("🔓 AUTO FARM: Kilitli araç silindi, kilit kaldırıldı:", child.Name)
                        end
                    end
                end)
            end
        end
    end


    -- Dropdown Functions - headlightMeshMap'teki araç isimlerini kullan
    _G.acne_populateDropdown = function()
        for _, child in pairs(DropdownList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        local y = 0
        
        -- headlightMeshMap ve reverselightsMeshMap'ten tüm unique araç isimlerini al
        local uniqueCars = {}
        
        -- 1. Headlights mesh map'ten araçları al
        for meshId, carName in pairs(headlightMeshMap) do
            if not uniqueCars[carName] then
                local carTier = getCarTier(carName)
                uniqueCars[carName] = carTier
            end
        end
        
        -- 2. ReverseLights mesh map'ten araçları al (Audi A5 vs. için)
        for meshId, carName in pairs(reverselightsMeshMap) do
            if not uniqueCars[carName] then
                local carTier = getCarTier(carName)
                uniqueCars[carName] = carTier
            end
        end
        
        -- Ek kontrol: Workspace'teki mevcut araçlardan eksik olanları bul
        local vehicles = workspace:FindFirstChild("Vehicles")
        if vehicles then
            for _, vehicleModel in pairs(vehicles:GetChildren()) do
                if vehicleModel:IsA("Model") then
                    local success, detectedCarName = pcall(getVehicleModelFromMeshId, vehicleModel)
                    if success and detectedCarName and not uniqueCars[detectedCarName] then
                        local carTier = getCarTier(detectedCarName)
                        uniqueCars[detectedCarName] = carTier
                    end
                end
            end
        end
        
        -- Tier sırasına göre araçları sırala
        local tierOrder = {"S-Tier", "A-Tier", "B-Tier", "C-Tier", "D-Tier", "Unknown"}
        local sortedCars = {}
        
        for _, tier in ipairs(tierOrder) do
            for carName, carTier in pairs(uniqueCars) do
                if carTier == tier then
                    table.insert(sortedCars, {name = carName, tier = tier})
                end
            end
        end
        
        for _, carData in ipairs(sortedCars) do
            local carName = carData.name
            local tier = carData.tier
            
            local CarOption = Instance.new("TextButton", DropdownList)
            CarOption.Size = UDim2.new(1,-10,0,30)
            CarOption.Position = UDim2.new(0,5,0,y)
            
            if selectedAutoTpCars[carName] then
                CarOption.BackgroundColor3 = Color3.fromRGB(100,150,100)
            else
                CarOption.BackgroundColor3 = Color3.fromRGB(50,50,60)
            end
            
            CarOption.TextColor3 = Color3.new(1,1,1)
            
            -- Araç ismini güncelleyen fonksiyon
            local function updateCarOptionText()
                local baseText = carName .. " [" .. tier .. "]"
                local state = carStates[carName]
                
                if state == "autofarm" then
                    CarOption.Text = baseText .. " (AUTO FARM)"
                elseif state == "onlybuy" then
                    CarOption.Text = baseText .. " (ONLY BUY)"
                else
                    CarOption.Text = baseText -- Normal durum, hiçbir ek text yok
                end
            end
            
            updateCarOptionText() -- İlk text'i ayarla
            CarOption.Font = Enum.Font.Gotham
            CarOption.TextSize = 14
            Instance.new("UICorner", CarOption).CornerRadius = UDim.new(0,5)
            
            -- Sol tıklama - Normal seçim/seçim kaldırma
            CarOption.MouseButton1Click:Connect(function()
                if selectedAutoTpCars[carName] then
                    selectedAutoTpCars[carName] = nil
                    CarOption.BackgroundColor3 = Color3.fromRGB(50,50,60)
                    print("Deselected car:", carName)
                else
                    selectedAutoTpCars[carName] = true
                    CarOption.BackgroundColor3 = Color3.fromRGB(100,150,100)
                    print("Selected car:", carName)
                end
                updateCarOptionText() -- Text'i güncelle
                _G.acne_updateDropdownText()
                
                -- Auto TP açıksa yeniden kontrol et
                if autoTpEnabled then
                    task.spawn(function()
                        task.wait(0.1)
                        _G.acne_checkExistingCars()
                    end)
                end

                if espEnabled then _G.acne_refreshList() end
            end)
            
            -- Sağ tıklama - "AUTO FARM" modu (yeni sistem)
            CarOption.MouseButton2Click:Connect(function()
                -- Sadece seçili araçlarda sağ tık çalışır
                if not selectedAutoTpCars[carName] then
                    print("Önce aracı seçin (sol tık), sonra sağ tık yapın!")
                    return
                end
                
                -- "DONT AUTO FARM" durumunu toggle et (ters mantık - sağ tık AUTO FARM yapar)
                local currentState = carStates[carName]
                
                if currentState == nil then
                    carStates[carName] = "autofarm"
                    print("� AUTO FARM mode enabled for:", carName, "- Will buy and auto farm!")
                elseif currentState == "autofarm" then
                    carStates[carName] = "onlybuy"
                    print("� Only purchase mode enabled for:", carName, "- Will only buy, no auto farm!")
                elseif currentState == "onlybuy" then
                    carStates[carName] = nil
                    print("Normal mode for:", carName)
                end
                
                updateCarOptionText() -- Text'i güncelle
                _G.acne_updateDropdownText()
                
                -- Auto TP açıksa yeniden kontrol et
                if autoTpEnabled then
                    task.spawn(function()
                        task.wait(0.1)
                        _G.acne_checkExistingCars()
                    end)
                end

                if espEnabled then _G.acne_refreshList() end
            end)
            
            y = y + 52
        end
        
        DropdownList.CanvasSize = UDim2.new(0,0,0,y)
    end

    DropdownButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        if not dropdownOpen then
            _G.acne_populateDropdown()
            DropdownList.Visible = true
            dropdownOpen = true
            DropdownArrow.Text = "▲"
            TweenService:Create(DropdownList, TweenInfo.new(0.3), {Size = UDim2.new(1,-20,0,200)}):Play()
        else
            dropdownOpen = false
            DropdownArrow.Text = "▼"
            TweenService:Create(DropdownList, TweenInfo.new(0.3), {Size = UDim2.new(1,-20,0,0)}):Play()
            task.spawn(function()
                task.wait(0.3)
                DropdownList.Visible = false
            end)
        end
    end)

    

    -- ESP Functions
    _G.acne_createESP = function(model)
        if activeESP[model] then return end
        
        -- Yeni araç yapısında araç ismini bul: model.Body içindeki araç modeli
        local carName = "Unknown Vehicle"
        local body = model:FindFirstChild("Body")
        local found = false

        if body then
            local obj = body:FindFirstChild("Headlights")
            if obj then
                for _, light in ipairs(obj:GetChildren()) do
                    local meshId = nil
                    
                    -- Güvenli MeshId kontrolü
                    local success, result = pcall(function()
                        return light.MeshId
                    end)
                    
                    if success and result then
                        meshId = result
                    else
                        local specialMesh = light:FindFirstChildWhichIsA("SpecialMesh")
                        if specialMesh then
                            local success2, result2 = pcall(function()
                                return specialMesh.MeshId
                            end)
                            if success2 and result2 then
                                meshId = result2
                            end
                        end
                    end
                    
                    if meshId and headlightMeshMap[meshId] then
                        carName = headlightMeshMap[meshId]
                        found = true
                        break
                    end
                end
            end

            if not found then
                obj = body:FindFirstChild("ReverseLights")
                if obj then
                    for _, light in ipairs(obj:GetChildren()) do
                        local meshId = nil
                        
                        -- Güvenli MeshId kontrolü
                        local success, result = pcall(function()
                            return light.MeshId
                        end)
                        
                        if success and result then
                            meshId = result
                        else
                            local specialMesh = light:FindFirstChildWhichIsA("SpecialMesh")
                            if specialMesh then
                                local success2, result2 = pcall(function()
                                    return specialMesh.MeshId
                                end)
                                if success2 and result2 then
                                    meshId = result2
                                end
                            end
                        end
                        
                        if meshId and reverselightsMeshMap[meshId] then
                            carName = reverselightsMeshMap[meshId]
                            found = true
                            break
                        end
                    end
                end
            end
        end
        
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(1,0,1)
        highlight.OutlineColor = Color3.new(1,0,1)
        highlight.FillTransparency = 0.5
        highlight.Adornee = model
        highlight.Parent = model

        local billboard = Instance.new("BillboardGui", model)
        billboard.Size = UDim2.new(0,200,0,50)
        billboard.StudsOffset = Vector3.new(0,5,0)
        billboard.AlwaysOnTop = true

        local label = Instance.new("TextLabel", billboard)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255,100,255)
        label.TextStrokeTransparency = 0.5
        label.TextScaled = true
        label.Font = Enum.Font.GothamBold
        label.Text = carName

        local conn = RunService.RenderStepped:Connect(function()
            if not model:IsDescendantOf(workspace) then conn:Disconnect() return end
            local root = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
            if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                label.Text = string.format("%s\n%d studs", carName, math.floor(distance))
            end
        end)

        activeESP[model] = {highlight=highlight, gui=billboard, conn=conn}
    end

    _G.acne_removeESP = function(model)
        if activeESP[model] then
            if activeESP[model].highlight then pcall(function() activeESP[model].highlight:Destroy() end) end
            if activeESP[model].gui then pcall(function() activeESP[model].gui:Destroy() end) end
            if activeESP[model].conn then pcall(function() activeESP[model].conn:Disconnect() end) end
            activeESP[model] = nil
        end
        if carButtons[model] then carButtons[model]:Destroy() carButtons[model]=nil end
    end

    _G.acne_refreshList = function()
        for _, btn in pairs(carButtons) do if btn and btn.Parent then btn:Destroy() end end
        for _, lbl in pairs(categoryLabels) do if lbl and lbl.Parent then lbl:Destroy() end end
        carButtons = {}
        categoryLabels = {}

        if not espEnabled then return end

        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then return end

        local y = 0
        for tier, cars in pairs(carTiers) do
            local TierLabel = Instance.new("TextLabel", CarList)
            TierLabel.Size = UDim2.new(1,-15,0,25)
            TierLabel.Position = UDim2.new(0,8,0,y)
            TierLabel.BackgroundTransparency = 1
            TierLabel.Text = tier
            TierLabel.TextColor3 = Color3.fromRGB(163, 152, 237)
            TierLabel.Font = Enum.Font.GothamBold
            TierLabel.TextXAlignment = Enum.TextXAlignment.Left
            TierLabel.TextSize = 18
            categoryLabels[tier] = TierLabel
            y = y + 30

            -- Yeni yapıya göre araçları tara
            for _, model in ipairs(Vehicles:GetChildren()) do
                if model:IsA("Model") then
                    -- Owner attribute'u varsa satın alınmış araç, ESP'de gösterme
                    local owner = model:GetAttribute("Owner")

                    if not owner then -- Sadece owner'ı olmayan araçları göster
                        local bodyPart = model:FindFirstChild("Body")
                        if bodyPart then
                            -- Body içindeki araç modelini kontrol et
                            for _, carModel in ipairs(cars) do
                                if bodyPart:FindFirstChild(carModel) then
                                    _G.acne_createESP(model)
                                    local CarButton = Instance.new("TextButton", CarList)
                                    CarButton.Size = UDim2.new(1, -15, 0, 44)
                                    CarButton.Position = UDim2.new(0,8,0,y)
                                    
                                    local originalName = getOriginalCarName(carModel)
                                    if selectedAutoTpCars[originalName] and autoTpEnabled then
                                        CarButton.BackgroundColor3 = Color3.fromRGB(100,200,100)
                                    else
                                        CarButton.BackgroundColor3 = Color3.fromRGB(31, 24, 62)
                                    end
                                
                                    CarButton.TextColor3 = Color3.new(1,1,1)
                                    CarButton.Text = carModel .. " [" .. tier .. "]"
                                    CarButton.Font = Enum.Font.Gotham
                                    CarButton.TextSize = 16
                                    Instance.new("UICorner", CarButton).CornerRadius = UDim.new(0,8)

                                    CarButton.MouseButton1Click:Connect(function()
                                        local root = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
                                        if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                            LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(0,5,0)
                                        end
                                    end)

                                    carButtons[model] = CarButton
                                    y = y + 52
                                    break -- Bu tier'da bulundu, diğer araçlara geçme
                                end
                            end
                        end
                    end -- owner kontrolü kapanışı
                end
            end
        end
        CarList.CanvasSize = UDim2.new(0,0,0,y)
    end


    -- refreshList override: araç butonlarına premium kontrolü ekler
    _G.acne___buildESPListWithPremium = function()
        for _, btn in pairs(carButtons) do if btn and btn.Parent then btn:Destroy() end end
        for _, lbl in pairs(categoryLabels) do if lbl and lbl.Parent then lbl:Destroy() end end
        carButtons = {}
        categoryLabels = {}

        if not espEnabled then return end

        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then return end

        local modelsByTier = {}
        for _, model in ipairs(Vehicles:GetChildren()) do
            if model:IsA("Model") then
                local owner = model:GetAttribute("Owner")
                if not owner then
                    local carName = getVehicleModelFromMeshId(model)
                    
                    if carName then
                        local carTier = getCarTier(carName)
                        
                        if carTier ~= "Unknown" then
                            modelsByTier[carTier] = modelsByTier[carTier] or {}
                            table.insert(modelsByTier[carTier], {model=model, carName=carName})
                        end
                    end
                end
            end
        end

        local sortedTiers = {"S-Tier", "A-Tier", "B-Tier", "C-Tier", "D-Tier"}
        local y = 0
        for _, tier in ipairs(sortedTiers) do
            local tierModels = modelsByTier[tier]
            if tierModels and #tierModels > 0 then
                local TierLabel = Instance.new("TextLabel", CarList)
                TierLabel.Size = UDim2.new(1,-15,0,25)
                TierLabel.Position = UDim2.new(0,8,0,y)
                TierLabel.BackgroundTransparency = 1
                TierLabel.Text = tier
                TierLabel.TextColor3 = Color3.fromRGB(163, 152, 237)
                TierLabel.Font = Enum.Font.GothamBold
                TierLabel.TextXAlignment = Enum.TextXAlignment.Left
                TierLabel.TextSize = 18
                categoryLabels[tier] = TierLabel
                y = y + 30

                for _, info in ipairs(tierModels) do
                    local model, carName = info.model, info.carName
                    _G.acne_createESP(model)
                    local CarButton = Instance.new("TextButton", CarList)
                    CarButton.Size = UDim2.new(1, -15, 0, 44)
                    CarButton.Position = UDim2.new(0,8,0,y)
                    CarButton.Text = carName.." ["..tier.."]"
                    CarButton.TextColor3 = Color3.new(1,1,1)
                    CarButton.Font = Enum.Font.Gotham
                    CarButton.TextSize = 16

                    if selectedAutoTpCars[carName] and autoTpEnabled then
                        CarButton.BackgroundColor3 = Color3.fromRGB(100,200,100)
                    else
                        CarButton.BackgroundColor3 = Color3.fromRGB(31, 24, 62)
                    end
                    Instance.new("UICorner", CarButton).CornerRadius = UDim.new(0,8)

                    CarButton.MouseButton1Click:Connect(function()
                        local root = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
                        if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(0,5,0)
                        end
                    end)
                    carButtons[model] = CarButton 
                    y = y + 52
                end
            end
        end
        CarList.CanvasSize = UDim2.new(0,0,0,y)
    end

    -- Orijinali sakla ve override et
    _G.acne___original_refreshList = _G.acne_refreshList
    _G.acne_refreshList = function()
        _G.acne___buildESPListWithPremium()
    end

    -- Button Events
    ESPButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        espEnabled = not espEnabled
        
        TweenService:Create(ESPButton, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
            BackgroundColor3=espEnabled and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111) -- Açık pembe / Mor
        }):Play()
        
        ESPButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"

        if espEnabled then
            _G.acne_refreshList()
            respawnBox.Visible = true
            if not espConnections["ChildAdded"] then
                espConnections["ChildAdded"] = workspace.Vehicles.ChildAdded:Connect(function(child) 
                    task.wait(0.5) 
                    _G.acne_refreshList()
                end)
            end
            if not espConnections["ChildRemoved"] then
                espConnections["ChildRemoved"] = workspace.Vehicles.ChildRemoved:Connect(function(child) 
                    _G.acne_removeESP(child) 
                    _G.acne_refreshList()
                end)
            end
        else
            for model in pairs(activeESP) do _G.acne_removeESP(model) end
            for _, conn in pairs(espConnections) do conn:Disconnect() end
            espConnections = {}
            for _, btn in pairs(carButtons) do if btn and btn.Parent then btn:Destroy() end end
            for _, lbl in pairs(categoryLabels) do if lbl and lbl.Parent then lbl:Destroy() end end
            carButtons = {}
            categoryLabels = {}
            respawnBox.Visible = false
        end
    end)

    -- Auto TP Button - Düzeltilmiş ve renk güncellemesi
    AutoTPButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Premium kontrolü - Auto TP kapatıldığında Auto Buy'ı da kapat
        if not isPremiumUser() then
            _G.acne_showPremiumWarning()
            return
        end
        
        autoTpEnabled = not autoTpEnabled
        
        -- Eğer Auto TP kapatılıyorsa Auto Buy'ı da kapat
        if not autoTpEnabled and autoBuyEnabled then
            autoBuyEnabled = false
            AutoBuyButton.Text = "Auto Buy: OFF"
            TweenService:Create(AutoBuyButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(65, 52, 111)
            }):Play()
            
            -- Hook'u pasif yap (tamamen kaldırma)
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local success, ConfirmationEvent = pcall(function()
                return ReplicatedStorage:WaitForChild("Events", 2)
                    :WaitForChild("HUD", 2)
                    :WaitForChild("Confirmation", 2)
            end)
            if success and ConfirmationEvent then
                ConfirmationEvent.OnClientInvoke = function(message)
                    if autoBuyEnabled then
                        return true
                    else
                        -- Normal oyun davranışını geri döndür
                        print("🎮 Auto TP disabled - normal purchase active:", message)
                        return nil
                    end
                end
                print("🧹 Auto TP kapatıldı - Hook pasif moda alındı, normal oyun çalışacak")
            end
            
            lockedToBuyTarget = false
            currentBuyTarget = nil
            if buyConnections.mainLoop then
                if type(buyConnections.mainLoop) == "thread" then
                    task.cancel(buyConnections.mainLoop)
                else
                    pcall(function() buyConnections.mainLoop:Disconnect() end)
                end
                buyConnections.mainLoop = nil
            end
            print("Auto TP kapatıldı, Auto Buy da devre dışı bırakıldı")
            
            -- AUTO FARM TP KİLİDİNİ TEMİZLE
            autoFarmTpLocked = false
            autoFarmLockedCar = nil
            print("🔓 Auto TP kapatıldı: Auto Farm TP kilidi temizlendi")
            
            -- AUTO TP KİLİDİNİ TEMİZLE
            autoTpLocked = false
            autoTpLockedCar = nil
            print("🔓 Auto TP kapatıldı: Auto TP kilidi temizlendi")
        end
        
        TweenService:Create(AutoTPButton, TweenInfo.new(0.3),{
            BackgroundColor3=autoTpEnabled and Color3.fromRGB(124, 92, 255) or Color3.fromRGB(65, 52, 111)
        }):Play()
        
        AutoTPButton.Text = autoTpEnabled and "Auto TP: ON" or "Auto TP: OFF"
        
        checkAutoFarmDependencies()

        print("Auto TP toggled:", autoTpEnabled)
        
        if autoTpEnabled then
            teleportedToCars = {}
            carNameTracker = {}
            currentTeleportedCar = nil
            print("Checking existing cars and setting up events...")
            _G.acne_checkExistingCars()
            setupAutoTPEvents = _G.acne_setupAutoTPEvents
            setupAutoTPEvents()
        else
            teleportedToCars = {}
            carNameTracker = {}
            currentTeleportedCar = nil
            
            -- AUTO TP KİLİTLERİNİ TEMİZLE (Auto TP kapatıldığında)
            autoTpLocked = false
            autoTpLockedCar = nil
            autoFarmTpLocked = false
            autoFarmLockedCar = nil
            print("🔓 Auto TP kapatıldı: Tüm TP kilitleri temizlendi")
            
            for _, conn in pairs(autoTpConnections) do
                if conn then conn:Disconnect() end
            end
            autoTpConnections = {}
            print("Auto TP disabled, cleaned up events")
        end

        if espEnabled then _G.acne_refreshList() end
    end)

    -- Auto TP premium koruması (tıklamadan sonra bir frame bekleyip geri alır)
    updateAutoFarmButtonState()


    ClearButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        selectedAutoTpCars = {}
        carStates = {} -- Araç durumlarını temizle
        teleportedToCars = {}
        carNameTracker = {}
        currentTeleportedCar = nil
        _G.acne_updateDropdownText()
        if espEnabled then _G.acne_refreshList() end
        if dropdownOpen then _G.acne_populateDropdown() end
        
        print("🧹 Clear All: Tüm araç seçimleri ve DONT AUTO FARM ayarları temizlendi")
        
        TweenService:Create(ClearButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(150,30,30)}):Play()
        task.wait(0.2)
        TweenService:Create(ClearButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200,50,50)}):Play()
    end)

    JoinServerButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        TweenService:Create(JoinServerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50,100,200)}):Play()
        JoinServerButton.Text = "Finding Server..."
        
        local PlaceId = game.PlaceId
        local maxAttempts = 5

        local function findLowPlayerServer()
            local servers = {}
            local cursor = ""
            repeat
                local url = string.format(
                    "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s",
                    PlaceId, cursor
                )

                local success, result = pcall(function()
                    return HttpService:JSONDecode(game:HttpGet(url))
                end)

                if success and result and result.data then
                    for _, server in pairs(result.data) do
                        if server.playing < server.maxPlayers - 5 and server.id ~= game.JobId then
                            table.insert(servers, server)
                        end
                    end
                    cursor = result.nextPageCursor or ""
                else
                    break
                end
            until cursor == ""
            return servers
        end
        
        local attempts = 0
        local function attempt()
            attempts = attempts + 1
            TweenService:Create(JoinServerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50,100,200)}):Play()
            JoinServerButton.Text = "Finding Server..."

            if attempts > maxAttempts then
                JoinServerButton.Text = "Join Failed"
                TweenService:Create(JoinServerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200,50,50)}):Play()
                return
            end
            
            local servers = findLowPlayerServer()
            if #servers > 0 then
                local randomServer = servers[math.random(1, #servers)]
                JoinServerButton.Text = "Joining..."
                TweenService:Create(JoinServerButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100,200,100)}):Play()
                local success, errorMessage = pcall(function()
                    TeleportService:TeleportToPlaceInstance(PlaceId, randomServer.id, LocalPlayer)
                end)
                if not success then
                    warn("Teleport failed: " .. tostring(errorMessage))
                    wait(2)
                    attempt()
                end
            else
            -- if can't find lowest then find normal
                local success, errorMessage = pcall(function()
                    TeleportService:Teleport(PlaceId, LocalPlayer)
                end)
                if not success then
                    warn("Basic teleport failed: " .. tostring(errorMessage))
                    wait(2)
                    attempt()
                end
            end
        end
        
        attempt()
    end)

    -- Repair Car Button Event - YENİ
    RepairCarButton.MouseButton1Click:Connect(function()
        if guiMinimized then return end
        
        -- Buton animasyonu
        TweenService:Create(RepairCarButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255,150,50)
        }):Play()
        RepairCarButton.Text = "🔍 Finding Vehicle..."
        
        task.spawn(function()
            -- 15 stud yakınındaki kendi aracını bul
            local nearbyVehicle = nil
            local minDistance = math.huge
            
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                print("❌ Repair Car: Karakter veya HumanoidRootPart bulunamadı")
                RepairCarButton.Text = "❌ Character Error"
                TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(200,50,50)
                }):Play()
                task.wait(2)
                RepairCarButton.Text = "🔧 Repair Car"
                TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(255,100,50)
                }):Play()
                return
            end
            
            local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
            local vehicles = workspace:FindFirstChild("Vehicles")
            
            if not vehicles then
                print("❌ Repair Car: Vehicles folder bulunamadı")
                RepairCarButton.Text = "❌ No Vehicles"
                TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(200,50,50)
                }):Play()
                task.wait(2)
                RepairCarButton.Text = "🔧 Repair Car"
                TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(255,100,50)
                }):Play()
                return
            end
            
            -- 15 stud yakınındaki kendi araçlarını ara
            for _, vehicle in pairs(vehicles:GetChildren()) do
                if vehicle:IsA("Model") then
                    local owner = vehicle:GetAttribute("Owner")
                    if owner == LocalPlayer.Name then
                        -- Aracın pozisyonunu hesapla
                        local vehiclePos = nil
                        local primaryPart = vehicle.PrimaryPart
                        if primaryPart then
                            vehiclePos = primaryPart.Position
                        else
                            -- PrimaryPart yoksa herhangi bir BasePart'ı kullan
                            local basePart = vehicle:FindFirstChildWhichIsA("BasePart")
                            if basePart then
                                vehiclePos = basePart.Position
                            end
                        end
                        
                        if vehiclePos then
                            local distance = (playerPos - vehiclePos).Magnitude
                            if distance <= 15 and distance < minDistance then
                                minDistance = distance
                                nearbyVehicle = vehicle
                            end
                        end
                    end
                end
            end
            
            if not nearbyVehicle then
                print("❌ Repair Car: 15 stud yakınında kendi aracınız bulunamadı")
                RepairCarButton.Text = "❌ No Vehicle Nearby"
                TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(200,50,50)
                }):Play()
                task.wait(2)
                RepairCarButton.Text = "🔧 Repair Car"
                TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(255,100,50)
                }):Play()
                return
            end
            
            print("✅ Repair Car: Yakın araç bulundu:", nearbyVehicle.Name, "- Mesafe:", math.floor(minDistance * 100) / 100, "stud")
            
            -- Hood detector'ını ateşle (Autofarm formatı - mesafe gözetmeden)
            RepairCarButton.Text = "  Opening Hood..."
            TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(255,200,50)
            }):Play()
            
            local hoodDetectorSuccess = pcall(function()
                local hoodDetector = nearbyVehicle.Misc.Hood.Detector.ClickDetector
                fireClickDetector(hoodDetector, LocalPlayer)
                print("🚗 Hood detector ateşlendi:", nearbyVehicle.Name)
                return true
            end)
            
            if hoodDetectorSuccess then
                print("✅ Hood detector başarılı")
                task.wait(1) -- Autofarm'dakiyle aynı bekleme süresi
                print("✅ Hood açıldı, repair işlemine başlanıyor")
            else
                print("⚠️ Hood detector ateşlenemedi, yine de devam ediliyor")
                task.wait(0.5)
            end
            
            -- Eğer araçta oturuyorsa çık (hood açıldıktan sonra)
            local char = LocalPlayer.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if humanoid and humanoid.SeatPart then
                print("🚗 Araçtan çıkılıyor...")
                RepairCarButton.Text = "🚪 Exiting Vehicle..."
                
                -- Araçtan çık
                humanoid.Sit = false
                task.wait(0.1)
                humanoid.Sit = false
                task.wait(0.2)
                
                -- Araçtan uzaklaş (sağ tarafa)
                if hrp then
                    local rightVector = hrp.CFrame.RightVector
                    hrp.CFrame = hrp.CFrame + (rightVector * 8)
                    print("📍 Araçtan uzaklaşıldı")
                end
                
                task.wait(0.3)
            else
                print("✅ Zaten araçta oturmuyor")
            end
            
            -- Repair frame'ine teleport et
            RepairCarButton.Text = "  Going to Repair..."
            TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(100,150,255)
            }):Play()
            
            -- Repair station'a teleport
            local repairCFrame = CFrame.new(-783.90, 3.35, -1300.51) * CFrame.Angles(math.rad(12.78), math.rad(89.94), math.rad(0.00))
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = repairCFrame
                print("📍 Repair station'a teleport edildi")
                task.wait(1) -- Repair'e teleport sonrası stabilizasyon
            end
            
            RepairCarButton.Text = "⚙️ Repairing..."
            
            -- Sadece Repair için özel fonksiyon (satış YOK)
            task.spawn(function()
                print("🔧 REPAIR CAR: Machine 1 operation BAŞLADI:", nearbyVehicle.Name)
                
                -- Makine 1'e teleport
                local machine1CFrame = CFrame.new(-767.44, 6.87, -1303.07) * CFrame.Angles(math.rad(0.00), math.rad(-112.58), math.rad(-0.00))
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = machine1CFrame
                    print("📍 REPAIR CAR: Makine 1'e teleport edildi")
                    
                    task.wait(0.5)
                    
                    -- RemovePart eventi gönder
                    local success, result = pcall(function()
                        local args = {
                            [1] = "RemovePart";
                            [2] = "CylinderHead";
                        }
                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                        print("🔧 RemovePart CylinderHead gönderildi:", nearbyVehicle.Name)
                        return true
                    end)
                    
                    if success then
                        task.wait(1)
                        
                        -- Makine 1 click detector
                        local machine1Success = pcall(function()
                            local machineClickDetector = workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector
                            fireClickDetector(workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector)
                            print("⚙️ Makine 1 click detector tetiklendi")
                            return true
                        end)
                        
                        if machine1Success then
                            task.wait(1)
                            
                            -- Makine 2'ye teleport
                            local machine2CFrame = CFrame.new(-767.13, 6.88, -1296.99) * CFrame.Angles(math.rad(0.00), math.rad(-43.44), math.rad(0.00))
                            LocalPlayer.Character.HumanoidRootPart.CFrame = machine2CFrame
                            print("📍 Makine 2'ye teleport edildi")
                            
                            task.wait(1)
                            
                            local machine2RemoveSuccess = pcall(function()
                                local args = {
                                    [1] = "RemovePart";
                                    [2] = "ExhaustManifold";
                                }
                                workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                print("🔧 RemovePart ExhaustManifold gönderildi:", nearbyVehicle.Name)
                                return true
                            end)
                            
                            if machine2RemoveSuccess then
                                task.wait(1)
                                
                                local machine2ClickSuccess = pcall(function()
                                    local machine2ClickDetector = workspace.Map:GetChildren()[2542]:GetChildren()[12].Button.ClickDetector
                                    fireClickDetector(workspace.Map:GetChildren()[2542]:GetChildren()[12].Button.ClickDetector)
                                    print("⚙️ Makine 2 click detector tetiklendi")
                                    return true
                                end)
                                
                                if machine2ClickSuccess then
                                    task.wait(1)
                                    
                                    -- Batarya
                                    local batteryCFrame = CFrame.new(-766.37, 6.02, -1290.29) * CFrame.Angles(math.rad(0.00), math.rad(-79.57), math.rad(0.00))
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = batteryCFrame
                                    print("📍 Batarya istasyonuna teleport edildi")
                                    
                                    task.wait(1)
                                    
                                    local batteryRemoveSuccess = pcall(function()
                                        local args = {
                                            [1] = "RemovePart";
                                            [2] = "Battery";
                                        }
                                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                        print("🔧 RemovePart Battery gönderildi:", nearbyVehicle.Name)
                                        return true
                                    end)
                                    
                                    if batteryRemoveSuccess then
                                        task.wait(1)
                                        
                                        local batteryClickSuccess = pcall(function()
                                            local batteryClickDetector = workspace.Map:GetChildren()[2542]:GetChildren()[14].Button.ClickDetector
                                            fireClickDetector(workspace.Map:GetChildren()[2542]:GetChildren()[14].Button.ClickDetector)
                                            print("⚙️ Batarya click detector tetiklendi")
                                            return true
                                        end)
                                        
                                        if batteryClickSuccess then
                                            task.wait(1)
                                            
                                            -- Su istasyonu
                                            local waterCFrame = CFrame.new(-766.30, 6.20, -1308.48) * CFrame.Angles(math.rad(-0.00), math.rad(-80.44), math.rad(-0.00))
                                            LocalPlayer.Character.HumanoidRootPart.CFrame = waterCFrame
                                            print("📍 Su istasyonuna teleport edildi")
                                            
                                            task.wait(1)
                                            
                                            local waterRemoveSuccess = pcall(function()
                                                local args = {
                                                    [1] = "RemovePart";
                                                    [2] = "AirIntake";
                                                }
                                                workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                print("🔧 RemovePart AirIntake gönderildi:", nearbyVehicle.Name)
                                                return true
                                            end)
                                            
                                            if waterRemoveSuccess then
                                                task.wait(1)
                                                
                                                local waterClickSuccess = pcall(function()
                                                    local waterClickDetector = workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector
                                                    fireClickDetector(workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector)
                                                    print("⚙️ Su click detector tetiklendi")
                                                    return true
                                                end)
                                                
                                                if waterClickSuccess then
                                                    task.wait(8)
                                                    
                                                    -- Özel pozisyona teleport (Injectors, Sparkplugs, TimingBelt)
                                                    local specialCFrame = CFrame.new(-775.41, 4.50, -1310.93) * CFrame.Angles(math.rad(0.00), math.rad(-22.41), math.rad(-0.00))
                                                    LocalPlayer.Character.HumanoidRootPart.CFrame = specialCFrame
                                                    print("📍 Özel pozisyona teleport edildi")
                                                    
                                                    task.wait(1)
                                                    
                                                    -- Injectors çıkar
                                                    pcall(function()
                                                        local args = {[1] = "RemovePart"; [2] = "Injectors"}
                                                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                        print("🔧 RemovePart Injectors gönderildi")
                                                    end)
                                                    
                                                    task.wait(1)
                                                    
                                                    -- Sparkplugs çıkar
                                                    pcall(function()
                                                        local args = {[1] = "RemovePart"; [2] = "Sparkplugs"}
                                                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                        print("🔧 RemovePart Sparkplugs gönderildi")
                                                    end)
                                                    
                                                    task.wait(1)
                                                    
                                                    -- TimingBelt çıkar
                                                    pcall(function()
                                                        local args = {[1] = "RemovePart"; [2] = "TimingBelt"}
                                                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                        print("🔧 RemovePart TimingBelt gönderildi")
                                                    end)
                                                    
                                                    task.wait(1)
                                                    
                                                    -- Makine 1'e geri teleport (EngineBlock için)
                                                    LocalPlayer.Character.HumanoidRootPart.CFrame = machine1CFrame
                                                    print("📍 Makine 1'e geri teleport edildi (EngineBlock için)")
                                                    
                                                    task.wait(1)
                                                    
                                                    -- EngineBlock çıkar
                                                    local engineBlockRemoveSuccess = pcall(function()
                                                        local args = {[1] = "RemovePart"; [2] = "EngineBlock"}
                                                        workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                        print("🔧 RemovePart EngineBlock gönderildi")
                                                        return true
                                                    end)
                                                    
                                                    if engineBlockRemoveSuccess then
                                                        task.wait(1)
                                                        
                                                        -- Makine 1 final click
                                                        local finalMachine1ClickSuccess = pcall(function()
                                                            local machineClickDetector = workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector
                                                            fireClickDetector(workspace.Map:GetChildren()[2542].GrindingMachine.Button.ClickDetector)
                                                            print("⚙️ Makine 1 final click detector tetiklendi")
                                                            return true
                                                        end)
                                                        
                                                        if finalMachine1ClickSuccess then
                                                            task.wait(6)
                                                            
                                                            -- Su istasyonuna geri teleport (Radiator için)
                                                            LocalPlayer.Character.HumanoidRootPart.CFrame = waterCFrame
                                                            print("📍 Su istasyonuna geri teleport edildi")
                                                            
                                                            task.wait(1)
                                                            
                                                            -- Radiator çıkar
                                                            local radiatorRemoveSuccess = pcall(function()
                                                                local args = {[1] = "RemovePart"; [2] = "Radiator"}
                                                                workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                                print("🔧 RemovePart Radiator gönderildi")
                                                                return true
                                                            end)
                                                            
                                                            if radiatorRemoveSuccess then
                                                                task.wait(1)
                                                                
                                                                -- Su final click
                                                                local finalWaterClickSuccess = pcall(function()
                                                                    local waterClickDetector = workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector
                                                                    fireClickDetector(workspace.Map:GetChildren()[2542].PartsWasher.Faucet.ClickDetector)
                                                                    print("⚙️ Su final click detector tetiklendi")
                                                                    return true
                                                                end)
                                                                
                                                                if finalWaterClickSuccess then
                                                                    task.wait(10)
                                                                    
                                                                    print("🔍 REPAIR CAR: 25 stud yakınındaki parçalar aranıyor...")
                                                                    
                                                                    -- 25 stud yakınındaki MoveableParts'ları bul
                                                                    local nearbyParts = {}
                                                                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                        local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
                                                                        local moveableParts = workspace:FindFirstChild("MoveableParts")
                                                                        
                                                                        if moveableParts then
                                                                            for _, part in pairs(moveableParts:GetChildren()) do
                                                                                if part:IsA("Model") then
                                                                                    local owner = part:GetAttribute("Owner")
                                                                                    if owner == LocalPlayer.Name then
                                                                                        local centerPart = part.PrimaryPart or part:FindFirstChildWhichIsA("BasePart")
                                                                                        if centerPart then
                                                                                            local distance = (playerPos - centerPart.Position).Magnitude
                                                                                            if distance <= 25 then
                                                                                                table.insert(nearbyParts, part)
                                                                                                print("✅ Yakında parça bulundu:", part.Name, "Mesafe:", math.floor(distance), "stud")
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                    
                                                                    print("🔍 Toplam", #nearbyParts, "yakın parça bulundu")
                                                                    
                                                                    -- Reapply sıralaması
                                                                    local reapplyOrder = {"EngineBlock", "Battery", "Radiator", "Injectors", "CylinderHead", "AirIntake", "ExhaustManifold", "Sparkplugs", "TimingBelt"}
                                                                    
                                                                    -- Yakındaki parçaları sıralı reapply et
                                                                    local reappliedCount = 0
                                                                    for _, partName in ipairs(reapplyOrder) do
                                                                        local foundPart = nil
                                                                        for _, part in ipairs(nearbyParts) do
                                                                            if part.Name == partName then
                                                                                foundPart = part
                                                                                break
                                                                            end
                                                                        end
                                                                        
                                                                        if foundPart then
                                                                            local reapplySuccess = pcall(function()
                                                                                local args = {[1] = "ReapplyPart"; [2] = foundPart}
                                                                                workspace:WaitForChild("Vehicles", 9e9):WaitForChild(nearbyVehicle.Name, 9e9):WaitForChild("PartsEvent", 9e9):FireServer(unpack(args))
                                                                                print("🔧 ReapplyPart", foundPart.Name, "gönderildi")
                                                                                return true
                                                                            end)
                                                                            
                                                                            if reapplySuccess then
                                                                                reappliedCount = reappliedCount + 1
                                                                            end
                                                                            
                                                                            if reappliedCount < #nearbyParts then
                                                                                task.wait(1)
                                                                            end
                                                                        end
                                                                    end
                                                                    
                                                                    print("✅ REPAIR CAR: Tüm reapply işlemleri tamamlandı! (" .. reappliedCount .. "/" .. #nearbyParts .. " parts)")
                                                                    
                                                                    task.wait(2)
                                                                    
                                                                    -- DriveSeat'e TP at ve işlemi bitir
                                                                    print("🚗 REPAIR CAR: DriveSeat'e teleport ediliyor...")
                                                                    
                                                                    local driveSeat = nil
                                                                    if nearbyVehicle and nearbyVehicle:IsDescendantOf(workspace) then
                                                                        -- DriveSeat'i bul
                                                                        for _, desc in pairs(nearbyVehicle:GetDescendants()) do
                                                                            if desc:IsA("VehicleSeat") and desc.Name == "DriveSeat" then
                                                                                driveSeat = desc
                                                                                break
                                                                            end
                                                                        end
                                                                        
                                                                        -- DriveSeat bulunamadıysa herhangi bir VehicleSeat'i kullan
                                                                        if not driveSeat then
                                                                            driveSeat = nearbyVehicle:FindFirstChildOfClass("VehicleSeat")
                                                                        end
                                                                    end
                                                                    
                                                                    if driveSeat and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                                                        -- DriveSeat'e otur (araç sürmek için)
                                                                        LocalPlayer.Character.HumanoidRootPart.CFrame = driveSeat.CFrame
                                                                        task.wait(0.2) -- Pozisyon stabilizasyonu için
                                                                        
                                                                        -- Humanoid'i DriveSeat'e oturtur
                                                                        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                                                        if humanoid then
                                                                            driveSeat:Sit(humanoid)
                                                                            task.wait(0.3)
                                                                            
                                                                            -- Oturma başarılı mı kontrol et
                                                                            if humanoid.SeatPart == driveSeat then
                                                                                print("✅ REPAIR CAR: DriveSeat'e başarıyla oturuldu")
                                                                            else
                                                                                print("⚠️ REPAIR CAR: DriveSeat'e oturulamadı, manuel deneme...")
                                                                                -- Manuel oturma denemesi
                                                                                for i = 1, 3 do
                                                                                    LocalPlayer.Character.HumanoidRootPart.CFrame = driveSeat.CFrame
                                                                                    task.wait(0.1)
                                                                                    driveSeat:Sit(humanoid)
                                                                                    task.wait(0.2)
                                                                                    if humanoid.SeatPart == driveSeat then
                                                                                        print("✅ REPAIR CAR: Manuel oturma başarılı!")
                                                                                        break
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                        
                                                                        print("📍 REPAIR CAR: DriveSeat'e oturuldu ve araç kullanıma hazır")
                                                                        
                                                                        -- Randomize Color kontrolü
                                                                        if randomizeColorEnabled then
                                                                            print("🎨 Randomize Color aktif, aracı boyamaya başlıyor...")
                                                                            task.wait(0.5) -- Stabilizasyon için bekle
                                                                            
                                                                            -- Rastgele renk oluştur (Autofarm'daki aynı format)
                                                                            local randomHue = math.random() * 360 -- 0-360 derece
                                                                            local randomSaturation = 0.7 + (math.random() * 0.3) -- 0.7-1.0 arası doygunluk
                                                                            local randomValue = 0.8 + (math.random() * 0.2) -- 0.8-1.0 arası parlaklık
                                                                            
                                                                            local randomColor = Color3.fromHSV(randomHue/360, randomSaturation, randomValue)
                                                                            
                                                                            print("🎨 Rastgele boyama başlatılıyor - HSV:", math.floor(randomHue), math.floor(randomSaturation*100)/100, math.floor(randomValue*100)/100)
                                                                            print("🎨 RGB değerleri:", math.floor(randomColor.R*255), math.floor(randomColor.G*255), math.floor(randomColor.B*255))
                                                                            
                                                                            -- Paint işlemini başlat (Autofarm'daki DOĞRU format)
                                                                            local paintSuccess = pcall(function()
                                                                                local args = {
                                                                                    [1] = nearbyVehicle, -- Araç objesi
                                                                                    [2] = randomColor    -- Color3 değeri
                                                                                }
                                                                                
                                                                                local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events", 5)
                                                                                local VehiclesEvents = Events:WaitForChild("Vehicles", 5)
                                                                                local SetPaintEvent = VehiclesEvents:WaitForChild("SetPaint", 5)
                                                                                
                                                                                SetPaintEvent:FireServer(unpack(args))
                                                                                return true
                                                                            end)
                                                                            
                                                                            if paintSuccess then
                                                                                print("🎨 ✅ Araç başarıyla rastgele renge boyandı:", nearbyVehicle.Name)
                                                                            else
                                                                                print("🎨 ❌ Boyama eventi tetiklenemedi, devam ediliyor...")
                                                                            end
                                                                            
                                                                            task.wait(1) -- Boyama işlemi için ek bekleme
                                                                        else
                                                                            print("🎨 Randomize Color kapalı, boyama atlanıyor")
                                                                        end
                                                                        
                                                                        -- Başarı bildirimi
                                                                        RepairCarButton.Text = "✅ Repair Completed"
                                                                        TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                                                                            BackgroundColor3 = Color3.fromRGB(50,255,50)
                                                                        }):Play()
                                                                        
                                                                        local completionNotification = Instance.new("ScreenGui", game.CoreGui)
                                                                        local completionFrame = Instance.new("Frame", completionNotification)
                                                                        completionFrame.Size = UDim2.new(0,400,0,80)
                                                                        completionFrame.Position = UDim2.new(0.5,-200,0,200)
                                                                        completionFrame.BackgroundColor3 = Color3.fromRGB(50,255,50)
                                                                        Instance.new("UICorner", completionFrame).CornerRadius = UDim.new(0,15)
                                                                        
                                                                        local completionTitle = Instance.new("TextLabel", completionFrame)
                                                                        completionTitle.Size = UDim2.new(1,0,0.6,0)
                                                                        completionTitle.BackgroundTransparency = 1
                                                                        completionTitle.Text = "🎉 Vehicle Repair Completed!"
                                                                        completionTitle.TextColor3 = Color3.new(1,1,1)
                                                                        completionTitle.Font = Enum.Font.GothamBold
                                                                        completionTitle.TextSize = 18
                                                                        
                                                                        local completionDetail = Instance.new("TextLabel", completionFrame)
                                                                        completionDetail.Position = UDim2.new(0,0,0.6,0)
                                                                        completionDetail.Size = UDim2.new(1,0,0.4,0)
                                                                        completionDetail.BackgroundTransparency = 1
                                                                        completionDetail.Text = "Sitting in DriveSeat: " .. nearbyVehicle.Name
                                                                        completionDetail.TextColor3 = Color3.new(0.9,0.9,0.9)
                                                                        completionDetail.Font = Enum.Font.Gotham
                                                                        completionDetail.TextSize = 14
                                                                        
                                                                        task.spawn(function()
                                                                            task.wait(5)
                                                                            pcall(function() completionNotification:Destroy() end)
                                                                        end)
                                                                        
                                                                        print("✅ REPAIR CAR: İşlem tamamen tamamlandı!")
                                                                        print("🚗 REPAIR CAR: Araç tamiri bitti, DriveSeat'e oturuldu!")
                                                                    else
                                                                        print("❌ REPAIR CAR: DriveSeat bulunamadı veya karakter hatası")
                                                                        RepairCarButton.Text = "❌ DriveSeat Error"
                                                                        TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                                                                            BackgroundColor3 = Color3.fromRGB(255,100,100)
                                                                        }):Play()
                                                                    end
                                                                    
                                                                    -- 5 saniye sonra butonu normale döndür
                                                                    task.wait(5)
                                                                    RepairCarButton.Text = "🔧 Repair Car"
                                                                    TweenService:Create(RepairCarButton, TweenInfo.new(0.5), {
                                                                        BackgroundColor3 = Color3.fromRGB(255,100,50)
                                                                    }):Play()
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            
            
            -- Tamir başlatıldı bildirimi
            print("✅ Repair Car: Tamir işlemi başlatıldı!")
            RepairCarButton.Text = "✅ Repair Started"
            TweenService:Create(RepairCarButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(50,200,50)
            }):Play()
            
            -- Bildirim göster
            local notification = Instance.new("ScreenGui", game.CoreGui)
            local frame = Instance.new("Frame", notification)
            frame.Size = UDim2.new(0,350,0,70)
            frame.Position = UDim2.new(0.5,-175,0,120)
            frame.BackgroundColor3 = Color3.fromRGB(50,200,50)
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)
            
            local titleLabel = Instance.new("TextLabel", frame)
            titleLabel.Size = UDim2.new(1,0,0.5,0)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = "🔧 Vehicle Repair Started"
            titleLabel.TextColor3 = Color3.new(1,1,1)
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 16
            
            local detailLabel = Instance.new("TextLabel", frame)
            detailLabel.Position = UDim2.new(0,0,0.5,0)
            detailLabel.Size = UDim2.new(1,0,0.5,0)
            detailLabel.BackgroundTransparency = 1
            detailLabel.Text = nearbyVehicle.Name .. " (" .. math.floor(minDistance * 10) / 10 .. " studs)"
            detailLabel.TextColor3 = Color3.new(0.9,0.9,0.9)
            detailLabel.Font = Enum.Font.Gotham
            detailLabel.TextSize = 14
            
            task.spawn(function()
                task.wait(4)
                pcall(function() notification:Destroy() end)
            end)
            
            -- 3 saniye sonra butonu normal haline döndür
            task.wait(3)
            RepairCarButton.Text = "🔧 Repair Car"
            TweenService:Create(RepairCarButton, TweenInfo.new(0.5), {
                BackgroundColor3 = Color3.fromRGB(255,100,50)
            }):Play()
        end)
    end)

    -- Açılış animasyonu
    -- ACNE / NEXUS: responsive shell, native touch targets and live styling.
    do
        ScreenGui.ResetOnSpawn = false
        MainFrame.ClipsDescendants = true
        MainFrame.BorderSizePixel = 0
        Title.Size = UDim2.new(1, 0, 0, 64)
        Title.Text = "   ACNE  /  NEXUS"
        Title.TextSize = 20
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
        MinimizeButton.Size = UDim2.fromOffset(44, 44)
        MinimizeButton.Position = UDim2.new(1, -54, 0, 10)
        MinimizeButton.Text = "-"
        TabFrame.Position = UDim2.fromOffset(12, 72)
        TabFrame.Size = UDim2.new(1, -24, 0, 52)
        TabFrame.BorderSizePixel = 0
        TabFrame.ScrollBarThickness = 2
        TabFrame.ScrollBarImageColor3 = Color3.fromRGB(107, 224, 242)
        TabFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
        TabLayout.Padding = UDim.new(0, 6)
        for _, tab in ipairs(TabFrame:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.Size = UDim2.fromOffset(96, 46)
                tab.TextSize = 14
            end
        end
        ContentFrame.Position = UDim2.fromOffset(12, 136)
        ContentFrame.Size = UDim2.new(1, -24, 1, -148)
        ContentFrame.ScrollingDirection = Enum.ScrollingDirection.XY
        ContentFrame.ScrollBarThickness = 3
        ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(107, 224, 242)
        CarList.ScrollBarThickness = 3
        CarList.ScrollBarImageColor3 = Color3.fromRGB(107, 224, 242)
        CarList.BorderSizePixel = 0
        respawnBox.TextSize = 13
        respawnBox.TextWrapped = true
        ResizeHandle.ZIndex = 5
        TpToOwnCarButton.Size = UDim2.fromOffset(160, 44)
        TpToOwnCarButton.Text = "TP TO OWN CAR"

        local function decorate(object)
            if not object:IsA("GuiObject") then return end
            object.BorderSizePixel = 0
            if object:IsA("TextButton") or object:IsA("TextBox") then
                if object.BackgroundTransparency < 1 then
                    local stroke = Instance.new("UIStroke")
                    stroke.Name = "NexusEdge"
                    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    stroke.Color = Color3.fromRGB(100, 122, 178)
                    stroke.Transparency = 0.72
                    stroke.Parent = object
                    if object:IsA("TextButton") then
                        object.MouseEnter:Connect(function()
                            TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.15}):Play()
                        end)
                        object.MouseLeave:Connect(function()
                            TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 0.72}):Play()
                        end)
                    end
                end
                if object:IsA("TextButton") and object.Size.Y.Scale == 0 and object.Size.Y.Offset >= 28 then
                    -- Preserve authored row spacing; list rows are sized explicitly.
                    object.TextSize = math.min(object.TextSize, 16)
                    object.TextWrapped = true
                end
            end
        end
        for _, object in ipairs(ScreenGui:GetDescendants()) do decorate(object) end
        ScreenGui.DescendantAdded:Connect(function(object) task.defer(decorate, object) end)
        local edge = Instance.new("UIStroke", MainFrame)
        edge.Color = Color3.fromRGB(124, 92, 255)
        edge.Transparency = 0.32
        local gradient = Instance.new("UIGradient", Title)
        gradient.Color = ColorSequence.new(Color3.fromRGB(210, 195, 255), Color3.fromRGB(125, 226, 255))
        gradient.Rotation = 15

        local function layoutContent()
            local width = ContentFrame.AbsoluteSize.X
            local compact = width < 560
            local esp = currentTab == "ESP"
            for _, page in ipairs(ContentFrame:GetChildren()) do
                if page:IsA("Frame") then
                    page.Size = UDim2.new(0, esp and width or math.max(width, 620), 1, 0)
                end
            end
            local canvas = ContentFrame.CanvasSize
            ContentFrame.CanvasSize = UDim2.new(0, esp and 0 or math.max(width, 620), canvas.Y.Scale, esp and 0 or math.max(800, canvas.Y.Offset))
            ESPButton.Position = UDim2.fromOffset(8, 8)
            ESPButton.Size = UDim2.new(compact and 1 or 0, compact and -16 or 180, 0, 44)
            respawnBox.Position = compact and UDim2.fromOffset(8, 58) or UDim2.fromOffset(200, 8)
            respawnBox.Size = compact and UDim2.new(1, -16, 0, 36) or UDim2.new(1, -208, 0, 44)
            TeleportTitle.Position = UDim2.fromOffset(8, compact and 104 or 68)
            CarList.Position = UDim2.fromOffset(0, compact and 142 or 106)
            CarList.Size = UDim2.new(1, -6, 1, compact and -148 or -112)
        end
        local function fitViewport()
            local viewport = ScreenGui.AbsoluteSize
            local width = math.min(760, math.max(240, viewport.X - 24))
            local height = math.min(650, math.max(240, viewport.Y - 80))
            savedMainFrameSize = UDim2.fromOffset(width, height)
            savedMainFramePosition = UDim2.fromOffset((viewport.X - width) / 2, 64)
            if not guiMinimized then
                MainFrame.Size = savedMainFrameSize
                MainFrame.Position = savedMainFramePosition
            end
            ResizeHandle.Visible = not UserInputService.TouchEnabled
            TpToOwnCarButton.Position = UDim2.new(1, -172, 0, 8)
            MiniFrame.Position = UDim2.fromOffset(12, 64)
            layoutContent()
        end
        ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitViewport)
        ContentFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(layoutContent)
        for _, page in ipairs(ContentFrame:GetChildren()) do
            if page:IsA("Frame") then
                page:GetPropertyChangedSignal("Visible"):Connect(function()
                    ContentFrame.CanvasPosition = Vector2.zero
                    layoutContent()
                end)
            end
        end
        fitViewport()
    end
    TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = savedMainFrameSize
    }):Play()

    -- Premium Activated bildirimi (premium kullanıcı için)
    if isPremiumUser() then
        task.spawn(function()
            task.wait(0.65)
            local toastGui = Instance.new("ScreenGui")
            toastGui.Name = "PremiumActivatedToast_" .. tostring(math.random(1,1e6))
            toastGui.ResetOnSpawn = false
            toastGui.Parent = game.CoreGui

            local toastFrame = Instance.new("Frame", toastGui)
            toastFrame.Size = UDim2.new(0,0,0,0)
            toastFrame.Position = UDim2.new(0.5,-150,0,50)
            toastFrame.BackgroundColor3 = Color3.fromRGB(50,200,50)
            Instance.new("UICorner", toastFrame).CornerRadius = UDim.new(0,10)

            local toastLabel = Instance.new("TextLabel", toastFrame)
            toastLabel.Size = UDim2.new(1,0,1,0)
            toastLabel.BackgroundTransparency = 1
            toastLabel.Text = "Premium Activated"
            toastLabel.TextColor3 = Color3.new(1,1,1)
            toastLabel.Font = Enum.Font.GothamBold
            toastLabel.TextSize = 16

            TweenService:Create(toastFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0,300,0,60)
            }):Play()

            task.delay(3, function()
                TweenService:Create(toastFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = UDim2.new(0,0,0,0)
                }):Play()
                task.delay(0.2, function() 
                    pcall(function() toastGui:Destroy() end) 
                end)
            end)
        end)
    end

    -- TP to Own Car Button Event Handler
    TpToOwnCarButton.MouseButton1Click:Connect(function()        
        -- Dragging kontrolü - eğer dragging yapılıyorsa click olayını engelle
        if tpCarButtonDragging then return end
        
        -- Buton animasyonu
        TweenService:Create(TpToOwnCarButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        }):Play()
        TpToOwnCarButton.Text = "🔍 Finding Car..."
        
        task.spawn(function()
            local foundOwnCar = nil
            local vehicles = workspace:FindFirstChild("Vehicles")
            
            if vehicles then
                -- Workspace'teki tüm araçları tara
                for _, vehicleModel in pairs(vehicles:GetChildren()) do
                    if vehicleModel:IsA("Model") then
                        -- Owner attribute'u kontrol et
                        local owner = vehicleModel:GetAttribute("Owner")
                        if owner and string.find(owner, LocalPlayer.Name) then
                            foundOwnCar = vehicleModel
                            break
                        end
                    end
                end
            end
            
            if foundOwnCar then
                -- Kendi aracını buldu, TP et
                local root = foundOwnCar.PrimaryPart or foundOwnCar:FindFirstChild("HumanoidRootPart") or foundOwnCar:FindFirstChildWhichIsA("BasePart")
                
                if root and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame + Vector3.new(5, 3, 0)
                    
                    -- Başarı mesajı
                    TpToOwnCarButton.Text = "✅ Teleported!"
                    TweenService:Create(TpToOwnCarButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                    }):Play()
                    
                    -- Bildirim göster
                    local notification = Instance.new("ScreenGui", game.CoreGui)
                    local frame = Instance.new("Frame", notification)
                    frame.Size = UDim2.new(0,250,0,50)
                    frame.Position = UDim2.new(0.5,-125,0,80)
                    frame.BackgroundColor3 = Color3.fromRGB(50,200,50)
                    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
                    
                    local label = Instance.new("TextLabel", frame)
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.Text = "🚗 Teleported to your car!"
                    label.TextColor3 = Color3.new(1,1,1)
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 14
                    
                    task.spawn(function()
                        task.wait(2)
                        pcall(function() notification:Destroy() end)
                    end)
                    
                    print("🚗 TP to Own Car: Successfully teleported to", foundOwnCar.Name)
                else
                    -- TP yapamadı (root part yok)
                    TpToOwnCarButton.Text = "❌ TP Failed"
                    TweenService:Create(TpToOwnCarButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                    }):Play()
                    print("❌ TP to Own Car: Could not find root part for", foundOwnCar.Name)
                end
            else
                -- Kendi arabası bulunamadı
                TpToOwnCarButton.Text = "❌ No Car Found"
                TweenService:Create(TpToOwnCarButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                }):Play()
                
                print("❌ TP to Own Car: No owned vehicle found")
            end
            
            -- 3 saniye sonra butonu normal haline döndür
            task.wait(3)
            TpToOwnCarButton.Text = "🚗 TP to Own Car"
            TweenService:Create(TpToOwnCarButton, TweenInfo.new(0.5), {
                BackgroundColor3 = Color3.fromRGB(31, 24, 62)
            }):Play()
        end)
    end)

    -- İlk dropdown text güncelle
    _G.acne_updateDropdownText()
end	