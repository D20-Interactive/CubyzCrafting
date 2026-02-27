-- luacheck: globals core

print("This file will be run at load time!")

core.register_node("cubyz_crafting:workbench", {
    description = "Workbench to make tools",
    tiles = {
        "crafting_workbench_top.png",
        "crafting_workbench_bottom.png",
        "crafting_workbench_side.png",
        "crafting_workbench_front.png",
    },
    paramtype2 = "facedir",
    groups = {choppy = 1, workbench = 1},
    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string("infotext", "Workbench")
    end,
    on_rightclick = function(_, _, player, _, _)
        -- Open the crafting UI
        core.show_formspec(player:get_player_name(), "cubyz_crafting_workbench:form", 
            "size[8,8]" ..
            "label[1,1;Crafting Menu]" ..
            "button[1,5;2,1;craft;Craft]"
        )
    end,
})

-- Crafting recipe
core.register_craft({
    type = "shaped",
    output = "cubyz_crafting:workbench",
    recipe = {
        {"", "default:wood", ""},
        {"default:wood", "default:wood", "default:wood"},
        {"", "default:wood", ""},
    },
})

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "cubyz_crafting_workbench:form" then
        if fields.craft then
            local inv = player:get_inventory()
            if inv:contains_item("main", "default:wood 5") then
                inv:remove_item("main", "default:wood 5")
                inv:add_item("main", "cubyz_crafting:workbench")
                core.chat_send_player(player:get_player_name(), "Crafted 1 Workbench!")
            else
                core.chat_send_player(player:get_player_name(), "Not enough wood planks!")
            end
        end
    end
end)
