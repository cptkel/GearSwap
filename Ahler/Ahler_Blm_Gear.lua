function user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','Resistant','Fodder','Proc','OccultAcumen')
	state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal','PDT','DTHippo')
	state.Weapons:options('None','Nuke','BurstWeapons','Staff')

	--gear.obi_cure_waist = "Witful Belt"
	gear.obi_low_nuke_waist = "Sacro Cord"
	gear.obi_high_nuke_waist = "Sacro Cord"
	
	gear.nuke_jse_back = {name="Taranus's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode') 
	send_command('bind ~^` gs c cycleback ElementalMode') --Robbiewobbie's idea
	
	
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	-- Weapons sets
	sets.weapons.Nuke = {main="Bunzi's Rod",sub="Ammurapi Shield"}
	sets.weapons.BurstWeapons = {}
	sets.weapons.Staff = {main="Mpaca's Staff",sub="Kaja Grip"}
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}	
	
	-- Treasure Hunter
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +1"}

    sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
		head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands=gear.merlinic_fc_hands,ring1="Kishar Ring",ring2="Prolix Ring",
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Gyve Trousers",feet=gear.merlinic_fc_feet}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",})

	sets.precast.FC.Death = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Shattersoul'] = {ammo="Ghastly Tathlum +1",
		head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Regal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Metamor. Ring +1",ring2="Freke Ring",
		back=gear.nuke_jse_back,waist="Fotia Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2",}

    sets.precast.WS['Myrkr'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Saevus pendant +1",ear1="Moonshade Earring",ear2="Etiolation Earring",
		body="Amalric Doublet +1",hands="Spae. Gloves +2",ring1="Mephitas's Ring +1",ring2="Metamor. Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Spae. Tonban +2",feet="Amalric Nails +1"}
		
	sets.precast.WS['Cataclysm'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Sorcerer's Stole +2",ear1="Moonshade Earring",ear2="Malignance Earring",
		body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Epaminondas's Ring",
		back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Arch. Tonban +3",feet="Amalric Nails +1"}
	
	sets.MaxTPMyrkr = {}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
		head=gear.merlinic_fc_head,neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Malignance Earring",
		body="Zendik Robe",hands=gear.merlinic_fc_hands,ring1="Kishar Ring",ring2="Prolix Ring",
		back="Fi Follet Cape +1",waist="Embla Sash",legs="Gyve Trousers",feet=gear.merlinic_fc_feet}

    sets.midcast.Cure = {}
		
    sets.midcast.LightWeatherCure = {}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {}

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
        head="Spae. Petasos +2",neck="Incanter's Torque",ear1="Malignance Earring",ear2="Regal Earring",
        body="Spaekona's Coat +2",hands="Spae. Gloves +2",ring1="Kishar Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Spae. Tonban +2",feet="Spae. Sabots +2"}
		
    sets.midcast['Enfeebling Magic'].Resistant = {}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {legs="Arch. Tonban +3",feet="Arch. Sabots +3"})
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

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {ammo="Pemphredo Tathlum",
		head="Pixie hairpin +1",neck="Incanter's Torque",ear1="Barkaro. Earring",
		ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Fucho-no-obi"}
    
    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Aspir.Death = {}
	
	sets.midcast.Death = {}

    sets.midcast.Stun = {}
		
    sets.midcast.Stun.Resistant = {}

    sets.midcast.BardSong = {}
		
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {head=empty, body="Twilight Cloak"})
		
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {ammo="Ghastly Tathlum +1",
        head="Arch. Petasos +3",neck="Sorcerer's Stole +2",ear1="Malignance Earring",ear2="Regal Earring",
        body="Arch. Coat +3",hands="Arch. Gloves +3",ring1="Freke Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Arch. Tonban +3",feet="Arch. Sabots +3"}
		
    sets.midcast['Elemental Magic'].Resistant = {}
		
    sets.midcast['Elemental Magic'].Fodder = {}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {}) --head=empty,body="Cohort Cloak +1",hands="Amalric Gages +1",feet="Amalric Nails +1"
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Moonlight cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame sollerets"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {}
		
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {feet="Hippo. Socks +1"})

	sets.idle.Death = {}

    sets.idle.Weak = set_combine(sets.idle)

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

	sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.HPDown = {}
		
	sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {back=gear.nuke_jse_back,feet="Wicce Sabots +1"}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +2"}
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {head="Ea Hat +1",neck="Mizu. Kubikazari",hands="Arch. Gloves +3",ring1="Locus Ring",ring2="Mujin Band"}
	sets.ResistantMagicBurst = {}
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 7)
end