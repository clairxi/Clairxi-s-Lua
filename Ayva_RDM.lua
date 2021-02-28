-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 include('organizer-lib')
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Saboteur = buffactive.saboteur or false

    skill_spells = S{'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enthunder', 'Enthunder II',
                    'Enaero', 'Enaero II', 'Enwater', 'Enwater II', 'Enstone', 'Enstone II',
                    'Gain-STR', 'Gain-DEX', 'Gain-VIT', 'Gain-AGI', 'Gain-INT', 'Gain-MND', 'Gain-CHR'}

    enfeebling_magic_acc = S{'Addle', 'Addle II', 'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
                             'Frazzle II',  'Gravity', 'Gravity II', 'Silence', 'Sleep', 'Sleep II', 'Sleepga'}

    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    
    divine_magic_skill = S{'Flash'}
    
    cure_spells = S{'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Curaga', 'Curaga II', 'Healing Breeze', 'Wild Carrot'}
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'DW', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal', 'Burst')
    state.IdleMode:options('Normal')
 
    select_default_macro_book()
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},}
    
    -- Use a set similiar Myrkr build - MP+
    sets.precast.JA['Convert'] = {main="Septoptic",
	    sub="Culminus",
	    ammo="Hydrocera",
	    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Shrieker's Cuffs",
	    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
	    feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
	    neck="Sanctity Necklace",
	    waist="Luminary Sash",
	    left_ear="Etiolation Earring",
	    right_ear="Halasz Earring",
	    left_ring="Persis Ring",
	    right_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},
	    back="Fi Follet Cape +1",}

    sets.precast.JA['Saboteur'] = {hands="Leth. Gantherots +1",}
    sets.buff.Saboteur = {hands="Leth. Gantherots +1",}
 
    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {}
 
    -- Don't need any special gear for Healing Waltz.
    -- sets.precast.Waltz['Healing Waltz'] = sets.precast.Waltz
 
    -- Fast cast sets for spells
 
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast

    -- 99 RDM needs only 50% Fast Cast in gear.
    -- No other FC sets necessary.
	sets.precast.FC = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    waist="Witful Belt",
	    left_ear="Malignance Earring",
	    left_ring="Weather. Ring",
	    right_ring="Lebeche Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
 
 --    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	-- sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    -- sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})

    -- sets.midcast.Dispelga = {}


        -- Weaponskill sets
    -- sets.precast.WS = {}

    --     -- SWORD
    -- sets.precast.WS['Chant du Cygne'] = {}

    -- sets.precast.WS['Death Blossom'] = {}

    -- sets.precast.WS['Requiescat'] = {} 
 
    -- sets.precast.WS['Sanguine Blade'] = {}

    -- sets.precast.WS['Savage Blade'] = {}

    --     -- DAGGER
    -- sets.precast.WS['Aeolian Edge'] = {}
 
    -- sets.precast.WS['Evisceration'] = {}

           -- CLUB

    -- sets.precast.WS['Seraph Strike'] = sets.precast.WS['Aeolian Edge']
    -- sets.precast.WS['Seraph Blade'] = sets.precast.WS['Aeolian Edge']

    -- Midcast Sets
 
    gear.default.obi_waist = "Eschan Stone"
    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.midcast.Cure = {main="Chatoyant Staff",
	    sub="Enki Strap",
	    ammo="Regal Gem",
	    head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands={ name="Kaykaus Cuffs", augments={'MP+60','"Conserve MP"+6','"Fast Cast"+3',}},
	    legs="Atrophy Tights +2",
	    feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
	    neck="Incanter's Torque",
	    waist=gear.ElementalObi,
	    left_ear="Mendi. Earring",
	    right_ear="Magnetic Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
	    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +3','Enha.mag. skill +6','Mag. Acc.+5',}},}
 
    sets.midcast.Curaga = sets.midcast.Cure

    -- sets.midcast.CureSelf = {}
 
    sets.midcast['Enhancing Magic'] = {main={ name="Colada", augments={'Enh. Mag. eff. dur. +3','INT+3','"Mag.Atk.Bns."+12','DMG:+17',}},
	    sub="Ammurapi Shield",
	    ammo="Pemphredo Tathlum",
	    head={ name="Telchine Cap", augments={'"Conserve MP"+3','Enh. Mag. eff. dur. +9',}},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Atrophy Gloves +2",
	    legs="Atrophy Tights +2",
	    feet="Leth. Houseaux +1",
	    neck="Incanter's Torque",
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Magnetic Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Enhancing Magic'].Skill = {main={ name="Colada", augments={'Enh. Mag. eff. dur. +3','INT+3','"Mag.Atk.Bns."+12','DMG:+17',}},
	    sub="Ammurapi Shield",
	    ammo="Pemphredo Tathlum",
	    head="Befouled Crown",
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands={ name="Viti. Gloves +2", augments={'Enhancing Magic duration',}},
	    legs="Atrophy Tights +2",
	    feet="Leth. Houseaux +1",
	    neck="Incanter's Torque",
	    waist="Embla Sash",
	    left_ear="Mimir Earring",
	    right_ear="Andoaa Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
	    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +3','Enha.mag. skill +6','Mag. Acc.+5',}},}

	sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
    sets.midcast['Haste II'] = sets.midcast['Enhancing Magic']
    sets.midcast['Flurry'] = sets.midcast['Enhancing Magic']
    sets.midcast['Flurry II'] = sets.midcast['Enhancing Magic']

    sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {left_ear="Earthcry Earring",})

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif",})

    sets.midcast['Phalanx'] = sets.midcast['Enhancing Magic']
    sets.midcast['Phalanx II'] = sets.midcast['Enhancing Magic']

    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif",
	    body="Atrophy Tabard +2",
	    legs="Leth. Fuseau +1",})

    sets.midcast.RefreshSelf = set_combine(sets.midcast['Refresh'], {feet="Inspirited Boots",})

    sets.midcast['Refresh II'] = sets.midcast['Refresh']
    sets.midcast['Refresh III'] = sets.midcast['Refresh']

    sets.midcast['Blaze Spikes'] = {main="Oranyan",
	    sub="Enki Strap",
	    ammo="Pemphredo Tathlum",
	    head="Jhakri Coronal +2",
	    body="Jhakri Robe +2",
	    hands="Jhakri Cuffs +2",
	    legs={ name="Viti. Tights +2", augments={'Enspell Damage','Accuracy',}},
	    feet="Jhakri Pigaches +2",
	    neck={ name="Duelist's Torque", augments={'Path: A',}},
	    waist="Channeler's Stone",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Freke Ring",
	    right_ring="Metamor. Ring +1",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Shock Spikes'] = sets.midcast['Blaze Spikes']
    sets.midcast['Ice Spikes'] = sets.midcast['Blaze Spikes']
 
    sets.midcast.Cursna = {main={ name="Colada", augments={'Enh. Mag. eff. dur. +3','INT+3','"Mag.Atk.Bns."+12','DMG:+17',}},
	    sub="Chanter's Shield",
	    ammo="Pemphredo Tathlum",
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Shrieker's Cuffs",
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
	    neck="Malison Medallion",
	    waist="Witful Belt",
	    left_ear="Malignance Earring",
	    right_ear="Loquac. Earring",
	    left_ring="Ephedra Ring",
	    right_ring="Ephedra Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Enfeebling Magic'] = {main="Oranyan",
	    sub="Enki Strap",
	    ammo="Regal Gem",
	    head="Atro. Chapeau +2",
	    body="Atrophy Tabard +2",
	    hands="Jhakri Cuffs +2",
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Spell interruption rate down -6%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
	    feet={ name="Vitiation Boots +2", augments={'Immunobreak Chance',}},
	    neck={ name="Duelist's Torque", augments={'Path: A',}},
	    waist="Luminary Sash",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Kishar Ring",
	    right_ring="Stikini Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Enfeebling Magic'].Acc = {main="Oranyan",
	    sub="Enki Strap",
	    ammo="Regal Gem",
	    head="Atro. Chapeau +2",
	    body="Atrophy Tabard +2",
	    hands="Jhakri Cuffs +2",
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Spell interruption rate down -6%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
	    feet={ name="Vitiation Boots +2", augments={'Immunobreak Chance',}},
	    neck={ name="Duelist's Torque", augments={'Path: A',}},
	    waist="Luminary Sash",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Kishar Ring",
	    right_ring="Stikini Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Enfeebling Magic'].Skill = {main="Oranyan",
	    sub="Enki Strap",
	    ammo="Regal Gem",
	    head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Atrophy Tabard +2",
	    hands="Leth. Gantherots +1",
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Spell interruption rate down -6%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
	    feet={ name="Vitiation Boots +2", augments={'Immunobreak Chance',}},
	    neck={ name="Duelist's Torque", augments={'Path: A',}},
	    waist="Rumination Sash",
	    left_ear="Snotra Earring",
	    right_ear="Vor Earring",
	    left_ring="Stikini Ring",
	    right_ring="Stikini Ring",
	    back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +3','Enha.mag. skill +6','Mag. Acc.+5',}},}
 
 	-- Affected by Enfeebling Magic Effect Equipment
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {body="Lethargy Sayon +1",})

    ---Affected by Dark Magic Skill
    sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
	    neck="Incanter's Torque",
	    left_ring="Evanescence Ring",})
 
    sets.midcast['Elemental Magic'] = {main={ name="Grioavolr", augments={'MP+100','Mag. Acc.+29','"Mag.Atk.Bns."+25',}},
	    sub="Enki Strap",
	    ammo="Pemphredo Tathlum",
	    head="Jhakri Coronal +2",
	    body="Jhakri Robe +2",
	    hands="Jhakri Cuffs +2",
	    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
	    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+11','CHR+3','Mag. Acc.+2','"Mag.Atk.Bns."+5',}},
	    neck="Baetyl Pendant",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Jhakri Ring",
	    right_ring="Freke Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Magic Damage +10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].Burst = {main={ name="Grioavolr", augments={'MP+100','Mag. Acc.+29','"Mag.Atk.Bns."+25',}},
	    sub="Enki Strap",
	    ammo="Pemphredo Tathlum",
	    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+21','Magic burst dmg.+6%','INT+8',}},
	    body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+4%','AGI+1','Mag. Acc.+15',}},
	    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
	    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+26','Magic burst dmg.+10%','CHR+14',}},
	    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+6%','Mag. Acc.+15','"Mag.Atk.Bns."+2',}},
	    neck="Mizu. Kubikazari",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Mujin Band",
	    right_ring="Locus Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+10 /Mag. Dmg.+10','Magic Damage +10','"Mag.Atk.Bns."+10',}},}
 
    sets.midcast.Drain = {main="Oranyan",
	    sub="Enki Strap",
	    ammo="Regal Gem",
	    head="Jhakri Coronal +2",
	    body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
	    hands="Jhakri Cuffs +2",
	    legs="Jhakri Slops +2",
	    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+11','CHR+3','Mag. Acc.+2','"Mag.Atk.Bns."+5',}},
	    neck="Erra Pendant",
	    waist="Fucho-no-Obi",
	    left_ear="Malignance Earring",
	    right_ear="Snotra Earring",
	    left_ring="Evanescence Ring",
	    right_ring="Freke Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
 
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast['Stun'] = {main="Oranyan",
	    sub="Enki Strap",
	    ammo="Regal Gem",
	    head="Atro. Chapeau +2",
	    body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
	    hands="Jhakri Cuffs +2",
	    legs={ name="Chironic Hose", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Spell interruption rate down -6%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
	    feet={ name="Vitiation Boots +2", augments={'Immunobreak Chance',}},
	    neck={ name="Duelist's Torque", augments={'Path: A',}},
	    waist="Luminary Sash",
	    left_ear="Malignance Earring",
	    right_ear="Regal Earring",
	    left_ring="Kishar Ring",
	    right_ring="Stikini Ring",
	    back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    
    -- Sets to return to when not performing an action.
 
    -- Idle sets
    sets.idle = {main="Bolelabunga",
	    sub="Genmei Shield",
	    ammo="Homiliary",
	    head={ name="Viti. Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
	    body="Jhakri Robe +2",
	    hands={ name="Merlinic Dastanas", augments={'Attack+4','MND+9','"Refresh"+1',}},
	    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	    feet={ name="Merlinic Crackows", augments={'Attack+16','INT+7','"Refresh"+1','Accuracy+10 Attack+10',}},
	    neck="Loricate Torque +1",
	    waist="Flume Belt",
	    left_ear="Sanare Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Defending Ring",
	    right_ring="Ayanmo Ring",
	    back="Moonbeam Cape",}
 
    sets.Kiting = {legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},}
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    -- sets.engaged = {}

    -- sets.engaged.Acc = {}

    -- sets.engaged.PDT = {}

    -- sets.engaged.DW = {}
  
    -- sets.engaged.DW.Acc = {}

    -- sets.engaged.DW.PDT = sets.engaged.PDT   

end
  
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
  
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.english == 'Dispelga' then
        equip(sets.precast.FC.Dispelga)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
        cancel_spell()
        send_command('@input /ma "Phalanx" <me>')
    end
    if spell.english == 'Dispelga' then
        equip(sets.precast.FC.Dispelga)
    end
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_midcast(spell, action, spellMap, eventArgs)
        if spell.english == "Impact" then
           equip(sets.midcast.Impact)
        end
    if spell.english == "Dispelga" then
        equip(sets.midcast.Dispelga)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
        if spell.english == "Impact" then
           equip(sets.midcast.Impact)
        end

    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)

    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)

    elseif spellMap == 'Refresh' and spell.target.type == 'SELF' then
        equip(sets.midcast.RefreshSelf)
    end
end
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enhancing Magic' then
            if skill_spells:contains(spell.english) then
                return 'Skill'
            end
        elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
            equip(sets.midcast.CureSelf)

        elseif spellMap == 'Refresh' and spell.target.type == 'SELF' then
            equip(sets.midcast.RefreshSelf)
            
        elseif spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_acc:contains(spell.english) then
                return 'Acc'

            elseif enfeebling_magic_skill:contains(spell.english) then
                return 'Skill'
            end
        end
    end
end
  
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
  
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end
  
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
  
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
      
    return idleSet
end
  
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
  
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
  
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
set_macro_page(1, 1)
end