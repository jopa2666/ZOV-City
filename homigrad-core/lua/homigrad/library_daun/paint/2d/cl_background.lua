-- "addons\\homigrad_core\\lua\\shlib\\tier_0\\paint\\2d\\cl_background.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local constructManual = {
    "brick",
	"brick_i",
	"brick_d",
	"brick_d_i",

	"candies",
	"candies_i",
	"candies_s",
	"candies_s_i",

	"lines_h",
	"lines_h_i",
	"lines_v",
	"lines_v_i",

	"lines_d_l",
	"lines_d_l_i",
	"lines_d_r",
	"lines_d_r_i",

	"lines_dashed_d_l",
	"lines_dashed_d_l_i",
	"lines_dashed_d_r",
	"lines_dashed_d_r_i",

	"lines_dashed_h",
	"lines_dashed_h_i",
	"lines_dashed_v",
	"lines_dashed_v_i",

	"lines_dense_h",
	"lines_dense_v",

	"lines_dense_d_l",
	"lines_dense_d_l_i",
	"lines_dense_d_r",
	"lines_dense_d_r_i",

	"lines_easy_h",
	"lines_easy_h_i",
	"lines_easy_v",
	"lines_easy_v_i",

	"lines_easy_d_l",
	"lines_easy_d_r",

	"lines_slender_h",
	"lines_slender_v",

	"box_points",
	"box_points_i",
	"box",
	"box_i",
	"box_s",
	"box_s_i",

	"pletanka",
	"pletanka_i",

	"romb",
	"romb_i",

	"romb_points",
	"romb_points_i",

	"romb_d",
	"romb_d_i",

	"shotlandka",
	"shotlandka_i",

	"spalera",
	"spalera_i",

	"points5",
	"points10",
	"points20",
	"points25",
	"points30",
	"points40",
	"points50",
	"points60",
	"points70",
	"points75",
	"points80",
	"points90",

	"sphere",
	"sphere_i",

	"wave",
	"wave_i",

	"zigzag",
	"zigzag_i"
}--сука здохни 79 обоев я в ахуе

local SetMaterial = surface.SetMaterial
local DrawTexturedRectUV = surface.DrawTexturedRectUV

local pngParametrs = "mips noclamp"

local materials = {}

for i,name in pairs(constructManual) do
	materials[name] = Material("homigrad/vgui/bg/" .. name .. ".png",pngParametrs)
end

materials.whitenoise = Material("homigrad/vgui/whitenoise.png",pngParametrs)

function surface.SetBG(name)
    SetMaterial(materials[name])
end

function draw.BG(x,y,w,h)
	DrawTexturedRectUV(x,y,w,h,0,0,w / 16,h / 16)
end

function draw.BG2(x,y,w,h)
	DrawTexturedRectUV(x,y,w,h,0,0,w / 32,h / 32)
end

function draw.BG05(x,y,w,h)
	DrawTexturedRectUV(x,y,w,h,0,0,w / 8,h / 8)
end

function draw.BG512(x,y,w,h)
	DrawTexturedRectUV(x,y,w,h,0,0,w / 512,h / 51)
end

function draw.BGScale(x,y,w,h,scale)
	DrawTexturedRectUV(x,y,w,h,0,0,w / scale,h / scale)
end

function draw.BGEx(x,y,w,h,sx,sy,scale)
	scale = 4096 * scale

	sx = sx and sx / 4096 or 0
	sy = sy and sy / 4096 or 0

	DrawTexturedRectUV(x,y,w,h,sx,sy,w / scale + sx,h / scale + sy)
end

/*local size = 64

hook.Add("HUDPaint","дубинапрям",function()
	surface.SetDrawColor(255,255,255,255)
	
	local x,y = 0,0
	for i,name in pairs(constructManual) do
		x = x + 1

		if size * x > ScrW() then
			x = 0
			y = y + 1
		end

		surface.SetBG(name)
		draw.BGScale(size * x,size * y,size,size,size)
	end
end)*/