util.AddNetworkString("inventory")
util.AddNetworkString("hg loot")
util.AddNetworkString("hg drop jmod")
util.AddNetworkString("hg loot jmod")
util.AddNetworkString("ply_take_item")
util.AddNetworkString("ply_take_ammo")
util.AddNetworkString("DropItemInv")

local BlackListWep = {
	["weapon_hands"] = true,
	["weapon_physgun"] = true,
	["gmod_tool"] = true,
	["gmod_camera"] = true,
}

local AllowedJMod = {
	["ent_jack_gmod_ezdetpack"] = true,
	["ent_jack_gmod_ezsticknadebundle"] = true,
	["ent_jack_gmod_eztnt"] = true,
	["ent_jack_gmod_eztimebomb"] = true,
	["ent_jack_gmod_ezsmokenade"] = true,
	["ent_jack_gmod_ezsignalnade"] = true,
	["ent_jack_gmod_ezgasnade"] = true,
	["ent_jack_gmod_ezfragnade"] = true,
	["ent_jack_gmod_ezfirenade"] = true,
    ["ent_jack_gmod_ezstickynade"] = true,
	["ent_jack_gmod_ezcsnade"] = true,
	["ent_jack_gmod_ezdynamite"] = true,
	["ent_jack_gmod_ezammo"] = true,
	["ent_jack_gmod_ezwarmine"] = true,
    ["ent_jack_gmod_ezsatchelcharge"] = true,
	["ent_jack_gmod_ezboundingmine"] = true,
	["ent_jack_gmod_ezlandmine"] = true,
	["ent_jack_gmod_eznade_impact"] = true,
	["ent_jack_gmod_ezslam"] = true,
}

hg.loots = hg.loots or {}

hg.loots.small_crate = {
	"weapon_burger",
	"weapon_water_bottle",
	"weapon_canned_burger",
	"weapon_milk",
	"weapon_chips",
	"weapon_energy_drink",
	"weapon_hammer",
	"weapon_sog",
	"weapon_hatchet",
}

hg.loots.medium_crate = {
	"weapon_chips",
	"weapon_burger",
	"weapon_sharik_pidoras_by_b3bros",
	"weapon_glockp80",
	"weapon_axe",
	"weapon_energy_drink",
	"weapon_milk",
	"weapon_lit_energy"
}

hg.loots.large_crate = {
	"weapon_axe",
	"weapon_crowbar_hg",
	"weapon_fubar",
	"weapon_shovel",
	"weapon_sog",
	"weapon_hammer",
	"weapon_xm1014",
}

hg.loots.melee_crate = {
	"weapon_axe",
	"weapon_crowbar_hg",
	"weapon_fubar",
	"weapon_hammer",
	"weapon_hatchet",
	"weapon_melee",
	"weapon_shovel",
	"weapon_sog",
	"weapon_tagila"
}

hg.loots.explosives_crate = {
"ent_jack_gmod_ezdetpack", 
	"ent_jack_gmod_ezsticknadebundle",
	"ent_jack_gmod_eztnt",
	"ent_jack_gmod_eztimebomb" ,
	"ent_jack_gmod_ezsmokenade" ,
	"ent_jack_gmod_ezsignalnade",
	"ent_jack_gmod_ezgasnade" ,
    "ent_jack_gmod_ezfragnade",
	"ent_jack_gmod_ezfirenade",
    "ent_jack_gmod_ezstickynade",
	"ent_jack_gmod_ezcsnade",
	"ent_jack_gmod_ezdynamite",
	"ent_jack_gmod_ezammo",
	"ent_jack_gmod_ezwarmine",
    "ent_jack_gmod_ezsatchelcharge",
	"ent_jack_gmod_ezboundingmine",
	"ent_jack_gmod_ezlandmine",
	"ent_jack_gmod_eznade_impact",
	"ent_jack_gmod_ezslam",
}

hg.loots.weapon_crate = {
	"weapon_mp5",
	"weapon_mp7",
	"weapon_deagle_a",
	"weapon_deagle_b",
	"weapon_glockp80",
	"weapon_w1894",
	"weapon_tec9",
	"weapon_ak74",
	"weapon_m4a1",
	"weapon_scar",
	"weapon_xm1014",
	"weapon_870_b",
	"weapon_870_a",
	"weapon_doublebarrel",
	"weapon_sharik",
}

