-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','Crit')
    state.HybridMode:options('Normal','Evasion','PDT')
    state.RangedMode:options('Normal','Acc')
    state.WeaponskillMode:options('Match','Normal','AttCap','Acc')
    state.CastingMode:options('Normal','Tank','Resistant')
    state.IdleMode:options('Normal','Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','HeishiTernion','HeishiGoko','KikokuTernion','DualSavageWeapons','Aeolian','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcKatana','ProcClub','ProcStaff')
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','DW20','DWMax'}
	
	gear.fc_jse_back = {name="Andartia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	gear.da_jse_back = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.mab_jse_back = {name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.enmity_jse_back = {name="Andartia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}}
	
	send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind ^r gs c set WeaponskillMode Normal;gs c set CastingMode Normal;gs c update')
	send_command('bind @a gs c weapons Aeolian')
	
	utsusemi_cancel_delay = .3
	utsusemi_ni_cancel_delay = .06
	
	set_lockstyle(4)
	
    select_default_macro_book()
end

function job_setup()

	state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff.Migawari = buffactive.Migawari or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
	state.Buff.Issekigan = buffactive.Issekigan or false
	
	state.Stance = M{['description']='Stance','Innin','Yonin','None'}

	autows = "Blade: Shun"
	autofood = 'Soy Ramen'
	
	utsusemi_ni_cancel_delay = .1
	
	state.ElementalMode = M{['description'] = 'Elemental Mode','Fire','Water','Lightning','Earth','Wind','Ice','Light','Dark',}
	
	update_melee_groups()
	init_job_states({"Capacity","AutoRuneMode","AutoTrustMode","AutoWSMode","AutoShadowMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode","ElementalWheel",},{"AutoBuffMode","AutoSambaMode","Weapons","OffenseMode","WeaponskillMode","Stance","IdleMode","Passive","RuneElement","ElementalMode","CastingMode","TreasureMode",})
end

function job_customize_melee_set(meleeSet)

	if state.Buff.Yonin then 
		if state.DefenseMode.value == 'None' or state.DefenseMode.value == 'Evasion' then
			meleeSet = set_combine(meleeSet, sets.buff.Yonin)
		end
	elseif state.Buff.Innin then
		if (state.OffenseMode.value == 'Normal' or state.OffenseMode.value == 'Fodder') and state.DefenseMode.value == 'None' then
			meleeSet = set_combine(meleeSet, sets.buff.Innin)
		end
    end
	
	if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end

	if state.Buff.Issekigan then
        meleeSet = set_combine(meleeSet, sets.buff.Issekigan)
    end
	
    return meleeSet
end

