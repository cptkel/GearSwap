-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','Crit')
    state.HybridMode:options('Normal','Evasion','PDT','SBPDT')
    state.RangedMode:options('Normal','Acc')
    state.WeaponskillMode:options('Match','Normal','AttCap','Acc')
    state.CastingMode:options('Normal','Resistant','Tank')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('HeishiGleti','HeishiKuni','GokoGleti','KikokuKuni','NagiGleti','DualSavageWeapons','Aeolian','Evisceration','GKT','EmpyArrow','Macc','None','ProcDagger','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana','ProcKatana','ProcClub','ProcStaff')
	
	state.Stance = M{['description']='Stance','Yonin','Innin','None'}
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','DW20','DWMax'}
	
	gear.fc_jse_back = {name="Andartia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	gear.da_jse_back = {name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.mab_jse_back = {name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.enmity_jse_back = {name="Andartia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}}
	gear.hybrid_jse_back = {name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.agi_jse_back = {name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.preshot_jse_back = {name="Andartia's Mantle", augments={'"Snapshot"+10',}}
	gear.rtp_jse_back = {name="Andartia's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	
	send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^r gs c set WeaponskillMode Normal;gs c set CastingMode Normal;gs c update')
	send_command('bind @a gs c weapons Aeolian')
	send_command('bind @h gs c weapons HeishiGleti')
	send_command('bind @k gs c weapons HeishiKuni')
	send_command('bind @s gs c weapons DualSavageWeapons')
	send_command('bind @j gs c weapons GKT')
	
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

    sets.Enmity = {ammo="Date Shuriken",
        head="Malignance Chapeau",neck="Unmoving Collar +1",ear1="Cryptic Earring",ear2="Trux Earring",
        body="Emet Harness +1",hands="Kurys Gloves",ring1="Petrov Ring",ring2="Eihwaz Ring",
        back=gear.enmity_jse_back,waist="Sinew Belt",legs="Zoar Subligar +1",feet="Mochi. Kyahan +3"}
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +3"}
    sets.precast.JA['Futae'] = {hands="Hattori Tekko +1"}
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
    sets.precast.RA = {
       head="Taeon Chapeau",
       body="Taeon Tabard",hands="Taeon Gloves",ring1="Crepuscular Ring",ring2="Haverton Ring +1",
       back=gear.preshot_jse_back,legs="Adhemar Kecks +1",feet="Taeon Boots"} 
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, {})
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Seeth. Bomblet +1",
		head="Nyame Helm",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Epaminondas's Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Samnuha Tights",feet="Nyame Sollerets"}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Chi'] = {ammo="Seeth. Bomblet +1",
		head="Mochi. Hatsuburi +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame gauntlets",ring1="Gere Ring",ring2="Epaminondas's Ring",
		back=gear.hybrid_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.precast.WS['Blade: Teki'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']
	
	sets.precast.WS['Blade: Hi'] = {ammo="Yetshila +1",
		head="Hachiya Hatsu. +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Odr Earring",
		body="Ken. Samue +1",hands="Mpaca's Gloves",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.agi_jse_back,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Nyame Sollerets"}
		
	sets.precast.WS['Blade: Kamu'] = {ammo="Seething Bomblet +1",
		head="Hachiya Hatsu. +3",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Brutal Earring",
		body="Tatena. Harama. +1",hands="Malignance Gloves",ring1="Gere Ring",ring2="Epona's Ring",
		back=gear.hybrid_jse_back,waist="Sailfi Belt +1",legs="Tatena. Haidate +1",feet="Tatena. Sune. +1"}
		
	sets.precast.WS['Blade: Ku'] = {ammo="Seething Bomblet +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Mache Earring +1",
		body=gear.adhemar_dd_body,hands="Mochizuki Tekko +3",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Tatena. Haidate +1",feet="Mochi. Kyahan +3"}
		
	sets.precast.WS['Blade: Metsu'] = {ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Mache Earring +1",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.hybrid_jse_back,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Nyame Sollerets"}
	
	sets.precast.WS['Blade: Shun'] = {ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Mochi. Hakama +3",feet="Mochi. Kyahan +3"}
	
	sets.precast.WS['Blade: Shun'].AttCap = {ammo="C. Palug Stone",
		head="Ken. Jinpachi +1",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Mache Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Mpaca's Hose",feet="Ken. Sune-ate +1"}
	
	sets.precast.WS['Blade: Ten'] = {ammo="Seething Bomblet +1",
		head="Mpaca's Cap",neck="Caro Necklace",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body=gear.adhemar_dd_body,hands="Nyame Gauntlets",ring1="Gere Ring",ring2="Regal Ring",
		back=gear.hybrid_jse_back,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Nyame Sollerets"}
	
	sets.precast.WS['Savage Blade'] = {ammo="Seething Bomblet +1",
		head="Mpaca's Cap",neck="Caro Necklace",ear1="Lugra Earring +1",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Gere Ring",
		back=gear.hybrid_jse_back,waist="Sailfi Belt +1",legs="Mochi. Hakama +3",feet="Nyame Sollerets"}
    
	sets.precast.WS['Evisceration'] = {ammo="Yetshila +1",
		head="Blistering Sallet +1",neck="Ninja Nodowa +2",ear1="Lugra Earring +1",ear2="Odr Earring",
		body="Ken. Samue +1",hands="Ryuo Tekko +1",ring1="Regal Ring",ring2="Gere Ring",
		back=gear.da_jse_back,waist="Fotia Belt",legs="Mpaca's Hose",feet="Ken. Sune-ate +1"}
		
	sets.precast.WS['Aeolian Edge'] = {ammo="Seething Bomblet +1",
		head="Mochi. Hatsuburi +3",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Dingir Ring",ring2="Epaminondas's Ring",
		back=gear.mab_jse_back,waist="Eschan Stone",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.precast.WS['Empyreal Arrow'] = {
		head="Nyame Helm",neck="Iskur Gorget",ear1="Telos Earring",ear2="Ishvara Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Cacoethic Ring +1",
		waist="Yemaya Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	sets.precast.WS['Tachi: Kagero'] = sets.precast.WS['Blade: Chi']
	sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS['Blade: Chi']
		
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
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
		head="Mochi. Hatsuburi +3",neck="Sanctity Necklace",ear1="Friomisi earring",ear2="Crematio Earring",
		body="Gyve doublet",hands="Nyame Gauntlets",ring1="Metamor. Ring +1",ring2="Shiva Ring +1",
		back=gear.mab_jse_back,waist="Orpheus's Sash",legs="Gyve Trousers",feet="Mochi. Kyahan +3"}
		
	sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast
		
    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {
		neck ="Sanctity Necklace",ear1 ="Dignitary's Earring",ear2 ="Crepuscular Earring", 
		body="Nyame Mail",ring2="Stikini Ring +1",
		legs="Nyame Flanchard"})
	
	sets.MagicBurst = set_combine(sets.midcast.ElementalNinjutsu, {
		ear1="Static Earring",
		body="Samnuha Coat",hands=gear.herculean_mbb_hands,ring1="Mujin Band",ring2="Locus Ring"})
		
	sets.MagicBurst.Resistant = set_combine(sets.midcast.ElementalNinjutsu.Resistant, {
		ear1="Static Earring",
		ring1="Mujin Band",ring2="Metamor. Ring +1"})
	
	sets.element.Earth = {}

    sets.midcast.NinjutsuDebuff = {
		head="Hachiya Hatsuburi +3",neck ="Sanctity Necklace",ear1 ="Dignitary's Earring",ear2 ="Crepuscular Earring", 
		body="Malignance Tabard",hands ="Malignance Gloves",ring1 ="Stikini Ring +1",ring2 ="Stikini Ring +1",
		back=gear.mab_jse_back,waist ="Eschan Stone",legs ="Malignance Tights",feet ="Mochi. Kyahan +3"}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {})
	
    sets.midcast['Migawari: Ichi'] = set_combine(sets.midcast.NinjutsuDebuff, {ammo="Sapience Orb",
		neck="Incanter's Torque",ear1="Hnoss Earring",
		body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Stikini Ring +1",ring2="Haverton Ring +1", 
		back=gear.fc_jse_back,legs="Nyame Flanchard",feet="Mochizuki Kyahan +3"})
		
	sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {back="Andartia's Mantle",feet="Hattori Kyahan +1"})

	sets.midcast.Utsusemi.Tank = set_combine(sets.Enmity, {ammo="Staunch Tathlum +1",ring1="Defending Ring",waist="Flume Belt +1",feet="Hattori Kyahan +1"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	
    sets.midcast.RA = {
		head="Malignance Chapeau",neck="Iskur Gorget",ear1="Telos Earring",ear2="Crep. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Crepuscular Ring",ring2="Cacoethic Ring +1",
		waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.enmity_jse_back,waist="Kasiri Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.idle.Sphere = set_combine(sets.idle, {})
		
    sets.idle.Weak = set_combine(sets.idle)
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {ammo="Yamarang", --date shuriken
		head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Eabani Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
		back=gear.enmity_jse_back,waist="Engraved Belt",legs="Malignance Tights",feet="Malignance Boots"}


    sets.Kiting = {feet="Danzo Sune-ate"}
	sets.DuskKiting = {feet="Hachiya Kyahan +2"}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Seki Shuriken",
		head="Mpaca's Cap",neck="Ninja Nodowa +2",ear1="Telos Earring",ear2="Cessance Earring",
		body="Tatena. Harama. +1",hands="Adhemar Wrist. +1",ring1="Gere Ring",ring2="Epona's Ring",
		back=gear.da_jse_back,waist="Windbuffet belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.engaged.Acc = {ammo="Date Shuriken",
		head="Ken. Jinpachi +1",neck="Ninja Nodowa +2",ear1="Mache Earring +1",ear2="Odr earring",
		body="Tatena. Harama. +1",hands="Ken. Tekko +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.da_jse_back,waist="Kentarch Belt +1",legs="Tatena. Haidate +1",feet="Tatena. Sune. +1"}
		
	sets.engaged.Crit = set_combine(sets.engaged, {ammo="Happo Shuriken",head="Blistering Sallet +1",ear1="Odr Earring",body="Mummu jacket +2",hands="Mummu wrists +2",legs="Mummu Kecks +2",feet="Mummu gamashes +2"})
    
	sets.engaged.Evasion = {ammo="Seki Shuriken",
		head="Malignance Chapeau",neck="Ninja Nodowa +2",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Mpaca's Doublet",hands="Malignance Gloves",ring1="Ilabrat RIng",ring2="Vengeful Ring",
		back=gear.enmity_jse_back,waist="Sailfi Belt +1",legs="Mpaca's Hose",feet="Malignance Boots"}
		
	sets.engaged.AM = {ammo="Seki Shuriken",
		head="Malignance Chapeau",neck="Ninja Nodowa +2",ear1="Telos Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Kentarch Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.engaged.Acc.Evasion = {}
	
	sets.engaged.PDT = set_combine(sets.engaged,{
        head="Malignance Chapeau",
        body="Mpaca's Doublet",hands="Malignance Gloves",ring1="Defending Ring",
        waist="Engraved Belt",legs="Mpaca's Hose",feet="Malignance Boots"})
	sets.engaged.SBPDT = set_combine(sets.engaged.PDT,{head="Ken. Jinpachi +1"}) --32 native; assumes 10 auspice; 8 to cap
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
	sets.weapons.HeishiGleti = {main="Heishi Shorinken",sub="Gleti's Knife"}
	sets.weapons.HeishiKuni = {main="Heishi Shorinken",sub="Kunimitsu"}
	sets.weapons.KikokuKuni = {main="Kikoku",sub="Kunimitsu"}
	sets.weapons.GokoGleti = {main="Gokotai",sub="Gleti's Knife"}
	sets.weapons.NagiGleti = {main="Nagi",sub="Gleti's Knife"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Uzura +3"}
	sets.weapons.Aeolian = {main="Tauret",sub="Kunimitsu"}
	sets.weapons.Evisceration = {main="Tauret",sub="Gleti's Knife"}
	sets.weapons.GKT = {main="Hachimonji",sub="Alber Strap"}
	sets.weapons.EmpyArrow = {main="Uzura +3",sub="Uzura +2",range="Ullr",ammo="Beryllium Arrow"}
	sets.weapons.Macc = {main="Nagi",sub="Gokotai",range="Ullr",ammo=empty}
	sets.weapons.ProcDagger = {main="Qutrub Knife",sub=empty}
	sets.weapons.ProcSword = {main="Excalipoor",sub=empty}
	sets.weapons.ProcGreatSword = {main="Ophidian Sword",sub=empty}
	sets.weapons.ProcScythe = {main="Hoe",sub=empty}
	sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade",sub=empty}
	sets.weapons.ProcGreatKatana = {main="Zanmato",sub=empty}
	sets.weapons.ProcKatana = {main="Ochu",sub=empty}
	sets.weapons.ProcClub = {main="Soulflayer's Wand",sub=empty}
	sets.weapons.ProcStaff = {main="Ranine Staff",sub=empty}
	
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
