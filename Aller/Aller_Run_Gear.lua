function user_setup()

	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DTLite','Tank')
	state.WeaponskillMode:options('Match','Normal','Acc')
	state.CastingMode:options('Normal','SIRD')
	state.PhysicalDefenseMode:options('PDT','PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm','DTCharm')
	state.IdleMode:options('Normal','Tank','KiteTank','Sphere')
	state.Weapons:options('Aettir','Lionheart','Epeolatry','EpeoTank','FellCleave','DualWeapons')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.herculean_phalanx_body = {name="Herculean Vest", augments={'Attack+19','"Dbl.Atk."+1','Phalanx +4','Accuracy+6 Attack+6',}}
	gear.herculean_phalanx_hands = {name="Herculean Gloves", augments={'Accuracy+12','AGI+4','Phalanx +4',}}
	gear.herculean_phalanx_legs = {name="Herculean Trousers", augments={'"Store TP"+1','Enmity-1','Phalanx +4','Accuracy+14 Attack+14','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}
	gear.herculean_phalanx_feet = {name="Herculean Boots", augments={'Mag. Acc.+2','Rng.Atk.+6','Phalanx +5','Accuracy+11 Attack+11',}}
	
	gear.enmity_jse_back = {name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}
	gear.stp_jse_back = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.da_jse_back = {name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.dimi_jse_back = {name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.fc_jse_back = {name="Ogma's cape", augments={'"Fast Cast"+10',}}
	
	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
	send_command('bind ^\\\\ input /ma "Protect IV" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^backspace input /ja "Lunge" <t>')
	send_command('bind @backspace input /ja "Gambit" <t>')
	send_command('bind !backspace input /ja "Rayke" <t>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
	
	select_default_macro_book()
	
	set_lockstyle(2)
end

function init_gear_sets()

    sets.Enmity = {ammo="Aqreqaq Bomblet",
	     head="Halitus Helm",neck="Futhark Torque +1",ear1="Trux Earring",ear2="Cryptic Earring",
	     body="Emet Harness +1",hands="Kurys Gloves",ring1="Vengeful Ring",ring2="Petrov Ring",
		 back=gear.enmity_jse_back,waist="Sinew Belt",legs="Eri. Leg Guards +1",feet="Ahosi Leggings"}
		 
    sets.Enmity.SIRD = {}
	
    sets.Enmity.DT = {} --changing test

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist's Coat +3",back=gear.enmity_jse_back,legs="Futhark Trousers +1"})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist Bottes +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist Mitons +1"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots +1"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons +1"})
    sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
    sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +3", legs="Futhark Trousers +1"})
    sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
    sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist Bottes +1"})
    sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Futhark Bandeau +3"})
    sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist Mitons +1"})
    sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots +1"})
    sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons +1"})
    sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

    sets.precast.JA['Lunge'] = {}

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	sets.element.Earth = {} --neck="Quanpur Necklace"

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",neck="Incanter's Torque",ring1="Stikini Ring +1",ring2="Stikini Ring +1",legs="Rune. Trousers +1"}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	-- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
            head="Rune. Bandeau +3",neck="Orunmila's Torque",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
            body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Kishar Ring",ring2="Gelatinous Ring +1",
            back=gear.fc_jse_back,waist="Carrier's Sash",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"}
			
	sets.precast.FC.DT = {}
			
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {legs="Futhark Trousers +1"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads'})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {}
	sets.precast.WS.Acc = {}
	
	sets.precast.WS['Fell Cleave'] = {ammo="Knobkierrie",
		head=gear.herculean_WSD_head,
		body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
		feet=gear.herculean_WSD_feet,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Sherida earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back=gear.dimi_jse_back,
	}
    sets.precast.WS['Resolution'] = {
		ammo="Seething Bomblet +1",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body=gear.adhemar_dd_body,
		hands="Adhemar Wrist. +1",
		legs="Samnuha Tights",
		feet=gear.herculean_tp_feet,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back=gear.da_jse_back
	}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc,{})
   
	sets.precast.WS['Dimidiation'] = {ammo="Knobkierrie",
		head=gear.herculean_WSD_head,neck="Caro Necklace",left_ear="Moonshade Earring",right_ear="Ishvara Earring",
		body="Adhemar Jacket +1",hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Ilabrat Ring",
		back=gear.dimi_jse_back,waist="Grunfeld Rope",legs="Lustr. Subligar +1",feet="Lustra. Leggings +1"}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS.Acc,{})
	
	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,{})
    sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
	
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast['Lunge'], {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
			
	sets.midcast.FastRecast.DT = {}

    sets.midcast['Enhancing Magic'] = {
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body="Manasa Chasuble",hands="Runeist Mitons +1",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1"}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{
		head="Fu. Bandeau +3",
		body=gear.herculean_phalanx_body,hands=gear.herculean_phalanx_hands,
		legs=gear.herculean_phalanx_legs,feet=gear.herculean_phalanx_feet,})
	sets.midcast['Phalanx'].DT = set_combine(sets.midcast['Phalanx'],{ammo="Staunch Tathlum +1",
		neck="Futhark Torque +1",ear2="Etiolation Earring",
		ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.enmity_jse_back,waist="Flume Belt"})
    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{head="Rune. Bandeau +3",legs="Futhark Trousers +1"}) --sacro,gauntlets,
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1",legs="Futhark Trousers +1"}) --gauntlets
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Foil = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {ammo="Staunch Tathlum +1",
        head="Fu. Bandeau +3",ear1="Mendi. Earring",ear2="Tuisto Earring", --neck="Sacro Gorget"
        body="Vrikodara Jupon",ring1="Defending Ring",ring2="Moonlight Ring",
        waist=gear.ElementalObi,legs="Eri. Leg Guards +1"}
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})
		
	sets.Self_Healing = {} 
	sets.Cure_Received = {}
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

    sets.idle = {ammo="Staunch Tathlum +1",
		head="Turms Cap +1",neck="Futhark Torque +1",ear1="Etiolation Earring",ear2="Tuisto Earring",
		body="Runeist's Coat +3",hands="Turms Mittens +1",ring1="Defending Ring",ring2="Gelatinous Ring +1", -- gauntlets
		back=gear.enmity_jse_back,waist="Flume Belt",legs="Eri. Leg Guards +1",feet="Erilaz Greaves +1"}
		
    sets.idle.Sphere = set_combine(sets.idle,{}) --body="Mekosu. Harness"
			
	sets.idle.Tank = {ammo="Staunch Tathlum +1",
		head="Turms Cap +1",
		body="Runeist's Coat +3",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Futhark Torque +1",
		waist="Engraved Belt",
		ear2="Tuisto Earring",
		ear1="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=gear.enmity_jse_back,}
		
	sets.idle.KiteTank = {}

	sets.idle.Weak = set_combine(sets.idle.Tank, {})

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Aettir = {main="Aettir",sub="Refined Grip +1"}
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.Epeolatry = {main="Epeolatry",sub="Utu Grip"}
	sets.weapons.EpeoTank = {main="Epeolatry",sub="Refined Grip +1"}
	sets.weapons.FellCleave = {main="Kaja Chopper",sub="Utu Grip"}
	sets.weapons.DualWeapons = {}
	
	-- Defense Sets
	
	sets.defense.PDT = {}
	sets.defense.PDT_HP = {}
		
	sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",neck="Futhark torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
        body="Futhark Coat +3",hands="Turms Mittens +1",ring1="Defending Ring",ring2="Moonlight Ring",
        back=gear.enmity_jse_back,waist="Engraved Belt",legs="Aya. Cosciales +2",feet="Turms leggings +1"} 
	sets.defense.MDT_HP = {}
	
	sets.defense.BDT = {}
	sets.defense.BDT_HP = {}
	
	sets.defense.MEVA = {}
	sets.defense.MEVA_HP = {}
		
	sets.defense.Death = {}

	sets.defense.DTCharm = {}
		
	sets.defense.Charm = {}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {ammo="Yamarang",
            head="Adhemar Bonnet +1",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
            body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Petrov Ring",ring2="Ilabrat Ring",
            back=gear.stp_jse_back,waist="Kentarch Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet}
	sets.engaged.Acc = {ammo="Yamarang",
            head="Rune. Bandeau +3",neck="Anu Torque",ear1="Cessance Earring",ear2="Telos Earring", --digni. earring
            body="Runeist's Coat +3",hands="Turms Mittens +1",ring1="Petrov Ring",ring2="Ilabrat Ring",
            back=gear.stp_jse_back,waist="Kentarch Belt +1",legs="Aya. Cosciales +2",feet="Turms Leggings +1"}
	sets.engaged.DTLite = {ammo="Staunch Tathlum +1",
            head="Aya. Zucchetto +2",neck="Anu Torque",ear1="Telos Earring",ear2="Sherida Earring",
            body="Ayanmo Corazza +2",hands="Turms Mittens +1",ring1="Defending Ring",ring2="Moonlight Ring",
            back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet="Meg. Jam. +2"}
    sets.engaged.Acc.DTLite = {}
	sets.engaged.Tank = {
		sub="Refined Grip +1",
		ammo="Staunch Tathlum +1",
		head="Turms Cap +1",
		body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Eabani Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back=gear.enmity_jse_back,
		}
    sets.engaged.Acc.Tank = sets.engaged.Tank
	sets.engaged.AM = set_combine(sets.engaged, {ear1="Dedition Earring",body="Ayanmo Corazza +2",ring1="Niqmaddu Ring",ring2="Chirich Ring +1",waist="Windbuffet Belt +1"})
	
	
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {hands="Turms Mittens +1"}
	sets.buff.Embolden = {back="Evasionist's Cape"}
	
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 10; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'SCH' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(6, 19)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 19)
	elseif player.sub_job == 'SAM' then
		set_macro_page(8, 19)
	elseif player.sub_job == 'DRK' then
		set_macro_page(9, 19)
	elseif player.sub_job == 'NIN' then
		set_macro_page(10, 19)
	else
		set_macro_page(5, 19)
	end
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	When='Always'},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	When='Always'},
		{Name='Aquaveil',	Buff='Aquaveil',		SpellID=55,		When='Always'},
		{Name='Stoneskin',	Buff='Stoneskin',		SpellID=54,		When='Always'},
	},

	Default = {
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	Reapply=false},
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	Reapply=false},
		{Name='Haste',		Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
	},
	
	Tank = {
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	Reapply=false},
		{Name='Cocoon',		Buff='Defense Boost',	SpellID=547,	Reapply=false},
		{Name='Haste',		Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
	},
	
	Full = {
		{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	Reapply=false},
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	Reapply=false},
		{Name='Haste',		Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',		Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Regen IV',	Buff='Regen',			SpellID=477,	Reapply=false},
	},
	Melee = {
		{Name='Temper',		Buff='Multi Strikes',	SpellID=493,	Reapply=false},
		{Name='Haste',		Buff='Haste',			SpellID=57,		Reapply=false},
		{Name='Refresh',	Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Aquaveil',	Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',		Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Phalanx',	Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Regen IV',	Buff='Regen',			SpellID=477,	Reapply=false},
	},
}