hg.loots.medkit_crate = {
	"weapon_medkit_hg",
	"weapon_bandage",
	"weapon_bandage",
	"weapon_painkillers_hg",
	"weapon_adrenaline",
}


hg.loots.grenade_crate = {
	"weapon_rgd5",
	"weapon_f1",
	"weapon_hl2nade",
}


hg.loots.pistol_crate = {
	"weapon_deagle_a",
	"weapon_deagle_b",
	"weapon_fiveseven",
	"weapon_glockp80",
	"weapon_usp_match",
	"weapon_329pd",
	"weapon_tec9",
	"weapon_glock18",
}

hg.loots.food_crate = {
	"weapon_sharik_pidoras_by_b3bros",
	"weapon_burger",
	"weapon_water_bottle",
	"weapon_canned_burger",
	"weapon_milk",
	"weapon_chips",
	"weapon_apple_pidor",
	"weapon_pivo",
	"weapon_lit_energy",
	"weapon_bread",
	"weapon_beton",
	"weapon_energy_drink",
} 

hg.loots.armor_crate = {
	"ent_armor_vest2",
	"ent_armor_vest4",
	"ent_armor_mask4",
	"ent_armor_mask1",
	"ent_armor_back2",
	"ent_armor_mask6",
	"ent_armor_vest1",
	"ent_armor_back3",
	"ent_armor_back5",
	"ent_armor_vest6",
	"ent_armor_mask5",
}

net.Receive("hg drop jmod",function(l,ply)
	if !ply.JModEntInv then
		return
	end

	local tr = hg.eyeTrace(ply,100)

	if IsValid(ply.JModEntInv) then
		ply:SetNWFloat("LastPickup",CurTime() + 0.2)
		local ent = hg.GetCurrentCharacter(ply)
		sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)
		ply.JModEntInv:SetNoDraw(false)
		ply.JModEntInv:SetCollisionGroup(COLLISION_GROUP_NONE)
		ply.JModEntInv:SetNotSolid(false)
		ply.JModEntInv:SetPos(tr.HitPos + vector_up * 16)

		ply.JModEntInv = NULL
	end
end)

net.Receive("hg loot jmod",function(l,ply)
	local ent = net.ReadEntity()

	if !ent.JModEntInv then
		return
	end

	local pent = ent.JModEntInv

	if pent == NULL or pent == Entity(1) then
		return
	end

	ply:SetNWFloat("LastPickup",CurTime() + 0.2)
	sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)

	local tr = hg.eyeTrace(ply,160)

	if ply.JModEntInv == NULL then
		ply.JModEntInv = pent
		pent:SetNoDraw(true)
		pent:SetNotSolid(true)
		pent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	else
		local fent2 = ply.JModEntInv

		fent2:SetNoDraw(false)
		fent2:SetCollisionGroup(COLLISION_GROUP_NONE)
		fent2:SetNotSolid(false)
		fent2:SetPos(tr.HitPos)

		ply.JModEntInv = pent
		pent:SetNoDraw(true)
		pent:SetNotSolid(true)
		pent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	if ent:IsRagdoll() and hg.RagdollOwner(ent).FakeRagdoll == ent and hg.RagdollOwner(ent):Alive() and hg.RagdollOwner(ent).Fake then
		local entply = hg.RagdollOwner(ent)

		entply.JModEntInv = NULL
	end

	ent.JModEntInv = NULL
end)

