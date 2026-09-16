local mod = RegisterMod("classy-bosses", 1)

local json = require("json")

local modData = {
    skinChance = 0.1,
    SkinMachineSpawnedThisRun = false
}

local function SaveGameData()
    mod:SaveData(json.encode(modData))
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, SaveGameData)
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, SaveGameData)

local MONSTRO_TYPE = 20
local MONSTRO_VARIANT = 0
local MONSTRO_SUBTYPE = 0
local MONSTRO_SUBTYPE1 = 1
local MONSTRO_SUBTYPE2 = 2

local HAUNT_TYPE = 260
local HAUNT_VARIANT = 0
local HAUNT_SUBTYPE = 0
local HAUNT_SUBTYPE1 = 1
local HAUNT_SUBTYPE2 = 2

local DUKE_TYPE = 67
local DUKE_VARIANT = 0
local DUKE_SUBTYPE = 0
local DUKE_SUBTYPE1 = 1
local DUKE_SUBTYPE2 = 2

local BLOAT_TYPE = 68
local BLOAT_VARIANT = 1
local BLOAT_SUBTYPE = 0
local BLOAT_SUBTYPE1 = 1



local SKIN_MACHINE_ID = 6
local SKIN_MACHINE_VARIANT = 2096

local sfx = SFXManager()

local SOUND_SPIN = Isaac.GetSoundIdByName("Spin")

local skinChance = 0.1
local displayText = ""
local textDisplayTimer = 0

local myFont = Font()
myFont:Load("font/teammeatfont16.fnt")

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, isContinued)
    if isContinued and mod:HasData() then
        local loadedData = json.decode(mod:LoadData())
        if loadedData then
            modData.skinChance = loadedData.skinChance or 0.1
            modData.SkinMachineSpawnedThisRun = loadedData.SkinMachineSpawnedThisRun or false
        end
    else
        modData.SkinMachineSpawnedThisRun = false
    end
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    local game = Game()
    local level = game:GetLevel()
    local roomIndex = level:GetCurrentRoomIndex()

    if level:GetStage() == LevelStage.STAGE1_1 and roomIndex == 84 then
        local player = Isaac.GetPlayer(0)
        local playerData = player:GetData()
        
        if playerData.SkinMachineSpawnedThisRun then return end
        
        playerData.SkinMachineSpawnedThisRun = true
        
        local activeMachines = Isaac.FindByType(SKIN_MACHINE_ID, SKIN_MACHINE_VARIANT)
        if #activeMachines == 0 then
            Isaac.Spawn(SKIN_MACHINE_ID, SKIN_MACHINE_VARIANT, 0, Vector(180, 160), Vector.Zero, nil)
        end
    end
end)

mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, function(_, player, collider, low)
    if collider.Type == SKIN_MACHINE_ID and collider.Variant == SKIN_MACHINE_VARIANT then
        local sprite = collider:GetSprite()
        local data = collider:GetData()
        local game = Game()

        if not data.TouchCooldown or game:GetFrameCount() >= data.TouchCooldown then --
            data.TouchCooldown = game:GetFrameCount() + 30  --
            
            sprite:Play("Spin", true)
            sfx:Play(SOUND_SPIN, 10)
            
            modData.skinChance = math.floor((modData.skinChance + 0.1) * 10 + 0.5) / 10
            
            if modData.skinChance > 1.0 then
                modData.skinChance = 0.0
            end
            
            displayText = "Variant Chance Changed To: " .. tostring(modData.skinChance * 100) .. "%"
            textDisplayTimer = 60
        end

        return false
    end
end)


mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function(_)
    local bombs = Isaac.FindByType(EntityType.ENTITY_BOMBDROP)
    local machines = Isaac.FindByType(SKIN_MACHINE_ID, SKIN_MACHINE_VARIANT)

    for _, bomb in ipairs(bombs) do
        if bomb:ToBomb() and bomb.FrameCount >= 0 then
            for _, machine in ipairs(machines) do
                local distance = bomb.Position:Distance(machine.Position)
                
                if distance < 90 then
                    bomb.Kill(bomb)
                end
            end
        end
    end

    local machines = Isaac.FindByType(SKIN_MACHINE_ID, SKIN_MACHINE_VARIANT)
    for _, machine in ipairs(machines) do
        local sprite = machine:GetSprite()
        
        if sprite:IsFinished("Spin") then
            sprite:Play("Idle", true)
        end
    end
    if textDisplayTimer > 0 then
        textDisplayTimer = textDisplayTimer - 1
    end
end)

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
    if textDisplayTimer > 0 then
        local screenW = Isaac.GetScreenWidth()
        local screenH = Isaac.GetScreenHeight()
        
        local renderX = screenW / 2.8
        local renderY = screenH * 0.6
        
        myFont:DrawStringScaled(displayText, renderX, renderY, 0.4, 0.4, KColor(1,1,1,1), 0, true)
    end
end)


-- rookie ass elseif statements please ignore them </3

-- monstro
function mod:OnMonstroInit(npc)
    local sprite = npc:GetSprite()
    
    if math.random() < modData.skinChance then
        local rollVariant = math.random(1, 2)
        
        if npc.Variant == MONSTRO_VARIANT and npc.SubType == MONSTRO_SUBTYPE then
            if rollVariant == 1 then
                sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_tophat.png")
            else
                sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_pizza.png")
            end
            sprite:LoadGraphics()
            
        elseif npc.Variant == MONSTRO_VARIANT and npc.SubType == MONSTRO_SUBTYPE1 then
            if rollVariant == 1 then
                sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_red_tophat.png")
            else
                sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_red_pizza.png")
            end
            sprite:LoadGraphics()
            
        elseif npc.Variant == MONSTRO_VARIANT and npc.SubType == MONSTRO_SUBTYPE2 then
            if rollVariant == 1 then
                sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_black_tophat.png")
            else
                sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_black_pizza.png")
            end
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnMonstroInit, MONSTRO_TYPE)

-- haunt
function mod:OnHauntInit(npc)
    local sprite = npc:GetSprite()
    if npc.Variant == HAUNT_VARIANT and npc.SubType == HAUNT_SUBTYPE then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_tophat.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == HAUNT_VARIANT and npc.SubType == HAUNT_SUBTYPE1 then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_black_tophat.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == HAUNT_VARIANT and npc.SubType == HAUNT_SUBTYPE2 then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_pink_tophat.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnHauntInit, HAUNT_TYPE)

-- duke
function mod:OnDukeInit(npc)
    local sprite = npc:GetSprite()
    if npc.Variant == DUKE_VARIANT and npc.SubType == DUKE_SUBTYPE then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/dukeofflies_sunglasses.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == DUKE_VARIANT and npc.SubType == DUKE_SUBTYPE1 then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/dukeofflies_green_sunglasses.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == DUKE_VARIANT and npc.SubType == DUKE_SUBTYPE2 then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/dukeofflies_orange_sunglasses.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnDukeInit, DUKE_TYPE)

-- bloat
function mod:OnBloatInit(npc)
    local sprite = npc:GetSprite()
    if npc.Variant == BLOAT_VARIANT and npc.SubType == BLOAT_SUBTYPE then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/bloat_poo.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == BLOAT_VARIANT and npc.SubType == BLOAT_SUBTYPE1 then
        if math.random() < modData.skinChance then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/bloat_green_poo.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnBloatInit, BLOAT_TYPE)