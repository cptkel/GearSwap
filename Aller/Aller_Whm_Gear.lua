-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT','TPEat')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

	
	gear.obi_cure_back = "Alaunus's Cape"
	gear.fc_jse_back = {name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	gear.idle_jse_back = {name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}}
	gear.tp_jse_back = {name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Alaunus's Cape", augments={'MND+10','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}}
	
	gear.vanya_fc = {name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}
	gear.vanya_healing = {name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Yagrush",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Yagrush",sub="C. Palug Hammer"}
	
	sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {}
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",ammo="Impatiens",
		head={ name=gear.vanya_fc, augments={'MP+50','"Fast Cast"+10','Haste+2%',}},neck="Cleric's Torque +1",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back=gear.fc_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {main="Queller Rod",sub="Sors Shield",ear1="Mendi. Earring",ear2="Glorious Earring",body="Ebers Bliaud +1",hands="Vanya Cuffs",ring2="Lebeche Ring",legs="Ebers Pant. +1",feet="Vanya Clogs"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {}) --feet="Hygieia Clogs +1"
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Dagan = {}
		
	sets.MaxTP = {}
	sets.MaxTP.Dagan = {} 

    --sets.precast.WS['Black Nova'] = {}
	
	--sets.precast.WS['Flash Nova'] = {}

    sets.precast.WS['Mystic Boon'] = {
		ammo="Staunch Tathlum +1",
		head={ name="Piety Cap +2", augments={'Enhances "Devotion" effect',}},
		body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},
		hands={ name="Piety Mitts +2", augments={'Enhances "Martyr" effect',}},
		legs={ name="Piety Pantaln. +2", augments={'Enhances "Afflatus Misery" effect',}},
		feet={ name="Piety Duckbills +2", augments={'Enhances "Afflatus Solace" effect',}},
		neck={ name="Clr. Torque +1", augments={'Path: A',}},
		waist="Grunfeld Rope",
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back=gear.wsd_jse_back
	}

    -- Midcast Sets

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {} 
	sets.Cure_Received = {} 
	sets.Self_Refresh = {}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {} --neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"
	
    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap",ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},neck="Cleric's Torque +1",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back=gear.fc_jse_back,waist="Embla Sash",legs="Aya. Cosciales +2",feet="Regal Pumps +1"}
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast
	
	sets.midcast.Cure = {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",
		body="Theo. Briault +2",
		hands="Theophany Mitts +2",
		legs="Ebers Pant. +1",
		feet="Kaykaus Boots",
		neck="Clr. Torque +1",
		waist="Luminary Sash",
		left_ear="Calamitous Earring",
		right_ear="Glorious Earring",
		left_ring="Menelaus's Ring",
		right_ring="Lebeche Ring",
		back=gear.fc_jse_back
	}
		
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{body="Ebers Bliaud +1"})

	sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Menelaus's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.midcast.LightWeatherCureSolace = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Ebers Bliaud +1",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Menelaus's Ring",
		back=gear.fc_jse_back,waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"}
		
	sets.midcast.LightDayCureSolace = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Ebers Bliaud +1",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Menelaus's Ring",
		back="Alaunus's Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.midcast.LightDayCure = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Menelaus's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.midcast.Curaga = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Stikini Ring +1",
		back="Alaunus's Cape",waist="Luminary Sash",legs="Ebers Pant. +1",feet="Kaykaus Boots"}
		
	sets.midcast.LightWeatherCuraga = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Stikini Ring +1",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"}
		
	sets.midcast.LightDayCuraga = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra",neck="Clr. Torque +1",ear1="Calamitous Earring",ear2="Glorious Earring",
		body="Theo. Briault +2",hands="Theophany Mitts +2",ring1="Lebeche Ring",ring2="Menelaus's Ring",
		back="Twilight Cape",waist="Hachirin-no-Obi",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.midcast.Cure.DT = {}
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {}
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {main="Yagrush",sub="Sors Shield",ammo="Hasty Pinion +1",
		head=gear.vanya_healing,neck="Debilis Medallion",ear1="Beatific Earring",ear2="Meili Earring",
		body="Ebers Bliaud +1",hands="Fanatic Gloves",ring1="Haoma's Ring",ring2="Menelaus's Ring",
		back="Alaunus's Cape",waist="Bishop's Sash",legs="Th. Pantaloons +2",feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = {main="Yagrush",sub="Sors Shield",neck="Clr. Torque +1",back="Mending Cape"}
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque +1"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Mending Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Theo. Duckbills +3"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {}) --feet="Ebers Duckbills +1"

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Regen = {main="Bolelabunga",sub="Ammurapi Shield",
		head="Inyanga Tiara +2",
		body="Piety Briault +3", --hands="Eber Mitts +1"
		waist="Embla Sash",legs="Th. Pantaloons +2",feet="Theo. Duckbills +3"}
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = {main="Beneficus",
		neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring", --head="Ebers Cap +1",
		body="Ebers Bliaud +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1", --hands="Ebers Mitts +1"
		back=gear.idle_jse_back,waist="Embla Sash",legs="Piety Pantaln. +2"} --feet="Ebers Duckbills +1"

	sets.midcast.Impact = {}
		
	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast['Divine Magic'] = {}
		
	sets.midcast.Holy = {}

	sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {}

    sets.midcast.Drain.Resistant = {}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}

	sets.midcast.Stun.Resistant = {}

	sets.midcast['Enfeebling Magic'] = {}

	sets.midcast['Enfeebling Magic'].Resistant = {}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Inyanga Tiara +2",
		body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Warder's Charm +1",
		waist="Slipor Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Inyanga Ring",
		back=gear.idle_jse_back
	}

	sets.idle.PDT = {}
		
    sets.idle.TPEat = set_combine(sets.idle, {})

	sets.idle.Weak = {}

    -- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.defense.MEVA = {}	
		
	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {}

		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		right_ring="Hetairoi Ring",
		back=gear.tp_jse_back
	}

    sets.engaged.Acc = {}

	sets.engaged.DW = {
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Hetairoi Ring",
		back=gear.tp_jse_back
	}

    sets.engaged.DW.Acc = {}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {back="Mending Cape"} --hands="Ebers Mitts +1"

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 8)
end