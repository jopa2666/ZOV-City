hg.bone = hg.bone or {}

local tbl = {
	["head"] = "ValveBiped.Bip01_Head1",
	["spine"] = "ValveBiped.Bip01_Spine",
	["spine1"] = "ValveBiped.Bip01_Spine1",
	["spine2"] = "ValveBiped.Bip01_Spine2",
	["spine4"] = "ValveBiped.Bip01_Spine4",
	["r_clavicle"] = "ValveBiped.Bip01_R_Clavicle",
	["r_upperarm"] = "ValveBiped.Bip01_R_UpperArm",
	["r_forearm"] = "ValveBiped.Bip01_R_Forearm",
	["r_hand"] = "ValveBiped.Bip01_R_Hand",
	["l_clavicle"] = "ValveBiped.Bip01_L_Clavicle",
	["l_upperarm"] = "ValveBiped.Bip01_L_UpperArm",
	["l_forearm"] = "ValveBiped.Bip01_L_Forearm",
	["l_hand"] = "ValveBiped.Bip01_L_Hand",

	["r_thigh"] = "ValveBiped.Bip01_R_Thigh",
	["r_calf"] = "ValveBiped.Bip01_R_Calf",
	["r_foot"] = "ValveBiped.Bip01_R_Foot",
	["r_toe"] = "ValveBiped.Bip01_R_Toe0",

	["l_thigh"] = "ValveBiped.Bip01_L_Thigh",
	["l_calf"] = "ValveBiped.Bip01_L_Calf",
	["l_foot"] = "ValveBiped.Bip01_L_Foot",
	["l_toe"] = "ValveBiped.Bip01_L_Toe0",
	
	["r_finger0"] = "ValveBiped.Bip01_R_Finger0",
	["r_finger01"] = "ValveBiped.Bip01_R_Finger01",
	["r_finger1"] = "ValveBiped.Bip01_R_Finger1",
	["r_finger11"] = "ValveBiped.Bip01_R_Finger11",
	["r_finger12"] = "ValveBiped.Bip01_R_Finger12",
	["r_finger2"] = "ValveBiped.Bip01_R_Finger2",
	["r_finger21"] = "ValveBiped.Bip01_R_Finger21",
	["l_finger0"] = "ValveBiped.Bip01_L_Finger0",
	["l_finger01"] = "ValveBiped.Bip01_L_Finger01",
	["l_finger01"] = "ValveBiped.Bip01_L_Finger01",
	["l_finger02"] = "ValveBiped.Bip01_L_Finger02",
	["l_finger1"] = "ValveBiped.Bip01_L_Finger1",
	["l_finger11"] = "ValveBiped.Bip01_L_Finger11",
	["l_finger2"] = "ValveBiped.Bip01_L_Finger2",
	["l_finger21"] = "ValveBiped.Bip01_L_Finger21",
	["l_finger3"] = "ValveBiped.Bip01_L_Finger3",
	["l_finger31"] = "ValveBiped.Bip01_L_Finger31",
	["l_finger4"] = "ValveBiped.Bip01_L_Finger4",
	["l_finger41"] = "ValveBiped.Bip01_L_Finger41",
}

hg.bone.client_only = {
	["r_finger0"] = "ValveBiped.Bip01_R_Finger0",
	["r_finger1"] = "ValveBiped.Bip01_R_Finger1",
	["r_finger11"] = "ValveBiped.Bip01_R_Finger11",
	["r_finger12"] = "ValveBiped.Bip01_R_Finger12",
	["r_finger2"] = "ValveBiped.Bip01_R_Finger2",
	["r_finger21"] = "ValveBiped.Bip01_R_Finger21",
	["l_finger0"] = "ValveBiped.Bip01_L_Finger0",
	["l_finger01"] = "ValveBiped.Bip01_L_Finger01",
	["l_finger02"] = "ValveBiped.Bip01_L_Finger02",
	["l_finger1"] = "ValveBiped.Bip01_L_Finger1",
	["l_finger11"] = "ValveBiped.Bip01_L_Finger11",
	["l_finger2"] = "ValveBiped.Bip01_L_Finger2",
	["l_finger21"] = "ValveBiped.Bip01_L_Finger21",
	["l_finger3"] = "ValveBiped.Bip01_L_Finger3",
	["l_finger31"] = "ValveBiped.Bip01_L_Finger31",
	["l_finger4"] = "ValveBiped.Bip01_L_Finger4",
	["l_finger41"] = "ValveBiped.Bip01_L_Finger41",
}

