-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DD')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'PDT')

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.midcast.Enmity = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Runeist's Coat +2",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

    sets.precast.JA['Pflug'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Runeist's Boots +2",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}
    
    sets.precast.JA['Battuta'] = {ammo="Sapience Orb",
        head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}
    
    sets.precast.JA['Liement'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.precast.JA['Gambit'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Runeist's Mitons +2",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}
    
    sets.precast.JA['Rayke'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet={ name="Futhark Boots +2", augments={'Enhances "Rayke" effect',}},
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}
    
    sets.precast.JA['Elemental Sforzo'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}
    
    sets.precast.JA['Swordplay'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands={ name="Futhark Mitons +1", augments={'Enhances "Sleight of Sword" effect',}},
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}
    
    sets.precast.JA['Embolden'] = sets.enmity

    sets.precast.JA["Vivacious Pulse"] = {ammo="Sapience Orb",
        head="Erilaz Galea +1",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Rune. Trousers +2",
        feet="Ahosi Leggings",
        neck="Incanter's Torque",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.precast.JA["One For All"] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.precast.JA['Lunge'] = {ammo="Pemphredo Tathlum",
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','STR+10','Mag. Acc.+11',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon skill damage +1%','Mag. Acc.+8',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+5',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Store TP"+1',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Acumen Ring",
        right_ring="Mujin Band",
        back={ name="Ogma's cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

    sets.precast.JA['Provoke'] = sets.midcast["One For All"]

    sets.precast.Waltz = {body="Passion Jacket",}

	-- Fast cast sets for spells
    sets.precast.FC = {ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Taeon Tabard", augments={'"Fast Cast"+5','Phalanx +2',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
        legs="Aya. Cosciales +2",
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Weather. Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.precast.FC['Enhancing Magic'] = {ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
        legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Weather. Ring",
        right_ring="Kishar Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads'})
    sets.precast.FC['Utsusemi: Ni'] = sets.precast.FC['Utsusemi: Ichi']

    -- Weaponskill sets
    sets.precast.WS = {ammo="Knobkierrie",
        head="Meghanada Visor +2",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet="Meg. Jam. +2",
        neck="Asperity Necklace",
        waist="Kentarch Belt +1",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- multi Attack
    sets.precast.WS['Resolution'] = {ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'Accuracy+14 Attack+14','"Triple Atk."+2','DEX+7','Attack+12',}},
        body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
        hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
        legs="Meg. Chausses +2",
        feet="Meg. Jam. +2",
        neck="Fotia Gorget",
        waist="Soil Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Sherida Earring",
        left_ring="Warp Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},}

    sets.precast.WS['Dimidiation'] = {ammo="Knobkierrie",
        head="Meghanada Visor +2",
        body="Meg. Cuirie +2",
        hands="Meg. Gloves +2",
        legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
        feet="Meg. Jam. +2",
        neck="Caro Necklace",
        waist="Chaac Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Herculean Slash'] = {ammo="Pemphredo Tathlum",
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','STR+10','Mag. Acc.+11',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon skill damage +1%','Mag. Acc.+8',}},
        legs={ name="Herculean Trousers", augments={'Weapon skill damage +2%','AGI+5','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Store TP"+1',}},
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Acumen Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.precast.WS['Shockwave'] = {ammo="Pemphredo Tathlum",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Gwati Earring",
        right_ear="Digni. Earring",
        left_ring="Etana Ring",
        right_ring="Weather. Ring",
        back={ name="Ogma's cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.precast.WS['Requiescat'] = sets.precast.WS

    sets.precast.WS['Savage Blade'] = sets.precast.WS

	-- Midcast sets

    sets.midcast['Foil'] = {ammo="Sapience Orb",
        head="Erilaz Galea +1",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
        feet="Erilaz Greaves +1",
        neck="Unmoving Collar +1",
        waist="Flume Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.midcast['Flash'] = {ammo="Sapience Orb",
        head="Halitus Helm",
        body="Emet Harness +1",
        hands="Kurys Gloves",
        legs="Eri. Leg Guards +1",
        feet="Ahosi Leggings",
        neck="Unmoving Collar +1",
        waist="Sulla Belt",
        left_ear="Cryptic Earring",
        right_ear="Friomisi Earring",
        left_ring="Petrov Ring",
        right_ring="Supershear Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.midcast['Jettatura'] = sets.midcast['Flash']
    sets.midcast['Geist Wall'] = sets.midcast['Flash']
    sets.midcast['Sheep Song'] = sets.midcast['Flash']
    sets.midcast['Blank Gaze'] = sets.midcast['Flash']

    sets.midcast['Enhancing Magic'] = {ammo="Staunch Tathlum",
        head="Erilaz Galea +1",
        body="Ashera Harness",
        hands="Runeist's Mitons +2",
        legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
        feet="Erilaz Greaves +1",
        neck="Incanter's Torque",
        waist="Rumination Sash",
        left_ear="Loquac. Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.midcast['Aquaveil'] = {ammo="Staunch Tathlum",
        head="Erilaz Galea +1",
        body="Ashera Harness",
        hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}},
        neck="Moonbeam Necklace",
        waist="Rumination Sash",
        left_ear="Halasz Earring",
        right_ear="Magnetic Earring",
        left_ring="Defending Ring",
        right_ring="Evanescence Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.midcast['Phalanx'] = {ammo="Staunch Tathlum",
        head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
        body={ name="Herculean Vest", augments={'Crit.hit rate+1','"Fast Cast"+3','Phalanx +5','Accuracy+18 Attack+18','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
        hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
        legs={ name="Taeon Tights", augments={'Spell interruption rate down -9%','Phalanx +3',}},
        feet={ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}},
        neck="Incanter's Torque",
        waist="Rumination Sash",
        left_ear="Loquac. Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.midcast['Regen'] = {ammo="Staunch Tathlum",
        head="Rune. Bandeau +2",
        body="Ashera Harness",
        hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
        legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Moonbeam Necklace",
        waist="Flume Belt",
        left_ear="Genmei Earring",
        right_ear="Magnetic Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.midcast['Stoneskin'] = {ammo="Staunch Tathlum",
        head="Erilaz Galea +1",
        body="Ashera Harness",
        hands="Runeist's Mitons +2",
        legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
        feet={ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}},
        neck="Incanter's Torque",
        waist="Rumination Sash",
        left_ear="Earthcry Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},}

    sets.midcast["Refresh"] = {ammo="Staunch Tathlum",
        head="Erilaz Galea +1",
        body="Ashera Harness",
        hands="Runeist's Mitons +2",
        legs={ name="Futhark Trousers +1", augments={'Enhances "Inspire" effect',}},
        feet={ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}},
        neck="Moonbeam Necklace",
        waist="Flume Belt",
        left_ear="Genmei Earring",
        right_ear="Magnetic Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}},} 

    sets.midcast.Cure = {}



    --------------------------------------
    -- Engaged sets
    --------------------------------------
    sets.engaged = {ammo="Staunch Tathlum",
        head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
        body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
        hands="Turms Mittens",
        legs="Eri. Leg Guards +1",
        feet="Turms Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        left_ear="Genmei Earring",
        right_ear="Sherida Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}
    
    sets.engaged.DD = {ammo="Yamarang",
        head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
        body="Ayanmo Corazza +2",
        hands={ name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Lissome Necklace",
        waist="Kentarch Belt +1",
        left_ear="Cessance Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Acc = {ammo="Yamarang",
    	head="Meghanada Visor +2",
    	body="Ayanmo Corazza +2",
    	hands="Meg. Gloves +2",
    	legs="Meg. Chausses +2",
    	feet="Runeist's Boots +2",
    	neck="Lissome Necklace",
    	waist="Kentarch Belt",
    	left_ear="Digni. Earring",
    	right_ear="Cessance Earring",
    	left_ring="Regal Ring",
    	right_ring="Moonbeam Ring",
    	back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    

    sets.engaged.Acc.PDT = sets.engaged.PDT

	-- Idle/resting/defense/etc sets

    sets.idle = {ammo="Homiliary",
        head="Rawhide Mask",
        body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
        hands={ name="Herculean Gloves", augments={'STR+5','DEX+10','"Refresh"+1','Accuracy+13 Attack+13',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Erilaz Greaves +1",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

    sets.idle.PDT = {ammo="Staunch Tathlum",
        head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
        body={ name="Futhark Coat +3", augments={'Enhances "Elemental Sforzo" effect',}},
        hands="Kurys Gloves",
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Erilaz Greaves +1",
        neck="Loricate Torque +1",
        waist="Flume Belt",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},}

	sets.Kiting = {}




end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end


-- -- function job_aftercast(spell)
-- --     if not spell.interrupted then
-- --         if spell.type == 'Rune' then
-- --             update_timers(spell)
-- --         elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
-- --             reset_timers()
-- --         elseif spell.name == "Swipe" then
-- --             send_command(trim(1))
-- --         end
-- --     end
-- end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
-- function update_timers(spell)
--     local expires_time = os.time() + 300
--     local entry_index = rune_count(spell.name) + 1

--     local entry = {rune=spell.name, index=entry_index, expires=expires_time}

--     rune_timers:append(entry)
--     local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
--     cmd_queue = cmd_queue .. trim()

--     -- add_to_chat(123,'cmd_queue='..cmd_queue)

--     send_command(cmd_queue)
-- end

-- -- Get the command string to create a custom timer for the provided entry.
-- function create_timer(entry)
--     local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
--     local duration = entry.expires - os.time()
--     return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
-- end

-- -- Get the command string to delete a custom timer for the provided entry.
-- function delete_timer(entry)
--     local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
--     return 'timers d ' .. timer_name .. ''
-- end

-- -- Reset all timers
-- function reset_timers()
--     local cmd_queue = ''
--     for index,entry in pairs(rune_timers) do
--         cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
--     end
--     rune_timers:clear()
--     send_command(cmd_queue)
-- end

-- -- Get a count of the number of runes of a given type
-- function rune_count(rune)
--     local count = 0
--     local current_time = os.time()
--     for _,entry in pairs(rune_timers) do
--         if entry.rune == rune and entry.expires > current_time then
--             count = count + 1
--         end
--     end
--     return count
-- end

-- -- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- -- If given a value n, remove n runes from the table.
-- function trim(n)
--     local cmd_queue = ''

--     local to_remove = n or (rune_timers:length() - max_runes)

--     while to_remove > 0 and rune_timers:length() > 0 do
--         local oldest
--         for index,entry in pairs(rune_timers) do
--             if oldest == nil or entry.expires < rune_timers[oldest].expires then
--                 oldest = index
--             end
--         end
        
--         cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
--         to_remove = to_remove - 1
--     end
    
--     return cmd_queue
-- end

-- -- Drop the index of all runes of a given type.
-- -- If the index drops to 0, it is removed from the table.
-- function prune(rune)
--     local cmd_queue = ''
    
--     for index,entry in pairs(rune_timers) do
--         if entry.rune == rune then
--             cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
--             entry.index = entry.index - 1
--         end
--     end

--     for index,entry in pairs(rune_timers) do
--         if entry.rune == rune then
--             if entry.index == 0 then
--                 rune_timers[index] = nil
--             else
--                 cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
--             end
--         end
--     end
    
--     return cmd_queue
-- end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

-- windower.raw_register_event('zone change',reset_timers)
-- windower.raw_register_event('logout',reset_timers)
-- windower.raw_register_event('status change',function(new, old)
--     if gearswap.res.statuses[new].english == 'Dead' then
--         reset_timers()
--     end
-- end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 4)
end
