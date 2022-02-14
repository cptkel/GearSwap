function user_setup()
  -- Options: Override default values
  state.OffenseMode:options('Normal','Acc','SB')
  state.WeaponskillMode:options('Match','Macc','Normal','Acc')
  state.HybridMode:options('Normal', 'PDT','PDTOnly')
  state.PhysicalDefenseMode:options('PDT', 'SB')
  state.MagicalDefenseMode:options('MDT')
  state.ResistDefenseMode:options('MEVA')
  state.IdleMode:options('Normal','Evasion')
  state.Weapons:options('None','Godhands','Verethragna','ShellCrusher','Cataclysm','ProcStaff','ProcClub','Barehanded','ProcSword','ProcGreatSword','ProcScythe','ProcPolearm','ProcGreatKatana')

  state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}

  update_melee_groups()
  
  gear.rao_head = {name="Rao Kabuto +1", augments={'STR+12','DEX+12','Attack+20',}}
  gear.ryuo_hands = {name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
  
  gear.tp_back = {name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.STRcrit_back = {name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
  gear.STRda_back = {name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.macc_back = {name="Segomo's Mantle", augments={'DEX+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  
  set_lockstyle(5)
  
  autows = 'Howling Fist'
  autowstp = 1000
  
  -- Additional local binds
  send_command('bind ^` input /ja "Boost" <me>')
  send_command('bind !` input /ja "Perfect Counter" <me>')
  send_command('bind ^backspace input /ja "Mantra" <me>')
  send_command('bind @` gs c cycle SkillchainMode')
  
  send_command('bind !c gs c weapons ShellCrusher;gs c update')
  send_command('bind !g gs c weapons Godhands;gs c update')
  send_command('bind !v gs c weapons Verethragna;gs c update')
  
  select_default_macro_book()
end

function user_job_post_precast(spell, spellMap, eventArgs)
  
  if spell.type == 'WeaponSkill' then
    if (spell.english == 'Spinning Attack' or spell.english == 'Cataclysm') and state.TreasureMode.value ~= 'None' then
      equip(sets.TreasureHunter)
      return
    end
  end
end
    
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------
  
  -- Precast Sets
  
  -- Precast sets to enhance JAs on use
  sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
  sets.precast.JA['Boost'] = {} --hands="Anchorite's Gloves +1"
  sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
  sets.precast.JA['Focus'] = {} --head="Anchorite's Crown +1"
  sets.precast.JA['Counterstance'] = {} --feet="Hesychast's Gaiters +1"
  sets.precast.JA['Footwork'] = {} --feet="Shukuyu Sune-Ate"
  sets.precast.JA['Formless Strikes'] = {} --body="Hesychast's Cyclas"
  sets.precast.JA['Mantra'] = {} --feet="Hesychast's Gaiters +1"

  sets.precast.JA['Chi Blast'] = {head="Hes. Crown +3"}
  
  sets.precast.JA['Chakra'] = {}

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}
    
  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.Step = {}
    
  sets.precast.Flourish1 = {}


  -- Fast cast sets for spells
  
  sets.precast.FC = {ammo="Sapience Orb",
    head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
    body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Prolix Ring",
    legs=gear.herculean_refresh_legs,feet=gear.herculean_fc_feet}

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"}) --body="Passion Jacket"

     
  -- Weaponskill sets
  -- Default set for any weaponskill that isn't any more specifically defined
  
  sets.precast.WS = {}
  


  -- Specific weaponskill sets.

  sets.precast.WS['Raging Fists'] = {ammo="Knobkierrie",
    head="Ken. Jinpachi +1",neck="Mnk. Nodowa +2",ear1="Moonshade Earring",ear2="Sherida Earring",
    body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRda_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1", feet="Mpaca's Boots"}
    
  sets.precast.WS['Howling Fist'] = {ammo="Coiste Bodhar",
    head="Mpaca's Cap",neck="Mnk. Nodowa +2",ear1="Moonshade Earring",ear2="Sherida Earring",
    body="Tatena. Harama. +1",hands="Mpaca's Gloves",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRda_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet="Mpaca's Boots"}
  
  sets.precast.WS['Asuran Fists']  = set_combine(sets.precast.WS, {})
  sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {})
  
  sets.precast.WS['Victory Smite'] = {ammo="Coiste Bodhar",
    head="Adhemar Bonnet +1",neck="Mnk. Nodowa +2",ear1="Odr Earring",ear2="Sherida Earring",
    body="Ken. Samue +1",hands=gear.ryuo_hands,ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRcrit_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Mpaca's Boots"}
    
  sets.precast.WS['Shijin Spiral'] = {ammo="Knobkierrie", --aurgelmir
    head="Ken. Jinpachi +1",neck="Mnk. Nodowa +2",ear1="Mache Earring +1",ear2="Sherida Earring",
    body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet="Mpaca's Boots"}
    
  sets.precast.WS['Shijin Spiral'].Macc = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Crep. Earring",
    body="Malignance Tabard",hands="Malignance Gloves", ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
    waist="Acuity Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
  sets.precast.WS['Dragon Kick'] = {ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",neck="Mnk. Nodowa +2",ear1="Moonshade Earring",ear2="Sherida Earring",
    body="Tatena. Harama. +1",hands="Mpaca's Gloves",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRda_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet="Anch. Gaiters +3"}
    
  sets.precast.WS['Tornado Kick'] = {ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",neck="Mnk. Nodowa +2",ear1="Moonshade Earring",ear2="Sherida Earring",
    body="Tatena. Harama. +1",hands="Mpaca's Gloves",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRda_back,waist="Moonbow Belt +1",legs="Tatena. Haidate +1",feet="Anch. Gaiters +3"}
  
  --[[sets.precast.WS['Spinning Attack'] = {ammo="Knobkierrie",
    head="Hesychast's Crown +3",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Ishvara Earring",
    body="Nyame Mail",hands="Nyame Gauntlets",ring1="Niqmaddu Ring",ring2="Regal Ring",
    back=gear.STRda_back,waist="Moonbow Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}]]--
    
  sets.precast.WS['Spinning Attack'] = {ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
    body=gear.adhemar_dd_body,hands="Adhemar Wrist. +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRda_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Mpaca's Boots"}
    

  sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
  sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
  sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
  sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {})
  sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc, {})
  sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
  sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
  sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

  sets.precast.WS['Shell Crusher'] = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Crep. Earring",
    body="Malignance Tabard",hands="Malignance Gloves", ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
    waist="Acuity Belt +1",legs="Malignance Tights",feet="Malignance Boots"}
    
  sets.precast.WS['Cataclysm'] = {ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Moonshade Earring",
    body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Metamor. Ring +1",
    back=gear.HF_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
  
  -- Swap to these on Moonshade using WS if at 3000 TP
  sets.MaxTP = {}
  sets.AccMaxTP = {}
  
  -- Midcast Sets
  sets.midcast.FastRecast = {ammo="Impatiens",
  head=gear.herculean_fc_head,neck="Orunmila's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
  body=gear.adhemar_fc_body,hands="Leyline Gloves",ring1="Prolix Ring",ring2="Kishar Ring"}
    
  -- Specific spells
  sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
    
  -- Sets to return to when not performing an action.
  
  -- Resting sets
  sets.resting = {}
  

  -- Idle sets
  sets.idle = {ammo="Amar Cluster",
    head="Mpaca's cap",neck="Bathy Choker +1",ear1="Eabani Earring",ear2="Odnowa Earring +1",
    body="Mpaca's doublet",hands="Mpaca's gloves",ring1="Ilabrat Ring",ring2="Gelatinous Ring +1",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Mpaca's hose",feet="Mpaca's boots"}

  sets.idle.Weak = {ammo="Staunch Tathlum +1",
    head="Nyame Helm",neck="Unmoving Collar +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
    body="Nyame Mail",hands="Nyame Gauntlets",ring1="Regal Ring",ring2="Gelatinous Ring +1",
    back=gear.tp_back,waist="Carrier's Sash",legs="Nyame flanchard",feet="Nyame Sollerets"}
  
  sets.idle.Evasion = {ammo="Sapience Orb",
    head="Malignance Chapeau",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Eabani Earring",
    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Gelatinous Ring +1",
    back=gear.tp_back,waist="Kasiri Belt",legs="Malignance Tights",feet="Malignance Boots"}

  -- Defense sets
  sets.defense.PDT = {}
    
  -- Defense sets
  sets.defense.SB = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",neck="Monk's Nodowa +2",ear1="Telos Earring",ear2="Sherida Earring",
    body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Defending Ring",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Hes. Hose +3",feet="Malignance Boots"}

  sets.defense.MDT = {}
    
  sets.defense.MEVA = {}

  sets.Kiting = {feet="Herald's Gaiters"}

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Normal melee sets
  sets.engaged = {ammo="Coiste Bodhar",
    head="Adhemar bonnet +1",neck="Mnk. Nodowa +2",ear1="Telos Earring",ear2="Sherida Earring",
    body="Ken. Samue +1",hands="Adhemar wrist. +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Hes. Hose +3", feet="Anchorite's Gaiters +3"}
    
  sets.engaged.Godhands = set_combine(sets.engaged, {ear1="Mache Earring +1"})
  
  sets.engaged.Acc = {ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",neck="Monk's Nodowa +2",ear1="Telos Earring",ear2="Sherida Earring",
    body="Ken. Samue +1",hands="Ken. Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-ate +1"}
  
  sets.engaged.Godhands.Acc = set_combine(sets.engaged.Acc, {ear1="Mache Earring +1"})
  sets.engaged.SB = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",neck="Monk's Nodowa +2",ear1="Telos Earring",ear2="Sherida Earring",
    body="Malignance Tabard",hands="Malignance Gloves",ring1="Niqmaddu Ring",ring2="Defending Ring",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Hes. Hose +3",feet="Malignance Boots"}
    
  sets.engaged.Godhands.SB = set_combine(sets.engaged.SB, {ear1="Mache Earring +1"})
  
  -- Defensive melee hybrid sets
  sets.engaged.PDT = {ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",neck="Monk's Nodowa +2",ear1="Schere Earring",ear2="Sherida Earring",
    body="Mpaca's Doublet",hands="Mpaca's Gloves",ring2="Gere Ring",ring1="Niqmaddu Ring",
    back=gear.tp_back,waist="Moonbow Belt +1",legs="Mpaca's Hose",feet="Malignance Boots"}
  
  sets.engaged.Godhands.PDT = set_combine(sets.engaged.PDT, {ear1="Mache Earring +1"})
  
  sets.engaged.Acc.PDT = {ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",neck="Monk's Nodowa +2",ear1="Schere Earring",ear2="Sherida Earring",
    body="Malignance Tabard",hands="Malignance Gloves",ring2="Defending Ring",ring1="Niqmaddu Ring",
    back=gear.tp_back,waist,waist="Moonbow Belt +1",legs="Malignance Tights",feet="Ken. Sune-Ate +1"}
  sets.engaged.PDTOnly = {}
  sets.engaged.Acc.PDTOnly = {}
  

  -- Hundred Fists/Impetus melee set mods
  
  sets.engaged.HF = {ammo="Coiste Bodhar",
    head="Adhemar Bonnet +1",neck="Mnk. Nodowa +2",ear1="Sherida Earring",ear2="Odr Earring",
    body="Anch. Cyclas +3",hands="Ryuo Tekko +1",ring1="Niqmaddu Ring",ring2="Gere Ring",
    back=gear.STRcrit_back,waist="Moonbow Belt +1",legs="Ken. Hakama +1",feet="Ken. Sune-Ate +1"}
  
  sets.engaged.PDT.HF = sets.engaged.HF
  sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
  
  




  sets.buff.Doom = set_combine(sets.buff.Doom, {})
  sets.buff.Sleep = {head="Frenzy Sallet"}
  sets.buff.Impetus = {body="Bhikku Cyclas +1"}
  sets.buff.ImpetusWS = {ammo="Coiste Bodhar",body="Bhikku Cyclas +1",ear1="Schere Earring",ear2="Sherida Earring",back=gear.STRda_back}
  sets.buff.Footwork = {} --feet="Shukuyu Sune-Ate"
  sets.buff.Boost = {waist="Ask Sash"}
  
  sets.FootworkWS = {ammo="Coiste Bodhar",legs="Mpaca's Hose"} --feet="Shukuyu Sune-Ate"
  sets.DayIdle = {}
  sets.NightIdle = {}
  sets.Knockback = {}
  sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
  sets.Skillchain = {}
  
  -- Weapons sets
  sets.weapons.Godhands = {main="Godhands"}
  sets.weapons.Verethragna = {main="Verethragna"}
  sets.weapons.ShellCrusher = {main="Xoanon", sub="Flanged Grip"}
  sets.weapons.Cataclysm = {main="Xoanon", sub="Alber Strap"}
  sets.weapons.Barehanded = {main=empty}
  sets.weapons.ProcStaff = {main="Ranine Staff"}
  sets.weapons.ProcClub = {main="Soulflayer's Wand"}
  sets.weapons.ProcSword = {main="",sub=empty}
  sets.weapons.ProcGreatSword = {main="Ophidian Sword",sub=empty}
  sets.weapons.ProcScythe = {main="Hoe",sub=empty}
  sets.weapons.ProcPolearm = {main="Tzee Xicu's Blade",sub=empty}
  sets.weapons.ProcGreatKatana = {main="",sub=empty}
end

--set lockstyle
function set_lockstyle(lockstyleset)
  send_command('wait 10; input /lockstyleset ' .. lockstyleset)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'DNC' then
    set_macro_page(5, 1)
  elseif player.sub_job == 'NIN' then
    set_macro_page(4, 1)
  elseif player.sub_job == 'THF' then
    set_macro_page(6, 1)
  elseif player.sub_job == 'RUN' then
    set_macro_page(7, 1)
  else
    set_macro_page(6, 1)
  end
end

-- Run after the general precast() is done.
function user_job_post_precast(spell, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    local WSset = standardize_set(get_precast_set(spell, spellMap))
    local wsacc = check_ws_acc()
    
    if (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
      -- Replace Moonshade Earring if we're at cap TP
      if get_effective_player_tp(spell, WSset) > 3200 then
        if wsacc:contains('Acc') and not buffactive['Sneak Attack'] and sets.AccMaxTP then
          equip(sets.AccMaxTP[spell.english] or sets.AccMaxTP)
        elseif sets.MaxTP then
          equip(sets.MaxTP[spell.english] or sets.MaxTP)
        else
        end
      end
    end
    
    if buffactive['Impetus'] and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
      equip(sets.buff.ImpetusWS)
    elseif buffactive.Footwork and (spell.english == "Dragon Kick" or spell.english   == "Tornado Kick") then
      equip(sets.FootworkWS)
    end
  end
    if spell.type == 'JobAbility' then
    if spell.english:endswith('Jump') then
      if sets.precast.JA[spell.english] then
        if sets.precast.JA[spell.english][state.OffenseMode.value] then
          equip(sets.precast.JA[spell.english][state.OffenseMode.value])
        end
      end
    end
  end
end