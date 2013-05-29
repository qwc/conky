--[[
Clock Rings by londonali1010 (2009), modified by anotherkamila <kamila@vesmir.sk>
and heavily modified by qwc <otte.mm@googlemail.com>

This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement near the end of the script uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/clock_rings-v1.1.1.lua
	lua_draw_hook_pre clock_rings

Changelog:
+ v1.1.1 -- Fixed minor bug that caused the script to crash if conky_parse() returns a nil value (20.20.2009)
+ v1.1 -- Added colour option for clock hands (07.10.2009)
+ v1.0 -- Original release (30.09.2009)
]]
default_ellipse_xscale = 1.1
default_ellipse_yscale = 0.6
default_color = 0x050c0e
default_alpha = 0.35
default_center_x = 500*(1/default_ellipse_xscale)
default_center_y = 500*(1/default_ellipse_yscale)


settings_table = {
	{
		name = 'cpu',
		arg = 'cpu1',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 318,
		thickness = 5,
		start_angle = 240,
		end_angle = 300,
		from_middle = true,
		backwards = false,
		title = '',
		draw_gauge_min = false,
		draw_gauge_max = false,
		draw_gauge_length = 20
	},
	{
		name = 'cpu',
		arg = 'cpu2',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 312,
		thickness = 5,
		start_angle = 240,
		end_angle = 300,
		from_middle = true
	},
	{
		name = 'cpu',
		arg = 'cpu3',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 306,
		thickness = 5,
		start_angle = 240,
		end_angle = 300,
		from_middle = true,
		backwards = false
	},
	{
		name = 'cpu',
		arg = 'cpu4',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 300,
		thickness = 5,
		start_angle = 240,
		end_angle = 300,
		from_middle = true,
		title = '',
		draw_gauge_min = false,
		draw_gauge_max = true,
		draw_gauge_length = 50
	},
	{
		name = 'cpu',
		arg = 'cpu5',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 300,
		thickness = 5,
		start_angle = 60,
		end_angle = 120,
		from_middle = true,
		backwards = true,
		title = '',
		draw_gauge_min = false,
		draw_gauge_max = true,
		draw_gauge_length = 50
	},
	{
		name = 'cpu',
		arg = 'cpu6',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 306,
		thickness = 5,
		start_angle = 60,
		end_angle = 120,
		from_middle = true,
		backwards = true
	},
	{
		name = 'cpu',
		arg = 'cpu7',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 312,
		thickness = 5,
		start_angle = 60,
		end_angle = 120,
		from_middle = true,
		backwards = true
	},
	{
		name = 'cpu',
		arg = 'cpu8',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 318,
		thickness = 5,
		start_angle = 60,
		end_angle = 120,
		from_middle = true,
		backwards = true
	},
	{
		name = 'memperc',
		arg = '',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 328,
		thickness = 10,
		start_angle = 45,
		end_angle = 135,
		from_middle = true,
		backwards = true,
		title = '',
		draw_gauge_min = false,
		draw_gauge_max = true,
		draw_gauge_length = 50
	},
	{
		name = 'swapperc',
		arg = '',
		max = 100,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 328,
		thickness = 10,
		start_angle = 225,
		end_angle = 315,
		from_middle = true,
		backwards = false,
		title = '',
		draw_gauge_min = false,
		draw_gauge_max = true,
		draw_gauge_length = 50
	},
	--[[{
		name = 'exec',
		arg = 'cat /sys/class/power_supply/BAT0/power_now',
		max = 30e6,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 52,
		thickness = 5,
		start_angle = 242,
		end_angle = 359
	},
	{
		name = 'exec',
		arg  = '~/bin/next_deadline_in.sh',
		max  = 30,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 59,
		thickness = 3,
		start_angle = 1,
		end_angle = 359
	},]]
	{
		name = 'downspeedf',
		arg  = 'enp3s0',
		max  = 120e3,
		unit = 'kB/s',
		max_dynamic = true,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 343,
		thickness = 15,
		start_angle = 30,
		end_angle = 150,
		from_middle = true,
		backwards = true,
		title = '',
		draw_gauge_txt = true,
		draw_gauge_min = false,
		draw_gauge_max = true,
		draw_gauge_length = 50
	},
	{
		name = 'upspeedf',
		arg  = 'enp3s0',
		max  = 120e3,
		unit = 'kB/s',
		max_dynamic = true,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 360,
		thickness = 15,
		start_angle = 30,
		end_angle = 150,
		from_middle = true,
		backwards = true,
		title = '',
		draw_gauge_txt = true,
		draw_gauge_min = false,
		draw_gauge_max = false,
		draw_gauge_length = 50
	},
	{
		name = 'diskio_read',
		arg  = '',
		max  = 200e6,
		unit = 'B/s',
		logscale = false,
		max_dynamic = true,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 343,
		thickness = 15,
		start_angle = 210,
		end_angle = 330,
		from_middle = true,
		backwards = false,
		title = '',
		draw_gauge_txt = true,
		draw_gauge_min = false,
		draw_gauge_max = true,
		draw_gauge_length = 50
	},
	{
		name = 'diskio_write',
		arg  = '',
		max  = 200e6,
		unit = 'B/s',
		logscale = false,
		max_dynamic = true,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 360,
		thickness = 15,
		start_angle = 210,
		end_angle = 330,
		from_middle = true,
		backwards = false,
		title = '',
		draw_gauge_txt = true,
		draw_gauge_min = false,
		draw_gauge_max = false,
		draw_gauge_length = 50
	}
	-- {
	-- 	name = 'diskio_read',
	-- 	arg  = '/dev/sda',
	-- 	max  = 300
	-- }
}


