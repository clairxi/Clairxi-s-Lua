-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-- Original LUA by Fenrir.Motenten; edited by Bismarck.Speedyjim
-------------------------------------------------------------------------------------------------------------------
 
--[[
        Custom commands:64
 
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
        In-game macro: /console gs c scholar xxx
 
                                        Light Arts              Dark Arts
 
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]
 
 
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()

end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Burst')
    state.IdleMode:options('Normal', 'PDT')
 
    state.MagicBurst = M(false, 'Magic Burst')
     
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder", 
                       "Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",}
    info.mid_nukes = S{"Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",}
    info.high_nukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
                       "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    select_default_macro_book()
    define_nuke_downgrades()
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
    -- Start defining the sets
    --------------------------------------
 
    -- Precast Sets
    -- Precast sets to enhance JAs
 
    sets.precast.JA['Tabula Rasa'] = {legs={ name="Peda. Pants +2", augments={'Enhances "Tabula Rasa" effect',}},}
    sets.precast.JA['Dark Arts'] = {body="Academic's Gown +3"}
    sets.precast.JA['Light Arts'] = {legs="Academic's Pants +3"}
    sets.precast.JA['Enlightenment'] = {body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},}
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1",}
    sets.buff['Focalization'] = {head={ name="Peda. M.Board +1", augments={'Enh. "Altruism" and "Focalization"',}},}
    -- sets.buff['Altruism'] = sets.buff['Focalization']
    -- sets.buff['Tranquility'] = {hands={ name="Peda. Bracers", augments={'Enh. "Tranquility" and "Equanimity"',}},}
    -- sets.buff['Equanimity'] = sets.buff['Tranquility']
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet={ name="Peda. Loafers +2", augments={'Enhances "Stormsurge" effect',}},}
    sets.buff['Alacrity'] = {feet={ name="Peda. Loafers +2", augments={'Enhances "Stormsurge" effect',}},}
    sets.buff['Stormsurge'] = {feet={ name="Peda. Loafers +2", augments={'Enhances "Stormsurge" effect',}},}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1",}
 
    sets.buff.FullSublimation = {head="Acad. Mortar. +3",
        body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
        waist="Embla Sash",
        left_ear="Savant's Earring",}
    sets.buff.PDTSublimation = sets.buff.FullSublimation

     
 
    -- Fast cast sets for spells
    -- FC +65%, Quick Magic +10% (cap), Grimoire - 15% 
    sets.precast.FC = {ammo="Impatiens",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+19','"Fast Cast"+5','INT+9',}},
    	body="Zendik Robe",
    	hands="Acad. Bracers +3",
    	legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    	feet="Acad. Loafers +3",
    	neck="Baetyl Pendant",
    	waist="Witful Belt",
    	left_ear="Loquac. Earring",
    	right_ear="Malignance Earring",
    	left_ring="Kishar Ring",
    	right_ring="Lebeche Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
 

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
     
    -- MP Gear needed for stronger Myrkr
    sets.precast.WS['Myrkr'] = {ammo="Hydrocera",
    	head="Pixie Hairpin +1",
    	body="Acad. Gown +3",
    	hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
    	legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    	feet="Arbatel Loafers +1",
    	neck="Sanctity Necklace",
    	waist="Luminary Sash",
    	left_ear="Gifted Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Mephitas's Ring",
    	right_ring="Bifrost Ring",
    	back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Enmity-10',}},}
 
    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
 
    -- Cure Sets
     
    -- Potency: +51%, Healing Skill: 610 total inc. Light Arts bonus, Enmity: -20, MND: +168, VIT: +87
    sets.midcast['Cure'] = {main="Daybreak",
    	sub="Sors Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    	body="Zendik Robe",
    	hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
    	legs="Acad. Pants +3",
    	feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
    	neck="Deviant Necklace",
    	waist="Austerity Belt",
    	left_ear="Calamitous Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Lebeche Ring",
    	back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Enmity-10',}},}

    sets.midcast['Cure II'] = sets.midcast['Cure']
    sets.midcast['Cure III'] = sets.midcast['Cure']
    sets.midcast['Cure IV'] = sets.midcast['Cure']
     
    -- Potency: +50%, Healing Skill: 562 total inc. Light Arts Bonus, MND: +160, VIT+ 89
    sets.midcast.CureWithLightWeather = {main="Chatoyant Staff",
    	sub="Pax Grip",
    	ammo="Pemphredo Tathlum",
    	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
    	legs="Acad. Pants +3",
    	feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
    	neck="Deviant Necklace",
    	waist="Hachirin-no-Obi",
    	left_ear="Mendi. Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Lebeche Ring",
    	back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Enmity-10',}},}
 
    sets.midcast.Curaga = sets.midcast['Cure'] -- idk why I keep this here... I guess if random /whm?!?! 
 
    -- Enhancing Magic Sets

    -- Equip Arbatel Bracers +1 when Perpetuance is active **confirm this is working**
    sets.midcast['Regen'] = {main="Bolelabunga",
    	sub="Ammurapi Shield",
    	ammo="Pemphredo Tathlum",
    	head="Arbatel Bonnet +1",
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
    	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    	feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    	neck="Reti Pendant",
    	waist="Austerity Belt",
    	left_ear="Gifted Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

    sets.midcast['Regen II'] = sets.midcast['Regen']
    sets.midcast['Regen III'] = sets.midcast['Regen']
    sets.midcast['Regen IV'] = sets.midcast['Regen']
    sets.midcast['Regen V'] = sets.midcast['Regen']
 
    sets.midcast['Enhancing Magic'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
    	sub="Ammurapi Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
    	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    	feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    	neck="Reti Pendant",
    	waist="Austerity Belt",
    	left_ear="Calamitous Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Stikini Ring",
    	back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Enmity-10','Damage taken-5%',}},}

    sets.midcast['Stoneskin'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
    	sub="Ammurapi Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
    	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}, --stop being a noob and get the omega legs!!!
    	feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    	neck="Reti Pendant",
    	waist="Siegel Sash",
    	left_ear="Earthcry Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Stikini Ring",
    	back="Solemnity Cape",}

    sets.midcast['Aquaveil'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
    	sub="Ammurapi Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Chironic Hat", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','MND+9','Mag. Acc.+9',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
	    hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
    	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    	feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    	neck="Reti Pendant",
    	waist="Austerity Belt",
    	left_ear="Calamitous Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Stikini Ring",
    	back="Solemnity Cape",}

    sets.midcast['Embrava'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
    	sub="Ammurapi Shield",
    	ammo="Pemphredo Tathlum",
    	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
    	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    	feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
    	neck="Reti Pendant",
    	waist="Austerity Belt",
    	left_ear="Calamitous Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Stikini Ring",
    	back="Solemnity Cape",}

    sets.midcast['Haste'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +3','STR+14','Mag. Acc.+20','"Mag.Atk.Bns."+11','DMG:+5',}},
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
        neck="Reti Pendant",
    	waist="Austerity Belt",
    	left_ear="Calamitous Earring",
    	right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Solemnity Cape",}

    -- sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring"})
    -- sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring1="Sheltered Ring"})+ 
 
    sets.midcast['Cursna'] = {main={ name="Gada", augments={'"Cure" spellcasting time -2%','MND+8','Mag. Acc.+21','"Mag.Atk.Bns."+24',}},
    	sub="Chanter's Shield",
    	ammo="Incantor Stone",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+19','"Fast Cast"+5','INT+9',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
    	legs="Acad. Pants +3",
    	feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    	neck="Malison Medallion",
    	waist="Witful Belt",
    	left_ear="Meili Earring",
    	right_ear="Malignance Earring",
    	left_ring="Menelaus's Ring",
    	right_ring="Haoma's Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}

    sets.midcast.Erase = sets.midcast.FastRecast
    
    sets.midcast.Klimaform = sets.midcast.FastRecast
 
    -- Custom spell classes

    gear.default.obi_waist = "Sacro Cord"

    sets.midcast['Enfeebling Magic'] = {main={ name="Grioavolr", augments={'Mag. crit. hit dmg. +3%','Mag. Acc.+24','"Mag.Atk.Bns."+30','Magic Damage +2',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head="Acad. Mortar. +3",
    	body="Acad. Gown +3",
    	hands="Acad. Bracers +3",
    	legs={ name="Chironic Hose", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','"Conserve MP"+1','CHR+4','Mag. Acc.+15','"Mag.Atk.Bns."+8',}},
    	feet="Acad. Loafers +3",
    	neck="Argute Stole +1",
    	waist="Luminary Sash",
    	left_ear="Malignance Earring",
    	right_ear="Regal Earring",
    	left_ring="Kishar Ring",
    	right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Kaustra'] = {main={ name="Grioavolr", augments={'Mag. crit. hit dmg. +3%','Mag. Acc.+24','"Mag.Atk.Bns."+30','Magic Damage +2',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head="Pixie Hairpin +1",
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands="Jhakri Cuffs +2",
    	legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
    	feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
    	neck="Erra Pendant",
    	waist=gear.ElementalObi,
    	left_ear="Malignance Earring",
    	right_ear="Regal Earring",
    	left_ring="Archon Ring",
    	right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}
 
    sets.midcast['Drain'] = {main={ name="Grioavolr", augments={'Mag. crit. hit dmg. +3%','Mag. Acc.+24','"Mag.Atk.Bns."+30','Magic Damage +2',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head="Acad. Mortar. +3",
    	body="Acad. Gown +3",
    	hands="Acad. Bracers +3",
    	legs={ name="Peda. Pants +3", augments={'Enhances "Tabula Rasa" effect',}},
    	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+4','MND+3','Mag. Acc.+15','"Mag.Atk.Bns."+4',}},
    	neck="Erra Pendant",
    	waist="Fucho-no-Obi",
    	left_ear="Malignance Earring",
    	right_ear="Regal Earring",
    	left_ring="Kishar Ring",
    	right_ring="Evanescence Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}
	sets.midcast['Drain II'] = sets.midcast['Drain']
 
    sets.midcast['Aspir'] = sets.midcast['Drain']
    sets.midcast['Aspir II'] = sets.midcast['Drain'] 
 
    sets.midcast['Stun'] = {main="Oranyan",
    	sub="Clerisy Strap +1",
    	ammo="Pemphredo Tathlum",
    	head="Acad. Mortar. +3",
    	body="Acad. Gown +3",
    	hands="Acad. Bracers +3",
    	legs="Acad. Pants +3",
    	feet="Acad. Loafers +3",
    	neck="Baetyl Pendant",
    	waist="Luminary Sash",
    	left_ear="Digni. Earring",
    	right_ear="Regal Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},}
 
 
    -- Elemental Magic sets are default for handling all-tier nukes.
    -- 40% Magic Burst I, and Unknown for Magic Burst II

    sets.midcast['Elemental Magic'] = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
        body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
        hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
        legs={ name="Peda. Pants +2", augments={'Enhances "Tabula Rasa" effect',}},
        feet={ name="Peda. Loafers +2", augments={'Enhances "Stormsurge" effect',}},
        neck="Sanctity Necklace",
        waist=gear.ElementalObi,
        left_ear="Regal Earring",
        right_ear="Barkaro. Earring",
        left_ring="Jhakri Ring",
        right_ring="Freke Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].MB = {ammo="Memoria Sachet",
        head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+21','Magic burst dmg.+6%','INT+8',}},
        body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+4%','AGI+1','Mag. Acc.+15',}},
        hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+26','Magic burst dmg.+10%','CHR+14',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+6%','Mag. Acc.+15','"Mag.Atk.Bns."+2',}},
        neck="Mizu. Kubikazari",
        waist=gear.ElementalObi,
        left_ear="Barkaro. Earring",
        right_ear="Regal Earring",
        left_ring="Jhakri Ring",
        right_ring="Mujin Band",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].LowTierNuke = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head="Mall. Chapeau +2",
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands="Jhakri Cuffs +2",
    	legs="Jhakri Slops +2",
    	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+4','MND+3','Mag. Acc.+15','"Mag.Atk.Bns."+4',}},
    	neck="Erra Pendant",
    	waist=gear.ElementalObi,
    	left_ear="Friomisi Earring",
    	right_ear="Hecate's Earring",
    	left_ring="Jhakri Ring",
    	right_ring="Adoulin Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].LowTierNuke.MB = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
    	body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+24','Magic burst dmg.+8%','MND+14','Mag. Acc.+11',}},
    	hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    	legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','Magic burst dmg.+7%','CHR+8','"Mag.Atk.Bns."+11',}},
    	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+4','MND+3','Mag. Acc.+15','"Mag.Atk.Bns."+4',}},
    	neck="Mizu. Kubikazari",
    	waist=gear.ElementalObi,
    	left_ear="Friomisi Earring",
    	right_ear="Hecate's Earring",
    	left_ring="Locus Ring",
    	right_ring="Mujin Band",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].MidTierNuke = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands="Jhakri Cuffs +2",
    	legs="Jhakri Slops +2",
    	feet="Jhakri Pigaches +2",
    	neck="Baetyl Pendant",
    	waist=gear.ElementalObi,
    	left_ear="Friomisi Earring",
    	right_ear="Hecate's Earring",
    	left_ring="Jhakri Ring",
    	right_ring="Adoulin Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].MidTierNuke.MB = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
    	body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+24','Magic burst dmg.+8%','MND+14','Mag. Acc.+11',}},
    	hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    	legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','Magic burst dmg.+7%','CHR+8','"Mag.Atk.Bns."+11',}},
    	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+4','MND+3','Mag. Acc.+15','"Mag.Atk.Bns."+4',}},
    	neck="Mizu. Kubikazari",
    	waist=gear.ElementalObi,
    	left_ear="Friomisi Earring",
    	right_ear="Hecate's Earring",
    	left_ring="Locus Ring",
    	right_ring="Mujin Band",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].HighTierNuke = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
    	body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    	hands="Jhakri Cuffs +2",
    	legs="Jhakri Slops +2",
    	feet="Jhakri Pigaches +2",
    	neck="Baetyl Pendant",
    	waist=gear.ElementalObi,
    	left_ear="Friomisi Earring",
    	right_ear="Hecate's Earring",
    	left_ring="Jhakri Ring",
    	right_ring="Adoulin Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].HighTierNuke.MB = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
    	body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+24','Magic burst dmg.+8%','MND+14','Mag. Acc.+11',}},
    	hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    	legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','Magic burst dmg.+7%','CHR+8','"Mag.Atk.Bns."+11',}},
    	feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+4','MND+3','Mag. Acc.+15','"Mag.Atk.Bns."+4',}},
    	neck="Mizu. Kubikazari",
    	waist=gear.ElementalObi,
    	left_ear="Friomisi Earring",
    	right_ear="Hecate's Earring",
    	left_ring="Locus Ring",
    	right_ring="Mujin Band",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}
     
    sets.midcast['Geohelix'] = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head="Volte Beret",
    	body="Jhakri Robe +2",
    	hands="Jhakri Cuffs +2",
    	legs="Jhakri Slops +2",
    	feet="Jhakri Pigaches +2",
    	neck="Sanctity Necklace",
    	waist="Eschan Stone",
    	left_ear="Barkaro. Earring",
    	right_ear="Regal Earring",
    	left_ring="Jhakri Ring",
    	right_ring="Adoulin Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Geohelix II'] = sets.midcast['Geohelix']    
    sets.midcast['Hydrohelix'] = sets.midcast['Geohelix']
    sets.midcast['Hydrohelix II'] = sets.midcast['Geohelix']
    sets.midcast['Anemohelix'] = sets.midcast['Geohelix']
    sets.midcast['Anemohelix II'] = sets.midcast['Geohelix']
    sets.midcast['Pyrohelix'] = sets.midcast['Geohelix']
    sets.midcast['Pyrohelix II'] = sets.midcast['Geohelix']
    sets.midcast['Cryohelix'] = sets.midcast['Geohelix']
    sets.midcast['Cryohelix II'] = sets.midcast['Geohelix']
    sets.midcast['Ionohelix'] = sets.midcast['Geohelix']
    sets.midcast['Ionohelix II'] = sets.midcast['Geohelix']
    sets.midcast['Luminohelix'] = sets.midcast['Geohelix']
    sets.midcast['Luminohelix II'] = sets.midcast['Geohelix']

    sets.midcast['Noctohelix'] = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
    	ammo="Pemphredo Tathlum",
    	head="Pixie Hairpin +1",
    	body="Jhakri Robe +2",
    	hands="Jhakri Cuffs +2",
    	legs="Jhakri Slops +2",
    	feet="Jhakri Pigaches +2",
    	neck="Sanctity Necklace",
    	waist="Eschan Stone",
    	left_ear="Barkaro. Earring",
    	right_ear="Regal Earring",
    	left_ring="Jhakri Ring",
    	right_ring="Archon Ring",
    	back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Noctohelix II'] = sets.midcast['Noctohelix']

    -- sets.midcast.Helix.Burst = sets.midcast['Elemental Magic'].BurstAcc
 
    sets.midcast.Impact = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        body="Twilight Cloak",
        hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+2','Mag. Acc.+14',}},
        feet="Acad. Loafers +3",
        neck="Mizu. Kubikazari",
        waist=gear.ElementalObi,
        left_ear="Barkaro. Earring",
        right_ear="Regal Earring",
        left_ring="Adoulin Ring",
        right_ring="Locus Ring",
        back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

 
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
 
    sets.idle = {main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    	sub="Enki Strap",
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
    	back={ name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','Enmity-10','Damage taken-5%',}},}  
         

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {}
 
 
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
   
     
    -- sets.magic_burst = {}
    -- Cap: 40%, Cap-breaking: 23% (Gifts: 13%, Mujin: 5%, Amalric Gages: 5%)
    -- Akademos: 10%, Mizukage: 10%, Merlinic Body: 10%, Merlinic Legs: 8% = 38%
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function refine_various_spells(spell, action, spellMap, eventArgs)
    aspirs = S{'Aspir','Aspir II'}
    sleeps = S{'Sleep','Sleep II'}
    sleepgas = S{'Sleepga'}
    
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
            elseif spell.english == 'Aspir II' then
                newSpell = 'Aspir'
            end         
        elseif sleeps:contains(spell.english) then
            if spell.english == 'Sleep' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            elseif spell.english == 'Sleep II' then
                newSpell = 'Sleep'
            end
        elseif sleepgas:contains(spell.english) then
            if spell.english == 'Sleepga' then
                add_to_chat(122,cancelling)
                eventArgs.cancel = true
                return
            end
        end
    end
     
    if newSpell ~= spell.english then
        send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
        eventArgs.cancel = true
        return
    end
end
 
function job_precast(spell, action, spellMap, eventArgs)   
    if spell.type == 'WhiteMagic' and state.Buff['Light Arts'] then
        equip(sets.LightArts.FC)
    elseif spell.type == 'BlackMagic' and state.Buff['Dark Arts'] then
        equip(sets.DarkArts.FC)
	end
    refine_nukes(spell, action, spellMap, eventArgs)
    refine_various_spells(spell, action, spellMap, eventArgs)
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
     
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
        equip(sets.magic_burst)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.element == world.day_element or spell.element == world.weather_element then
        equip ({waist="Hachirin-no-Obi"})
    end
end
 
function job_aftercast(spell)
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
        send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
        send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Break' or spell.english == 'Breakga' then
        send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    end
end 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
    if (buff == 'Dark Arts' and gain or buffactive['Dark Arts']) then
        disable('main','sub')
	elseif (buff == 'Light Arts' and gain or buffactive['Light Arts']) then
        enable('main','sub')

    end
end
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
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
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' or  buffactive['Aurorastorm II'] then
                return "CureWithLightWeather"
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
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
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end
 
    update_active_strategems()
    update_sublimation()
end
 
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false
 
    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end
 
function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end
 
-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' then --or spellMap ~= 'ElementalEnfeeble'
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.skill == "Elemental Magic" and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end
 
    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end
 
 
function display_current_caster_state()
    local msg = ''
 
    if state.OffenseMode.value ~= 'None' then
        msg = msg .. 'Melee'
 
        if state.CombatForm.has_value then
            msg = msg .. ' (' .. state.CombatForm.value .. ')'
        end
         
        msg = msg .. ', '
    end
 
    msg = msg .. 'Idle ['..state.IdleMode.value..'], Casting ['..state.CastingMode.value..']'
 
    add_to_chat(122, msg)
    local currentStrats = get_current_strategem_count()
    local arts
    if buffactive['Light Arts'] or buffactive['Addendum: White'] then
        arts = 'Light Arts'
    elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
        arts = 'Dark Arts'
    else
        arts = 'No Arts Activated'
    end
    add_to_chat(122, 'Current Available Strategems: ['..currentStrats..'], '..arts..'')
end
 
-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use
    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
 
    local currentStrats = get_current_strategem_count()
    local newStratCount = currentStrats - 1
    local strategem = cmdParams[2]:lower()
     
    if currentStrats > 0 and strategem ~= 'light' and strategem ~= 'dark' then
        add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
    elseif currentStrats == 0 then
        add_to_chat(122, '***Out of strategems! Canceling...***')
        return
    end
 
    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
            add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        elseif buffactive['dark arts']  or buffactive['addendum: black'] then
            send_command('input /ja "Light Arts" <me>')
            add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
            add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        elseif buffactive['light arts'] or buffactive['addendum: white'] then
            send_command('input /ja "Dark Arts" <me>')
            add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('@input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('@input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('@input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('@input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('@input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('@input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('@input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('@input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('@input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('@input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('@input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('@input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('@input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('@input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('@input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('@input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end
 
function get_current_strategem_count()
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]
 
    local maxStrategems = math.floor(player.main_job_level + 10) / 20
 
    local fullRechargeTime = 5*33
 
    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
     
    return currentCharges
end

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
                                                        ['Thundara'] = 123, ['Thundara II'] = 253, ['Thundara III'] = 476,
                                                    	['Geohelix'] = 26, ['Geohelix II'] = 78, ['Hydrohelix'] = 26, ['Hydrohelix II'] = 78, ['Anemohelix'] = 26, ['Anemohelix II'] = 78,
                                                    	['Pyrohelix'] = 26, ['Pyrohelix II'] = 78, ['Cryohelix'] = 26, ['Cryohelix II'] = 78, ['Ionohelix'] = 26, ['Ionohelix II'] = 78,
                                                    	['Noctohelix'] = 26, ['Noctohelix II'] = 78, ['Luminohelix'] = 26, ['Luminohelix II'] = 78,}
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
    set_macro_page(1, 7)
    
end