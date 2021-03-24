-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
        mote_include_version = 2
 
        -- Load and initialize the include file.
        include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
        indi_timer = ''
        indi_duration = 280
    state.Buff['Collimated Fervor'] = buffactive['Collimated Fervor'] or false
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
        
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Burst', 'BurstResist')
    state.IdleMode:options('Normal', 'PDT')

    state.PetMode = M{['description']='Pet Mode'}
    state.PetMode:options('Normal', 'MasterDT', 'Away')

    send_command('bind ^` gs c cycle PetMode')
 
    select_default_macro_book()
    define_nuke_downgrades()
end

function user_unload()
    send_command('unbind ^`')
end

 
function define_nuke_downgrades()
        t1              =       S{      'Stone',                'Water',                'Aero',                 'Fire',                 'Blizzard',             'Thunder'}
        t2              =       S{      'Stone II',             'Water II',             'Aero II',              'Fire II',              'Blizzard II',          'Thunder II'}
        t3              =       S{      'Stone III',            'Water III',            'Aero III',             'Fire III',             'Blizzard III',         'Thunder III'}
        t4              =       S{      'Stone IV',             'Water IV',             'Aero IV',              'Fire IV',              'Blizzard IV',          'Thunder IV'}
        t5              =       S{      'Stone V',              'Water V',              'Aero V',               'Fire V',               'Blizzard V',           'Thunder V'}
        t6              =       S{      'Stone VI',             'Water VI',             'Aero VI',              'Fire VI',              'Blizzard VI',          'Thunder VI'}
        ra1             =       S{      'Stonera',              'Watera',               'Aera',                 'Fira',                 'Blizzara',             'Thundara'}
        ra2             =       S{      'Stonera II',           'Watera II',            'Aera II',              'Fira II',              'Blizzara II',          'Thundara II'}
        ra3             =       S{      'Stonera III',          'Watera III',           'Aera III',             'Fira III',             'Blizzara III',         'Thundara III'}
        no_down =       S{              'Quake',                'Flood',                'Tornado',              'Flare',                'Freeze',               'Burst',
                                        'Quake II',             'Flood II',             'Tornado II',           'Flare II',             'Freeze II',            'Burst II',
                                        'Stonega',              'Waterga',              'Aeroga',               'Firaga',               'Blizzaga',             'Thundaga',
                                        'Stonega II',           'Waterga II',           'Aeroga II',            'Firaga II',            'Blizzaga II',          'Thundaga II',
                                        'Stonega III',          'Waterga III',          'Aeroga III',           'Firaga III',           'Blizzaga III',         'Thundaga III',
                                        'Stoneja',              'Waterja',              'Aeroja',               'Firaja',               'Blizzaja',             'Thundaja',
                                        'Rasp',                 'Drown',                'Choke',                'Burn',                 'Frost',                'Shock',
                                        'Geohelix',             'Hydrohelix',           'Anemohelix',           'Pyrohelix',            'Cryohelix',            'Ionohelix',
                                        'Luminohelix',          'Noctohelix',           'Comet',                'Meteor',               'Impact'}
        aras    =       S{              'Stonera',              'Watera',               'Aera',                 'Fira',                 'Blizzara',             'Thundara',
                                        'Stonera II',           'Watera II',            'Aera II',              'Fira II',              'Blizzara II',          'Thundara II',
                                        'Stonera III',          'Watera III',           'Aera III',             'Fira III',             'Blizzara III',         'Thundara III'}
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
--------------------------------------
-- LET THE GEARSWAPING BEGIN!
--------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--             JOB ABILITIES                 --
--------------------------------------------------------------------------------------------------------------------------
    
    sets.precast.JA['Bolster'] = {body={ name="Bagua Tunic +3", augments={'Enhances "Bolster" effect',}},}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +3",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
    sets.precast.JA['Concentric Pulse'] = {head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},}

    --Merited Abilities
    -- sets.precast.JA['Mending Halation'] ={legs={ name="Bagua Pants +2", augments={'Enhances "Mending Halation" effect',}},}
    sets.precast.JA['Radial Arcana'] = {feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},}

    --If Curative Recantation is merited include Relic Hands for higher healing, if not just ignore.
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",
        hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},}