local PLAYER = FindMetaTable("Player")

function PLAYER:MBPosition(bone, pos)
	--if self:GetManipulateBonePosition(bone):IsEqualTol(pos, 0.01) then return end

	timer.Simple(0, function()
		self:ManipulateBonePosition(bone, pos)
	end)
end

function PLAYER:MBAngles(bone, ang)
	--if self:GetManipulateBoneAngles(bone):IsEqualTol(ang, 0.01) then return end

	timer.Simple(0, function()
		self:ManipulateBoneAngles(bone, ang)
	end)
end

hg.bone.matrixManual_Name = tbl

local matrix, matrixSet

local vecZero, angZero, vecFull = Vector(0, 0, 0), Angle(0, 0, 0), Vector(1, 1, 1)
local layer, name, boneName, boneID

local function reset(ply)
	ply.manipulated = ply.manipulated or {}
	ply.unmanipulated = {}
	ply.manipulate = {}
	ply.matrixes = {}
	
	for bone = 0, ply:GetBoneCount() do
		ply:ManipulateBonePosition(bone, vecZero, true)
		ply:ManipulateBoneAngles(bone, angZero, true)
		ply:ManipulateBoneScale(bone, vecFull, true)
	end
	
	ply.manipulated = {}
end

local function createLayer(ply, layer, lookup_name)
	boneName = hg.bone.matrixManual_Name[lookup_name]
	boneID = isnumber(lookup_name) and lookup_name or ply:LookupBone(boneName)
	
	if not boneID then return end

	ply.manipulated = ply.manipulated or {}
	ply.manipulated[boneID] = ply.manipulated[boneID] or {}
	ply.manipulated[boneID].Pos = ply.manipulated[boneID].Pos or Vector(0, 0, 0)
	ply.manipulated[boneID].Ang = ply.manipulated[boneID].Ang or Angle(0, 0, 0)
	ply.manipulated[boneID].layers = ply.manipulated[boneID].layers or {}
	ply.manipulated[boneID].layers[layer] = ply.manipulated[boneID].layers[layer] or {Pos = Vector(0, 0, 0), Ang = Angle(0, 0, 0)}
end

hook.Add("Player Getup", "homigrad-bones", function(ply) reset(ply) end)

local CurTime, LerpVector, LerpAngle = CurTime, LerpVector, LerpAngle
local m, mSet, mAngle, mPos
local vecZero, angZero = Vector(0, 0, 0), Angle(0, 0, 0)
local tickInterval = engine.TickInterval
local FrameTime = FrameTime
local math_min = math.min
local mul = 1
local timeHuy = CurTime()
local hook_Run = hook.Run
local angle = FindMetaTable("Angle")

function math.EqualWithTolerance(val1, val2, tol)
    return math.abs(val1 - val2) <= tol
end

function angle:IsEqualTol(ang, tol)
    if (tol == nil) then
        return self == ang
    end

    return math.EqualWithTolerance(self[1], ang[1], tol)
        and math.EqualWithTolerance(self[2], ang[2], tol)
        and math.EqualWithTolerance(self[3], ang[3], tol)
end

function angle:AngIsEqualTo(otherAng, huy)
	if not angle.IsEqualTol then return false end
	return self:IsEqualTol(otherAng, huy)
end