hook.Add("Player Think","Homigrad_Loot_Inventory",function(ply)
	if !ply:Alive() then
		return
	end

	if ply.JModEntInv != NULL then
		ply.JModEntInv:SetPos(ply:GetPos())
	end

	if ply.Fake then
		return
	end
	if ply:KeyDown(IN_SPEED) and ply:KeyPressed(IN_USE) then
		local tr = hg.eyeTrace(ply,160)

		if tr.Entity then
			local ent = tr.Entity

			if !IsValid(ent) or ent == NULL then
				return
			end

			if AllowedJMod[ent:GetClass()] then
				ply:SetNWFloat("LastPickup",CurTime() + 0.2)
				if ply.JModEntInv != NULL then
					local pent  = ply.JModEntInv //fent

					pent:SetNoDraw(false)
					ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
					ent:SetNoDraw(true)
					pent:SetCollisionGroup(COLLISION_GROUP_NONE)
					pent:SetPos(tr.HitPos)

					ply.JModEntInv = ent
				else
					ply.JModEntInv = ent
					ent:SetNoDraw(true)
					ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
				end
			end
		end
	end
	if ply:KeyDown(IN_ATTACK2) and ply:KeyPressed(IN_USE) then
		local tr = hg.eyeTrace(ply,160)

		if tr.Entity then
			local ent = tr.Entity

			if ent:IsRagdoll() and hg.RagdollOwner(ent) != NULL and ent.Inventory then

				ply:SetNWFloat("LastPickup",CurTime() + 0.2)

				net.Start("hg inventory")
				net.WriteEntity(ent)
				net.WriteTable(ent.Inventory)
				net.WriteFloat(8)// Дефолт значение ивента //#ent.Inventory)
				net.WriteEntity(ent.JModEntInv)
				net.Send(ply)
			end
		end
	end
end)

net.Receive("hg loot",function(len,ply)
	if !ply:Alive() then
		return
	end
	local ent = net.ReadEntity()
	local taked = net.ReadString()

	if !ent.Inventory then
		return
	end

	if table.HasValue(ent.Inventory,taked) then
		ply:SetNWFloat("LastPickup",CurTime() + 0.2)
		sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)
		table.RemoveByValue(ent.Inventory,taked)

		if weapons.Get(taked) then
			if ply:HasWeapon(taked) then
				local ent_wep = ents.Create(taked)
				ent_wep:Spawn()
				ent_wep:SetPos(ent:GetPos() + vector_up * 32)
				ent_wep.IsSpawned = true

				if ent:IsRagdoll() and hg.RagdollOwner(ent):Alive() and hg.RagdollOwner(ent).FakeRagdoll == ent then
					hg.RagdollOwner(ent):StripWeapon(taked)
				end

				if ent_wep.ishgwep then
					ent_wep:EmitSound("snd_jack_hmcd_ammotake.wav")
					ent_wep:SetClip1(0)
					ply:GiveAmmo(ent_wep:GetMaxClip1(),ent_wep:GetPrimaryAmmoType(),true)
				end
			else
				local wep = ply:Give(taked)
				if ent:IsRagdoll() and hg.RagdollOwner(ent):Alive() and hg.RagdollOwner(ent).FakeRagdoll == ent then

					local wep2 = hg.RagdollOwner(ent):GetWeapon(taked)

					wep.Attachments = wep2.Attachments
					wep:SetClip1(wep2:Clip1())
				end
			end


			if ent:IsRagdoll() and hg.RagdollOwner(ent):Alive() and hg.RagdollOwner(ent).FakeRagdoll == ent then
				hg.RagdollOwner(ent):StripWeapon(taked)
			end
		end

		if weapons.Get(taked).isMelee and weapons.Get(taked).isTakeSlot then
			for _, wep in ipairs(ply:GetWeapons()) do
				if wep.isMelee and wep:GetClass() != taked and wep.isTakeSlot then
					ply:DropWep(wep)
				end
			end
		end

		if weapons.Get(taked).TwoHands then
			for _, wep in ipairs(ply:GetWeapons()) do
				if wep.TwoHands and wep:GetClass() != taked then
					ply:DropWep(wep)
				end
			end
		end

		if weapons.Get(taked).TwoHands != nil then
			for _, wep in ipairs(ply:GetWeapons()) do
				if wep.TwoHands == false and weapons.Get(taked).TwoHands == false and wep:GetClass() != taked then
					ply:DropWep(wep)
				end
			end
		end
	else
		net.Start("localized_chat")
        net.WriteString('item_notexist')
        net.Send(ply)
	end
end)

local function send(ply,lootEnt,remove)
	if ply then
		net.Start("inventory")
		net.WriteEntity(not remove and lootEnt or nil)
		net.WriteTable(lootEnt.Info.Weapons)
		net.WriteTable(lootEnt.Info.Ammo)
		net.Send(ply)
	else
		if lootEnt.UsersInventory and istable(lootEnt.UsersInventory) then
			for ply in pairs(lootEnt.UsersInventory) do
				if not IsValid(ply) or not ply:Alive() or remove then lootEnt.UsersInventory[ply] = nil end

				send(ply,lootEnt,remove)
			end
		end
	end
end

