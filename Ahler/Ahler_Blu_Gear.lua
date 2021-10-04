function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.WeaponskillMode:options('Match','Normal','Acc')
    state.CastingMode:options('Normal','Evasion','Ody')
    state.IdleMode:options('Normal','Evasion','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('MagicWeapons','Tizbron','Sanguine','TizMACC','Tank','Savage','None')
	state.AutoBuffMode:options('Off','Auto','Default','Cleave')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

	gear.mab_wsd_back = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%',}}
	gear.tp_jse_back = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.nuking_back = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.expsb_jse_back = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.evasion_jse_back = {name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Mag.Atk.Bns."+10','Evasion+15',}}
	
	--gear.obi_cure_waist = ""
	--gear.obi_nuke_waist = ""
	--gear.obi_cure_back = ""

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	
	select_default_macro_book()
	
	set_lockstyle(3)
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +3",feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +2"}
	sets.buff.Convergence = {}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +2"}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {}


	-- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Sapience Orb",
		head="Carmine Mask +1",neck="Orunmila's torque",ear1="Enchntr. Earring +1",ear2="Odnowa Earring +1",
		body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Kishar Ring",ring2="Gelatinous Ring +1",
		back="Fi Follet Cape +1",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Carmine Greaves +1"} 
		
		
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {}) --body="Passion Jacket"

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})
	
	--[[sets.precast.FC['Blue Magic'].Evasion = set_combine(sets.precast.FC, {ammo="Amar Cluster",
		head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.evasion_jse_back,waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"})]]--	


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	sets.precast.WS.Acc = {}

	sets.precast.WS.DT = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = {ammo="Knobkierrie",
		head=gear.herculean_WSD_head,neck="Mirage Stole +1",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring", ring2="Epaminondas's Ring",
		back=gear.expsb_jse_back,waist="Sailfi Belt +1",legs="Luhlaza Shalwar +3",feet="Jhakri Pigaches +2"}
		
	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
	
	sets.precast.WS['Expiacion'] = {ammo="Aurgelmir Orb +1",
		head=gear.herculean_WSD_head,neck="Mirage Stole +1",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ilabrat Ring", ring2="Epaminondas's Ring",
		back=gear.expsb_jse_back,waist="Sailfi Belt +1",legs="Luhlaza Shalwar +3",feet="Jhakri Pigaches +2"}
		
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Expiacion'].DT = set_combine(sets.precast.WS.DT, {})
	
	--[[sets.precast.WS['Sanguine Blade'] = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Baetyl Pendant",ear2="Friomisi Earring",ear1="Regal Earring",
		body="Amalric Doublet +1",hands="Jhakri Cuffs +2",ring1="Archon Ring",ring2="Epaminondas's Ring",
		back=gear.mab_wsd_back,waist=gear.ElementalObi,legs="Luhlaza Shalwar +3",feet="Amalric Nails +1"}]]--
					 
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {ear2="Regal Earring",ring1="Metamor. Ring +1",waist="Luminary Sash"})

	sets.precast.WS['Flash Nova'] = {}
					 
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.AccMaxTP = {ear1="Regal Earring",ear2="Telos Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = {}

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {}

	sets.midcast['Blue Magic'].PhysicalAcc = {}

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	
	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {ammo="Ghastly Tathlum +1",
		 neck="Baetyl Pendant",ear2="Friomisi Earring",ear1="Regal Earring",
		 body="Cohort Cloak +1",hands="Amalric Gages +1",ring1="Metamor. Ring +1",ring2="Shiva Ring +1",
		 back=gear.nuking_back,waist=gear.ElementalObi,legs="Luhlaza Shalwar +3",feet="Amalric Nails +1"}
					 
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Pemphredo Tathlum",
		head="Assim. Keffiyeh +3",neck="Mirage Stole +1",ear1="Regal Earring",ear2="Digni. Earring",
		body="Malignance Tabard",hands="Malignance Gloves",left_ring="Metamor. Ring +1",right_ring="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Assim. Shalwar +3",feet="Malignance Boots"}
   
	sets.midcast['Enfeebling Magic'] = {}

	sets.midcast['Dark Magic'] = {}

	sets.midcast['Enhancing Magic'] = {}
		
	sets.midcast['Phalanx'] = {}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast['Divine Magic'] = {}

	sets.midcast['Elemental Magic'] = {}


	sets.midcast.Helix = sets.midcast['Elemental Magic']
	
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Light = {} --ring2="Weatherspoon Ring"

	sets.midcast.Cure = {}

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = {}

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {head="Carmine Mask +1",ear1="Njordr Earring",ring1="Stikini Ring +1",waist="Eschan Stone",legs="Malignance Tights"})

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['Dream Flower'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})
	
	sets.midcast['Blue Magic']['Dream Flower'].Evasion = set_combine(sets.precast.FC, {ammo="Amar Cluster",
		head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.evasion_jse_back,waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"})
	
	sets.midcast['Blue Magic']['Dream Flower'].Ody = sets.midcast['Blue Magic']['Dream Flower'].Evasion
	
	sets.midcast['Blue Magic']['Entomb'] = sets.midcast['Blue Magic'].Magical
	
	sets.midcast['Blue Magic']['Entomb'].Ody = sets.midcast['Blue Magic']['Dream Flower'].Evasion
	
	--[[sets.midcast['Blue Magic']['Entomb'].Evasion = set_combine(sets.precast.FC, {ammo="Amar Cluster",
		head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.evasion_jse_back,waist="Flume Belt +1",legs="Malignance Tights",feet="Malignance Boots"})]]--
	
	sets.midcast['Blue Magic']['White Wind'] = {}
					
	sets.midcast['Blue Magic']['Healing Breeze'] = sets.midcast['Blue Magic']['White Wind']

	sets.midcast['Blue Magic'].Healing = {}

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {}

	sets.midcast['Blue Magic'].SkillBasedBuff = {
		head="Luh. Keffiyeh +3",neck="Mirage Stole +1",ear1="Njordr Earring",
		body="Assim. Jubbah +3",hands="Rawhide Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Cornflower Cape",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +2"}

	sets.midcast['Blue Magic'].Buff = {}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})
	
	
	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +1"}

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum +1",
		head=gear.herculean_refresh_head,neck="Bathy Choker +1",ear1="Etiolation Earring", ear2="Odnowa Earring +1",
		body="Jhakri Robe +2",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.tp_jse_back,waist="Fucho-no-obi",legs=gear.herculean_refresh_legs,feet=gear.herculean_refresh_feet}

	sets.idle.Evasion = {ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.evasion_jse_back,waist="Kasiri Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.idle.PDT = {}
	
	sets.idle.DTHippo = set_combine(sets.idle.Evasion, {legs="Carmine Cuisses +1",feet="Hippo. Socks +1"})

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.defense.MEVA = {}

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.MagicWeapons = {main="Maxentius",sub="Bunzi's Rod"}
	sets.weapons.Tizbron = {main="Tizona",sub="Thibron"}
	sets.weapons.Sanguine = {main="Naegling",sub="Maxentius"}
	sets.weapons.TizMACC = {main="Tizona",sub="Naegling"}
	sets.weapons.Tank = {main="Tizona",sub="Sakpata's Sword"}
	sets.weapons.Savage = {main="Naegling",sub="Thibron"}
	

	-- Engaged sets

	sets.engaged = {ammo="Ginsen",
		head="Adhemar Bonnet +1",neck="Mirage Stole +1",ear1="Telos Earring",ear2="Suppanomimi",
		body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet}

	sets.engaged.AM = {ammo="Ginsen",
		head="Malignance Chapeau",neck="Mirage Stole +1",ear1="Telos Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc = set_combine(sets.engaged, {})

	sets.engaged.Acc.AM = set_combine(sets.engaged.AM, {})

	sets.engaged.DT = {ammo="Ginsen",
		head="Adhemar Bonnet +1",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Epona's Ring",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT.AM = {ammo="Ginsen",
		head="Malignance Chapeau",neck="Mirage Stole +1",ear1="Telos Earring",ear2="Eabani Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {ammo="Amar Cluster",
		head="Malignance Chapeau",neck="Mirage Stole +1",
		ring2="Chirich Ring +1"})
				
	sets.engaged.Acc.DT.AM = {}

	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	sets.MagicBurst = {}
	sets.Phalanx_Received = {}
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 10; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 3)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 3)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 3)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 3)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 3)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 3)
	else
		set_macro_page(6, 3)
	end
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.chat.input('/ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	When='Always'},
		{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	When='Idle'},
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	When='Idle'},
		{Name='Nat. Meditation',	Buff='Attack Boost',	SpellID=700,	When='Engaged'},
		{Name='Mighty Guard',		Buff='Mighty Guard',	SpellID=750,	When='Combat'},
	},
	
	Default = {
		{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	Reapply=false},
		{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	Reapply=false},
		{Name='Refresh',			Buff='Refresh',			SpellID=109,	Reapply=false},
		{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	Reapply=false},
		{Name='Barrier Tusk',		Buff='Phalanx',			SpellID=685,	Reapply=false},
		{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Occultation',		Buff='Blink',			SpellID=679,	Reapply=false},
		{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Mighty Guard',		Buff='Mighty Guard',	SpellID=750,	Reapply=false},
		{Name='Nat. Meditation',	Buff='Attack Boost',	SpellID=700,	Reapply=false},
	},
	
	Cleave = {
		{Name='Erratic Flutter',	Buff='Haste',			SpellID=710,	Reapply=false,	When='Always'},
		--{Name='Battery Charge',		Buff='Refresh',			SpellID=662,	Reapply=false},
		--{Name='Refresh',			Buff='Refresh',			SpellID=109,	Reapply=false},
		--{Name='Phalanx',			Buff='Phalanx',			SpellID=106,	Reapply=false},
		--{Name='Barrier Tusk',		Buff='Phalanx',			SpellID=685,	Reapply=false},
		--{Name='Stoneskin',			Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Occultation',		Buff='Blink',			SpellID=679,	Reapply=false,	When='Always'},
		--{Name='Blink',				Buff='Blink',			SpellID=53,		Reapply=false},
		--{Name='Carcharian Verve',	Buff='Aquaveil',		SpellID=745,	Reapply=false},
		{Name='Memento Mori',		Buff='Magic Atk. Boost',SpellID=538,	Reapply=false,	When='Idle'},
	},
}