-- Use these settings to define the origin and extent of your clock.

clock_r = 500
clock_inner_space = 0.8
clock_gauges_num = 12
clock_x = default_center_x
clock_y = default_center_y

-- Colour & alpha of the clock hands

clock_color = default_color
clock_alpha = default_alpha

local cairo = require 'cairo'
local CAIRO = cairo

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
function ring_get_coordinates(value,setting,radius)
	if radius == nil then
		radius = setting["radius"]
	end
	local coordinates = {}
	coordinates["startarc"] = setting['start_angle']*(2*math.pi/360)
	coordinates["endarc"] = setting['end_angle']*(2*math.pi/360)
	coordinates["startx"] = clock_x + radius* math.sin(coordinates["startarc"])
	coordinates["starty"] = clock_y - radius* math.cos(coordinates["startarc"])
	coordinates["endx"] = clock_x + radius* math.sin(coordinates["endarc"])
	coordinates["endy"] = clock_y - radius* math.cos(coordinates["endarc"])
	coordinates["middle"] = coordinates["endarc"] - (coordinates["endarc"] - coordinates["startarc"])/2.0
	coordinates["valuearc"] = value*(coordinates["endarc"] - coordinates["startarc"])
	coordinates["vsx"] = clock_x + radius* math.sin(coordinates["middle"] - coordinates["valuearc"]/2.0)
	coordinates["vsy"] = clock_y - radius* math.sin(coordinates["middle"] - coordinates["valuearc"]/2.0)
	coordinates["vex"] = clock_x + radius* math.sin(coordinates["middle"] + coordinates["valuearc"]/2.0)
	coordinates["vey"] = clock_y - radius* math.sin(coordinates["middle"] + coordinates["valuearc"]/2.0)
	return coordinates
end
function get_arc_xy(r,arc)
	local ret = {}
	ret["x"] = clock_x + r*math.sin(arc)
	ret["y"] =clock_y - r*math.cos(arc)
	return ret
end