hg.send = send

net.Receive("DropItemInv",function(l,ply)
    local wepdrop = net.ReadString()
    if !ply:HasWeapon(wepdrop) then
        return
    end

	ply:SetNWFloat("LastPickup",CurTime() + 0.2)
	local ent = hg.GetCurrentCharacter(ply)
	sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)

    ply:DropWep(ply:GetWeapon(wepdrop))

end) 

hook.Add("AllowPlayerPickup","Homigrad_Gavno",function(ply,ent)
	if ent:IsWeapon() then
		return false
	end
end)

hook.Add("PlayerUse","NoDrawUse",function(ply,ent)
	if ent:GetNoDraw() then
		return false
	else
		return true
	end
end)

hook.Add("PlayerCanPickupWeapon","Homigrad_Shit",function(ply,ent)
	local tr = hg.eyeTrace(ply)
	if ply:HasWeapon(ent:GetClass()) and hg.Weapons[ent] then
		ply:GiveAmmo(ent:Clip1(),ent:GetPrimaryAmmoType(),true)
		if ent:Clip1() > 0 then
			ent:SetClip1(0)
			sound.Play("snd_jack_hmcd_ammotake.wav",ent:GetPos(),75,100,1)
			ply:SetNWFloat("LastPickup",CurTime() + 0.2)
			sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)
		end
		return false
	end
	if ply:KeyDown(IN_USE) and IsValid(ent) and ent:GetOwner() != ply and (hg.eyeTrace(ply,150).Entity == ent or ent:GetPos():Distance(ply:GetPos()) < 45 and (IsValid(hg.eyeTrace(ply).Entity) and !hg.eyeTrace(ply).Entity:IsWeapon() or !hg.eyeTrace(ply).Entity)) then
		ply:SetNWFloat("LastPickup",CurTime() + 0.2)
		sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)
		if ent.isMelee and ent.isTakeSlot then
				for _, wep in ipairs(ply:GetWeapons()) do
					if wep.isMelee and wep.isTakeSlot then
						ply:DropWep(wep)
					end
				end
			end
		
			if ent.TwoHands then
				for _, wep in ipairs(ply:GetWeapons()) do
					if wep.TwoHands then
						ply:DropWep(wep)
					end
				end
			end
		
			if ent.TwoHands != nil then
				for _, wep in ipairs(ply:GetWeapons()) do
					if wep.TwoHands == false and ent.TwoHands == false then
						ply:DropWep(wep)
					end
				end
			end
			return true
		end
		if !ent.IsSpawned then
			if ent.isMelee and ent.isTakeSlot then
				for _, wep in ipairs(ply:GetWeapons()) do
					if wep.isMelee and wep.isTakeSlot then
						ply:DropWep(wep)
					end
				end
			end
		
			if ent.TwoHands then
				for _, wep in ipairs(ply:GetWeapons()) do
					if wep.TwoHands then
						ply:DropWep(wep)
					end
				end
			end
		
			if ent.TwoHands != nil then
				for _, wep in ipairs(ply:GetWeapons()) do
					if wep.TwoHands == false and ent.TwoHands == false then
						ply:DropWep(wep)
					end
				end
			end

		return true
	else
		return false
	end

	if ply:HasWeapon(ent:GetClass()) then
		return false
	end
end)

hook.Add("Player Think","Homigrad_Limit",function(ply)
	local inv = {}

	ply:SetAllowWeaponsInVehicle(false)

	for _, wep in ipairs(ply:GetWeapons()) do
		if isentity(wep) and IsValid(wep) and wep.GetClass and BlackListWep[wep:GetClass()] then
			continue 
		end
		table.insert(inv,wep)
	end

	local invs = {}

	for _, wep in ipairs(ply:GetWeapons()) do
		if isentity(wep) and IsValid(wep) and wep.GetClass and BlackListWep[wep:GetClass()] then
			continue 
		end
		table.insert(invs,wep:GetClass())
	end


	ply.Inventory = invs

	if #inv > 8 then
		local a,b = table.Random(inv)
		if a != ply:GetActiveWeapon() then
			ply:DropWep(a)
			ply:SetNWFloat("LastPickup",CurTime() + 0.2)
			sound.Play("snd_jack_gear"..math.random(1,6)..".wav",ent:GetPos(),75,100,1)
		end
	end
end)