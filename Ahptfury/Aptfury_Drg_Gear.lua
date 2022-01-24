-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.WeaponskillMode:options('Match','Normal','AttCap','AC')
    state.HybridMode:options('Normal','PDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Weapons:options('Trishula','ShiningOne','Sword','Staff','None')
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}

    select_default_macro_book()
	
	gear.tp_back = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.stardiver_back = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.wsd_back = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	
	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind @f7 gs c toggle AutoJumpMode')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !s gs c weapons Sword;gs c set stance none;gs c autows Savage Blade')
	send_command('bind !t gs c weapons Trishula;gs c set stance Hasso;gs c autows Stardiver')
	send_command('bind !i gs c weapons ShiningOne;gs c set stance Hasso;gs c autows Impulse Drive')
	send_command('alias swing gs c showset SteadyWing;wait 4.5;input /pet "Steady Wing" <me>;wait 2;gs c showset')
	
	
end
--- Circle JA spells Map
     Circle_JAs = S{
        'Warding Circle','Arcane Crest','Ancient Circle',
        'Holy Circle','Killer Instinct'}
function user_job_buff_change(buffname, gain)
  if Circle_JAs:contains(buffname) then
    if not gain then
      windower.chat.input('//gs c set weaponskillmode match')
    end
  end
end
-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Ptero. Fin. G. +3"}
	sets.precast.JA.Jump = {
		head="Flam. Zucchetto +2",neck="Vim Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
		body="Ptero. Mail +3",hands="Vis. Fng. Gaunt. +3",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		waist="Ioskeha Belt +1",legs="Ptero. Brais +3"}
	sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}
	sets.precast.JA['High Jump'] = sets.precast.JA.Jump
	sets.precast.JA['Soul Jump'] = {}
	sets.precast.JA['Spirit Jump'] = {}
	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {head="Vishap Armet +1"} --head="Vishap Armet",hands="Lnc. Vmbrc. +2"
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3"}
	sets.precast.JA['Deep Breathing'] = {} --hands="Ptero. Armet +1"
	sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3"}
	sets.precast.JA['Steady Wing'] = {legs="Vishap Brais +3",feet="Ptero. Greaves +3"}
	
	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {back="Brigantia's Mantle"}
	sets.precast.JA['Smiting Breath'] = {back="Brigantia's Mantle"}
	sets.HealingBreath = {back="Brigantia's Mantle"}
	--sets.SmitingBreath = {back="Brigantia's Mantle"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
	sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {head="Vishap Armet +1"})
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {}
		
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] ={ammo="Knobkierrie",
		head="Ptero. Armet +3",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Dagon Breastplate",hands="Sulev. Gauntlets +2",ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.stardiver_back,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"}
	
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {feet="Ptero. Greaves +3"})
	

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Sonic Thrust'] = {ammo="Knobkierrie",
		head="Ptero. Armet +3",neck="Dgn. Collar +2",ear1="Moonshade Earring",ear2="Thrud Earring",
		body="Dagon Breastplate",hands="Ptero. Fin. G. +3",ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.wsd_back,waist="Fotia Belt",legs="Vishap Brais +3",feet="Sulev. Leggings +2"}

	sets.precast.WS['Impulse Drive'] = {ammo="Knobkierrie",
		head="Ptero. Armet +3",neck="Dgn. Collar +2",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Dagon Breastplate",hands="Ptero. Fin. G. +3",ring1="Epaminondas's Ring",ring2="Niqmaddu Ring",
		back=gear.wsd_back,waist="Sailfi Belt +1",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"}
		
	sets.precast.WS['Impulse Drive'].AttCap = {ammo="Knobkierrie",
		head="Gleti's mask",neck="Dgn. Collar +2",ear1="Moonshade Earring",ear2="Sherida Earring",
		body="Gleti's cuirass",hands="Gleti's gauntlets",ring1="Epaminondas's Ring",ring2="Niqmaddu Ring",
		back=gear.wsd_back,waist="Sailfi Belt +1",legs="Gleti's breeches",feet="Gleti's boots"}
	
	sets.precast.WS['Savage Blade'] = {ammo="Knobkierrie",
		head="Nyame Helm",neck="Dgn. Collar +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Ptero. Fin. G. +3",ring1="Regal Ring",ring2="Epaminondas's Ring",
		back=gear.wsd_back,waist="Sailfi Belt +1",legs="Vishap Brais +3",feet="Nyame Sollerets"}
		
	sets.precast.WS['Savage Blade'].AttCap = {ammo="Crepuscular Pebble",
		head="Nyame Helm",neck="Dgn. Collar +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Gleti's cuirass",hands="Ptero. Fin. G. +3",ring1="Regal Ring",ring2="Epaminondas's Ring",
		back=gear.wsd_back,waist="Sailfi Belt +1",legs="Vishap Brais +3",feet="Gleti's boots"}
	
	sets.precast.WS['Savage Blade'].AC = set_combine(sets.precast.WS['Savage Blade'], {body="Founder's Breastplate"})
		
	sets.precast.WS['Full Swing'] = {ammo="Knobkierrie",
		head="Gleti's mask",neck="Dgn. Collar +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Gleti's cuirass",hands="Ptero. Fin. G. +3",ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.wsd_back,waist="Sailfi Belt +1",legs="Vishap Brais +3",feet="Nyame Sollerets"}
		
	sets.precast.WS['Retribution'] = {ammo="Knobkierrie",
		head="Gleti's mask",neck="Dgn. Collar +2",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Gleti's cuirass",hands="Ptero. Fin. G. +3",ring1="Regal Ring",ring2="Niqmaddu Ring",
		back=gear.wsd_back,waist="Sailfi Belt +1",legs="Vishap Brais +3",feet="Nyame Sollerets"}
	
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS['Savage Blade'], {})
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",neck="Dgn. Collar +2",ear1="Brutal Earring",ear2="Sherida Earring",
		body="Hjarrandi Breastplate",hands="Gleti's Gauntlets",ring1="Defending Ring",ring2="Niqmaddu Ring",
		back=gear.tp_back,waist="Ioskeha Belt +1",legs="Ptero. Brais +3",feet="Gleti's Boots"}
		
	sets.idle.Refresh = {}

	sets.idle.Weak = set_combine(sets.idle, {})
		
	sets.idle.Reraise = set_combine(sets.idle, {})
	
	-- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {})
		
	sets.defense.MEVA = {}

	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Reraise = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    --sets.passive.MP = {}
    --sets.passive.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Trishula = {main="Trishula",sub="Utu Grip"}
	sets.weapons.ShiningOne = {main="Shining One",sub="Utu Grip"}
	sets.weapons.Sword = {main="Naegling",sub="Legion Scutum"}
	sets.weapons.Staff = {main="Malignance Pole",sub="Utu Grip"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Sherida Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring +1",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Moonshade Earring",ear2="Sherida Earring",}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",neck="Vim Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
		body="Hjarrandi Breastplate",hands="Acro Gauntlets",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.tp_back,waist="Ioskeha Belt +1",legs="Ptero. Brais +3",feet="Flam. Gambieras +2"}
   
	sets.engaged.Acc = set_combine(sets.engaged, {hands="Sulev. Gauntlets +2",ring1="Flamma Ring"})
    
	sets.engaged.Sword = {ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",neck="Dgn. Collar +2",ear1="Dedition Earring",ear2="Sherida Earring",
		body="Hjarrandi Breastplate",hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Niqmaddu Ring",
		back=gear.tp_back,waist="Ioskeha Belt +1",legs="Ptero. Brais +3",feet="Flamma Gambieras +2"}
		
    sets.engaged.Sword.Acc = set_combine(sets.engaged.Sword, {ear1="Digni. Earring",ring1="Regal Ring"})
	sets.engaged.Sword.PDT = set_combine(sets.idle, {waist="Tempus Fugit"})
	sets.engaged.AM = {}
    
	sets.engaged.AM.Acc = {}
   
	
    sets.engaged.PDT = sets.idle 
    
	sets.engaged.Acc.PDT = {}
    
	
    sets.engaged.AM.PDT = {}
    
	sets.engaged.AM.Acc.PDT = {}
    
		
	--[[ Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.
	
    sets.engaged.Adoulin = {}
    sets.engaged.Adoulin.SomeAcc = {}
	sets.engaged.Adoulin.Acc = {}
    sets.engaged.Adoulin.FullAcc = {}
    sets.engaged.Adoulin.Fodder = {}

    sets.engaged.Adoulin.AM = {}
    sets.engaged.Adoulin.AM.SomeAcc = {}
	sets.engaged.Adoulin.AM.Acc = {}
    sets.engaged.Adoulin.AM.FullAcc = {}
    sets.engaged.Adoulin.AM.Fodder = {}
	
    sets.engaged.Adoulin.PDT = {}
    sets.engaged.Adoulin.SomeAcc.PDT = {}
	sets.engaged.Adoulin.Acc.PDT = {}
    sets.engaged.Adoulin.FullAcc.PDT = {}
    sets.engaged.Adoulin.Fodder.PDT = {}
	
    sets.engaged.Adoulin.AM.PDT = {}
    sets.engaged.Adoulin.AM.SomeAcc.PDT = {}
	sets.engaged.Adoulin.AM.Acc.PDT = {}
    sets.engaged.Adoulin.AM.FullAcc.PDT = {}
    sets.engaged.Adoulin.AM.Fodder.PDT = {}
	]]

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(5, 13)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    else
        set_macro_page(5, 13)
    end
end