function draw_ring2(cr, percent, setting, value)
	local function draw_gauge(cr,setting)
		cairo_set_line_width(cr, 1)
		local max_x_i = clock_x + (setting['radius'] - setting['draw_gauge_length']) * math.sin(setting['start_angle']*(2*math.pi/360))
		local max_y_i = clock_y - (setting['radius'] - setting['draw_gauge_length']) * math.cos(setting['start_angle']*(2*math.pi/360))
		local max_x_o = clock_x + setting['radius'] * math.sin(setting['start_angle']*(2*math.pi/360))
		local max_y_o = clock_y - setting['radius'] * math.cos(setting['start_angle']*(2*math.pi/360))
		local pat = cairo_pattern_create_linear(max_x_o,max_y_o,max_x_i,max_y_i)
        cairo_pattern_add_color_stop_rgba(pat, 0, rgb_to_r_g_b(default_color,default_alpha))
        cairo_pattern_add_color_stop_rgba(pat, 1, rgb_to_r_g_b(default_color,0))

        cairo_set_source(cr,pat)

		cairo_move_to(cr, max_x_i,max_y_i)
		cairo_line_to(cr, max_x_o,max_y_o)
		cairo_stroke(cr)
		
		if setting['from_middle'] then
			cairo_set_line_width(cr, 1)
			local max_x_i2 = clock_x + (setting['radius'] - setting['draw_gauge_length']) * math.sin(setting['end_angle']*(2*math.pi/360))
			local max_y_i2 = clock_y - (setting['radius'] - setting['draw_gauge_length']) * math.cos(setting['end_angle']*(2*math.pi/360))
			local max_x_o2 = clock_x + setting['radius'] * math.sin(setting['end_angle']*(2*math.pi/360))
			local max_y_o2 = clock_y - setting['radius'] * math.cos(setting['end_angle']*(2*math.pi/360))
			local pat2 = cairo_pattern_create_linear(max_x_o2,max_y_o2,max_x_i2,max_y_i2)
			cairo_pattern_add_color_stop_rgba(pat2, 0, rgb_to_r_g_b(default_color,default_alpha))
			cairo_pattern_add_color_stop_rgba(pat2, 1, rgb_to_r_g_b(default_color,0))
			cairo_set_source(cr,pat2)
			cairo_move_to(cr, max_x_i2,max_y_i2)
			cairo_line_to(cr, max_x_o2,max_y_o2)
			cairo_stroke(cr)
		end
		cairo_stroke(cr)
		
	end
	local function find_dyn_max(value)
		local max = 0
		local i = 1
		while i <= setting["max"] do
			if i > value then 
				max = i 
				break 
			end
			i=i*10
		end
		if i >= setting["max"] then 
			max = setting["max"]
		end
		if i < 1000 then
			max = 1000
		end
		--print("blah")
		local divide = 1
		local byte = ""
		if max >= 1000000 then
			divide = 1000000
			byte = "M"
		else
			if max > 1000 and max < 1000000 then
				divide = 1000
				byte = "k"
			end
		end
		return max,divide,byte
	end
	local w,h=conky_window.width,conky_window.height
	local xc,yc,ring_r,ring_w,sa,ea=setting['x'],setting['y'],setting['radius'],setting['thickness'],setting['start_angle'],setting['end_angle']
	local bgc, bga, fgc, fga=setting['bg_colour'], setting['bg_alpha'], setting['fg_colour'], setting['fg_alpha']

	if setting["logscale"] then
		percent = (math.log(value)-math.log(1))/(math.log(setting["max"])-math.log(1))
	end
	if setting["max_dynamic"] then
		local m = find_dyn_max(value)
		percent = value/m
	end
	
	if percent <= 0.00001*ring_r then
		percent = 0.00001*ring_r
	end
	
	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=percent*(angle_f-angle_0)
	
	-- Draw background ring
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	-- Draw title and gauges
	if setting['draw_gauge_max'] then
		draw_gauge(cr,setting)
	end
	if setting['draw_gauge_txt'] then
		local function draw_gauge_text (cr,setting)
			cairo_set_source_rgba(cr,rgb_to_r_g_b(0x000000,0.5))
			local co = ring_get_coordinates(percent,setting,setting["radius"]-5)
			cairo_select_font_face(cr,"Helvetica",0,0)
			cairo_set_font_size(cr,12)
			cairo_save(cr)
			local arc = 0
			if co["startarc"] > math.pi then
				local xy = get_arc_xy(setting["radius"]-5,co["endarc"] - 8*(2*math.pi/360))
				cairo_move_to(cr, xy["x"],xy["y"])
				arc = co["endarc"] - 3*(2*math.pi/360)
			else
				cairo_move_to(cr,co["startx"] ,co["starty"] )
				arc = co["startarc"]+2*(2*math.pi/360)
			end
			cairo_rotate(cr,arc)
			local max, divide, byte = find_dyn_max(value)
			local unit = setting["unit"]
			if unit == "kB/s" then
				unit = "B/s"
				if byte == "" then
					byte = "k"
				else 
					if byte == "k" then
						byte = "M"
					end
				end
			end
			cairo_show_text(cr,string.format("%.0f %s%s",value/divide, byte, unit))
			cairo_restore(cr)
			cairo_stroke(cr)
		end
		draw_gauge_text(cr,setting)
	end
	
	-- Draw indicator ring
	cairo_set_line_width(cr,ring_w)
	if setting['from_middle'] then
		local middle=angle_f-((angle_f-angle_0)/2.0)
		local angle_m0=middle-t_arc/2.0
		local angle_mf=middle+t_arc/2.0
		cairo_arc(cr,xc,yc,ring_r,angle_m0,angle_mf)
	else
		if setting['backwards'] then
			cairo_arc(cr,xc,yc,ring_r,angle_f-t_arc,angle_f)
		else
			cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
		end
	end
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
end

