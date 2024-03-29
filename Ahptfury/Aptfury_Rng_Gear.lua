-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
  state.OffenseMode:options('Normal','Acc')
  state.HybridMode:options('Normal','DTLite','DT')
  state.RangedMode:options('Normal','Acc')
  state.WeaponskillMode:options('Match','Normal','Acc')
  state.IdleMode:options('Normal', 'PDT')
  state.Weapons:options('Default','LastStand','DualSavageWeapons','DualEviscerationWeapons','DualMalevolence','Aeolian','Gandiva','Detonator','Coronach','None')
  
  WeaponType =  {['Sparrowhawk +2'] = "Bow",
           ['Fomalhaut'] = "Gun",
           ['Anarchy +2'] = "Gun",
           ['Annihilator'] = "Gun",
           ['Armageddon'] = "Gun",
           ['Gastraphetes'] = "Crossbow",
           ['Gandiva'] = "Bow",
           }

  DefaultAmmo = {
    ['Bow']  = {['Default'] = "Chrono Arrow",
          ['WS'] = "Chrono Arrow",
          ['Acc'] = "Chrono Arrow",
          ['Magic'] = "Chrono Arrow",
          ['MagicAcc'] = "Chrono Arrow",
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
  
  
  
  ammostock = 98
    
    -- Additional local binds
  send_command('bind numpad0 input /ra <t>')
  send_command('bind numpad1 input /ja "Double Shot" <me>')
  send_command('bind numpad3 input /ws Last Stand <t>')
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
  sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
  sets.precast.JA['Scavenge'] = {feet="Orion Socks +2"}
  sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +3"}
  sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
  sets.precast.JA['Double Shot'] = {back=gear.rngtp_jse_back}


  -- Fast cast sets for spells

  sets.precast.FC = {}

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


  -- Ranged sets (snapshot)

  sets.precast.RA =   {
    head="Taeon Chapeau",neck="Scout's Gorget +2",
    body="Amini Caban +1",hands="Carmine Fin. Ga. +1",ring1="Crepuscular Ring",
    back=gear.snapshot_jse_back,waist="Yemaya Belt",legs="Orion Braccae +3",feet="Meg. Jam. +2"}
  sets.precast.RA.Gastraphetes = set_combine(sets.precast.RA, {head="Orion Beret +3"})  
  sets.precast.RA.Flurry = set_combine(sets.precast.RA, {head="Orion Beret +3",legs="Adhemar Kecks +1",feet="Meg. Jam. +2",})
  sets.precast.RA.Flurry.Gastraphetes = set_combine(sets.precast.RA.Flurry, {feet="Pursuer's Gaiters",})
  sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, {feet="Arcadian Socks +3",}) --75 snapshot
  sets.precast.RA.Flurry2.Gastraphetes = set_combine(sets.precast.RA.Flurry2, {legs="Pursuer's Pants"})
  
  sets.precast.RA.Embrava = set_combine(sets.precast.RA.Flurry2, {}) --embrava is 25 snapshot

  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {}
    
  sets.precast.WS.Acc = {}

  sets.precast.WS['Last Stand'] = {
    head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Ishvara Earring",ear2="Moonshade Earring",
    body="Nyame Mail",hands="Meg. Gloves +2",ring1="Regal Ring",ring2="Epaminondas's Ring",
    back=gear.laststand_jse_back,waist="Fotia Belt",legs="Arc. Braccae +3",feet="Nyame Sollerets"}
  
  sets.precast.WS['Wildfire'] = {
    neck="Scout's Gorget +2",ear1="Friomisi Earring",ear2="Crematio Earring",
    body="Cohort Cloak +1",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Dingir Ring",
    back=gear.tf_jse_back,waist="Orpheus's Sash",legs="Arc. Braccae +3",feet="Nyame Sollerets"}

  sets.precast.WS['Wildfire'].Acc = {}
    
  sets.precast.WS['Coronach'] = {
    head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Ishvara Earring",ear2="Sherida Earring",
    body="Nyame Mail",hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Regal Ring",
    back=gear.laststand_jse_back,waist="Fotia Belt",legs="Arc. Braccae +3",feet="Nyame Sollerets"}
  
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
    body="Cohort Cloak +1",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Dingir Ring",
    back=gear.tf_jse_back,waist=gear.ElementalObi,legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
  
  sets.precast.WS['Trueflight'] = {
    neck="Scout's Gorget +2",ear1="Friomisi Earring",ear2="Moonshade Earring",
    body="Cohort Cloak +1",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Dingir Ring",
    back=gear.tf_jse_back,waist=gear.ElementalObi,legs="Arc. Braccae +3",feet="Nyame Sollerets"}

  sets.precast.WS['Trueflight'].Acc = {}
  
  sets.precast.WS['Savage Blade'] = {
    head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Moonshade Earring",ear2="Ishvara Earring",
    body="Nyame Mail",hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Karieyh Ring",
    waist="Sailfi Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
  
  sets.precast.WS['Detonator'] = {
    head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Moonshade Earring",ear2="Ishvara Earring",
    body="Ikenga's Vest",hands="Meg. Gloves +2",ring1="Epaminondas's Ring",ring2="Regal Ring",
    back=gear.laststand_jse_back,waist="Fotia Belt",legs="Arc. Braccae +3",feet="Nyame Sollerets"}
    
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
    back=gear.rngtp_jse_back,waist="K. Kachina Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
  
  sets.midcast.RA.Acc = {head="Orion Beret +3",ear2="Enervating Earring",ring1="Cacoethic Ring +1",feet="Orion Socks +2"}
  
  sets.midcast.RA.Gandiva = set_combine(sets.midcast.RA, {})
  sets.midcast.RA.Gandiva.AM = {
    head="Meghanada Visor +2",neck="Scout's Gorget +2",ear1="Telos Earring",ear2="Odr Earring",
    body="Nisroch Jerkin",hands="Mummu Wrists +2",ring1="Begrudging Ring",ring2="Mummu Ring",
    back=gear.crit_jse_back,waist="K. Kachina Belt +1",legs="Mummu Kecks +2",feet="Osh. Leggings +1"}
    
  sets.midcast.RA.Armageddon = set_combine(sets.midcast.RA, {})
  sets.midcast.RA.Armageddon.AM = {
    head="Meghanada Visor +2",neck="Scout's Gorget +2",ear1="Telos Earring",ear2="Odr Earring",
    body="Nisroch Jerkin",hands="Mummu Wrists +2",ring1="Begrudging Ring",ring2="Mummu Ring",
    back=gear.crit_jse_back,waist="K. Kachina Belt +1",legs="Mummu Kecks +2",feet="Osh. Leggings +1"}
    
  --These sets will overlay based on accuracy level, regardless of other options.
  sets.buff.Camouflage = {body="Orion Jerkin +3"}
  sets.buff.Camouflage.Acc = {}
  sets.buff['Double Shot'] = {
    head="Oshosi Mask +1",
    body="Arcadian Jerkin +3",hands="Oshosi Gloves +1",
    back=gear.rngtp_jse_back,legs="Osh. Trousers +1",feet="Osh. Leggings +1"}
  sets.buff['Double Shot'].AM = set_combine(sets.buff['Double Shot'], {hands="Mummu Wrists +2",back=gear.crit_jse_back})
  sets.buff['Double Shot'].Acc = {}
  sets.buff.Barrage = {
    head="Orion Beret +3",neck="Scout's Gorget +2",ear1="Enervating Earring",ear2="Telos Earring",
    body="Orion Jerkin +3",hands="Orion Bracers +3",ring1="Regal Ring",ring2="Cacoethic Ring +1",
    back=gear.crit_jse_back,waist="K. Kachina Belt +1",legs="Adhemar Kecks +1",feet="Orion Socks +2"}
  
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
  sets.weapons.Default = {main="Oneiros Knife",sub="Nusku Shield",range="Armageddon"}
  sets.weapons.LastStand = {main="Perun +1",sub="Nusku Shield",range="Fomalhaut"}
  sets.weapons.DualSavageWeapons = {main="Naegling",sub="Blurred Knife +1",range="Sparrowhawk +2",ammo="Hauksbok Arrow"}
  sets.weapons.DualEviscerationWeapons = {main="Tauret",sub="Ternion Dagger +1",range="Anarchy +2"}
  sets.weapons.DualMalevolence = {main="Malevolence",sub="Malevolence",range="Gastraphetes"}
  sets.weapons.Aeolian = {main="Tauret",sub="Malevolence",range="Sparrowhawk +2",ammo="Hauksbok Arrow"}
  sets.weapons.Gandiva = {main="Oneiros Knife",sub="Nusku Shield",range="Gandiva"}
  sets.weapons.Detonator = {main="Ternion Dagger +1",sub="Nusku Shield",range="Armageddon"}
  sets.weapons.Coronach = {main="Ternion Dagger +1",sub="Perun +1",range="Annihilator"}
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
    back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_tp_feet}
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
    set_macro_page(2, 19)
  elseif player.sub_job == 'DNC' then
    set_macro_page(1, 19)
  elseif player.sub_job == 'DRG' then
    set_macro_page(3, 19)
  else
    set_macro_page(1, 19)
  end
end

function job_post_precast(spell, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if not (spell.skill == 'Marksmanship' or spell.skill == 'Archery') and WeaponType[player.equipment.range] == 'Bow' and item_available('Hauksbok Arrow') then
      equip({ammo="Hauksbok Arrow"})
    end
  
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
        elseif S{25,26}:contains(spell.skill) then
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
    
  elseif spell.action_type == 'Ranged Attack' then
      if buffactive.Embrava then      
      if buffactive.Flurry then
      if lastflurry == 1 then
        if sets.precast.RA[state.Weapons.value] and sets.precast.RA[state.Weapons.value].Flurry then
          equip(sets.precast.RA[state.Weapons.value].FlurryEM)
        elseif sets.precast.RA.Flurry then
          equip(sets.precast.RA.FlurryEM)
        end
      elseif lastflurry == 2 then
        if sets.precast.RA[state.Weapons.value] and sets.precast.RA[state.Weapons.value].Flurry2 then
          equip(sets.precast.RA[state.Weapons.value].Flurry2EM)
        elseif sets.precast.RA.Flurry2 then
          equip(sets.precast.RA.Flurry2EM)
          
        end
        end
        end              
      if sets.precast.RA[state.Weapons.value] and sets.precast.RA[state.Weapons.value].Embrava then
          equip(sets.precast.RA[state.Weapons.value].Embrava)
      elseif  sets.precast.RA.Embrava then
      equip(sets.precast.RA.Embrava)
      end
      end
    
    if buffactive.Flurry then
      if lastflurry == 1 then
        if sets.precast.RA[state.Weapons.value] and sets.precast.RA[state.Weapons.value].Flurry then
          equip(sets.precast.RA[state.Weapons.value].Flurry)
        elseif sets.precast.RA.Flurry then
          equip(sets.precast.RA.Flurry)
        end
      elseif lastflurry == 2 then
        if sets.precast.RA[state.Weapons.value] and sets.precast.RA[state.Weapons.value].Flurry2 then
          equip(sets.precast.RA[state.Weapons.value].Flurry2)
        elseif sets.precast.RA.Flurry2 then
          equip(sets.precast.RA.Flurry2)
        end
      end
    end

    if statusammo then
      equip({ammo=statusammo})
    end
  end
end