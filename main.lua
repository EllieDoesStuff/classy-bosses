local mod = RegisterMod("classy-bosses", 1)

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

-- rookie ass elseif statements please ignore them </3

-- monstro
function mod:OnMonstroInit(npc)
    local sprite = npc:GetSprite()
    if npc.Variant == MONSTRO_VARIANT and npc.SubType == MONSTRO_SUBTYPE then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_tophat.png")
            sprite:LoadGraphics()
        elseif math.random() < 0.1 then
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_pizza.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == MONSTRO_VARIANT and npc.SubType == MONSTRO_SUBTYPE1 then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_red_tophat.png")
            sprite:LoadGraphics()
        elseif math.random() < 0.1 then
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_red_pizza.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == MONSTRO_VARIANT and npc.SubType == MONSTRO_SUBTYPE2 then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_black_tophat.png")
            sprite:LoadGraphics()
        elseif math.random() < 0.1 then
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_black_pizza.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnMonstroInit, MONSTRO_TYPE)

-- haunt
function mod:OnHauntInit(npc)
    local sprite = npc:GetSprite()
    if npc.Variant == HAUNT_VARIANT and npc.SubType == HAUNT_SUBTYPE then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_tophat.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == HAUNT_VARIANT and npc.SubType == HAUNT_SUBTYPE1 then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_black_tophat.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == HAUNT_VARIANT and npc.SubType == HAUNT_SUBTYPE2 then
        if math.random() < 0.1 then
            
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
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/dukeofflies_sunglasses.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == DUKE_VARIANT and npc.SubType == DUKE_SUBTYPE1 then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/dukeofflies_green_sunglasses.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == DUKE_VARIANT and npc.SubType == DUKE_SUBTYPE2 then
        if math.random() < 0.1 then
            
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
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/bloat_poo.png")
            sprite:LoadGraphics()
        end
    elseif npc.Variant == BLOAT_VARIANT and npc.SubType == BLOAT_SUBTYPE1 then
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/bloat_green_poo.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnBloatInit, BLOAT_TYPE)