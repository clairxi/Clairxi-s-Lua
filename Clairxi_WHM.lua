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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'DW')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    send_command('alias g510_m1g1 input /assist <bt>')
    send_command('alias g510_m1g3 input /ja "Divine Caress" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets
    sets.buff.FullSublimation = {waist="Embla Sash",}
    sets.buff.PDTSublimation = sets.buff.FullSublimation

    -- Fast cast sets for spells
    sets.precast.FC = {main="Sucellus",
        sub="Chanter's Shield",
        ammo="Incantor Stone",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Inyanga Jubbah +2",
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="Aya. Cosciales +2",
        feet="Regal Pumps +1",
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

        --- No longer needed on Clairxi but saved for when sharing with others. ---

 --    sets.precast.FC['Cure'] = {main="Sucellus",
 --        sub="Chanter's Shield",
 --        ammo="Incantor Stone",
 --        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
 --        body="Inyanga Jubbah +2",
 --        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
 --        legs="Aya. Cosciales +2",
 --        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
 --        neck="Cleric's Torque",
 --        waist="Witful Belt",
 --        left_ear="Loquac. Earring",
 --        right_ear="Etiolation Earring",
 --        left_ring="Kishar Ring",
 --        right_ring="Prolix Ring",
 --        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

 --    sets.precast.FC['Cure II'] = sets.precast.FC['Cure']
 --    sets.precast.FC['Cure III'] = sets.precast.FC['Cure']
 --    sets.precast.FC['Cure IV'] = sets.precast.FC['Cure']
 --    sets.precast.FC['Cure V'] = sets.precast.FC['Cure']
 --    sets.precast.FC['Cure VI'] = sets.precast.FC['Cure']
	-- sets.precast.FC['Curaga III'] = sets.precast.FC['Cure'] 
	-- sets.precast.FC['Curaga IV'] = sets.precast.FC['Cure']
    
 --    sets.precast.FC['Healing Magic'] = {main="Sucellus",
 --    	sub="Chanter's Shield",
 --    	ammo="Incantor Stone",
 --    	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
 --    	body="Inyanga Jubbah +2",
 --    	hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
 --    	legs="Ebers Pant. +1",
 --    	feet="Regal Pumps +1",
 --    	neck="Cleric's Torque",
 --    	waist="Witful Belt",
 --    	left_ear="Loquac. Earring",
 --    	right_ear="Etiolation Earring",
 --    	left_ring="Kishar Ring",
 --    	right_ring="Prolix Ring",
 --    	back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

 --    sets.precast.FC['Enhancing Magic'] =  {main="Sucellus",
	--     sub="Chanter's Shield",
	--     ammo="Incantor Stone",
	--     head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
	--     body="Inyanga Jubbah +2",
	--     hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
	--     legs="Aya. Cosciales +2",
	--     feet="Regal Pumps +1",
	--     neck="Cleric's Torque",
	--     waist="Embla Sash",
	--     left_ear="Loquac. Earring",
 --    	right_ear="Etiolation Earring",
 --    	left_ring="Kishar Ring",
 --    	right_ring="Prolix Ring",
 --    	back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}}

    sets.precast.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})

    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},}

    sets.precast.JA.Martyr = {hands="Piety Mitts +3"}

    sets.precast.JA.Devotion = {head="Piety Cap +2"}

    sets.precast.JA['Afflatus Solace'] = {feet={ name="Piety Duckbills +3", augments={'Enhances "Afflatus Solace" effect',}},}

    sets.precast.JA['Afflatus Misery'] = {legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},}

    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    -- Cure sets
    gear.default.obi_waist = "Austerity Belt"

    sets.midcast.CureNormal = {main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
        sub="Sors Shield",
        ammo="Pemphredo Tathlum",
        head="Theophany Cap +3",
        body="Ebers Bliaud +1",
        hands="Theophany Mitts +3",
        legs="Ebers Pant. +1",
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Austerity Belt",
        left_ear="Glorious Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.midcast.CuragaNormal = {main={ name="Queller Rod", augments={'MP+80','"Cure" potency +15%','Enmity-5',}},
        sub="Sors Shield",
        ammo="Pemphredo Tathlum",
        head="Theophany Cap +3",
        body="Theo. Briault +3",
        hands="Theophany Mitts +3",
        legs="Ebers Pant. +1",
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Austerity Belt",
        left_ear="Glorious Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.midcast.CureStorm = { main="Chatoyant Staff",
        sub="Pax Grip",
        ammo="Pemphredo Tathlum",
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body="Ebers Bliaud +1",
        hands="Theophany Mitts +3",
        legs="Ebers Pant. +1",
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Hachirin-no-Obi",
        left_ear="Glorious Earring",
        right_ear="Novia Earring",
        left_ring="Stikini Ring",
        right_ring="Lebeche Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.midcast.CuragaStorm = {main="Chatoyant Staff",
        sub="Pax Grip",
        ammo="Pemphredo Tathlum",
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body="Theo. Briault +3",
        hands="Theophany Mitts +3",
        legs="Ebers Pant. +1",
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Hachirin-no-Obi",
        left_ear="Glorious Earring",
        right_ear="Novia Earring",
        left_ring="Stikini Ring",
        right_ring="Lebeche Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.midcast['Full Cure'] = sets.midcast.FastRecast

    sets.midcast.CureMelee = {ammo="Pemphredo Tathlum",
    	head="Theophany Cap +3",
    	body="Ebers Bliaud +1",
    	hands="Theophany Mitts +3",
    	legs="Ebers Pant. +1",
    	feet={ name="Piety Duckbills +3", augments={'Enhances "Afflatus Solace" effect',}},
    	neck="Cleric's Torque",
    	waist="Austerity Belt",
    	left_ear="Glorious Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Lebeche Ring",
    	back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10',}},}

    sets.midcast.Cursna = {main="Yagrush",
        sub="Chanter's Shield",
        ammo="Incantor Stone",
        head="Ebers Cap +1",
        body="Inyanga Jubbah +2",
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="Th. Pant. +3",
        feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck="Malison Medallion",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Haoma's Ring",
        right_ring="Menelaus's Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

    sets.midcast.StatusRemoval = {main="Yagrush",
        sub="Chanter's Shield",
        ammo="Incantor Stone",
        head="Ebers Cap +1",
        body="Inyanga Jubbah +2",
        hands="Ebers Mitts +1",
        legs="Ebers Pant. +1",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        neck="Cleric's Torque",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

    sets.midcast['Erase'] = {main="Yagrush",
        sub="Chanter's Shield",
        ammo="Pemphredo Tathlum",
        head="Ebers Cap +1",
        body="Inyanga Jubbah +2",
        hands="Ebers Mitts +1",
        legs="Ebers Pant. +1",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        neck="Cleric's Torque",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Thauma. Cape",}

    sets.midcast['Esuna'] = {main="Sucellus",
    	sub="Chanter's Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    	body="Inyanga Jubbah +2",
    	hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    	legs="Aya. Cosciales +2",
    	feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
    	neck="Cleric's Torque",
    	waist="Austerity Belt",
    	left_ear="Loquac. Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back="Solemnity Cape",}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Boost-STR'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet="Theo. Duckbills +3",
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Andoaa Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Perimede Cape",}

    sets.midcast['Boost-DEX'] = sets.midcast['Boost-STR']
    sets.midcast['Boost-VIT'] = sets.midcast['Boost-STR']
    sets.midcast['Boost-AGI'] = sets.midcast['Boost-STR']
    sets.midcast['Boost-INT'] = sets.midcast['Boost-STR']
    sets.midcast['Boost-MND'] = sets.midcast['Boost-STR']
    sets.midcast['Boost-CHR'] = sets.midcast['Boost-STR']

    sets.midcast.Stoneskin = {main="Septoptic +1",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet="Theo. Duckbills +3",
        neck="Nodens Gorget",
        waist="Austerity Belt",
        left_ear="Andoaa Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Solemnity Cape",}

    sets.midcast.Haste = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet="Theo. Duckbills +3",
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast['Aurorastorm'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet="Theo. Duckbills +3",
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape"}

    -- sets.midcast.Dispelga = {}

    sets.midcast.Stun = sets.precast.FC

    sets.midcast.Aquaveil = {main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet="Theo. Duckbills +3",
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast.Auspice = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet="Ebers Duckbills +1",
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast.BarElement = {main="Beneficus",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
        feet="Theo. Duckbills +3",
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Solemnity Cape",}

	sets.midcast['Baramnesra'] = sets.midcast.BarElement
	sets.midcast['Barsleepra'] = sets.midcast.BarElement
	sets.midcast['Barpoisonra'] = sets.midcast.BarElement
	sets.midcast['Barparalyzra'] = sets.midcast.BarElement
	sets.midcast['Barblindra'] = sets.midcast.BarElement
	sets.midcast['Barsilencera'] = sets.midcast.BarElement
	sets.midcast['Barpetra'] = sets.midcast.BarElement
	sets.midcast['Barvira'] = sets.midcast.BarElement

    sets.midcast['Regen'] = {main="Bolelabunga",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Inyanga Tiara +2",
        body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},
        hands="Ebers Mitts +1",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast['Regen II'] = sets.midcast['Regen']
    sets.midcast['Regen III'] = sets.midcast['Regen']
    sets.midcast['Regen IV'] = sets.midcast['Regen']

    sets.midcast.Protectra = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Piety Duckbills +3", augments={'Enhances "Afflatus Solace" effect',}},
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast['Protect V'] = sets.midcast.Protectra

    sets.midcast.Shellra = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
        feet="Theo. Duckbills +3",
        neck="Deviant Necklace",
        waist="Embla Sash",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast['Shell V'] = sets.midcast.Shellra

    sets.midcast['Divine Magic'] = {main={ name="Gada", augments={'"Cure" spellcasting time -2%','MND+8','Mag. Acc.+21','"Mag.Atk.Bns."+24',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Ipoca Beret",
        body={ name="Chironic Doublet", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Cure" spellcasting time -2%','CHR+3','Mag. Acc.+10',}},
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        neck="Jokushu Chain",
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Repose'] = {main={ name="Gada", augments={'"Cure" spellcasting time -2%','MND+8','Mag. Acc.+21','"Mag.Atk.Bns."+24',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Chironic Hat", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','MND+9','Mag. Acc.+9',}},
        body="Theo. Briault +3",
        hands="Theophany Mitts +3",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Holy'] = {main={ name="Gada", augments={'"Cure" spellcasting time -2%','MND+8','Mag. Acc.+21','"Mag.Atk.Bns."+24',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Chironic Hat", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','MND+9','Mag. Acc.+9',}},
        body={ name="Chironic Doublet", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Cure" spellcasting time -2%','CHR+3','Mag. Acc.+10',}},
        hands="Chironic Gloves",
        legs="Th. Pant. +3",
        feet={ name="Chironic Slippers", augments={'Mag. Acc.+30','"Resist Silence"+10','CHR+6',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Holy II'] = sets.midcast['Holy']

    sets.midcast['Flash'] = {main={ name="Gada", augments={'"Cure" spellcasting time -2%','MND+8','Mag. Acc.+21','"Mag.Atk.Bns."+24',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Chironic Hat", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','MND+9','Mag. Acc.+9',}},
        body="Theo. Briault +3",
        hands="Theophany Mitts +3",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        neck="Jokushu Chain",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    -- Custom spell classes
    sets.midcast['Enfeebling Magic'] = {main={ name="Gada", augments={'"Cure" spellcasting time -2%','MND+8','Mag. Acc.+21','"Mag.Atk.Bns."+24',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Inyanga Tiara +2",
        body="Theo. Briault +3",
        hands="Theophany Mitts +3",
        legs="Th. Pant. +3",
        feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Arise'] = {main="Sucellus",
    	sub="Chanter's Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    	body="Inyanga Jubbah +2",
    	hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    	legs="Aya. Cosciales +2",
    	feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
    	neck="Cleric's Torque",
    	waist="Austerity Belt",
    	left_ear="Loquac. Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back="Solemnity Cape",}

    sets.midcast['Raise III'] = sets.midcast['Arise']
    sets.midcast['Raise II'] = sets.midcast['Arise']
    sets.midcast['Raise'] = sets.midcast['Arise']

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",
        sub="Pax Grip",
        ammo="Homiliary",
        head="Volte Beret",
        body="Shamash Robe",
        hands={ name="Chironic Gloves", augments={'Mag. Acc.+27','STR+8','"Refresh"+1',}},
        legs={ name="Chironic Hose", augments={'INT+11','"Mag.Atk.Bns."+11','"Refresh"+1','Accuracy+10 Attack+10',}},
        feet={ name="Chironic Slippers", augments={'Pet: "Mag.Atk.Bns."+5','"Drain" and "Aspir" potency +1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        neck="Loricate Torque +1",
        waist="Porous Rope",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak",
        sub="Genmei Shield",
        ammo="Homiliary",
        head="Volte Beret",
        body="Shamash Robe",
        hands={ name="Chironic Gloves", augments={'Mag. Acc.+27','STR+8','"Refresh"+1',}},
        legs={ name="Chironic Hose", augments={'INT+11','"Mag.Atk.Bns."+11','"Refresh"+1','Accuracy+10 Attack+10',}},
        feet={ name="Chironic Slippers", augments={'Pet: "Mag.Atk.Bns."+5','"Drain" and "Aspir" potency +1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        neck="Loricate Torque +1",
        waist="Porous Rope",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.idle.PDT = {main="Daybreak",
        sub="Genmei Shield",
        ammo="Staunch Tathlum",
        head="Volte Beret",
        body="Shamash Robe",
        hands={ name="Chironic Gloves", augments={'Mag. Acc.+27','STR+8','"Refresh"+1',}},
        legs="Aya. Cosciales +2",
        feet={ name="Chironic Slippers", augments={'Pet: "Mag.Atk.Bns."+5','"Drain" and "Aspir" potency +1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
        neck="Loricate Torque +1",
        waist="Porous Rope",
        left_ear="Sanare Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.idle.MDT = {main="Malignance Pole",
        sub="Enki Strap",
        ammo="Staunch Tathlum",
        head="Volte Beret",
        body="Volte doublet",
        hands="Inyan. Dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Inyan. Crackows +2",
        neck="Warder's Charm",
        waist="Porous Rope",
        left_ear="Sanare Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Haste+10','Damage taken-5%',}},}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets
    sets.engaged = {main="Tishtrya",
    	sub="Genmei Shield",
    	ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Combatant's Torque",
        waist="Grunfeld Rope",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Ilabrat Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.DW = {main="Tishtrya",
        sub="Beryllium Mace",
        ammo="Staunch Tathlum",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body="Ayanmo Corazza +2",
        hands={ name="Chironic Gloves", augments={'Accuracy+10 Attack+10','"Dual Wield"+4','Accuracy+12','Attack+3',}},
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Combatant's Torque",
        waist="Grunfeld Rope",
        left_ear="Cessance Earring",
        right_ear="Suppanomimi",
        left_ring="Ilabrat Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.precast.WS['Hexa Strike'] = {ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
        body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},
        hands="Aya. Manopolas +2",
        legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
        feet={ name="Piety Duckbills +3", augments={'Enhances "Afflatus Solace" effect',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Mystic Boon'] = {ammo="Staunch Tathlum",
        head="Aya. Zucchetto +2",
        body={ name="Piety Briault +3", augments={'Enhances "Benediction" effect',}},
        hands="Aya. Manopolas +2",
        legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
        feet={ name="Piety Duckbills +3", augments={'Enhances "Afflatus Solace" effect',}},
        neck="Caro Necklace",
        waist="Porous Rope",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Stikini Ring",
        back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}

    -- sets.precast.WS['Mystic Boon'] = {ammo="Staunch Tathlum",
    -- head={ name="Chironic Hat", augments={'Attack+2','"Dbl.Atk."+4','CHR+10',}},
    -- body="Ayanmo Corazza +2",
    -- hands={ name="Chironic Gloves", augments={'Attack+5','"Dbl.Atk."+4','Accuracy+5',}},
    -- legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
    -- feet={ name="Piety Duckbills +3", augments={'Enhances "Afflatus Solace" effect',}},
    -- neck="Fotia Gorget",
    -- waist="Fotia Belt",
    -- left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    -- right_ear="Brutal Earring",
    -- left_ring="Rufescent Ring",
    -- right_ring="Petrov Ring",
    -- back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Dispelga" then
        equip({main="Daybreak"})
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Dispelga' then
        equip(sets.precast.Dispelga)
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spell.english == "Dispelga" then
        equip({main="Daybreak"})
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' or newValue =='DW' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga')  then
                if buffactive['Aurorastorm'] then
                    if player.status == 'Engaged' then
                        return "CureMelee"
                    elseif default_spell_map == 'Cure' then
                        return "CureStorm"
                    elseif default_spell_map == 'Curaga' then
                        return "CuragaStorm"
                    end
                else
                    if player.status == 'Engaged' then
                        return "CureMelee"
                    elseif default_spell_map == 'Curaga' then
                        return "CuragaNormal"
                    else
                        return "CureNormal"
                    end
                end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
    
    if spell.english == 'Dispelga' then 
        return 'Dispelga'
    end
end

function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end


function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end
 
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
 
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
    update_sublimation()
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

--Global intercept on midcast.
function user_midcast(spell, action, spellMap, eventArgs)
 -- Default base equipment layer of fast recast.
 if spell.action_type == 'Magic' and sets.midcast and sets.midcast.conserve then
     equip(sets.midcast.conserve)
 end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end
