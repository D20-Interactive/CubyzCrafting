minetest.register_on_joinplayer(function(player)
    local chiga = player:get_player_name()
    minetest.chat_send_all(string.format("This chiga entered: %s", chiga))
end)

local function get_player_data( data )
	local pos = data:get_pos()

	return string.format(
        "Player: %s | HP: %d | Position: %d,%d,%d",
        data:get_player_name(),
        data:get_hp(),
        pos.x, pos.y, pos.z
	)
end

minetest.register_chatcommand("find_chiga", {
    privs = { interact = true },

    func = function( name, param )
        local player = minetest.get_player_by_name(param)
        minetest.chat_send_all(param)
        if not player then
            return false, "The chiga is absent"
        end
        return true, get_player_data(player)
    end

})

--local modpath = minetest.get_modpath(minetest.get_current_modname())

--dofile(modpath .. "/items.lua")
