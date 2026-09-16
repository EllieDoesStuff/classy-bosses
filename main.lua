local mod = RegisterMod("classy-bosses", 1)

local MONSTRO_TYPE = 20
local MONSTRO_VARIANT = 0

local HAUNT_TYPE = 260
local HAUNT_VARIANT = 0

local DUKE_TYPE = 67
local DUKE_VARIANT = 0

local BLOAT_TYPE = 68
local BLOAT_VARIANT = 1

-- rookie ass elseif statements please ignore them </3

-- monstro
function mod:OnMonstroInit(npc)
    if npc.Variant == MONSTRO_VARIANT then
        local sprite = npc:GetSprite()
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_tophat.png")
            sprite:LoadGraphics()
        elseif math.random() < 0.1 then
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/monstro_pizza.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnMonstroInit, MONSTRO_TYPE)

-- haunt
function mod:OnHauntInit(npc)
    if npc.Variant == HAUNT_VARIANT then
        local sprite = npc:GetSprite()
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_tophat.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnHauntInit, HAUNT_TYPE)

-- duke
function mod:OnDukeInit(npc)
    if npc.Variant == DUKE_VARIANT then
        local sprite = npc:GetSprite()
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/dukeofflies_sunglasses.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnDukeInit, DUKE_TYPE)

-- bloat
function mod:OnBloatInit(npc)
    if npc.Variant == BLOAT_VARIANT then
        local sprite = npc:GetSprite()
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/classic/bloat_poo.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnBloatInit, BLOAT_TYPE)