local hg_anims_draw_distance = ConVarExists("hg_anims_draw_distance") and GetConVar("hg_anims_draw_distance") or CreateClientConVar("hg_anims_draw_distance", 1024, true, nil, "distance to draw anims (0 = infinite)", 0, 4096)
local hg_anim_fps = ConVarExists("hg_anim_fps") and GetConVar("hg_anim_fps") or CreateClientConVar("hg_anim_fps", 66, true, nil, "fps to draw anims (0 = maximum fps available)", 0, 250)

local tolerance = 0.1

local player_GetAll = player.GetAll
local timeFrame = 0

local function recursive_bones(ply, bone)
	local children = ply:GetChildBones(bone)

	local parent = ply:GetBoneParent(bone)
	parent = parent != -1 and parent or 0

	local matp = ply.unmanipulated[parent] or ply:GetBoneMatrix(parent)

	if ply.matrixes[bone] then
		local new_matrix = ply.matrixes[bone]
		--print(new_matrix:GetAngles())
		local old_matrix = ply.unmanipulated[bone]
		
		local lmat = old_matrix:GetInverse() * new_matrix
		local ang = lmat:GetAngles()
		local vec, _ = WorldToLocal(new_matrix:GetTranslation(), angle_zero, old_matrix:GetTranslation(), matp:GetAngles())
		--print(old_matrix:GetTranslation())
		--ply.manipulate[bone] = {vec, ang}

		--ply:ManipulateBonePosition(bone, vec)
		--ply:ManipulateBoneAngles(bone, lmat:GetAngles())

		--ply:MBPosition(bone, vec)
		--ply:MBAngles(bone, lmat:GetAngles())

		--ply:MBPosition(bone, lpos)
		--ply:MBAngles(bone, ang)
	end

	for i = 1, #children do
		local bonec = children[i]

		recursive_bones(ply, bonec)
	end
end

local dtime2
function hg.HomigradBones(ply, time, dtime)
	if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() then return end

	local dist = CLIENT and LocalPlayer():GetPos():Distance(ply:GetPos()) or 0
	local drawdistance = CLIENT and hg_anims_draw_distance:GetInt() or 0
	
	if CLIENT and (not ply.shouldTransmit or ply.NotSeen) then return end

	local dtime = (1 / hg_anim_fps:GetFloat())
	
	if CLIENT and (hg_anim_fps:GetInt() != 0) and ((time - (ply.timeFrame or 0)) < dtime) then return end
	if CLIENT then
		dtime = time - (ply.timeFrame or 0)
		ply.timeFrame = time
	end
	dtime2 = dtime
	hook_Run("Bones", ply, dtime)

	--[[for bonename, tbl in pairs(ply.manipulated) do
		boneName = hg.bone.matrixManual_Name[bonename]
		boneID = ply:LookupBone(boneName)
		ply:ManipulateBonePosition(boneID, tbl.Pos, false)
		ply:ManipulateBoneAngles(boneID, tbl.Ang, false)
	end--]]

	if not ply.manipulated then reset(ply) return end

	for bone, tbl in pairs(ply.manipulated) do
		for layer, tbl in pairs(tbl.layers) do
			if (tbl.lastset != time) then
				hg.bone.Set(ply, bone, vector_origin, angle_zero, layer, 0.5, dtime, true)
			end
		end
	end
end

function hg.get_unmanipulated_bones(ply, bone, matmodify)--set bone to 0 for the 1-st recurse
	ply.unmanipulated = ply.unmanipulated or {}
	matmodify = matmodify or Matrix()

	local vec = ply:GetManipulateBonePosition(bone)
	local ang = ply:GetManipulateBoneAngles(bone)

	local parent = ply:GetBoneParent(bone)
	parent = parent != -1 and parent or 0
	local mat = ply:GetBoneMatrix(bone)
	local matp = ply:GetBoneMatrix(parent)

	local ang1 = matp:GetAngles()

	local vec2 = ang1:Forward() * vec[1] + ang1:Right() * -vec[2] + ang1:Up() * vec[3]
	local ang2 = mat:GetAngles()
	--ОБЯЗАТЕЛЬНО В ПОРЯДКЕ 3 1 2!!! (roll pitch yaw)
	ang2:RotateAroundAxis(ang2:Forward(), -ang[3])
	ang2:RotateAroundAxis(ang2:Right(), ang[1])
	ang2:RotateAroundAxis(ang2:Up(), -ang[2])

	mat:SetTranslation(mat:GetTranslation() - vec2)
	mat:SetAngles(ang2)

	if matmodify then
		mat = matmodify * mat
	end

	ply.unmanipulated[bone] = mat

	local children = ply:GetChildBones(bone)

	local modify = mat * ply:GetBoneMatrix(bone):GetInverse()
	
	for i = 1, #children do
		local bonec = children[i]

		hg.get_unmanipulated_bones(ply, bonec, modify)
	end