--[[function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if not is_dual_wielding() then return end
    
    local haste = 0 -- Lili was here
    haste = haste + (buffactive[33] and (lasthaste == 2 and 30 or 15) or 0) -- Haste II or Haste
    haste = haste + (buffactive[580] and 35.5 or 0) -- Indi/Geo-Haste, 30% at 900 skill, 35.5 with Dunna, 41 with Idris
    haste = haste + (buffactive[370] and 5 or 0) -- Haste Samba, assuming minimum strength of 5%
    haste = haste + (buffactive[604] and 15 or 0) -- Mighty Guard
    haste = haste + (buffactive[228] and 26 or 0) -- Embrava, assuming maximum potency of 26%
    
    if buffactive.March then
        -- March potencies makes some assumptions: 
        -- Honor March: 16.99 - Victory March: 28.61 - Advancing March: 18.95
        haste = haste + (buffactive.March >= 3 and 16.99+28.61+18.95 or 0) -- Assumes max potency marches
        haste = haste + (buffactive.March == 2 and 16.99+28.61 or 0) -- Assumes max potency Honor March + Victory March.
        haste = haste + (buffactive.March == 1 and 16.99 or 0) -- Assumes max potency Honor March
    end
        
    if haste > 40 then
        add_to_chat(8, '----Max-Haste Mode Enabled----')
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif haste >= 35 then
        add_to_chat(8, '---Haste 35%---')
        classes.CustomMeleeGroups:append('Haste_35')
    elseif haste >= 30 then
        add_to_chat(8, '---Haste 30%---')
        classes.CustomMeleeGroups:append('Haste_30')
    elseif haste >= 15 then
        add_to_chat(8, '---Haste 15%---')
        classes.CustomMeleeGroups:append('Haste_15')    
    end
end]]--    

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {ammo="Sapience Orb",
        head="Malignance Chapeau",neck="Unmoving Collar +1",ear1="Cryptic Earring",ear2="Trux Earring",
        body="Emet Harness +1",hands="Kurys Gloves",ring1="Petrov Ring",ring2="Eihwaz Ring",
        back=gear.enmity_jse_back,waist="Sinew Belt",legs="Zoar Subligar +1",feet="Mochi. Kyahan +3"}
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +3"}
    sets.precast.JA['Futae'] = {} --hands="Hattori Tekko +1"
    sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity
	sets.precast.JA['Vallation'] = sets.Enmity
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = sets.Enmity
	sets.precast.JA['Swordplay'] = sets.Enmity
	sets.precast.JA['Last Resort'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
		head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Kishar Ring",
		back=gear.fc_jse_back,legs=gear.herculean_refresh_legs,feet=gear.herculean_fc_feet}
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochi. Chainmail +3"}) 
	sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {})

    -- Snapshot for ranged
    sets.precast.RA = {}
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Seeth. Bomblet +1",
		head=gear.herculean_WSD_head,neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Epaminondas's Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean_WSD_feet}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Shun'] = {
		head="Mpaca's Cap",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Tatena. Haidate +1",feet="Mochi. Kyahan +3"}
	
	sets.precast.WS['Blade: Shun'].AttCap = {ammo="C. Palug Stone",
		head="Ken. Jinpachi +1",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Odr Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Jokushu Haidate",feet="Ken. Sune-ate +1"}
	
	sets.precast.WS['Blade: Metsu'] = {
		head="Hachiya Hatsu. +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Odr Earring",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Mochi. Kyahan +3"}
	
    sets.precast.WS['Blade: Ku'] = {ammo="Seething Bomblet +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Mache Earring +1",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Tatena. Haidate +1",feet="Mochi. Kyahan +3"}
	
	sets.precast.WS['Blade: Ten'] = {ammo="Seething Bomblet +1",
		head="Hachiya Hatsu. +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Odr Earring",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Mochi. Kyahan +3"}
	
    sets.precast.WS['Blade: Chi'] = {ammo="Seeth. Bomblet +1",
		head="Mochi. Hatsuburi +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Gere Ring",ring2="Epaminondas's Ring",
		waist="Orpheus's Sash",legs="Mochi. Hakama +3",feet=gear.herculean_WSD_feet}--back=andartia str magacc/magdmg/wsd

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Blade: Chi'], {})

	sets.precast.WS['Savage Blade'] = {ammo="Seething Bomblet +1",
		head="Hachiya Hatsu. +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body=gear.herculean_wsd_body,hands="Mpaca's Gloves",ring1="Regal Ring",ring2="Epaminondas's Ring",
		waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet=gear.herculean_WSD_feet}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring",ear2="Lugra Earring +1",}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Sapience Orb",
		head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Kishar Ring",
		back=gear.fc_jse_back,legs=gear.herculean_refresh_legs,feet=gear.herculean_fc_feet}

    sets.midcast.ElementalNinjutsu = {ammo="Ghastly Tathlum +1",
		head="Mochi. Hatsuburi +3",neck="Baetyl Pendant",ear1="Friomisi earring",ear2="Regal Earring",
		body="Gyve doublet",hands="Leyline gloves",ring1="Metamor. Ring +1",ring2="Shiva Ring +1",
		back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Gyve Trousers",feet="Mochi. Kyahan +3"}
		
	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast
		
    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})
	
	sets.MagicBurst = set_combine(sets.midcast.ElementalNinjutsu, {
		head="Mochi. Hatsuburi +3",
		body="Samnuha Coat",ring1="Mujin Band",ring2="Locus Ring",
		feet="Mochi. Kyahan +3"})
	
	sets.element.Earth = {}

    sets.midcast.NinjutsuDebuff = {}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {})
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {back="Andartia's Mantle",feet="Hattori Kyahan +1"})

	sets.midcast.Utsusemi.Tank = set_combine(sets.Enmity, {feet="Hattori Kyahan +1"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	
    sets.midcast.RA = {}
		
    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Odnowa Earring +1",ear2="Infused Earring",
        body="Hiza. Haramaki +2",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.da_jse_back,waist="Engraved Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.idle.Sphere = set_combine(sets.idle, {})
		
    sets.idle.Weak = set_combine(sets.idle)
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    sets.Kiting = {feet="Hachiya Kyahan +2"}
	sets.DuskKiting = {}
	sets.DuskIdle = {}
	sets.DayIdle = {feet="Hachiya Kyahan +2"}
	--sets.NightIdle = {feet="Danzo Sune-ate"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Seki Shuriken",
		head="Adhemar Bonnet +1",neck="Ninja Nodowa +2",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ken. Samue +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Gere Ring",
		back=gear.da_jse_back,waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet}
		
    sets.engaged.Acc = {}
	sets.engaged.Crit = set_combine(sets.engaged, {ammo="Happo Shuriken",head="Blistering Sallet +1",ear1="Odr Earring",body="Mummu jacket +2",hands="Mummu wrists +2",legs="Mummu Kecks +2",feet="Mummu gamashes +2"})
    sets.engaged.Evasion = {}
	sets.engaged.Acc.Evasion = {}
	sets.engaged.PDT = set_combine(sets.engaged,{
        head="Malignance Chapeau",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",
        legs="Malignance Tights",feet="Malignance Boots"})
	sets.engaged.Acc.PDT = {}
	
		
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {} --body="Hattori Ningi +1"
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Yonin = {} --legs="Hattori Hakama +1"
    sets.buff.Innin = {} --head="Hattori Zukin +1"
	sets.buff.Issekigan = set_combine(sets.Enmity, {hands="Hizamaru Kote +2",legs="Rawhide Trousers",feet="Hattori Kyahan +1"})
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.DW20 = {ear1="Suppanomimi",ear2="Eabani Earring"}
	sets.DWMax = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
	-- Weapons sets
	sets.weapons.HeishiTernion = {main="Heishi Shorinken",sub="Ternion Dagger +1"}
	sets.weapons.HeishiGoko = {main="Heishi Shorinken",sub="Gokotai"}
	sets.weapons.KikokuTernion = {main="Kikoku",sub="Ternion Dagger +1"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Uzura +2"}
	sets.weapons.Aeolian = {main="Tauret",sub="Ternion Dagger +1"}
	sets.weapons.ProcDagger = {main="Qutrub Knife",sub=empty}
	sets.weapons.ProcSword = {main="Onion Sword",sub=empty}
	sets.weapons.ProcGreatSword = {main="Ophidian Sword",sub=empty}
	sets.weapons.ProcScythe = {main="Hoe",sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Uchigatana",sub=empty}
	sets.weapons.ProcKatana = {main="Ochu",sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand",sub=empty}
	sets.weapons.ProcStaff = {main="Ram Staff",sub=empty}
	
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 10; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'RNG' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 12)
    else
        set_macro_page(1, 12)
    end
end
