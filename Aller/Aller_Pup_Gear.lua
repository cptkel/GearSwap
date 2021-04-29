-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Pet','DT','PDT','Normal')
    state.WeaponskillMode:options('Match','Normal','Acc')
    state.PhysicalDefenseMode:options('PDT','MDT','MEVA')
	state.IdleMode:options('Normal')
	state.Weapons:options('None','Su5','Kenkonken','Godhands')
	
	-- Default/Automatic maneuvers for each pet mode.  Define at least 3.
	defaultManeuvers = {
		Melee = {
			{Name='Fire Maneuver', 	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
			{Name='Wind Maneuver', 	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
		},
		Ranged = {
			{Name='Wind Maneuver', 	  Amount=0},
			{Name='Fire Maneuver',	  Amount=2},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=0},
		},
		HybridRanged = {
			{Name='Wind Maneuver', 	  Amount=0},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Thunder Maneuver', Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Tank = {
			{Name='Earth Maneuver',	  Amount=1},
			{Name='Fire Maneuver',	  Amount=1},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Dark Maneuver',	  Amount=0},
			{Name='Wind Maneuver', 	  Amount=0},
			{Name='Thunder Maneuver', Amount=0},
		},
		--Bruiser
		LightTank = { 
			{Name='Earth Maneuver',	  Amount=0},
			{Name='Fire Maneuver',	  Amount=2},
			{Name='Light Maneuver',	  Amount=1},
			{Name='Dark Maneuver',	  Amount=0},
			{Name='Wind Maneuver',	  Amount=0},
			{Name='Water Maneuver',	  Amount=0},
		},
		Magic = {
			{Name='Light Maneuver',	  Amount=1},
			{Name='Ice Maneuver',	  Amount=0},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Earth Maneuver',	  Amount=0},
			{Name='Wind Maneuver',	  Amount=1},
		},
		Heal = {
			{Name='Light Maneuver',	  Amount=2},
			{Name='Dark Maneuver',	  Amount=1},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
		Nuke = {
			{Name='Ice Maneuver',	  Amount=3},
			{Name='Dark Maneuver',	  Amount=0},
			{Name='Water Maneuver',	  Amount=0},
			{Name='Earth Maneuver',	  Amount=0},
		},
	}

	deactivatehpp = 85
	
	--check about dropping idle cape + changing tank/mab cape
	gear.idle_jse_back={name="Visucius's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}}
	gear.strDA_jse_back={name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.strCRIT_jse_back={name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
	gear.pethybrid_jse_back={name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}}
	
	
	gear.taeon_head={name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.taeon_body={name="Taeon Tabard", augments={'Pet: Attack+19 Pet: Rng.Atk.+19','Pet: "Dbl. Atk."+3','Pet: Damage taken -4%',}}
	gear.taeon_hands={name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.taeon_legs={name="Taeon Tights", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	gear.taeon_feet={name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
	
	gear.rao_head={name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
	
	select_default_macro_book()
	
	set_lockstyle(1)
	
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f8 gs c toggle AutoPuppetMode')
	send_command('bind @f7 gs c toggle AutoRepairMode')
end

--testing LightTank enmity swapping
function job_customize_idle_set(idleSet)
    if pet.isvalid and pet.status == 'Engaged' then
        local now = os.clock()
        if state.PetWSGear.value and sets.midcast.Pet and pet.tp and pet.tp > 999 then
            if sets.midcast.Pet.PetWSGear and sets.midcast.Pet.PetWSGear[state.PetMode.value] then
                idleSet = set_combine(idleSet, sets.midcast.Pet.PetWSGear[state.PetMode.value])
			elseif sets.midcast.Pet.PetWSGear then
                idleSet = set_combine(idleSet, sets.midcast.Pet.PetWSGear)
            end
        elseif state.PetEnmityGear.value and sets.midcast.Pet.PetEnmityGear and state.PetMode.value == "LightTank" and ((PupFlashReady < now and buffactive['Light Maneuver']) or (PupVokeReady < now and buffactive['Fire Maneuver'])) then            
            idleSet = set_combine(sets.idle.Pet.Engaged.LightTank, sets.midcast.Pet.PetEnmityGear)
		elseif state.PetEnmityGear.value and sets.midcast.Pet.PetEnmityGear and ((PupFlashReady < now and buffactive['Light Maneuver']) or (PupVokeReady < now and buffactive['Fire Maneuver'])) then
            idleSet = set_combine(idleSet, sets.midcast.Pet.PetEnmityGear)
        elseif sets.idle.Pet.Engaged[state.PetMode.value] then
            idleSet = set_combine(idleSet, sets.idle.Pet.Engaged[state.PetMode.value])
        else
            idleSet = set_combine(idleSet, sets.idle.Pet.Engaged)
        end

        if buffactive['Overdrive'] and sets.buff.Overdrive then
            idleSet = set_combine(idleSet, sets.buff.Overdrive)
        end
    elseif  data.jobs.mage_jobs:contains(player.sub_job) then
        if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere')) then
            if sets.latent_refresh then
                idleSet = set_combine(idleSet, sets.latent_refresh)
            end
        end
    end
    return idleSet
end


-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
	head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Zendik Robe",ring1="Lebeche Ring",ring2="Prolix Ring", --rahab ring, herc hands aug:FC
	back="Fi Follet Cape +1",legs=gear.herculean_refresh_legs,feet="Regal Pumps +1"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Karagoz Scarpe +1"}
    sets.precast.JA['Repair'] = {ammo="Automat. Oil +3",feet="Foire Babouches +3"}
	sets.precast.JA['Maintenance'] = {ammo="Automat. Oil +3"}

    sets.precast.JA.Maneuver = {main="Kenkonken",neck="Buffoon's Collar",body="Karagoz Farsetto +1",hands="Foire Dastanas +3",left_ear="Burana Earring"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
	sets.precast.WS.Acc = {}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = {
		head="Blistering Sallet +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Mpaca's Doublet",hands="Ryuo Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
		back=gear.strCRIT_jse_back,waist="Moonbow Belt +1",legs="Mpaca's Hose",feet="Mpaca's Boots"}
  
	sets.precast.WS['Stringing Pummel'] = {
		head="Blistering Sallet +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Mpaca's Doublet",hands="Ryou Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		back=gear.strCRIT_jse_back,waist="Fotia Belt",legs="Mpaca's Hose",feet="Mpaca's Boots"}
  
	sets.precast.WS['Shijin Spiral'] = {
		head=gear.herculean_strTA_head,neck="Fotia Gorget",ear1="Brutal Earring",ear2="Mache Earring +1",
		body="Tali'ah Manteel +2",hands=gear.herculean_strTA_hands,ring1="Niqmaddu Ring",ring2="Gere Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet}
		
    sets.precast.WS['Howling Fist'] = {
		head="Mpaca's Cap",neck="Pup. Collar +1",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Tali'ah Manteel +2",hands=gear.herculean_strTA_hands,ring1="Niqmaddu Ring",ring2="Gere Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Mpaca's Hose",feet=gear.herculean_tp_feet}
	
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS['Howling Fist'], {})
	
  
    -- Midcast Sets

    sets.midcast.FastRecast = {
		head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Zendik Robe",ring1="Lebeche Ring",ring2="Prolix Ring",
		legs=gear.herculean_refresh_legs,feet="Regal Pumps +1"}
	
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
	sets.midcast.Pet['Enfeebling Magic'] = {}
    sets.midcast.Pet['Elemental Magic'] = {
		head=gear.herculean_petmagic_head,neck="Pup. Collar +1",ear1="Burana Earring",ear2="Enmerkar Earring",
		body="Udug Jacket",hands=gear.herculean_petmagic_hands,ring1="Tali'ah Ring",ring2="C. Palug Ring",
		back=gear.MAB_jse_back,waist="Ukko Sash",legs="Pitre Churidars +3",feet="Pitre Babouches +3"}
	
	-- The following sets are predictive and are equipped before we even know the ability will happen, as a workaround due to
	-- the fact that start of ability packets are too late in the case of Pup abilities, WS, and certain spells.
	sets.midcast.Pet.PetEnmityGear = {
		head="Heyoka Cap +1",ear1="Rimeice Earring",ear2="Domes. Earring",
        body="Heyoka Harness",hands="Heyoka Mittens",
        legs="Heyoka Subligar +1",feet="Heyoka Leggings"}
	sets.midcast.Pet.PetEnmityGear.LightTank = {
		head="Heyoka Cap +1",ear1="Rimeice Earring",ear2="Domes. Earring",
        body="Heyoka Harness",hands="Heyoka Mittens",
        legs="Heyoka Subligar +1",feet="Heyoka Leggings"}
	sets.midcast.Pet.PetWSGear = {
		main="Xiucoatl",
		head ="Karagoz Capello +1",neck="Shulmanu Collar",ear1="Burana Earring",ear2="Enmerkar Earring",
        body="Pitre Tobe +3",hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="Overbearing Ring",
		back="Dispersal Mantle",waist="Klouskap Sash +1",legs="Kara. Pantaloni +1",feet="Mpaca's Boots"}
		
	sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Melee = {
		main="Xiucoatl",
		head=gear.taeon_head,neck="Shulmanu Collar",ear1="Kyrene's Earring",ear2="Domes. Earring",
		body="Pitre Tobe +3",hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back=gear.pethybrid_jse_back,waist="Incarnation Sash",legs=gear.taeon_legs,feet="Mpaca's Boots"}
	sets.midcast.Pet.PetWSGear.Tank = {
		main="Xiucoatl",
		head=gear.taeon_head,neck="Shulmanu Collar",ear1="Kyrene's Earring",ear2="Domes. Earring",
		body="Pitre Tobe +3",hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back=gear.pethybrid_jse_back,waist="Incarnation Sash",legs=gear.taeon_legs,feet="Mpaca's Boots"}
	sets.midcast.Pet.PetWSGear.LightTank = {
		main="Xiucoatl",
		head=gear.taeon_head,neck="Shulmanu Collar",ear1="Kyrene's Earring",ear2="Domes. Earring",
		body="Pitre Tobe +3",hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back=gear.pethybrid_jse_back,waist="Incarnation Sash",legs=gear.taeon_legs,feet="Mpaca's Boots"}
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
	sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})
    
	-- Currently broken, preserved in case of future functionality.
	--sets.midcast.Pet.WeaponSkill = {}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets

    sets.idle = {main="Kenkonken",range="Animator P +1",ammo="Automat. Oil +3",
		head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
		back=gear.idle_jse_back,waist="Carrier's Sash",legs="Malignance Tights",feet="Malignance Boots"}
		
		
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = set_combine(sets.idle, {})

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {main="Xiucoatl",range="Animator P +1", --Ohtas (BiS but will drop 150HP when swapping)
		head=gear.taeon_head,neck="Shulmanu Collar",ear1="Rimeice Earring",ear2="Enmerkar Earring",
		body="Pitre Tobe +3",hands=gear.taeon_hands,ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back=gear.pethybrid_jse_back,waist="Klouskap Sash +1",legs=gear.taeon_legs,feet="Mpaca's Boots"} --Incarnation sash

	sets.idle.Pet.Engaged.Ranged = {main="Xiucoatl",range="Animator P II +1",
		head="Pitre Taj +3",neck="Shulmanu Collar",ear1="Burana Earring",ear2="Enmerkar Earring",
		body="Pitre Tobe +3",hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="Varar Ring +1",
		back=gear.pethybrid_jse_back,waist="Klouskap Sash +1",legs="Kara. Pantaloni +1",feet="Mpaca's Boots"}
		
	sets.idle.Pet.Engaged.HybridRanged = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Tank = {main="Gnafron's Adargas",ranged="Animator P +1",
		head=gear.rao_head,neck="Shepherd's Chain",ear1="Rimeice Earring",ear2="Enmerkar Earring",
		body="Rao Togi +1",hands="Rao Kote +1",ring1="Thurandaut Ring",ring2="Overbearing Ring",
		back=gear.idle_jse_back,waist="Isa Belt",legs="Rao Haidate +1",feet="Rao Sune-Ate +1"}
		
	sets.idle.Pet.Engaged.LightTank = {main="Ohtas",ranged="Animator P +1",
		head=gear.taeon_head,neck="Shulmanu Collar",ear1="Rimeice Earring",ear2="Enmerkar Earring",
		body=gear.taeon_body,hands=gear.taeon_hands,ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back=gear.pethybrid_jse_back,waist="Incarnation Sash",legs=gear.taeon_legs,feet=gear.taeon_feet}
	
	sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
	sets.idle.Pet.Engaged.Heal = set_combine(sets.idle.Pet.Engaged.Magic, {})
	sets.idle.Pet.Engaged.Nuke = {
		head="Pitre Taj +3",ear1="Burana Earring",
		back="Contriver's Cape",waist="Ukko Sash",legs="Pitre Churidars +3"}


    -- Defense sets
	
	--SE/VE OD
    sets.defense.PDT = {main="Xiucoatl",
		head ="Karagoz Capello +1",neck="Shulmanu Collar",ear1="Rimeice Earring",ear2="Enmerkar Earring",
        body="Pitre Tobe +3",hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back="Dispersal Mantle",waist="Klouskap Sash +1",legs="Heyoka Subligar +1",feet="Mpaca's Boots"}
	--VE/VE OD
    sets.defense.MDT = {main="Xiucoatl",
		head=gear.taeon_head,neck="Shulmanu Collar",ear1="Rimeice Earring",ear2="Enmerkar Earring",
		body=gear.taeon_body,hands="Mpaca's Gloves",ring1="Thurandaut Ring",ring2="C. Palug Ring",
		back=gear.pethybrid_jse_back,waist="Klouskap Sash +1",legs=gear.taeon_legs,feet="Mpaca's Boots"}
	
		
    sets.defense.MEVA = {}

    sets.Kiting = {feet="Hermes' Sandals"}

	sets.buff['Overdrive'] = {}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Ryuo Somen +1",neck="Shulmanu Collar",ear1="Telos Earring",ear2="Brutal Earring", --Schere Earring
		body="Mpaca's Doublet",hands=gear.herculean_tp_hands,ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Ryuo Hakama +1",feet=gear.herculean_tp_feet}
		
    sets.engaged.Acc = {}
    
	sets.engaged.PDT = {
        head="Mpaca's Cap",neck="Shulmanu Collar",ear1="Telos Earring",ear2="Brutal Earring", --ear2=Schere
		body="Mpaca's Doublet",hands="Mpaca's Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Mpaca's Hose",feet="Mpaca's Boots"}
		
    sets.engaged.PDT.AM = {
		head="Malignance Chapeau",neck="Bilious Torque",ear1="Telos Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.DT = {
		head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.AM = {
		head="Malignance Chapeau",neck="Bilious Torque",ear1="Telos Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.strDA_jse_back,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.Acc.DT = {}
    sets.engaged.Pet = {
        main="Xiucoatl",
		head="Heyoka Cap +1",neck="Shulmanu Collar",ear1="Telos Earring",ear2="Dedition Earring",
		body="Mpaca's Doublet",hands="Mpaca's Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.pethybrid_jse_back,waist="Moonbow Belt +1",legs="Heyoka Subligar +1",feet="Mpaca's Boots"}
		
    sets.engaged.Pet.AM = {
		main="Xiucoatl",
		head="Heyoka Cap +1",neck="Shulmanu Collar",ear1="Telos Earring",ear2="Dedition Earring",
		body="Mpaca's Doublet",hands="Mpaca's Gloves",ring1="Gere Ring",ring2="Niqmaddu Ring",
		back=gear.pethybrid_jse_back,waist="Moonbow Belt +1",legs="Heyoka Subligar +1",feet="Mpaca's Boots"}
		
	sets.engaged.PetDT = {}
	sets.engaged.Acc.Pet = {}
    
	-- Weapons sets
	sets.weapons.Kenkonken = {main="Kenkonken",range="Animator P +1",}
	sets.weapons.Su5 = {main="Xiucoatl",range="Animator P +1",}
	sets.weapons.Godhands = {main="Godhands",range="Animator P +1",}
	
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
    end
end