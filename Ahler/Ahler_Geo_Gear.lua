function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Idris','DualWeapons')
	
	gear.nuke_jse_back = {name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.idle_jse_back = {name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
	
	
	gear.obi_low_nuke_waist = "Sacro Cord"
	gear.obi_high_nuke_waist = "Sacro Cord"
	
	autoindi = "Precision"
	autogeo = "Frailty"
	autoentrust = 'Haste'
	autoentrustee = '<p2>'
	
	set_lockstyle(7)
	
	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +3",back=gear.idle_jse_back}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +3"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {head="Bagua Galero +3"}
	
	-- Fast cast sets for spells

	sets.precast.FC = {range="Dunna", --3
		head="Merlinic Hood",neck="Orunmila's Torque", --14,-5
		body="Zendik Robe",hands="Merlinic Dastanas", --13,-6
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Geomancy Pants +3",feet="Merlinic Crackows"} --10,5,15,11

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC,{})
	
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkaro. Earring",hands="Bagua Mitaines +3"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
		
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {range="Dunna", --3
		head="Merlinic Hood",neck="Orunmila's Torque", --14,-5
		body="Zendik Robe",hands="Merlinic Dastanas", --13,-6
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Geomancy Pants +3",feet="Merlinic Crackows"}

	sets.midcast.Geomancy = {main="Idris",sub="Genmei Shield",range="Dunna",
		head="Azimuth Hood +1",neck="Bagua Charm +1",ear1="Calamitous Earring",ear2="Mendi. Earring",
		body="Vedic Coat",hands="Azimuth Gloves +1",ring1="Stikini Ring +1",ring2="Mephitas's Ring +1",
		back="Lifestream Cape",waist="Shinjutsu-no-obi +1",legs="Vanya Slops",feet="Azimuth Gaiters +1"}
		
	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {head={name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},neck="Incanter's Torque",legs="Bagua Pants +3"})
		
    sets.midcast.Cure = {main="Gada",sub="Sors Shield",
		head="Vanya Hood",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Meili Earring",
		body="Vanya Robe",hands="Vanya Cuffs",ring1="Stikini Ring +1",ring2="Haoma's Ring",
		back="Tempered Cape +1",waist="Bishop's Sash",legs="Vanya Slops",feet="Vanya Clogs"}
		
sets.midcast.LightWeatherCure = {}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",ring1="Menelaus's Ring",ring2="Haoma's Ring",})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {}) --main="Oranyan",sub="Clemency Grip"
	
    sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="Bagua Galero +3",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Freke Ring",ring2="Metamor. Ring +1",
		gear.nuke_jse_back,waist="Sacro Cord",legs="Bagua Pants +3", feet="Amalric Nails +1"} 
		

    sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	
	sets.midcast['Dark Magic'] = {}
		
    sets.midcast.Drain = {}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {}
		
	sets.midcast.Stun.Resistant = {}

	sets.midcast.Impact = {head=empty,body="Twilight Cloak"}
		
	sets.midcast['Enfeebling Magic'] = {}
		
	sets.midcast['Enfeebling Magic'].Resistant = {}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})
		
	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club,sub="Ammurapi Shield",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Merciful Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {sub="Genmei Shield",head="Amalric Coif +1"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

	-- Gear for specific elemental nukes.
	sets.element.Wind = {}
	sets.element.Ice = {}
	sets.element.Earth = {}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {}

	-- Idle sets

	sets.idle = {main="Daybreak",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Bagua Galero +3",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Mallquis Saio +2",hands="Bagua Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Fucho-no-Obi",legs="Bagua Pants +3",feet="Geo. Sandals +3"}
	
	sets.idle.PDT = {}
		
	sets.idle.TPEat = set_combine(sets.idle, {})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {main="Idris",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Azimuth Hood +1",neck="Bagua Charm +1",ear1="Etiolation Earring",ear2="Lugalbanda Earring",
		body="Geomancy Tunic +3",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Isa Belt",legs="Gyve Trousers",feet="Bagua Sandals +3"}

	sets.idle.PDT.Pet = {main="Idris",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Bagua Galero +3",neck="Bagua Charm +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Nyame Mail",hands="Geo. Mitaines +3",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.idle_jse_back,waist="Slipor Sash",legs="Nyame Flanchard",feet="Bagua Sandals +3"}
		

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = set_combine(sets.idle, {})

	-- Defense sets
	
	sets.defense.PDT = {}

	sets.defense.MDT = {}
		
    sets.defense.MEVA = {}
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Geo. Sandals +3"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.HPDown = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {}
		
	sets.engaged.DW = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst	mode.
    sets.MagicBurst = {}
	sets.RecoverBurst = {}

	-- Weapons sets
	sets.weapons.Idris = {main='Idris',sub='Genmei Shield'}
	sets.weapons.DualWeapons = {}
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end