function draw_graph(cr, currentvalue, setting)
	
end



function draw_clock_hands(cr,xc,yc)
	local mins,hours,secs_arc,mins_arc,hours_arc
	local xh,yh,xm,ym,xs,ys

	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)

	mins  = os.date("%M")
	hours = os.date("%I")

	mins_arc  = (2*math.pi/60)*mins
	hours_arc = (2*math.pi/12)*hours+mins_arc/12

	-- Draw hour hand

	xh_o = xc+0.9*clock_r*math.sin(hours_arc)
	yh_o = yc-0.9*clock_r*math.cos(hours_arc)
	xh_i = xc+clock_inner_space*clock_r*math.sin(hours_arc)
	yh_i = yc-clock_inner_space*clock_r*math.cos(hours_arc)

	local hpat = cairo_pattern_create_linear(xh_i,yh_i,xh_o,yh_o)
    cairo_pattern_add_color_stop_rgba(hpat, 0, rgb_to_r_g_b(default_color,default_alpha))
    cairo_pattern_add_color_stop_rgba(hpat, 1, rgb_to_r_g_b(default_color,0))
    cairo_set_source(cr,hpat)
	
	cairo_move_to(cr,xh_i,yh_i)
	cairo_line_to(cr,xh_o,yh_o)

	cairo_set_line_width(cr,10)
	cairo_stroke(cr)

	-- Draw minute hand

	xm_o = xc+1*clock_r*math.sin(mins_arc)
	ym_o = yc-1*clock_r*math.cos(mins_arc)
	xm_i = xc+clock_inner_space*clock_r*math.sin(mins_arc)
	ym_i = yc-clock_inner_space*clock_r*math.cos(mins_arc)

	local mpat = cairo_pattern_create_linear(xm_i,ym_i,xm_o,ym_o)
    cairo_pattern_add_color_stop_rgba(mpat, 0, rgb_to_r_g_b(default_color,default_alpha))
    cairo_pattern_add_color_stop_rgba(mpat, 1, rgb_to_r_g_b(default_color,0))
    cairo_set_source(cr,mpat)
	
	cairo_move_to(cr,xm_i,ym_i)
	cairo_line_to(cr,xm_o,ym_o)

	cairo_set_line_width(cr,5)
	cairo_stroke(cr)
end

function draw_clock_gauges(cr, xc, yc)
	local step = 2*math.pi/clock_gauges_num;
	local innerMin = 0.77
	local innerMax = 0.77
	local outerMin = 1.0
	local outerMax = 1.0
	

	cairo_set_line_width(cr, 1)
	
	for i = 0, clock_gauges_num-1 do
		local gx_i = xc + ((i%2 == 0) and innerMax or innerMin)*clock_r*math.sin(i*step)
		local gy_i = yc - ((i%2 == 0) and innerMax or innerMin)*clock_r*math.cos(i*step)
		local gx_o = xc + ((i%2 == 0) and outerMax or outerMin)*clock_r*math.sin(i*step)
		local gy_o = yc - ((i%2 == 0) and outerMax or outerMin)*clock_r*math.cos(i*step)

		local pat = cairo_pattern_create_linear(gx_i,gy_i,gx_o,gy_o)
        cairo_pattern_add_color_stop_rgba(pat, 0, rgb_to_r_g_b(default_color,default_alpha))
        cairo_pattern_add_color_stop_rgba(pat, 1, rgb_to_r_g_b(default_color,0))

        cairo_set_source(cr,pat)

		cairo_move_to(cr, gx_i,gy_i)
		cairo_line_to(cr, gx_o,gy_o)

		cairo_stroke(cr)
	end
end

function conky_clock_rings()
	local function setup_rings(cr,setting)
		local str=''
		local value=0

		str=string.format('${%s %s}',setting['name'],setting['arg'])
		str=conky_parse(str)

		value=tonumber(str)
		if value == nil then value = 0 end
		percent=value/setting['max']
		
		draw_ring2(cr,percent,setting,value)
	end

	-- Check that Conky has been running for at least 5s

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

	local cr=cairo_create(cs)	

	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	cairo_scale(cr,default_ellipse_xscale,default_ellipse_yscale)
	if update_num > 2 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end

	draw_clock_hands(cr,clock_x,clock_y)
	draw_clock_gauges(cr, clock_x, clock_y)
end
