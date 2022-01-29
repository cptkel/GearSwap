-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc','Crit')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','Acc','Proc')
    state.CastingMode:options('Normal','Proc','Fodder')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal','DT','DTRostam')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('None','Default','DualSavageWeapons','DualSavageWeaponsACC','DualLeadenRanged','DualLeadenRangedACC','DualLeadenMelee','DualLeadenMeleeACC','Aeolian','Evisceration','DualLastStand','DualLastStandACC','LastStand','SBLS','Armageddon')
	state.CompensatorMode:options('Always','300','1000','Never')
	state.ElementalMode 	  = M{['description'] = 'Elemental Mode', 'Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water'}
	
    autows = 'Savage Blade'
	gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    gear.ACCbullet = "Devastating Bullet"
	options.ammo_warning_limit = 15

	gear.roll_jse_back = {name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Mag. Evasion+15',}}
	gear.leaden_back = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.sb_back = {name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.laststand_back = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.tp_jse_back = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.shoot_jse_back = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	
	set_lockstyle(1)
	ammostock = 98
	-- Additional local binds
	send_command('bind numpad0 input /ra <t>')
	send_command('bind numpad3 input /ws Leaden Salute <t>')
	send_command('bind numpad1 input /ja "Triple Shot" <me>')
	
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')

	send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
	send_command('bind @q gs c weapons Aeolian;gs c update')
	send_command('bind ^q gs c weapons DualKustawi;gs c update')
	send_command('bind !q gs c weapons DualLeadenMelee;gs c update')
	send_command('bind @pause roller roll')

    select_default_macro_book()
end

 function user_job_post_precast(spell, spellMap, eventArgs)
  if spell.type == "CorsairShot" then

    if state.CastingMode.value == 'Fodder' and spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot' then
      local orpheus_avail = item_available("Orpheus's Sash")
      local hachirin_avail = item_available('Hachirin-no-Obi')
                
      if hachirin_avail and spell.element and spell.element == world.weather_element and world.weather_intensity == 2 then
        equip({waist="Hachirin-no-Obi"})
      elseif orpheus_avail and spell.target.distance < 3 then
        equip({waist="Orpheus's Sash"})
      elseif hachirin_avail and spell.element and spell.element == world.weather_element and spell.element == world.day_element then
        equip({waist="Hachirin-no-Obi"})
      elseif orpheus_avail and spell.target.distance < 8 then
        equip({waist="Orpheus's Sash"})
      elseif hachirin_avail and spell.element and (spell.element == world.weather_element or spell.element == world.day_element) then
        equip({waist="Hachirin-no-Obi"})
      end
    end
  end
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.precast.CorsairRoll = {main={name="Rostam", bag="Wardrobe 2"},range="Compensator",
        head="Lanun Tricorne +3",neck="Regal Necklace",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Chasseur's Gants +1",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Desultor Tassets",feet="Malignance boots"}

    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {}) --legs="Chas. Culottes +1"
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {}) --feet="Chass. Bottes +1"
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {}) --hands="Chasseur's Gants +1"
    
	sets.precast.CorsairShot = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
        back=gear.shoot_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Tights"}
	
    sets.precast.CorsairShot.Damage = {ammo="Hauksbok Bullet",
        head=gear.herculean_mab_head,neck="Comm. Charm +2",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Lanun Frac +3",hands="Carmine Fin. Ga. +1",ring1="Dingir Ring", --Fenrir Ring +1
        back=gear.leaden_back,waist="Eschan Stone",legs=gear.herculean_leaden_legs,feet="Lanun Bottes +3"}
		
	sets.precast.CorsairShot.Acc= {ammo=gear.QDbullet,
		head="Laksa. Tricorne +2", neck="Comm. Charm +2",ear1="Digni. Earring",ear2="Gwati Earring", 
		body="Malignance Tabard",hands="Laksa. Gants +2",ring1="Stikini Ring +1",ring2="Regal Ring",
		back=gear.shoot_jse_back,waist="K. Kachina Belt +1",legs="Malignance Tights",feet="Laksa. Bottes  +2"} 
		
	sets.precast.CorsairShot.Proc = set_combine(sets.precast.CorsairShot.Damage, {feet="Chass. Bottes +1"})

    sets.precast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Laksa. Tricorne +2",neck="Comm. Charm +2",ear1="Digni. Earring",ear2="Gwati Earring", 
        body="Malignance Tabard",hands="Laksa. Gants +2",ring1="Stikini Ring +1",ring2="Regal Ring",
        back=gear.shoot_jse_back,waist="K. Kachina Belt +1",legs="Malignance Tights",feet="Laksa. Bottes  +2"} 

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {}) --neck="Magoraga Beads",body="Passion Jacket"
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.RA = {ammo=gear.RAbullet,
       head="Taeon Chapeau",neck="Comm. Charm +2",
       body="Laksa. Frac +3",hands="Lanun Gants +3",ring1="Crepuscular Ring",
        back=gear.roll_jse_back,waist="Yemaya Belt",legs="Adhemar Kecks +1",feet="Meg. Jam. +2"} 
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {head="Chass. Tricorne +1",hands="Carmine Fin. Ga. +1"})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, {feet="Pursuer's Gaiters"})
	
	sets.precast.RA.Embrava = set_combine(sets.precast.RA.Flurry2, {}) --embrava is 25 snapshot

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Acc = {}		
		
    sets.precast.WS.Proc = {}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = {ammo=gear.WSbullet,
        head="Nyame Helm",neck="Comm. Charm +2",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Laksa. Frac +3",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Epaminondas's Ring",
		back=gear.sb_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Lanun Bottes +3"}
		

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		head="Meghanada Visor +2",neck="Decimus Torque",ear2="Telos Earring", 
		waist="Grunfeld Rope"})
	
    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head="Nyame Helm",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Laksa. Frac +3",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Dingir Ring",
        back=gear.laststand_back,waist="Fotia Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {ammo=gear.ACCbullet,neck="Comm. Charm +2",waist="K. Kachina Belt +1"})
		
    sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	
    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Comm. Charm +2",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Lanun Frac +3",hands=gear.herculean_wsd_hands,ring1="Archon Ring",ring2="Dingir Ring",
		back=gear.leaden_back,waist="Eschan Stone",legs=gear.herculean_leaden_legs,feet="Lanun Bottes +3"}
		

    sets.precast.WS['Leaden Salute'].Acc = {}

    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head="Nyame Helm",neck="Comm. Charm +2",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Lanun Frac +3",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Dingir Ring",
        back=gear.leaden_back,waist="Eschan Stone",legs="Nyame Flanchard",feet="Lanun Bottes +3"} --skymir cord +1

    sets.precast.WS['Wildfire'].Acc = {}
		
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
	
	sets.precast.WS['Aeolian Edge'] = {ammo="Hauksbok Bullet",
		head=gear.herculean_mab_head,neck="Comm. Charm +2",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body="Lanun Frac +3",hands="Carmine Fin. Ga. +1",ring1="Dingir Ring",ring2="Epaminondas's Ring",
		back=gear.leaden_back,waist="Orpheus's Sash", legs=gear.herculean_leaden_legs,feet="Lanun Bottes +3"}
	
	sets.precast.WS['Evisceration'] = {
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Regal Ring",ring2="Ilabrat Ring",
		back=gear.tp_jse_back,waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}
	
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Ilabrat Ring",
		back=gear.shoot_jse_back,waist="Yemaya Belt",legs="Malignance Tights",feet="Malignance Boots"}
	
	sets.midcast.RA.Armageddon = set_combine(sets.midcast.RA, {})
	sets.midcast.RA.Armageddon.AM = {ammo=gear.RAbullet,
		head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Odr Earring",ear2="Telos Earring",
		body="Meg. Cuirie +2",hands="Mummu Wrists +2",ring1="Mummu Ring",ring2="Begrudging Ring",
		back=gear.crit_jse_back,waist="K. Kachina Belt +1",legs="Darraigner's Brais",feet="Osh. Leggings +1"}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {neck="Comm. Charm +2",body="Laksa. Frac +3",ring1="Regal Ring",ring2="Cacoethic Ring +1",waist="K. Kachina Belt +1"})
		
	sets.buff['Triple Shot'] = {head="Oshosi Mask +1",body="Chasseur's Frac +1",hands="Lanun Gants +3",back=gear.shoot_jse_back,legs="Osh. Trousers +1",feet="Osh. Leggings +1"}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
		back=gear.roll_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
	sets.idle.PDT = {}	
    sets.idle.Refresh = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.DWMax = {ear1="Eabani Earring",body="Adhemar Jacket +1",hands="Floral Gauntlets",waist="Reiki Yotai",legs="Carmine Cuisses +1",feet="Taeon Boots"} 

	-- Weapons sets
	sets.weapons.Default = {main="Kustawi +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Gleti's Knife",range="Anarchy +2"}
	sets.weapons.DualSavageWeaponsACC = {main="Naegling",sub="Demers. Degen +1",range="Anarchy +2"}
	sets.weapons.DualLeadenRanged = {main={name="Rostam",bag="inventory"},sub="Tauret",range="Death Penalty"}
	sets.weapons.DualLeadenRangedACC = {main={name="Rostam",bag="inventory"},sub="Kustawi +1",range="Death Penalty"}
	sets.weapons.DualLeadenMelee = {main={name="Rostam",bag="inventory"},sub="Gleti's Knife",range="Death Penalty"} --pathB,Tauret
	sets.weapons.DualLeadenMeleeACC = {main={name="Rostam",bag="inventory"},sub="Demers. Degen +1",range="Death Penalty"}
	sets.weapons.Aeolian = {main={name="Rostam",bag="inventory"},sub="Tauret",range="Anarchy +2"}
	sets.weapons.Evisceration = {main="Tauret",sub="Gleti's Knife",range="Anarchy +2"}
	sets.weapons.DualLastStand = {main={name="Rostam",bag="inventory"},sub="Gleti's Knife",range="Fomalhaut"}
	sets.weapons.DualLastStandACC = {main={name="Rostam",bag="inventory"},sub="Kustawi +1",range="Fomalhaut"}
	sets.weapons.LastStand = {main={name="Rostam",bag="inventory"},sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.LastStandACC = {main={name="Rostam",bag="inventory"},sub="Nusku Shield",range="Armageddon"}
	sets.weapons.SBLS = {main="Naegling",sub="Gleti's Knife",range="Death Penalty"}
	sets.weapons.Armageddon = {main="Naegling",sub="Tauret",range="Armageddon"}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet} --Samnuha Tights
	
	sets.engaged.Acc = {}
	sets.engaged.DT = {
		head="Adhemar Bonnet +1",neck="Loricate torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Epona's Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {ear2="Telos Earring"})
	sets.engaged.DW = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Telos Earring",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet} --Samnuha Tights
    sets.engaged.DW.Acc = {
		head="Carmine Mask +1",neck="Decimus Torque",ear1="Digni. Earring",ear2="Mache Earring +1",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_tp_feet}
	sets.engaged.DW.Crit = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Suppanomimi",ear2="Odr Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Begrudging Ring",ring2="Mummu Ring",
		gear.tp_jse_back,waist="Reiki Yotai",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}
		
	
	sets.engaged.DW.DT = {
        head="Adhemar Bonnet +1",neck="Loricate torque +1",ear1="Suppanomimi",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Epona's Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
	sets.engaged.DW.DTRostam = {
		head="Adhemar Bonnet +1",neck="Loricate torque +1",ear1="Suppanomimi",ear2="Telos Earring",
        body="Malignance Tabard",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet="Malignance Boots"}
	sets.engaged.DW.Acc.DT = {
        head="Malignance Chapeau",neck="Decimus Torque",ear1="Suppanomimi",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"} 
		

end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 11)
    elseif player.sub_job == 'RNG' then
        set_macro_page(9, 11)
    else
        set_macro_page(10, 11)
    end   


end

function job_buff_change(buff, gain)
    if player.equipment.Ranged and buff:contains('Aftermath') then
        classes.CustomRangedGroups:clear()
        if (player.equipment.Ranged == 'Armageddon' and buffactive['Aftermath: Lv.3']) then
            classes.CustomRangedGroups:append('AM')
        end
    end
end

function job_post_precast(spell, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		local WSset = standardize_set(get_precast_set(spell, spellMap))
		local wsacc = check_ws_acc()
		
		if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			-- Replace Moonshade Earring if we're at cap TP
			if get_effective_player_tp(spell, WSset) > 3200 then
				if data.weaponskills.elemental:contains(spell.english) then
					if wsacc:contains('Acc') and sets.MagicalAccMaxTP then
						equip(sets.MagicalAccMaxTP[spell.english] or sets.MagicalAccMaxTP)
					elseif sets.MagicalMaxTP then
						equip(sets.MagicalMaxTP[spell.english] or sets.MagicalMaxTP)
					else
					end
				elseif spell.skill == 26 then
					if wsacc:contains('Acc') and sets.RangedAccMaxTP then
						equip(sets.RangedAccMaxTP[spell.english] or sets.RangedAccMaxTP)
					elseif sets.RangedMaxTP then
						equip(sets.RangedMaxTP[spell.english] or sets.RangedMaxTP)
					else
					end
				else
					if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
						equip(sets.AccMaxTP[spell.english] or sets.AccMaxTP)
					elseif sets.MaxTP then
						equip(sets.MaxTP[spell.english] or sets.MaxTP)
					else
					end
				end
			end
		end
	elseif spell.type == 'CorsairShot' and not (spell.english == 'Light Shot' or spell.english == 'Dark Shot') then
		if (state.WeaponskillMode.value == "Proc" or state.CastingMode.value == "Proc") and sets.precast.CorsairShot.Proc then
			equip(sets.precast.CorsairShot.Proc)
		elseif state.CastingMode.value == 'Fodder' and sets.precast.CorsairShot.Damage then
			equip(sets.precast.CorsairShot.Damage)
			
			local distance = spell.target.distance - spell.target.model_size
			local single_obi_intensity = 0
			local orpheus_intensity = 0
			local hachirin_intensity = 0

			if item_available("Orpheus's Sash") then
				orpheus_intensity = (16 - (distance <= 1 and 1 or distance >= 15 and 15 or distance))
			end
			
			if item_available(data.elements.obi_of[spell.element]) then
				if spell.element == world.weather_element then
					single_obi_intensity = single_obi_intensity + data.weather_bonus_potency[world.weather_intensity]
				end
				if spell.element == world.day_element then
					single_obi_intensity = single_obi_intensity + 10
				end
			end
			
			if item_available('Hachirin-no-Obi') then
				if spell.element == world.weather_element then
					hachirin_intensity = hachirin_intensity + data.weather_bonus_potency[world.weather_intensity]
				elseif spell.element == data.elements.weak_to[world.weather_element] then
					hachirin_intensity = hachirin_intensity - data.weather_bonus_potency[world.weather_intensity]
				end
				if spell.element == world.day_element then
					hachirin_intensity = hachirin_intensity + 10
				elseif spell.element == data.elements.weak_to[world.day_element] then
					hachirin_intensity = hachirin_intensity - 10
				end
			end
			
			if single_obi_intensity >= hachirin_intensity and single_obi_intensity >= orpheus_intensity and single_obi_intensity >= 5 then
				equip({waist=data.elements.obi_of[spell.element]})
			elseif hachirin_intensity >= orpheus_intensity and hachirin_intensity >= 5 then
				equip({waist="Hachirin-no-Obi"})
			elseif orpheus_intensity >= 5 then
				equip({waist="Orpheus's Sash"})
			end
			
		end
		
	elseif spell.action_type == 'Ranged Attack' then
			if buffactive.Embrava then			
				if buffactive.Flurry then
			if sets.precast.RA.Flurry and lastflurry == 1 then
				equip(sets.precast.RA.FlurryEM)
			elseif sets.precast.RA.Flurry2 and lastflurry == 2 then
				equip(sets.precast.RA.Flurry2EM)				
				end
				end	
			if  sets.precast.RA.Embrava then								
				equip(sets.precast.RA.Embrava)
				end
				end
		if buffactive.Flurry then
			if sets.precast.RA.Flurry and lastflurry == 1 then
				equip(sets.precast.RA.Flurry)
			elseif sets.precast.RA.Flurry2 and lastflurry == 2 then
				equip(sets.precast.RA.Flurry2)
			end
		end
	elseif spell.type == 'CorsairRoll' or spell.english == "Double-Up" then
		if state.LuzafRing.value and item_available("Luzaf's Ring") then
			equip(sets.precast.LuzafRing)
		end
		if spell.type == 'CorsairRoll' and state.CompensatorMode.value ~= 'Never' and (state.CompensatorMode.value == 'Always' or tonumber(state.CompensatorMode.value) > player.tp) then
			if item_available("Compensator") then
				enable('range')
				equip({range="Compensator"})
			end
			if sets.precast.CorsairRoll.main and sets.precast.CorsairRoll.main ~= player.equipment.main then
				enable('main')
				equip({main=sets.precast.CorsairRoll.main})
			end
		end
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 and sets.precast.FoldDoubleBust then
		equip(sets.precast.FoldDoubleBust)
	end
end
