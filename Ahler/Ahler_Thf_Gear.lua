-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','Crit')
    state.HybridMode:options('Normal','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','Acc')
	state.IdleMode:options('Normal','Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Aeneas','Evisceration','MagicWeapons','None')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.tp_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.evisceration_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.fc_jse_back = {name="Toutatis's Cape", augments={'"Fast Cast"+10',}}
	gear.aeolian_jse_back = {name="Toutatis's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%',}}
	
    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Throwing;gs c update')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')
	send_command('bind @k input /item "Living Key" <t>')

	set_lockstyle(6)

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = {hands="Plunderer's Armlets +2",legs={ name="Herculean Trousers", augments={'Accuracy+17','CHR+2','"Treasure Hunter"+2',}}}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Jute Boots +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Ternion Dagger +1"}
	sets.weapons.Evisceration = {main="Tauret",sub="Gleti's Knife"}
	sets.weapons.MagicWeapons = {main="Aeneas",sub="Tauret"}
	
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = {}
		
    sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Accomplice'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {} --body="Pillager's Vest +1"
    sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest"
    sets.precast.JA['Steal'] = {} --hands="Pill. Armlets +1"
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {} --legs="Skulker's Culottes",feet="Skulk. Poulaines +1"
    sets.precast.JA['Perfect Dodge'] = {} --hands="Plunderer's Armlets +1"
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

	sets.Self_Waltz = {}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
	head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Prolix Ring",
	back=gear.fc_jse_back,legs=gear.herculean_refresh_legs}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    
	sets.precast.WS["Rudra's Storm"] = {ammo="Yetshila +1",
		head="Pill. Bonnet +3",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Ilabrat Ring",ring2="Regal Ring",
		waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"
	}
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {})

    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {})
	sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"], {})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"], {})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"], {})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"], {})
	
    sets.precast.WS['Evisceration'] = {ammo="Yetshila +1",
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Odr Earring",
		body="Meg. Cuirie +2",hands="Adhemar Wrist. +1",ring1="Ilabrat Ring",ring2="Regal Ring",
		back=gear.evisceration_jse_back,waist="Fotia Belt",legs="Pill. Culottes +3",feet=gear.herculean_crit_feet}
		
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS['Last Stand'] = {}

    sets.precast.WS['Aeolian Edge'] = {ammo="Ghastly Tathlum +1",
		head=gear.herculean_mab_head,neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
		body=gear.herculean_wsd_body,hands=gear.herculean_tp_hands,ring1="Epaminondas's Ring",ring2="Dingir Ring",
		back=gear.aeolian_jse_back,waist=gear.ElementalObi,legs=gear.herculean_mab_legs,feet=gear.herculean_mab_feet}
		
	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
	
	sets.precast.WS['Savage Blade'] = {ammo="Seeth. Bomblet +1",
		head="Pill. Bonnet +3",neck="Anu Torque",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Regal Ring",
		back=gear.evisceration_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}



	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear2="Sherida Earring"} --ear1="Zennaroi Earring"

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=gear.tp_jse_back,waist="Engraved Belt",legs="Malignance Tights",feet="Malignance Boots"}
		
    sets.idle.Sphere = set_combine(sets.idle, {})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
	sets.defense.MEVA = {}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Erudition Necklace",ear1="Dedition Earring",ear2="Sherida Earring",
        body="Pillager's Vest +2",hands="Adhemar Wrist. +1",ring1="Hetairoi Ring",ring2="Gere Ring",
        back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.herculean_tp_feet}
		
    sets.engaged.Acc = {}
		
    sets.engaged.PDT = {ammo="Staunch Tathlum +1",
		head="Adhemar Bonnet +1",neck="Loricate Torque +1",ear1="Sherida Earring",ear2="Odnowa Earring +1",
		body="Malignance Tabard",hands="Adhemar Wrist. +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Meg. Chausses +2",feet=gear.herculean_tp_feet}
		
	sets.engaged.Crit = {ammo="Yetshila +1",
		head="Adhemar Bonnet +1",neck="Erudit. Necklace",ear1="Suppanomimi",ear2="Odr Earring",
		body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Hetairoi Ring",ring2="Mummu Ring",
		back=gear.evisceration_jse_back,waist="Reiki Yotai",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}
		
	sets.engaged.Acc.PDT = {}

    
		
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 10; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(6, 5)
    end
end
