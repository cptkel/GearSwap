function user_job_setup()
  state.OffenseMode:options('Normal','Acc')
  state.HybridMode:options('Normal','DT','PetTank','BothDD')
  state.WeaponskillMode:options('Match','Normal','Acc')
  state.CastingMode:options('Normal')
  state.IdleMode:options('Normal','Refresh','Reraise')
  state.RestingMode:options('Normal')
  state.PhysicalDefenseMode:options('PetPDT','PDT','Reraise','PKiller')
  state.MagicalDefenseMode:options('PetMDT','MDT', 'MKiller')
  state.ResistDefenseMode:options('PetMEVA', 'MEVA')
  state.Weapons:options('None','PetPDTAxe','DualWeapons','DualReady')
  state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Knockback','Suppa','DWEarrings'}

  -- Set up Jug Pet cycling and keybind Ctrl+F7
  -- INPUT PREFERRED JUG PETS HERE
  state.JugMode = M{['description']='Jug Mode', 'BouncingBertha','VivaciousVickie','SultryPatrice','FluffyBredo','GenerousArthur','VivaciousGaston','EnergizedSefina','WarlikePatrick','SwoopingZhivago','JovialEdwin','BlackbeardRandy','RhymingShizuna','AmiableRoche','SharpwitHermes','SpiderFamiliar','PonderingPeter','FatsoFargann','DaringRoland'}
  send_command('bind ^f7 gs c cycle JugMode')

  -- Set up Monster Correlation Modes and keybind Alt+F7
  state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
  send_command('bind !f7 gs c cycle CorrelationMode')

  -- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F7
  state.PetMode = M{['description']='Pet Mode','DD','Tank'}
  send_command('bind @f7 gs c cycle PetMode')

  -- Set up Reward Modes and keybind Ctrl+Backspace
  state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
  send_command('bind ^backspace gs c cycle RewardMode')

  send_command('bind @f8 gs c toggle AutoReadyMode')
  send_command('bind !` gs c ready default')

  --Example of how to change default ready moves.
  --[[ready_moves.default.ScissorlegXerin = 'Sensilla Blades'
  ready_moves.default.GenerousArthur = 'Corrosive Ooze'
  ready_moves.default.CaringKiyomaro = 'Zealous Snort']]--
  
  gear.tp_jse_back = {name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
  gear.strda_back = {name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
  gear.ready_back = {name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Damage taken-5%',}}
  gear.macc_back = {name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: "Regen"+10','System: 1 ID: 1246 Val: 4',}}
  gear.savage_back = {name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
  gear.primalrend_back = {name="Artio's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
  
  select_default_macro_book()
end


-- BST gearsets
function init_gear_sets()
  -- PRECAST SETS
  sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +3"}
  sets.precast.JA['Bestial Loyalty'] = {hands="Ankusa Gloves +1"}
  sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
  sets.precast.JA.Familiar = {}
  sets.precast.JA.Tame = {}
  sets.precast.JA.Spur = {back="Artio's Mantle"} --feet="Nukumi Ocreae +1"
  sets.SpurAxe = {}
  sets.SpurAxesDW = {}

  sets.precast.JA['Feral Howl'] = {body="Ankusa Jackcoat +1"}

  sets.precast.JA.Reward = {}

  sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Theta"})
  sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
  sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})
  
  sets.RewardAxe = {}
  sets.RewardAxesDW = {}

  sets.precast.JA.Charm = {}

  -- CURING WALTZ
  sets.precast.Waltz = {}

    -- HEALING WALTZ
  sets.precast.Waltz['Healing Waltz'] = {}

    -- STEPS
  sets.precast.Step = {}

    -- VIOLENT FLOURISH
  sets.precast.Flourish1 = {}
  sets.precast.Flourish1['Violent Flourish'] = {}

  sets.precast.FC = {}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- MIDCAST SETS
  sets.midcast.FastRecast = {}

  sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

  sets.midcast.Cure = {}

  sets.midcast.Curaga = sets.midcast.Cure

  sets.Self_Healing = {}
  sets.Cure_Received = {}
  sets.Self_Refresh = {}

  sets.midcast.Stoneskin = sets.midcast.FastRecast

  sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {})

  sets.midcast.Protect = set_combine(sets.midcast.FastRecast, {})
  sets.midcast.Protectra = sets.midcast.Protect

  sets.midcast.Shell = set_combine(sets.midcast.FastRecast, {})
  sets.midcast.Shellra = sets.midcast.Shell

  sets.midcast['Enfeebling Magic'] = sets.midcast.FastRecast

  sets.midcast['Elemental Magic'] = sets.midcast.FastRecast

  sets.midcast.Helix = sets.midcast['Elemental Magic']
  sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic']

    -- WEAPONSKILLS
    -- Default weaponskill sets.
  sets.precast.WS = {}

  sets.precast.WS.Acc = {}

  -- Specific weaponskill sets.
  sets.precast.WS['Decimation'] = {ammo="Coiste Bodhar",
    head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Brutal Earring",
    body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Epona's Ring",
    back=gear.strda_back,waist="Fotia Belt",legs="Gleti's Breeches",feet="Gleti's Boots"}
  
  sets.precast.WS['Mistral Axe'] = {ammo="Voluspa Tathlum",
    head="Ankusa Helm +3",neck="Bst. Collar +2",ear1="Moonshade Earring",ear2="Thrud Earring",
    body="Gleti's Cuirass",hands="Totemic Gloves +3",ring1="Epaminondas's Ring",ring2="Regal Ring",
    back=gear.savage_back,waist="Sailfi Belt +1",legs="Gleti's Breeches",feet="Gleti's Boots"}
    
  sets.precast.WS['Calamity'] = set_combine(sets.precast.WS['Mistral Axe'], {})
  
  sets.precast.WS['Ruinator'] = {}
  
  sets.precast.WS['Onslaught'] = {}
  
  sets.precast.WS['Primal Rend'] = {ammo="Voluspa Tathlum",
    head="Nyame Helm",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
    body="Nyame Mail",hands="Nyame Gauntlets",ring1="Epaminondas's Ring",ring2="Weatherspoon Ring",
    back=gear.primalrend_back,waist="Orpheus's Sash",legs="Nyame flanchard",feet="Nyame Sollerets"}

  sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {})
  
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Mistral Axe'], {})

    -- Swap to these on Moonshade using WS if at 3000 TP
  sets.MaxTP = {}
  sets.AccMaxTP = {}

        -- PET SIC & READY MOVES
  sets.midcast.Pet.WS = {ammo="Voluspa Tathlum",
    head="Emicho Coronet +1",neck="Shulmanu Collar",ear1="Domesticator's Earring",ear2="Hija Earring",
    body=gear.valorous_pet_body,hands="Nukumi Manoplas +1",ring1="Varar Ring +1",ring2="C. Palug Ring",
    back=gear.ready_back,waist="Incarnation Sash",legs=gear.valorous_pet_legs,feet="Gleti's Boots"}

  sets.midcast.Pet.Acc = set_combine(sets.midcast.Pet.WS, {})
  
  sets.midcast.Pet.MultiHitReady = {}
        
  sets.midcast.Pet.MagicReady = {ammo="Voluspa Tathlum",
    head="Nyame helm",neck="Adad Amulet",ear1="Hija Earring",ear2="Enmerkar Earring",
    body="Udug Jacket",hands="Nukumi Manoplas +1",ring1="Tali'ah Ring",ring2="C. Palug Ring",
    back=gear.ready_back,waist="Incarnation Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
    
  sets.midcast.Pet.DebuffReady = {ammo="Voluspa Tathlum",
    head="Nyame helm",neck="Adad Amulet",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
    body="Nyame Mail",hands="Nyame Gauntlets",ring1="Tali'ah Ring",ring2="C. Palug Ring",
    back=gear.macc_back,waist="Incarnation Sash",legs="Nyame Flanchard",feet="Gleti's Boots"}
    
  sets.midcast.Pet.PhysicalDebuffReady = {}

  sets.midcast.Pet.ReadyRecast = {main="Aymur",legs="Gleti's Breeches"}
  sets.midcast.Pet.ReadyRecastDW = {main="Aymur",legs="Gleti's Breeches"}
  sets.midcast.Pet.Neutral = {}
  sets.midcast.Pet.Favorable = {}
  sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1"}

  -- RESTING
  sets.resting = {}

  sets.idle = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
    body="Malignance Tabard",hands="Malignance Gloves",ring1="Vengeful Ring",ring2="C. Palug Ring",
    back=gear.tp_jse_back,waist="Flume Belt",legs="Malignance Tights",feet="Malignance Boots"}

  sets.idle.Refresh = {}
    
  sets.idle.Reraise = set_combine(sets.idle, {})

  sets.idle.Pet = set_combine(sets.idle, {})

  sets.idle.Pet.Engaged = set_combine(sets.idle, {
    head="Nyame Helm",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
    body="Tot. Jackcoat +3",hands="Gleti's Gauntlets",ring1="Defending Ring",
    back=gear.macc_back,waist="Isa Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"})

  sets.idle.Pet.Engaged.DW = {}

  -- DEFENSE SETS
  sets.defense.PDT = {}

  sets.defense.PetPDT = {}

  sets.defense.PetMDT = {}

  sets.defense.PetMEVA = sets.defense.PetMDT

  sets.defense.PKiller = set_combine(sets.defense.PDT, {body="Nukumi Gausape +1"})
  sets.defense.Reraise = set_combine(sets.defense.PDT, {})

  sets.defense.MDT = {}

  sets.defense.MEVA = {}

  sets.defense.MKiller = set_combine(sets.defense.MDT, {body="Nukumi Gausape +1"})

  sets.Kiting = {feet="Skd. Jambeaux +1"}
  sets.DayIdle = {}
  sets.NightIdle = {}

  -- MELEE (SINGLE-WIELD) SETS
  sets.engaged = {ammo="Coiste Bodhar",
    head="Skormoth Mask",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
    body="Tali'ah Manteel +2",hands="Malignance Gloves",ring1="Epona's Ring",ring2="Gere Ring",
    back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

  sets.engaged.Acc = {}
  
  sets.engaged.AM = set_combine(sets.engaged, {head="Malignance Chapeau",body="Malignance Tabard",ring1="Chirich Ring +1",ring2="Chirich Ring +1"})

  

  -- MELEE (SINGLE-WIELD) HYBRID SETS
  sets.engaged.DT = {ammo="Coiste Bodhar",
    head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
    body="Gleti's Cuirass",hands="Malignance Gloves",ring1="Epona's Ring",ring2="Defending Ring",
    back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

  sets.engaged.Acc.DT = {ammo="Voluspa Tathlum",
    head="Malignance Chapeau",neck="Bst. Collar +2",ear1="Telos Earring",ear2="Digni. Earring",
    body="Gleti's Cuirass",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Defending Ring",
    back=gear.tp_jse_back,waist="Grunfeld Rope",legs="Malignance Tights",feet="Malignance Boots"}

  

  -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
  sets.engaged.DW = {ammo="Coiste Bodhar",
    head="Skormoth Mask",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
    body="Tali'ah Manteel +2",hands="Malignance Gloves",ring1="Epona's Ring",ring2="Defending Ring",
    back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

  sets.engaged.DW.Acc = {}

  sets.engaged.DW.AM = set_combine(sets.engaged.AM, {})
  sets.engaged.DW.AM.DT = set_combine(sets.engaged.AM, {})

  -- MELEE (DUAL-WIELD) HYBRID SETS
  sets.engaged.DW.DT = set_combine(sets.engaged.DT, {})
  sets.engaged.DW.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
  sets.engaged.DW.AM.DT = set_combine(sets.engaged.AM, {})

  -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET ENGAGED
  sets.engaged.BothDD = set_combine(sets.engaged,{})
  sets.engaged.BothDD.Acc = set_combine(sets.engaged.Acc, {})
  

  -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
  sets.engaged.PetTank = set_combine(sets.idle.Pet.Engaged,{})
  sets.engaged.PetTank.Acc = set_combine(sets.engaged.Acc, {})
  
  -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET ENGAGED
  sets.engaged.DW.BothDD = set_combine(sets.engaged.DW,{})
  sets.engaged.DW.BothDD.Acc = set_combine(sets.engaged.DW.Acc, {})
  

  -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
  sets.engaged.DW.PetTank = set_combine(sets.engaged.DW,{})
  sets.engaged.DW.PetTank.Acc = set_combine(sets.engaged.DW.Acc, {})
  
  sets.buff['Killer Instinct'] = {body="Nukumi Gausape +1"}
  sets.buff.Doom = set_combine(sets.buff.Doom, {})
  sets.buff.Sleep = {head="Frenzy Sallet"}
  sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
  sets.Knockback = {}
  sets.SuppaBrutal = {}
  sets.DWEarrings = {}
  
  -- Weapons sets
  
  sets.weapons.PetPDTAxe = {main="Pangu",sub="Sacro Bulwark"}
  sets.weapons.DualWeapons = {main ="Dolichenus",sub="Ternion Dagger +1"}
  sets.weapons.DualReady = {main="Agwu's Axe",sub="Arktoi"}


-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------

  sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Seedbed Soil"})
  sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fish Oil Broth"})
  sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sun Water"})
  sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="D. Herbal Broth"})
  sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cng. Brain Broth"})
  sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Grass. Broth"})
  sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Mlw. Bird Broth"})
  sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gob. Bug Broth"})
  sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
  sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Auroral Broth"})
  sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="L. Carrot Broth"})
  sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wool Grease"})
  sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vermihumus"})
  sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Briny Broth"})
  sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepbed Soil"})
  sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Plasma Broth"})
  sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lucky Broth"})
  sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Svg. Mole Broth"})
  sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rzr. Brain Broth"})
  sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
  sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cl. Wheat Broth"})
  sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shadowy Broth"})

  -------------------------------------------------------------------------------------------------------------------
  -- Complete iLvl Jug Pet Precast List
  -------------------------------------------------------------------------------------------------------------------

  sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Swirling Broth"})
  sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vis. Broth"})
  sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shimmering Broth"})
  sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Ferm. Broth"})
  sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Livid Broth"})
  sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spicy Broth"})
  sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bubbly Broth"})
  sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lyrical Broth"})
  sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Salubrious Broth"})
  sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Windy Greens"})
  sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Airy Broth"})
  sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Trans. Broth"})
  sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crumbly Soil"})
  sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Blackwater Broth"})
  sets.precast.JA['Bestial Loyalty'].SuspiciousAlice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Furious Broth"})
  sets.precast.JA['Bestial Loyalty'].AnklebiterJedd = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crackling Broth"})
  sets.precast.JA['Bestial Loyalty'].FleetReinhard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rapid Broth"})
  sets.precast.JA['Bestial Loyalty'].CursedAnnabelle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Creepy Broth"})
  sets.precast.JA['Bestial Loyalty'].SurgingStorm = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Insipid Broth"})
  sets.precast.JA['Bestial Loyalty'].SubmergedIyo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepwater Broth"})
  sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Electrified Broth"})
  sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bug-Ridden Broth"})
  sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fizzy Broth"})
  sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Tant. Broth"})
  sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pale Sap"})
  sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Meaty Broth"})
  sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Dire Broth"})
  sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Muddy Broth"})
  sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wetlands Broth"})
  sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Heavenly Broth"})
  sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wispy Broth"})
  sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Saline Broth"})
  sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sugary Broth"})
  sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Glazed Broth"})
  sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sticky Webbing"})
  sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Slimy Webbing"})
  sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Poisonous Broth"})
  sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Venomous Broth"})
  sets.precast.JA['Bestial Loyalty'].WeevilFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pristine Sap"})
  sets.precast.JA['Bestial Loyalty'].StalwartAngelina = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="T. Pristine Sap"})
  sets.precast.JA['Bestial Loyalty'].SweetCaroline = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Aged Humus"})
  sets.precast.JA['Bestial Loyalty']['P.CrabFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rancid Broth"})
  sets.precast.JA['Bestial Loyalty'].JovialEdwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pungent Broth"})
  sets.precast.JA['Bestial Loyalty']['Y.BeetleFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Zestful Sap"})
  sets.precast.JA['Bestial Loyalty'].EnergizedSefina = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gassy Sap"})
  sets.precast.JA['Bestial Loyalty'].LynxFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Frizzante Broth"})
  sets.precast.JA['Bestial Loyalty'].VivaciousGaston = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spumante Broth"})
  sets.precast.JA['Bestial Loyalty']['Hip.Familiar'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Turpid Broth"})
  sets.precast.JA['Bestial Loyalty'].DaringRoland = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Feculent Broth"})
  sets.precast.JA['Bestial Loyalty'].SlimeFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Decaying Broth"})
  sets.precast.JA['Bestial Loyalty'].SultryPatrice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Putrescent Broth"})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  if player.sub_job == 'DNC' then
    set_macro_page(4, 16)
  elseif player.sub_job == 'NIN' then
    set_macro_page(4, 16)
  elseif player.sub_job == 'THF' then
    set_macro_page(4, 16)
  elseif player.sub_job == 'RUN' then
    set_macro_page(4, 16)
  else
    set_macro_page(4, 16)
  end
end