--------------------------------------------------------------------------------------------------------------------------
--             PRECAST WEAPONSKILLS                 --
--------------------------------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Flash Nova'] = {}
 
    sets.precast.WS['Hexa Strike'] = {}
 
    sets.precast.WS['Realmrazer'] = {}
 
    sets.precast.WS['Exudation'] = {}


--------------------------------------------------------------------------------------------------------------------------
--             PRECAST SPELLS                 --
--------------------------------------------------------------------------------------------------------------------------
    ------ Capped at 80% no additional FC sets needed -------
 
    sets.precast.FC = {range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Amalric Coif",
        body="Zendik Robe",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
        legs="Geomancy Pants +3",
        feet="Regal Pumps +1",
        neck="Voltsurge Torque",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Weather. Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
       
    sets.precast['Impact'] = set_combine(sets.precast.FC,{body="Twilight Cloak",})  

    sets.precast.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})

    --This is if you have Primeval Zeal Merited.... Otherwise this does nothing.
    -- sets.precast.FC.CF = set_combine(sets.precast.FC,{head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},})       
          
--------------------------------------------------------------------------------------------------------------------------
--             GEOMANCY MIDCAST SPELLS                 --
--------------------------------------------------------------------------------------------------------------------------
 
        -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC

    --- 900 Combined skill from Handbell skill & Geomancy skill
    --- Geomancy + does not stack and will only take the highest, nor count towards the 900 skill
    --- Idris = +10
    --- Bagua's Charm +2 = +7
    --- Bagua's Charm +1 = +6
    --- Bagua's Charm = +5
    --- Dunna = +5
 
    sets.midcast.Geomancy = {main={ name="Idris", augments={'Path: A',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
        body="Vedic Coat",
        hands="Geo. Mitaines +3",
        legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        feet={ name="Vanya Clogs", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        neck={ name="Bagua Charm +1", augments={'Path: A',}},
        waist="Pythia Sash +1",
        left_ear="Magnetic Earring",
        right_ear="Etiolation Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
       
    sets.midcast.Geomancy.Indi = {main={ name="Idris", augments={'Path: A',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
        body="Vedic Coat",
        hands="Geo. Mitaines +3",
        legs={ name="Bagua Pants +2", augments={'Enhances "Mending Halation" effect',}},
        feet="Azimuth Gaiters +1",
        neck="Incanter's Torque",
        waist="Pythia Sash +1",
        left_ear="Magnetic Earring",
        right_ear="Etiolation Earring",
        left_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},
        right_ring="Freke Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}

    -- Geomancy + gear does NOT enhance your indi spell being casted on someone else.
    sets.midcast.Geomancy.Entrust = {main="Septoptic",
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
        body="Vedic Coat",
        hands="Geo. Mitaines +3",
        legs={ name="Bagua Pants +2", augments={'Enhances "Mending Halation" effect',}},
        feet="Azimuth Gaiters +1",
        neck="Incanter's Torque",
        waist="Pythia Sash +1",
        left_ear="Magnetic Earring",
        right_ear="Etiolation Earring",
        left_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},
        right_ring="Freke Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}

--------------------------------------------------------------------------------------------------------------------------
--             WHITE MAGIC MIDCAST SPELLS                 --
--------------------------------------------------------------------------------------------------------------------------
 
    sets.midcast.Cure = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','STR+2','"Mag.Atk.Bns."+19',}},
        sub="Sors Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Vedic Coat",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
        legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        neck="Nodens Gorget",
        waist="Embla Sash",
        left_ear="Magnetic Earring",
        right_ear="Mendi. Earring",
        left_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},
        right_ring="Lebeche Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
               
    sets.midcast.Cursna = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','STR+2','"Mag.Atk.Bns."+19',}},
        sub="Sors Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Zendik Robe",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
        legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck="Malison Medallion",
        waist="Embla Sash",
        left_ear="Magnetic Earring",
        right_ear="Malignance Earring",
        left_ring="Ephedra Ring",
        right_ring="Ephedra Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
 
    sets.midcast.Curaga = sets.midcast.Cure
 
    -- This set is attempting to get 500 skill 
    sets.midcast['Enhancing Magic'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','STR+2','"Mag.Atk.Bns."+19',}},
        sub="Ammurapi Shield",
        head="Befouled Crown",
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}},
        feet="Regal Pumps +1",
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Mimir Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Fi Follet Cape +1",}

    -- This is a pure enhancing magic duration set.
    sets.midcast['Haste'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','STR+2','"Mag.Atk.Bns."+19',}},
        sub="Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Telchine Cap", augments={'"Conserve MP"+3','Enh. Mag. eff. dur. +9',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Magnetic Earring",
        right_ear="Malignance Earring",
        left_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},
        right_ring="Weather. Ring",
        back="Fi Follet Cape +1",}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {left_ear="Earthcry Earring",})
       
    sets.midcast['Regen'] = sets.midcast['Haste']

    -- Lua will automatically recognize if casting on Self to put on Inspirited Boots if in inventory/wardrobes
    sets.midcast['Refresh'] = set_combine(sets.midcast['Haste'], {head="Amalric Coif",})   

    sets.midcast['Enfeebling Magic'] = {main={ name="Idris", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Geo. Galero +3",
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3",
        legs="Geomancy Pants +3",
        feet="Geo. Sandals +3",
        neck={ name="Bagua Charm +1", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Weather. Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

--------------------------------------------------------------------------------------------------------------------------
--             BLACK MAGIC MIDCAST SPELLS                 --
--------------------------------------------------------------------------------------------------------------------------

    sets.midcast['Dispel'] = sets.midcast['Enfeebling Magic']
    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak"})
  
    sets.midcast['Drain'] = {main={ name="Idris", augments={'Path: A',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
        body="Geomancy Tunic +3",
        hands="Geo. Mitaines +3",
        legs="Geomancy Pants +3",
        feet="Agwu's Pigaches",
        neck="Erra Pendant",
        waist="Fucho-no-Obi",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Evanescence Ring",
        right_ring="Archon Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}
 
    sets.midcast['Aspir'] = sets.midcast['Drain']
    sets.midcast['Aspir II'] = sets.midcast['Drain']
    sets.midcast['Aspir III'] = sets.midcast['Drain']      
 
        -- Elemental Magic sets
 
    sets.midcast['Elemental Magic'] = {main={ name="Grioavolr", augments={'MP+100','Mag. Acc.+29','"Mag.Atk.Bns."+25',}},
        sub="Enki Strap",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
        body={ name="Bagua Tunic +3", augments={'Enhances "Bolster" effect',}},
        hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},
        legs="Jhakri Slops +2",
        feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Jhakri Ring",
        right_ring="Freke Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}
 
    sets.midcast['Elemental Magic'].Resistant = {main={ name="Grioavolr", augments={'MP+100','Mag. Acc.+29','"Mag.Atk.Bns."+25',}},
        sub="Enki Strap",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Barkaro. Earring",
        right_ear="Malignance Earring",
        left_ring="Jhakri Ring",
        right_ring="Freke Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    --- Magic Burst I - Caps at 40%
    --- Magic Burst II does not have a known cap - Need to cap I before applying II
               
    sets.midcast['Elemental Magic'].Burst = {main={ name="Grioavolr", augments={'MP+100','Mag. Acc.+29','"Mag.Atk.Bns."+25',}},
        sub="Enki Strap",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Geo. Galero +3",
        body="Ea Houppelande",
        hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+26','Magic burst dmg.+10%','CHR+14',}},
        feet="Jhakri Pigaches +2",
        neck="Mizu. Kubikazari",
        waist="Eschan Stone",
        left_ear="Regal Earring",
        right_ear="Malignance Earring",
        left_ring="Locus Ring",
        right_ring="Mujin Band",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}
               
    sets.midcast['Elemental Magic'].BurstResist = sets.midcast['Elemental Magic'].Burst
               
    sets.midcast['Impact'] = set_combine(sets.midcast['Elemental Magic'], {main="Daybreak"})          
 
 
--------------------------------------------------------------------------------------------------------------------------
--             IDLE SETS                 --
--------------------------------------------------------------------------------------------------------------------------

    -- Idle sets
    sets.idle = {main={ name="Idris", augments={'Path: A',}},
        sub="Genmei Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Befouled Crown",
        body="Geomancy Tunic +3",
        hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},
        legs="Volte Brais",
        feet="Geo. Sandals +3",
        neck="Loricate Torque +1",
        waist="Fucho-no-Obi",
        left_ear="Sanare Earring",
        right_ear="Hearty Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
               
    --- Total Pet Damage Taken - = -87.5%
    --- Geomancer gets innate Pet DT - 38%
    --- Only need -49.5% in gear
    --- Pet Regen can combat the innate "Perp Cost" of a Luopan
    ---    - Standard Luopan - 24 HP/Tic
    ---    - Lasting Emanation Luopan - 17 HP/Tic
    ---    - Ecliptic Attrition Luopan - 30 HP/Tic
    ---    - Both LE / EA Luopan - 23 HP/Tic

    -- Pet sets are for when Luopan is present.
    sets.idle.Pet = {main={ name="Idris", augments={'Path: A',}},
        sub="Genmei Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Telchine Cap", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        body={ name="Telchine Chas.", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        neck={ name="Bagua Charm +1", augments={'Path: A',}},
        waist="Isa Belt",
        left_ear="Sanare Earring",
        right_ear="Hearty Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Nantosuelta's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},}
               
    sets.idle.Pet.MasterDT = {main={ name="Idris", augments={'Path: A',}},
        sub="Genmei Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Telchine Cap", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        body="Mallquis Saio +2",
        hands="Geo. Mitaines +3",
        legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        feet="Mallquis Clogs +2",
        neck="Loricate Torque +1",
        waist="Isa Belt",
        left_ear="Sanare Earring",
        right_ear="Hearty Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Nantosuelta's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},}

    sets.idle.Pet.Away = {main={ name="Idris", augments={'Path: A',}},
        sub="Genmei Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Telchine Cap", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        body="Jhakri Robe +2",
        hands="Geo. Mitaines +3",
        legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
        neck={ name="Bagua Charm +1", augments={'Path: A',}},
        waist="Fucho-no-Obi",
        left_ear="Sanare Earring",
        right_ear="Hearty Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Nantosuelta's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},}
 
--------------------------------------------------------------------------------------------------------------------------
--             LOL ENGAGED SETS                 --
--------------------------------------------------------------------------------------------------------------------------
 
    --Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {}

end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
        refine_nukes(spell, action, spellMap, eventArgs)
        refine_various_spells(spell, action, spellMap, eventArgs)
    if spell.english == "Dispelga" then
        equip({main="Daybreak"})
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Dispelga' then
        equip(sets.precast.Dispelga)
    end
    if spell.skill == "Elemental Magic" and buffactive['Collimated Fervor'] then
        equip(sets.precast.FC.CF)
    end
end
 
function refine_various_spells(spell, action, spellMap, eventArgs)
        aspirs = S{'Aspir','Aspir II','Aspir III'}
        sleeps = S{'Sleep','Sleep II'}
        sleepgas = S{'Sleepga','Sleepga II'}
 
        if not sleepgas:contains(spell.english) and not sleeps:contains(spell.english) and not aspirs:contains(spell.english) then
                return
        end
 
        local newSpell = spell.english
        local spell_recasts = windower.ffxi.get_spell_recasts()
        local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
 
        if spell_recasts[spell.recast_id] > 0 then
                if aspirs:contains(spell.english) then
                        if spell.english == 'Aspir' then
                                add_to_chat(122,cancelling)
                                eventArgs.cancel = true
                                return
                        elseif spell.english == 'Aspir II' then newSpell = 'Aspir'
                        elseif spell.english == 'Aspir III' then newSpell = 'Aspir II'
                        end                    
                elseif sleeps:contains(spell.english) then
                        if spell.english == 'Sleep' then
                                add_to_chat(122,cancelling)
                                eventArgs.cancel = true
                                return
                        elseif spell.english == 'Sleep II' then newSpell = 'Sleep'
                        end
                elseif sleepgas:contains(spell.english) then
                        if spell.english == 'Sleepga' then
                                add_to_chat(122,cancelling)
                                eventArgs.cancel = true
                                return
                        elseif spell.english == 'Sleepga II' then newSpell = 'Sleepga'
                        end
                end
        end
 
        if newSpell ~= spell.english then
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
                return
        end
end
 
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Geomancy' then
            if string.find(spell.english, 'Geo-') then
                equip(sets.midcast.Geomancy)
            elseif string.find(spell.english, 'Indi-') then
                equip(sets.midcast.Geomancy.Indi)          
                if buffactive['Entrust'] then
                    sets.midcast.Geomancy.Indi = sets.midcast.Geomancy.Entrust        
                end
            end
        end
    end
end
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and spell.element == world.day_element or spell.element == world.weather_element then
        equip ({waist="Hachirin-no-obi"})
    end
    if spell.english == "Dispelga" then
        equip({main="Daybreak"})
    end
    if spell.target.type == 'SELF' and spell.english == "Refresh" then
        equip({feet="Inspirited Boots"})
    end
end
   
function job_aftercast(spell, action, spellMap, eventArgs)
        if not spell.interrupted then
                if spell.english:startswith('Indi') then
                        if not classes.CustomIdleGroups:contains('Indi') then
                                classes.CustomIdleGroups:append('Indi')
                        end
                        send_command('@timers d "'..indi_timer..'"')
                        indi_timer = spell.english
                        send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
                elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
                        send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
                elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
                        send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
                end
        elseif not player.indi then
                classes.CustomIdleGroups:clear()
        end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
        if player.indi and not classes.CustomIdleGroups:contains('Indi')then
                classes.CustomIdleGroups:append('Indi')
                handle_equipping_gear(player.status)
        elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
                classes.CustomIdleGroups:clear()
                handle_equipping_gear(player.status)
        end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
    if spell.english == 'Dispelga' then 
        return 'Dispelga'
    end
end
 
function customize_idle_set(idleSet)
        if player.mpp < 51 then
                idleSet = set_combine(idleSet, sets.latent_refresh)
        end
        return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
            classes.CustomIdleGroups:append('Indi')
    end
    update_pet_mode()
    handle_equipping_gear(player.status, eventArgs)
        if state.PetMode.value == 'Normal' then
             equip(sets.idle.Pet)
             eventArgs.handled = false
        elseif state.PetMode.value == 'MasterDT' then
             equip(sets.idle.Pet.MasterDT)
             eventArgs.handled = false
        elseif state.PetMode.value == 'Away' then
             equip(sets.idle.Pet.Away)
             eventArgs.handled = false
        end
        return idleSet
end

function get_pet_mode()
    if pet.isvalid then
        return state.PetMode.value or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    update_custom_groups()
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
        display_current_caster_state()
        eventArgs.handled = true
end

function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

 
function refine_nukes(spell, action, spellMap, eventArgs)
        local nuke_mp_cost = {  ['Stone'] = 4, ['Stone II'] = 16, ['Stone III'] = 46, ['Stone IV'] = 88,                          ['Stone V'] = 135,                      ['Stone VI'] = 237,
                                                        ['Water'] = 5, ['Water II'] = 19, ['Water III'] = 46, ['Water IV'] = 99,                          ['Water V'] = 175,                      ['Water VI'] = 266,
                                                        ['Aero'] = 6, ['Aero II'] = 22, ['Aero III'] = 54, ['Aero IV'] = 115,                     ['Aero V'] = 198,                        ['Aero VI'] = 299,
                                                        ['Fire'] = 7, ['Fire II'] = 26, ['Fire III'] = 63, ['Fire IV'] = 135,                     ['Fire V'] = 228,                        ['Fire VI'] = 339,
                                                        ['Blizzard'] = 8, ['Blizzard II'] = 31, ['Blizzard III'] = 75, ['Blizzard IV'] = 162,  ['Blizzard V'] = 267,   ['Blizzard VI'] = 386,
                                                        ['Thunder'] = 9, ['Thunder II'] = 37, ['Thunder III'] = 91, ['Thunder IV'] = 195,   ['Thunder V'] = 306,        ['Thunder VI'] = 437,
                                                        ['Stonera'] = 54, ['Stonera II'] = 143, ['Stonera III'] = 276,
                                                        ['Watera'] = 66, ['Watera II'] = 163, ['Watera III'] = 312,
                                                        ['Aera'] = 79, ['Aera II'] = 184, ['Aera III'] = 350,
                                                        ['Fira'] = 93, ['Fira II'] = 206, ['Fira III'] = 390,
                                                        ['Blizzara'] = 108, ['Blizzara II'] = 229, ['Blizzara III'] = 432,
                                                        ['Thundara'] = 123, ['Thundara II'] = 253, ['Thundara III'] = 476}
        if spell.skill ~= 'Elemental Magic' or no_down:contains(spell.english) then
                return
        end
 
        local elementType
 
        if spell.element == 'Earth' then elementType = 'Stone'
        elseif spell.element == 'Water' then elementType = 'Water'
        elseif spell.element == 'Wind' then elementType = 'Aero'
        elseif spell.element == 'Fire' then elementType = 'Fire'
        elseif spell.element == 'Ice' then elementType = 'Blizzard'
        elseif spell.element == 'Lightning' then elementType = 'Thunder'
        end
 
        local newAra
 
        if aras:contains(spell.english)then
                if elementType == 'Stone' then newAra = 'Stonera'
                elseif elementType == 'Water' then newAra = 'Watera'
                elseif elementType == 'Aero' then newAra = 'Aera'
                elseif elementType == 'Fire' then newAra = 'Fira'
                elseif elementType == 'Blizzard' then newAra = 'Blizzara'
                elseif elementType == 'Thunder' then newAra = 'Thundara'
                end
        end
 
        local newNuke = spell.english
 
        local nukeMpCost = nuke_mp_cost[newNuke]
 
        if buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
                nukeMpCost = math.floor(nukeMpCost * 0.9)
        elseif buffactive['Light Arts'] or buffactive['Addendum: White'] then
                nukeMpCost = math.ceil(nukeMpCost * 1.2)
        end
 
        local downgrade
 
        -- Downgrade the spell to what we can actually afford
        if player.mp < nukeMpCost and not buffactive['Mana Well'] then
                if spell.element == 'Earth' then
                        if aras:contains(spell.english) then
                                if player.mp < 54 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 143 then newNuke = ''..newAra..''
                                elseif player.mp < 276 then newNuke = ''..newAra..' II'
                                end
                        elseif not aras:contains(spell.english) then
                                if player.mp < 4 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 16 then newNuke = 'Stone'
                                elseif player.mp < 40 then newNuke = 'Stone II'
                                elseif player.mp < 88 then newNuke = 'Stone III'
                                elseif player.mp < 156 then newNuke = 'Stone IV'
                                elseif player.mp < 237 then newNuke = 'Stone V'
                                end
                        end
                elseif spell.element == 'Water' then
                        if aras:contains(spell.english) then
                                if player.mp < 66 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 163 then newNuke = ''..newAra..''
                                elseif player.mp < 312 then newNuke = ''..newAra..' II'
                                end
                        elseif not aras:contains(spell.english) then
                                if player.mp < 5 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 19 then newNuke = 'Water'
                                elseif player.mp < 46 then newNuke = 'Water II'
                                elseif player.mp < 99 then newNuke = 'Water III'
                                elseif player.mp < 175 then newNuke = 'Water IV'
                                elseif player.mp < 266 then newNuke = 'Water V'
                                end
                        end
                elseif spell.element == 'Wind' then
                        if aras:contains(spell.english) then
                                if player.mp < 79 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 184 then newNuke = ''..newAra..''
                                elseif player.mp < 350 then newNuke = ''..newAra..' II'
                                end
                        elseif not aras:contains(spell.english) then
                                if player.mp < 6 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 22 then newNuke = 'Aero'
                                elseif player.mp < 54 then newNuke = 'Aero II'
                                elseif player.mp < 115 then newNuke = 'Aero III'
                                elseif player.mp < 198 then newNuke = 'Aero IV'
                                elseif player.mp < 299 then newNuke = 'Aero V'
                                end
                        end
                elseif spell.element == 'Fire' then
                        if aras:contains(spell.english) then
                                if player.mp < 93 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 206 then newNuke = ''..newAra..''
                                elseif player.mp < 390 then newNuke = ''..newAra..' II'
                                end
                        elseif not aras:contains(spell.english) then
                                if player.mp < 7 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 26 then newNuke = 'Fire'
                                elseif player.mp < 63 then newNuke = 'Fire II'
                                elseif player.mp < 135 then newNuke = 'Fire III'
                                elseif player.mp < 228 then newNuke = 'Fire IV'
                                elseif player.mp < 339 then newNuke = 'Fire V'
                                end
                        end
                elseif spell.element == 'Ice' then
                        if aras:contains(spell.english) then
                                if player.mp < 108 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 229 then newNuke = ''..newAra..''
                                elseif player.mp < 432 then newNuke = ''..newAra..' II'
                                end
                        elseif not aras:contains(spell.english) then
                                if player.mp < 8 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 31 then newNuke = 'Blizzard'
                                elseif player.mp < 75 then newNuke = 'Blizzard II'
                                elseif player.mp < 162 then newNuke = 'Blizzard III'
                                elseif player.mp < 267 then newNuke = 'Blizzard IV'
                                elseif player.mp < 386 then newNuke = 'Blizzard V'
                                end
                        end
                elseif spell.element == 'Lightning' then
                        if aras:contains(spell.english) then
                                if player.mp < 123 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 253 then newNuke = ''..newAra..''
                                elseif player.mp < 476 then newNuke = ''..newAra..' II'
                                end
                        elseif not aras:contains(spell.english) then
                                if player.mp < 9 then
                                        add_to_chat(122, 'Insufficient MP ['..tostring(player.mp)..']. Cancelling.')
                                        eventArgs.cancel = true
                                        return
                                elseif player.mp < 37 then newNuke = 'Thunder'
                                elseif player.mp < 91 then newNuke = 'Thunder II'
                                elseif player.mp < 195 then newNuke = 'Thunder III'
                                elseif player.mp < 306 then newNuke = 'Thunder IV'
                                elseif player.mp < 437 then newNuke = 'Thunder V'
                                end
                        end
                end
 
                downgrade = 'Insufficient MP ['..tostring(player.mp)..'] to cast '..spell.english..'. Changing spell to '..newNuke..'.'
        end
 
        -- Downgrade the spell to what we can actually cast
        local spell_recasts = windower.ffxi.get_spell_recasts()
        if spell_recasts[spell.recast_id] > 0 then
                if t1:contains(spell.english) then
                        add_to_chat(122, ''..spell.english..' is on cooldown. Cancelling.')
                        eventArgs.cancel = true
                        return
                elseif t2:contains(spell.english) then newNuke = ''..elementType..''
                elseif t3:contains(spell.english) then newNuke = ''..elementType..' II'
                elseif t4:contains(spell.english) then newNuke = ''..elementType..' III'
                elseif t5:contains(spell.english) then newNuke = ''..elementType..' IV'
                elseif t6:contains(spell.english) then newNuke = ''..elementType..' V'
                elseif ra2:contains(spell.english) then newNuke = ''..newAra..''
                elseif ra3:contains(spell.english) then newNuke = ''..newAra..' II'
                end
 
                downgrade = '***'..spell.english..'*** is on cooldown. Downgrading spell to ***'..newNuke..'***.'
        end
 
        if newNuke ~= spell.english then
                send_command('@input /ma "'..newNuke..'" '..tostring(spell.target.raw))
                if downgrade then
                        add_to_chat(122, downgrade)
                end
                eventArgs.cancel = true
                return
        end
end

 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        set_macro_page(1,2)
end
