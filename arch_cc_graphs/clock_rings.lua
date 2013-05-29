--[[
Clock Rings by londonali1010 (2009), modified by anotherkamila <kamila@vesmir.sk>

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
		backwards = false
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
		end_angle = 300
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
		end_angle = 300
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
		backwards = true
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
		radius = 333,
		thickness = 10,
		start_angle = 45,
		end_angle = 135,
		backwards = true
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
		radius = 333,
		thickness = 10,
		start_angle = 225,
		end_angle = 315,
		backwards = false
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
		max  = 10e3,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 350,
		thickness = 15,
		start_angle = 30,
		end_angle = 150,
		backwards = true
	},
	{
		name = 'upspeedf',
		arg  = 'enp3s0',
		max  = 10e3,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 370,
		thickness = 15,
		start_angle = 30,
		end_angle = 150,
		backwards = true
	},
	{
		name = 'diskio_read',
		arg  = '',
		max  = 50e6,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 350,
		thickness = 15,
		start_angle = 210,
		end_angle = 330,
		backwards = false
	},
	{
		name = 'diskio_write',
		arg  = '',
		max  = 50e6,
		bg_colour = default_color,
		bg_alpha = 0.2,
		fg_colour = default_color,
		fg_alpha = default_alpha,
		x = default_center_x, y = default_center_y,
		radius = 370,
		thickness = 15,
		start_angle = 210,
		end_angle = 330,
		backwards = false
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

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height

	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring
	
	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring

	if pt['backwards'] then
		cairo_arc(cr,xc,yc,ring_r,angle_f-t_arc,angle_f)
	else
		cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	end
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
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
	local function setup_rings(cr,pt)
		local str=''
		local value=0

		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)

		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
		
		draw_ring(cr,pct,pt)
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
