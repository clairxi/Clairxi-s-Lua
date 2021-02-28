-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job. Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options ('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'DT')

	select_default_macro_book()
	update_melee_groups()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- Start defining the sets
--------------------------------------
-- Precast Sets

-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},}
	sets.precast.JA['Arcane Circle'] = {feet="Ig. Sollerets +2",}
	sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +1",}
	sets.precast.JA['Souleater'] = {head="Ig. Burgonet +3",}
	sets.precast.JA['Weapon Bash'] = {hands="Ig. Gauntlets +3",}
	sets.precast.JA['Last Resort'] = {feet={ name="Fall. Sollerets +2", augments={'Enhances "Desperate Blows" effect',}},
    	back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
	sets.precast.JA['Dark Seal'] = {head={ name="Fall. Burgeonet +2", augments={'Enhances "Dark Seal" effect',}},}
	sets.precast.JA['Blood Weapon'] = {body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},}

-- Precast Sets
	sets.precast.FC = {ammo="Sapience Orb",
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
	    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
	    neck="Voltsurge Torque",
	    left_ear="Malignance Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Kishar Ring",
	    right_ring="Weather. Ring",
	    back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

-- Specific spells
	sets.midcast['Endark'] = {ammo="Pemphredo Tathlum",
	    head="Ig. Burgonet +3",
	    body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
	    hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
	    neck="Incanter's Torque",
	    left_ear="Magnetic Earring",
	    right_ear="Mendi. Earring",
	    left_ring="Evanescence Ring",
	    right_ring="Stikini Ring",
	    back={ name="Ankou's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}

    sets.midcast['Endark II'] = sets.midcast['Endark']

	sets.midcast['Dread Spikes'] = {ammo="Pemphredo Tathlum",
	    head="Hjarrandi Helm",
	    body="Heath. Cuirass +1",
	    hands="Ig. Gauntlets +3",
	    legs="Flamma Dirs +2",
	    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Eabani Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Moonbeam Ring",
	    right_ring="Etana Ring",
	    back={ name="Ankou's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}

	sets.midcast['Elemental Magic'] = {ammo="Seeth. Bomblet +1",
	    head="Flam. Zucchetto +2",
	    body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
	    hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet="Heath. Sollerets +1",
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Lugra Earring +1",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
	    back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

	sets.midcast['Enfeebling Magic'] = {ammo="Pemphredo Tathlum",
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body="Flamma Korazin +2",
	    hands="Flam. Manopolas +2",
	    legs="Flamma Dirs +2",
	    feet="Ig. Sollerets +2",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Gwati Earring",
	    left_ring="Kishar Ring",
	    right_ring="Weather. Ring",
	    back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

	sets.midcast['Absorb-STR'] = {ammo="Pemphredo Tathlum",
	    head="Ig. Burgonet +3",
	    body="Flamma Korazin +2",
	    hands="Heath. Gauntlets +1",
	    legs="Flamma Dirs +2",
	    feet="Ig. Sollerets +2",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Gwati Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
	    back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Absorb-DEX'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-VIT'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-AGI'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-INT'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-MND'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-CHR'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-ACC'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-Attri'] = sets.midcast['Absorb-STR']
    sets.midcast['Absorb-TP'] = sets.midcast['Absorb-STR']
	   	
	sets.midcast['Stun'] = {ammo="Pemphredo Tathlum",
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body={ name="Fall. Cuirass +3", augments={'Enhances "Blood Weapon" effect',}},
	    hands="Flam. Manopolas +2",
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet="Ig. Sollerets +2",
	    neck="Voltsurge Torque",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Gwati Earring",
	    left_ring="Kishar Ring",
	    right_ring="Weather. Ring",
	    back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

	sets.midcast['Drain'] = {ammo="Pemphredo Tathlum",
	    body="Lugra Cloak +1",
	    hands={ name="Fall. Fin. Gaunt. +3", augments={'Enhances "Diabolic Eye" effect',}},
	    legs={ name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}},
	    feet="Ig. Sollerets +2",
	    neck="Erra Pendant",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Gwati Earring",
	    left_ring="Evanescence Ring",
	    right_ring="Weather. Ring",
	    back={ name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Drain II'] = sets.midcast['Drain']
    sets.midcast['Drain III'] = sets.midcast['Drain']
	sets.midcast['Aspir'] = sets.midcast['Drain']


------------------------------------------------------WEAPONSKILLS--------------------------------------------------------------------------
-- Weaponskill sets
-- FOR ANY WS NOT DEFINED WILL USE BELOW
    sets.precast.WS ={}
		
-------------------------------------------------------------- SCYTHE -----------------------------------------------------------------------
	
	-- 60% STR / 60% MND - Damage varies w/ TP - Use TP Bonus gear, think Savage Blade set
    sets.precast.WS['Cross Reaper'] = {ammo="Knobkierrie",
	    head="Flam. Zucchetto +2",
	    body="Ignominy Cuirass +3",
	    hands="Sulev. Gauntlets +2",
	    legs={ name="Fall. Flanchard +2", augments={'Enhances "Muted Soul" effect',}},
	    feet="Sulev. Leggings +2",
	    neck={ name="Abyssal Beads +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Thrud Earring",
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- 40% STR / 40% INT - Drains HP, Gives 10% equipment haste unless your Relic is afterglowed then it's 10% in Job ability Haste!!!
    sets.precast.WS['Catastrophe'] = {}

    -- 73~85% INT - Damages varies w/ TP - Fotia belt/waist might be best
    sets.precast.WS['Entropy'] = {ammo="Knobkierrie",
	    head="Flam. Zucchetto +2",
	    body="Ignominy Cuirass +3",
    	hands="Sulev. Gauntlets +2",
	    legs="Ig. Flanchard +3",
	    feet="Flam. Gambieras +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Thrud Earring",
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- 20% STR / 20% INT - Damage varies w/ TP 
    sets.precast.WS['Insurgency'] = {ammo="Knobkierrie",
    	head="Hjarrandi Helm",
	    body="Ignominy Cuirass +3",
	    hands="Sulev. Gauntlets +2",
	    legs={ name="Fall. Flanchard +2", augments={'Enhances "Muted Soul" effect',}},
	    feet="Sulev. Leggings +2",
	    neck={ name="Abyssal Beads +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Thrud Earring",
	    left_ring="Niqmaddu Ring",
	    right_ring="Regal Ring",
	    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- 60% STR / 60% MND - Ignores Def - fTP increases amount of def is ignored.
    sets.precast.WS['Quietus'] = {ammo="Knobkierrie",
        head="Hjarrandi Helm",
        body="Ignominy Cuirass +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Fall. Flanchard +3", augments={'Enhances "Muted Soul" effect',}},
        feet="Flam. Gambieras +2",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

-------------------------------------------------------------------- SWORD ---------------------------------------------------------------------------------

	-- 50% MND / 30% STR - Amount drained varies w/ TP - Darkness Weaponskill - elemental belt
	sets.precast.WS['Sanguine Blade'] = {}

	-- STR 50% & MND 50% - Damage varies with TP - More modifers and weaponskill damage
	sets.precast.WS['Savage Blade'] = {}
		
	-- 73~85% MND - Attack Power varies with TP - Will want to use attack bonus as non-elemental dmg
	sets.precast.WS['Requiescat'] = {}

----------------------------------------------------------------- GREAT SWORD ---------------------------------------------------------------------------
	-- 80% VIT - damage varies w/ TP - TP bonus 
	sets.precast.WS['Torcleaver'] = {}

	-- 40% STR / 40% VIT - Increases crit rate
    sets.precast.WS['Scourge'] = {}
		
	-- 73~85% STR - Damage Varies with TP - .72, 1.5, 2.25 - fTP transfers across all hits.
	sets.precast.WS['Resolution'] = {}

	-- 50% STR & 50% INT - Damage varies with TP 
	sets.precast.WS['Ground Strike'] = {}

-- Idle sets 
	sets.idle = {ammo="Staunch Tathlum",
	    body="Lugra Cloak +1",
	    hands="Sulev. Gauntlets +2",
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet="Sulev. Leggings +2",
	    neck="Coatl Gorget +1",
	    waist="Flume Belt",
	    left_ear="Sanare Earring",
	    right_ear="Hearty Earring",
	    left_ring="Moonbeam Ring",
	    right_ring="Defending Ring",
	    back={ name="Ankou's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}

	sets.idle.DT = {}	    
	
-- Engaged sets

	sets.engaged = {ammo="Ginsen",
	    head="Flam. Zucchetto +2",
	    body="Hjarrandi Breast.",
	    hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
	    legs="Ig. Flanchard +3",
	    feet="Flam. Gambieras +2",
	    neck={ name="Abyssal Beads +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear="Brutal Earring",
	    right_ear="Telos Earring",
	    left_ring="Niqmaddu Ring",
	    right_ring="Petrov Ring",
	    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

	sets.engaged.Acc = {}

	sets.engaged.DT = {}

    sets.engaged.Acc.DT = sets.engaged.PDT

end 

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' then
		if spell.element == world.day_element or spell.element == world.weather_element then
			equip(sets.midcast['Elemental Magic'], {waist="Hachirin-no-Obi"})
		end
	end
	if S{"Drain","Drain II","Drain III", "Aspir", "Aspir II", "Aspir III"}:contains(spell.english) and (spell.element==world.day_element or spell.element==world.weather_element) then
		equip({waist="Hachirin-no-obi"})
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
     -- Equip obi if weather/day matches for WS.   
    if spell.type == 'WeaponSkill' then
        if (state.RangedMode == 'Acc' and RangedWeaponskills:contains(spell.english)) then
            equip(sets.precast.WS[spell.english].Acc)
        elseif (state.OffenseMode == 'Acc' and not RangedWeaponskills:contains(spell.english)) then
            equip(sets.precast.WS[spell.english].Acc)
        end
		if spell.english == 'Sanguine Blade' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
				eventArgs.handled = true 
            end
		elseif spell.english == 'Infernal Scythe' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
				eventArgs.handled = true
            end
		end
    end
end

------------------------------------------------------------------------------------------------------------------- 
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff:lower()=='sleep' then
        if gain and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
            equip({neck="Berserker's Torque"})
        elseif not gain then -- Take Berserker's off
            handle_equipping_gear(player.status)
        end
    end
        if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if buff == 'Aftermath: Lv.3' then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function update_melee_groups()
    if player then
        classes.CustomMeleeGroups:clear()

	if buffactive['Aftermath: Lv.3'] then
            if player.equipment.main == "Liberator" then
                classes.CustomMeleeGroups:append('Liberator')
            elseif player.equipment.main == "Caladbolg" then
                classes.CustomMeleeGroups:append('Calad')
            elseif player.equipment.main == "Redemption" then
                classes.CustomMeleeGroups:append('Red')
            end
        end
    end
    return meleeSet
end

function job_update(cmdParams, eventArgs)
    update_melee_groups()
end

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.RangedMode.value ~= 'Normal' then
        msg = msg .. ', Rng: '..state.RangedMode.current
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

function customize_melee_set(meleeSet)
    if state.Buff.Sleep and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
        meleeSet = set_combine(meleeSet,{neck="Berserker's Torque"})
    end
    return meleeSet
end

-- function customize_idle_set(idleSet)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 7)
end