end

if CLIENT then
	hook.Add("Player Think", "homigrad-bones", hg.HomigradBones)
else
	hook.Add("Player Think", "homigrad-bones", hg.HomigradBones)
end

function hg.bone.Set(ply, lookup_name, vec, ang, layer, lerp, dtime)
	dtime = dtime or dtime2
	boneName = hg.bone.matrixManual_Name[lookup_name]
	boneID = isnumber(lookup_name) and lookup_name or ply:LookupBone(boneName)

	if not boneID then return end
	
	layer = layer or "unspecified"

	if layer and layer != "all" then
		createLayer(ply, layer, boneID)

		if lerp then
			vec = LerpVector(hg.lerpFrameTime2(lerp, dtime), ply.manipulated[boneID].layers[layer].Pos, vec)
			ang = LerpAngle(hg.lerpFrameTime2(lerp, dtime), ply.manipulated[boneID].layers[layer].Ang, ang)
		end
		
		local oldpos, oldang = hg.bone.Get(ply, boneID)
		--print(oldang)
		local setPos = oldpos - ply.manipulated[boneID].layers[layer].Pos + vec
		local setAng = oldang - ply.manipulated[boneID].layers[layer].Ang + ang

		hg.bone.SetRaw(ply, boneID, setPos, setAng)

		--print(layer, lookup_name, oldang, ply.layers[layer][lookup_name].Ang, ang, setAng)

		ply.manipulated[boneID].layers[layer].Pos = -(-vec)
		ply.manipulated[boneID].layers[layer].Ang = -(-ang)
		ply.manipulated[boneID].layers[layer].lastset = CurTime()
	end
end
--PrintTable(Player(3).manipulated)
function hg.bone.SetRaw(ply, boneID, vec, ang)
	ply.manipulated = ply.manipulated or {}
	ply.manipulated[boneID] = ply.manipulated[boneID] or {}

	ply.manipulated[boneID].Pos = vec
	ply.manipulated[boneID].Ang = ang
	
	ply:ManipulateBonePosition(boneID, vec, false)
	ply:ManipulateBoneAngles(boneID, ang, false)
end

function hg.bone.Get(ply, lookup_name)
	boneName = hg.bone.matrixManual_Name[lookup_name]
	boneID = isnumber(lookup_name) and lookup_name or ply:LookupBone(boneName)

	if not boneID or not ply.manipulated[boneID] then return end

	return ply.manipulated[boneID].Pos, ply.manipulated[boneID].Ang
end

local ENTITY = FindMetaTable("Entity")

function ENTITY:SetBoneMatrix2(boneID, matrix, dontset)
    local localpos = self:GetManipulateBonePosition(boneID)
    local localang = self:GetManipulateBoneAngles(boneID)
    local newmat = Matrix()
    newmat:SetTranslation(localpos)
    newmat:SetAngles(localang)
    local inv = newmat:GetInverse()
    local oldMat = self:GetBoneMatrix(boneID) * inv
    local newMat = oldMat:GetInverse() * matrix
    local lpos, lang = newMat:GetTranslation(), newMat:GetAngles()

    if not dontset then
        self:ManipulateBonePosition(boneID, lpos, false)
        self:ManipulateBoneAngles(boneID, lang, false)
    end

    return lpos, lang
end
