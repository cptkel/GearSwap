-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DTLite','DT')
	state.RangedMode:options('Normal','Acc')
	state.WeaponskillMode:options('Match','Normal','Acc')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('None','Default','LastStand','DualSavageWeapons','DualEviscerationWeapons','DualMalevolence','Aeolian','Gandiva')
	
	WeaponType =  {['Sparrowhawk +2'] = "Bow",
                   ['Fomalhaut'] = "Gun",
				   ['Anarchy +2'] = "Gun",
                   ['Annihilator'] = "Gun",
				   ['Gastraphetes'] = "Crossbow",
				   ['Gandiva'] = "Bow",
				   }

	DefaultAmmo = {
		['Bow']  = {['Default'] = "Voluspa Arrow",
					['WS'] = "Voluspa Arrow",
					['Acc'] = "Voluspa Arrow",
					['Magic'] = "Voluspa Arrow",
					['MagicAcc'] = "Voluspa Arrow",
					['Unlimited'] = "Hauksbok Arrow",
					['MagicUnlimited'] ="Hauksbok Arrow",
					['MagicAccUnlimited'] ="Hauksbok Arrow"},
					
		['Gun']  = {['Default'] = "Chrono Bullet",
					['WS'] = "Chrono Bullet",
					['Acc'] = "Chrono Bullet",
					['Magic'] = "Orichalc. Bullet",
					['MagicAcc'] = "Orichalc. Bullet",
					['Unlimited'] = "Hauksbok Bullet",
					['MagicUnlimited'] = "Hauksbok Bullet",
					['MagicAccUnlimited'] ="Animikii Bullet"},
					
		['Crossbow'] = {['Default'] = "Quelling Bolt",
						['WS'] = "Quelling Bolt",
						['Acc'] = "Quelling Bolt",
						['Magic'] = "Quelling Bolt",
						['MagicAcc'] = "Quelling Bolt",
						['Unlimited'] = "Hauksbok Bolt",
						['MagicUnlimited'] = "Hauksbok Bolt",
						['MagicAccUnlimited'] ="Hauksbok Bolt"}
	}
	
	gear.tp_jse_back = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.tp_crit_back = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.snapshot_jse_back = {name="Belenus's Cape", augments={'"Snapshot"+10',}}
	gear.tf_jse_back = {name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.rngtp_jse_back = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
	gear.crit_jse_back = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','Crit.hit rate+10',}}
	gear.dexcrit_jse_back = {name="Belenus's Cape", augments={'DEX+20','Rng.Acc.+20 Rng.Atk.+20','DEX+10','Crit.hit rate+10',}}
	gear.laststand_jse_back = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	
	--ammostock = 98
	  
	  -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	
	set_lockstyle(2)
	
	select_default_macro_book()

	data.equipment.rema_ranged_weapons_ammo = {
	['Fomalhaut'] = 'Chrono Bullet',
	['Death Penalty'] = 'Living Bullet',
	['Armageddon'] = 'Devastating Bullet',
	['Fail-Not'] = 'Chrono Arrow',
	['Gandiva'] = 'Chrono Arrow',
	['Gastraphetes'] = "Quelling Bolt",
	['Yoichinoyumi'] = "Yoichi's Arrow",
	['Annihilator'] = 'Chrono Bullet'
	}

	data.equipment.rema_ranged_weapons_ammo_pouch = {
	['Fomalhaut'] = 'Chr. Bul. Pouch',
	['Death Penalty'] = 'Liv. Bul. Pouch',
	['Armageddon'] = 'Dev. Bul. Pouch',
	['Fail-Not'] = 'Chrono Quiver',
	['Gandiva'] = 'Chrono Quiver',
	['Gastraphetes'] = "Quelling B. Quiver",
	['Yoichinoyumi'] = "Yoichi's Quiver",
	['Annihilator'] = 'Chr. Bul. Pouch'
	}
end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {} --body="Orion Jerkin +1"
	sets.precast.JA['Scavenge'] = {} --feet="Orion Socks +1"
	sets.precast.JA['Shadowbind'] = {} --hands="Orion Bracers +1"
	sets.precast.JA['Sharpshot'] = {} --legs="Orion Braccae +3"
	sets.precast.JA['Double Shot'] = {back=gear.rngtp_jse_back}


	-- Fast cast sets for spells

    sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


	-- Ranged sets (snapshot)

	sets.precast.RA = 	{
		head="Orion Beret +3",neck="Scout's Gorget +2",
		body="Amini Caban +1",hands="Carmine Fin. Ga. +1",
		back=gear.snapshot_jse_back,waist="Impulse Belt",legs="Orion Braccae +2",feet="Meg. Jam. +2",
	}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {legs="Adhemar Kecks +1",feet="Meg. Jam. +2",})
	sets.precast.RA.Flurry.Gastraphetes = set_combine(sets.precast.RA, {legs="Adhemar Kecks +1",feet="Pursuer's Gaiters",})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {waist="Yemaya Belt",legs="Pursuer's Pants",feet="Arcadian Socks +2",})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.Acc = {}

    sets.precast.WS['Last Stand'] = {
		head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Ishvara Earring",ear2="Moonshade Earring",
		body=gear.herculean_wsd_body,hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Epaminondas's Ring",
		back=gear.laststand_jse_back,waist="Fotia Belt",legs="Arc. Braccae +3",feet=gear.herculean_wsd_feet}
	
	sets.precast.WS['Wildfire'] = {}

    sets.precast.WS['Wildfire'].Acc = {}
		
    sets.precast.WS['Coronach'] = {
		head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Ishvara Earring",ear2="Sherida Earring",
		body=gear.herculean_wsd_body,hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Regal Ring",
		back=gear.laststand_jse_back,waist="Fotia Belt",legs="Arc. Braccae +3",feet=gear.herculean_wsd_feet}
	
	sets.precast.WS['Aeolian Edge'] = {}
	
	sets.precast.WS["Jishnu's Radiance"] = {
			head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Odr Earring",ear2="Sherida Earring",
			body="Meg. Cuirie +2",hands="Mummu Wrists +2",ring1="Regal Ring",ring2="Begrudging Ring",
			back=gear.dexcrit_jse_back,waist="Fotia Belt",legs="Jokushu Haidate",feet="Thereoid Greaves"}
	
	sets.precast.WS['Evisceration'] = {
		head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Mache Earring +1",
        body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Mummu Ring",ring2="Regal Ring",
        back=gear.tp_crit_back,waist="Fotia Belt",legs="Samnuha Tights",feet="Mummu Gamash. +2"}
		
	sets.precast.WS['Aeolian Edge'] = {
		neck="Scout's Gorget +2",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Cohort Cloak +1",hands=gear.herculean_mab_hands,ring1="Epaminondas's Ring",ring2="Dingir Ring",
		back=gear.tf_jse_back,waist=gear.ElementalObi,legs=gear.herculean_leaden_legs,feet=gear.herculean_wsd_feet,
	}
		
	
    sets.precast.WS['Trueflight'] = {
		neck="Scout's Gorget +2",ear1="Friomisi Earring",ear2="Moonshade Earring",
		body="Cohort Cloak +1",hands=gear.herculean_mab_hands,ring1="Epaminondas's Ring",ring2="Dingir Ring",
		back=gear.tf_jse_back,waist=gear.ElementalObi,legs=gear.herculean_leaden_legs,feet=gear.herculean_wsd_feet,
	}

    sets.precast.WS['Trueflight'].Acc = {}
	
	sets.precast.WS['Savage Blade'] = {
		head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Moonshade Earring",ear2="Ishvara Earring",
		hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Karieyh Ring",
		waist="Sailfi Belt +1",
	}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
    sets.midcast.FastRecast = {}
		
	-- Ranged sets

    sets.midcast.RA = {main="Perun +1",sub="Nusku Shield",
		head="Arcadian Beret +3",neck="Scout's Gorget +2",ear1="Telos Earring",ear2="Dedition Earring",
		body="Nisroch Jerkin",hands="Malignance Gloves",ring1="Regal Ring",ring2="Ilabrat Ring",
		back=gear.rngtp_jse_back,waist="K. Kachina Belt +1",legs="Malignance Tights",feet="Malignance Boots",
	}
	
    sets.midcast.RA.Acc = {}
	
	sets.midcast.RA.Gandiva = set_combine(sets.midcast.RA, {})
	sets.midcast.RA.Gandiva.AM = {
		head="Meghanada Visor +2",neck="Scout's Gorget +2",ear1="Telos Earring",ear2="Enervating Earring",
		body="Nisroch Jerkin",hands="Mummu Wrists +2",ring1="Begrudging Ring",ring2="Mummu Ring",
		back=crit_jse_back,waist="K. Kachina Belt +1",legs="Mummu Kecks +2",feet="Osh. Leggings +1",}
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {} --body="Orion Jerkin +1"
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {
		head="Arcadian Beret +3",
		body="Arcadian Jerkin +3",
		back=gear.rngtp_jse_back,legs="Osh. Trousers +1",feet="Osh. Leggings +1"
	}
	sets.buff['Double Shot'].Acc = {}
	sets.buff.Barrage = {
		head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Enervating Earring",ear2="Telos Earring",
		body="Orion Jerkin +2",hands="Orion Bracers +2",ring1="Regal Ring",
		back=gear.crit_jse_back,waist="K. Kachina Belt +1",feet="Orion Socks +2"
	}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
    sets.idle = {
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Eabani Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Vengeful Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}
		
    sets.defense.MEVA = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons.Default = {main="Kustawi +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.LastStand = {main="Perun +1",sub="Nusku Shield",range="Fomalhaut"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Blurred Knife +1",range="Sparrowhawk +2",ammo="Hauksbok Arrow"}
	sets.weapons.DualEviscerationWeapons = {main="Tauret",sub="Ternion Dagger +1",range="Anarchy +2"}
	sets.weapons.DualMalevolence = {main="Malevolence",sub="Malevolence",range="Gastraphetes"}
	sets.weapons.Aeolian = {main="Tauret",sub="Malevolence",range="Sparrowhawk +2",ammo="Hauksbok Arrow"}
	sets.weapons.Gandiva = {main="Oneiros Knife",sub="Nusku Shield",range="Gandiva"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    -- Normal melee group
    sets.engaged = {
		head="Adhemar Bonnet +1",neck="Iskur Gorget",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet}
    
    sets.engaged.Acc = {}

    sets.engaged.DTLite = {}
		
    sets.engaged.DT = {}

    sets.engaged.DW = {
		head="Adhemar Bonnet +1",neck="Scout's Gorget +2",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet
	}
	sets.engaged.DW.DTLite = {}
	sets.engaged.DW.DT = {
        head="Malignance Chapeau",neck="Loricate torque +1",ear1="Suppanomimi",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Malignance Gloves",ring1="Gelatinous Ring +1",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}	
   
    
    sets.engaged.DW.Acc = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

--set lockstyle
function set_lockstyle(lockstyleset)
    send_command('wait 3; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 19)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 19)
    else
        set_macro_page(1, 19)
    end
end
