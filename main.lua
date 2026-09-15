local mod = RegisterMod("classy-bosses", 1)

local MONSTRO_TYPE = 20
local MONSTRO_VARIANT = 0

local HAUNT_TYPE = 260
local HAUNT_VARIANT = 0

function mod:OnMonstroInit(npc)
    if npc.Variant == MONSTRO_VARIANT then
        local sprite = npc:GetSprite()
        -- rookie ass elseif statements please ignore them </3
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

function mod:OnHauntInit(npc)
    if npc.Variant == HAUNT_VARIANT then
        local sprite = npc:GetSprite()
        -- rookie ass elseif statements please ignore them </3
        if math.random() < 0.1 then
            
            sprite:ReplaceSpritesheet(0, "gfx/bosses/rebirth/haunt_tophat.png")
            sprite:LoadGraphics()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.OnHauntInit, HAUNT_TYPE)