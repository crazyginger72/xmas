
function grow_tree(data, a, pos)  
    local c_air = minetest.get_content_id("air")
    local c_ignore = minetest.get_content_id("ignore")
    local c_tree = minetest.get_content_id("default:tree")
    local c_leaves = minetest.get_content_id("xmas:leaves") 
    local c_star = minetest.get_content_id("xmas:star")   
    local x, y, z = pos.x, pos.y, pos.z
    for yy = y, y+18 do
        for twx = -1, 1 do
        for twz = -1, 1 do
            local vi = a:index(x+twx, yy, z+twz)
            if a:contains(x+twx, yy, z+twz) and (data[vi] == c_air or yy == y) then
                data[vi] = c_tree
            end
        end
        end
    end
    local vi = a:index(x, y+24, z)
    if a:contains(x, y+25, z) and (data[vi] == c_air or yy == y) then
        data[vi] = c_star
    end
    for yindex = 3, 24 do
    for xindex = -12, 12 do
    for zindex = -12, 12 do
        if a:contains(x+xindex, y+yindex, z+zindex) and math.abs(xindex) <= (23-yindex)/2 and math.abs(zindex) <= (23-yindex)/2 then
            local vi = a:index(x+xindex, y+yindex, z+zindex)
            if data[vi] == (c_air or c_ignore) and math.abs(xindex)+math.abs(zindex) <= (23-yindex)/1.25 then
                if math.random(100) <=100 then
                    if (math.abs(xindex) == (23-yindex)/2 or math.abs(zindex) == (23-yindex)/2) and math.random(1, 100) <=  16 and yindex < 21 then
                        local c_ball = minetest.get_content_id("xmas:ball_"..math.random(1,4)) 
                        data[vi] = c_ball
                    else
                        data[vi] = c_leaves
                    end
                end
            end
        end
    end
    end
    end
end

minetest.register_abm({
	nodenames = {"xmas:sapling"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.log("action", "A xmas tree grows @"..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-2, z=pos.z-16}, {x=pos.x+16, y=pos.y+26, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		grow_tree(data, a, pos)
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
	end
})

minetest.register_node("xmas:sapling", {
	description = "Xmas Tree Sapling",
	drawtype = "plantlike",
	visual_scale = 2,
	tiles = {"xmas_sapling.png"},
	inventory_image = "xmas_sapling.png",
	wield_image = "xmas_sapling.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.65, -0.80, -0.65, 0.65, 0.525, 0.65}
	},
	groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("xmas:leaves", {
    description = "Jungle Leaves",
    drawtype = "plantlike",
    visual_scale = 1.5,
    tiles = {"xmas_leaves.png"},
    paramtype = "light",
    waving = 1,
    buildable_to = true,
    walkable = false,
    climbable = true,
    is_ground_content = false,
    groups = {snappy=3,leafdecay=13,flammable=2,not_in_creative_inventory=1},
    drop = "",
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("xmas:ball_1", {
    description = "Xmas Ball Red",
    mesh = "ball.obj",
    drawtype = "mesh",
    tiles = {"wool_red.png"},
    paramtype = "light",
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,leafdecay=12},
    sounds = default.node_sound_wood_defaults(),
    node_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
    selection_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
})

minetest.register_node("xmas:ball_2", {
    description = "Xmas Ball Blue",
    mesh = "ball.obj",
    drawtype = "mesh",
    tiles = {"wool_blue.png"},
    paramtype = "light",
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,leafdecay=12},
    sounds = default.node_sound_wood_defaults(),
    node_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
    selection_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
})

minetest.register_node("xmas:ball_3", {
    description = "Xmas Ball Silver",
    mesh = "ball.obj",
    drawtype = "mesh",
    tiles = {"wool_grey.png"},
    paramtype = "light",
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,leafdecay=12},
    sounds = default.node_sound_wood_defaults(),
    node_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
    selection_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
})

minetest.register_node("xmas:ball_4", {
    description = "Xmas Ball Purple",
    mesh = "ball.obj",
    drawtype = "mesh",
    tiles = {"wool_violet.png"},
    paramtype = "light",
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,leafdecay=12},
    sounds = default.node_sound_wood_defaults(),
    node_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
    selection_box = {type = "fixed",fixed = {{-1.0, -1.0, -1.0, 1.0, 1.0, 1.0},},},
})

minetest.register_node("xmas:star", {
    description = "Xmas Star",
    drawtype = "plantlike",
    tiles = {"xmas_star.png"},
    paramtype = "light",
    drop = "xmas:sapling",
    light_source = 14,
    visual_scale = 5,
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,leafdecay=14},
    sounds = default.node_sound_wood_defaults(),
})