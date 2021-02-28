-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('Mote-Globals.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot','Healing Breeze'}
	blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Hybrid','Acc')
	state.HybridMode:options('Normal','DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal','Refresh')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.enmity = {ammo="Iron Gobbet",
        head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands={ name="Cab. Gauntlets +1", augments={'Enhances "Chivalry" effect',}},
        legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}},
        neck="Unmoving Collar +1",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Apeile Ring +1",
        right_ring="Petrov Ring",
        back="Agema Cape",}
		
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.enmity, {legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}},})
    sets.precast.JA['Holy Circle'] = set_combine(sets.enmity, {feet="Rev. Leggings +1",})
    sets.precast.JA['Shield Bash'] = {hands={ name="Cab. Gauntlets +1", augments={'Enhances "Chivalry" effect',}},}
    sets.precast.JA['Sentinel'] = set_combine(sets.enmity, {feet={ name="Cab. Leggings +1", augments={'Enhances "Guardian" effect',}},})
    sets.precast.JA['Rampart'] = set_combine(sets.enmity, {head={ name="Cab. Coronet +1", augments={'Enhances "Iron Will" effect',}},})
    sets.precast.JA['Fealty'] = {body={ name="Cab. Surcoat +1", augments={'Enhances "Fealty" effect',}},}
    sets.precast.JA['Divine Emblem'] = {feet="Chevalier's Sabatons +1"}
    sets.precast.JA['Cover'] = {head="Rev. Coronet +1",}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo="Iron Gobbet",
        head="Volte Salade",
        body="Dagon Breast.",
        hands={ name="Cab. Gauntlets +1", augments={'Enhances "Chivalry" effect',}},
        legs="Sulev. Cuisses +2",
        feet="Sulev. Leggings +2",
        waist="Rumination Sash",
        left_ear="Nourish. Earring",
        left_ring="Vertigo Ring",
        right_ring="Stikini Ring",}
    

    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {ammo="Sonia's Plectrum",
    --     head="Reverence Coronet +1",
    --     body="Gorney Haubert +1",hands="Reverence Gauntlets +1",ring2="Asklepian Ring",
    --     back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
        
    -- Don't need any special gear for Healing Waltz.
    -- sets.precast.Waltz['Healing Waltz'] = {}
    
    -- sets.precast.Step = {waist="Chaac Belt"}
    -- sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body={ name="Odyss. Chestplate", augments={'Mag. Acc.+10 "Mag.Atk.Bns."+10','"Fast Cast"+3','AGI+2','Mag. Acc.+12',}},
	    hands="Volte Moufles",
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet={ name="Odyssean Greaves", augments={'Accuracy+17 Attack+17','"Fast Cast"+2','AGI+10','Attack+13',}},
	    neck="Moonbeam Necklace",
	    waist="Rumination Sash",
	    left_ear="Loquac. Earring",
	    right_ear="Magnetic Earring",
	    left_ring="Defending Ring",
	    right_ring="Kishar Ring",
	    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.precast.FC['Cure'] = {ammo="Sapience Orb",
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body={ name="Jumalik Mail", augments={'HP+50','Attack+13','Enmity+7','"Refresh"+1',}},
	    hands="Volte Moufles",
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet={ name="Odyssean Greaves", augments={'Accuracy+17 Attack+17','"Fast Cast"+2','AGI+10','Attack+13',}},
	    neck="Moonbeam Necklace",
	    waist="Rumination Sash",
	    left_ear="Loquac. Earring",
	    right_ear="Magnetic Earring",
	    left_ring="Defending Ring",
	    right_ring="Kishar Ring",
	    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.precast.FC['Cure II'] = sets.precast.FC['Cure']
    sets.precast.FC['Cure III'] = sets.precast.FC['Cure']
    sets.precast.FC['Cure IV'] = sets.precast.FC['Cure']
			
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Iron Gobbet",
	    head="Sulevia's Mask +2",
	    body="Dagon Breast.",
	    hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+12','Accuracy+10',}},
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {ammo="Iron Gobbet",
	    head="Sulevia's Mask +2",
	    body="Dagon Breast.",
	    hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+12','Accuracy+10',}},
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- sets.precast.WS['Requiescat'].Acc = {}

    sets.precast.WS['Savage Blade'] = {ammo="Iron Gobbet",
	    head="Sulevia's Mask +2",
	    body="Dagon Breast.",
	    hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+12','Accuracy+10',}},
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Caro Necklace",
	    waist="Grunfeld Rope",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- sets.precast.WS['Savage Blade'].Acc = {}
	
    sets.precast.WS['Chant du Cygne'] = {ammo="Iron Gobbet",
	    head="Sulevia's Mask +2",
	    body="Dagon Breast.",
	    hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+12','Accuracy+10',}},
	    legs="Sulev. Cuisses +2",
	    feet="Sulev. Leggings +2",
	    neck="Caro Necklace",
	    waist="Grunfeld Rope",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    left_ring="Rufescent Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Rudianos's Mantle"},}

    -- sets.precast.WS['Chant du Cygne'].Acc = {}

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
	    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst dmg.+10%','"Refresh"+1',}},
	    body={ name="Valorous Mail", augments={'Chance of successful block +2','Weapon skill damage +2%','Accuracy+15 Attack+15','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
	    hands={ name="Odyssean Gauntlets", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +1%','AGI+2','Mag. Acc.+5','"Mag.Atk.Bns."+5',}},
	    legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+23','"Dbl.Atk."+2','DEX+8','Mag. Acc.+13',}},
	    feet="Flam. Gambieras +2",
	    neck="Baetyl Pendant",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Hecate's Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Stikini Ring",
	    back="Toro Cape",}
    
    sets.precast.WS['Atonement'] = {ammo="Iron Gobbet",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    feet="Chev. Sabatons +1",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Friomisi Earring",
	    right_ear="Cryptic Earring",
	    left_ring="Apeile Ring +1",
	    right_ring="Petrov Ring",
	    back="Mubvum. Mantle",}
    
    -- sets.precast.WS['Impulse Drive'] = {}
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

	-- sets.midcast.FastRecast = {ammo="Staunch Tathlum",
    --    head="Souveran Schaller +1",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Knightly Earring",
    --    body="Souveran Cuirass +1", hands="Regal Gauntlets",ring1="Defending Ring",ring2="Kishar Ring",
    --    back=Hyd.PLDcape5,waist="Rumination Sash",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}
		
    sets.midcast['Flash'] = {ammo="Sapience Orb",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet="Flam. Gambieras +2",
	    neck="Moonbeam Necklace",
	    waist="Rumination Sash",
	    left_ear="Cryptic Earring",
	    right_ear="Friomisi Earring",
	    left_ring="Moonbeam Ring",
	    right_ring="Moonbeam Ring",
	    back="Mubvum. Mantle",}
    
    sets.midcast['Stun'] = {ammo="Sapience Orb",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet="Flam. Gambieras +2",
	    neck="Moonbeam Necklace",
	    waist="Rumination Sash",
	    left_ear="Cryptic Earring",
	    right_ear="Friomisi Earring",
	    left_ring="Moonbeam Ring",
	    right_ring="Moonbeam Ring",
	    back="Mubvum. Mantle",}

    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
    sets.midcast['Cure'] = {ammo="Staunch Tathlum",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    hands="Rev. Gauntlets +2",
	    legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+13','"Cure" potency +5%','MND+2','Mag. Acc.+15',}},
	    feet={ name="Odyssean Greaves", augments={'Accuracy+17 Attack+17','"Fast Cast"+2','AGI+10','Attack+13',}},
	    neck="Unmoving Collar +1",
	    waist="Rumination Sash",
	    left_ear="Mendi. Earring",
	    right_ear="Magnetic Earring",
	    left_ring="Defending Ring",
	    right_ring="Moonbeam Ring",
	    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.midcast['Cure II'] = sets.midcast['Cure']
    sets.midcast['Cure III'] = sets.midcast['Cure']
    sets.midcast['Cure IIV'] = sets.midcast['Cure']

    sets.midcast['Enhancing Magic'] = {ammo="Staunch Tathlum",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body="Rev. Surcoat +2",
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs="Rev. Breeches +2",
	    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
	    neck="Incanter's Torque",
	    waist="Rumination Sash",
	    left_ear="Andoaa Earring",
	    right_ear="Magnetic Earring",
	    left_ring="Stikini Ring",
	    right_ring="Moonbeam Ring",
	    back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}
	
	sets.midcast['Blue Magic'] = set_combine(sets.enmity, {head="Souveran Schaller +1"})
	sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
	sets.midcast['Blue Magic'].Buffs = set_combine(sets.SIRD, {neck="Incanter's Torque"})
	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    feet="Rev. Leggings +2",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Odnowa Earring",
	    right_ear="Odnowa Earring +1",
	    left_ring="Defending Ring",
	    right_ring="Moonbeam Ring",
	    back="Moonbeam Cape",}
		
    sets.idle.Refresh = {ammo="Homiliary",
	    head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst dmg.+10%','"Refresh"+1',}},
	    body="Chozor. Coselete",
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    feet="Rev. Leggings +2",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Odnowa Earring",
	    right_ear="Odnowa Earring +1",
	    left_ring="Defending Ring",
	    right_ring="Moonbeam Ring",
	    back="Moonbeam Cape",}
 
	-- sets.idle.MDT = {} 
		
	sets.Kiting = set_combine(idleSet, {
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},})

	sets.Kiting.Refresh = sets.Kiting

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}

    sets.MP = {neck="Creed Collar",waist="Flume Belt"}

    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Staunch Tathlum",
	    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	    feet="Rev. Leggings +2",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Odnowa Earring",
	    right_ear="Odnowa Earring +1",
	    left_ring="Defending Ring",
	    right_ring="Moonbeam Ring",
	    back="Moonbeam Cape",}

    sets.engaged.DT = {}

    sets.engaged.Hybrid = {}

    sets.engaged.Hybrid.DT = {}

    sets.engaged.Acc = {}

    sets.engaged.Acc.DT = {}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
    sets.buff.Sentinel = {feet={ name="Cab. Leggings +1", augments={'Enhances "Guardian" effect',}},}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Swaps back to gear on SIRD.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.interrupted then
        handle_equipping_gear(player.status)
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------



-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- -- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

-- function customize_defense_set(defenseSet)   
    -- if state.Buff.Doom then
        -- defenseSet = set_combine(defenseSet, sets.buff.Doom)
    -- end
    
    -- return defenseSet
-- end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- function update_defense_mode()
    -- if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        -- classes.CustomDefenseGroups:append('Kheshig Blade')
    -- end
    
    -- if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        -- if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           -- player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            -- state.CombatForm:set('DW')
        -- else
            -- state.CombatForm:reset()
        -- end
    -- end
-- end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 11)
end