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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Accuracy')
    state.CastingMode:options('Normal', 'MB')
    state.IdleMode:options('Normal', 'Death')

info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder", "Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II", "Stonega", "Waterga", "Aeroga", "Firaga", "Blizzaga", "Thundaga"}

info.mid_nukes = S{"Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III", "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV", "Stonega II", "Waterga II", "Aeroga II", "Firaga II", "Blizzaga II", "Thundaga II", 
                   "Quake", "Quake II", "Floood", "Flood II", "Tornado", "Tornado II", "Flare", "Flare II", "Freeze", "Freeze II", "Burst", "Burst II"}

info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V", "Stonega III", "Waterga III", "Aeroga III", "Firaga III", "Blizzaga III", "Stone VI", "Water VI", "Aero VI", "Fire VI", "Blizzard VI", "Thunder VI",
                    "Thundaga III", "Stoneja", "Waterja", "Aeroja", "Firaja", "Blizzaja", "Thundaja"}

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
        no_down         =       S{      'Quake',                'Flood',                'Tornado',              'Flare',                'Freeze',               'Burst',
                                        'Quake II',             'Flood II',             'Tornado II',           'Flare II',             'Freeze II',            'Burst II',
                                        'Stonega',              'Waterga',              'Aeroga',               'Firaga',               'Blizzaga',             'Thundaga',
                                        'Stonega II',           'Waterga II',           'Aeroga II',            'Firaga II',            'Blizzaga II',          'Thundaga II',
                                        'Stonega III',          'Waterga III',          'Aeroga III',           'Firaga III',           'Blizzaga III',         'Thundaga III',
                                        'Stoneja',              'Waterja',              'Aeroja',               'Firaja',               'Blizzaja',             'Thundaja',
                                        'Rasp',                 'Drown',                'Choke',                'Burn',                 'Frost',                'Shock',
                                        'Geohelix',             'Hydrohelix',           'Anemohelix',           'Pyrohelix',            'Cryohelix',            'Ionohelix',
                                        'Luminohelix',          'Noctohelix',            'Comet',                'Meteor',               'Impact'}
        aras            =       S{      'Stonera',              'Watera',               'Aera',                 'Fira',                 'Blizzara',             'Thundara',
                                        'Stonera II',           'Watera II',            'Aera II',              'Fira II',              'Blizzara II',          'Thundara II',
                                        'Stonera III',          'Watera III',           'Aera III',             'Fira III',             'Blizzara III',         'Thundara III'}
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Sapience Orb",
    	head="Amalric Coif",
    	body="Zendik Robe",
	    hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
    	legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    	feet="Regal Pumps +1",
    	neck="Baetyl Pendant",
    	waist="Witful Belt",
    	left_ear="Loquac. Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back={ name="Taranus's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = {ammo="Sapience Orb",
    	head="Amalric Coif",
    	body="Nefer Kalasiris",
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
    	legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    	feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    	neck="Baetyl Pendant",
    	waist="Witful Belt",
    	left_ear="Loquac. Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back={ name="Bane Cape", augments={'Elem. magic skill +4','Dark magic skill +5','"Mag.Atk.Bns."+4','"Fast Cast"+4',}},}

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC['Elemental Magic'] = {ammo="Sapience Orb",
    	head="Amalric Coif",
    	body="Zendik Robe",
    	hands="Mallquis Cuffs +1",
    	legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    	feet="Mallquis Clogs +2",
    	neck="Baetyl Pendant",
    	waist="Witful Belt",
    	right_ear="Loquac. Earring",
    	left_ear="Barkaro. Earring",
    	left_ring="Kishar Ring",
    	right_ring="Prolix Ring",
    	back={ name="Bane Cape", augments={'Elem. magic skill +4','Dark magic skill +5','"Mag.Atk.Bns."+4','"Fast Cast"+4',}},}

    ---- Midcast Sets ----
    gear.default.obi_waist = "Refoccilation stone"

    sets.midcast.FastRecast = {}

    sets.midcast.conserve = {}

    sets.midcast.Cure = {ammo="Plumose Sachet",
    	head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    	body="Nefer Kalasiris",
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
    	legs="Gyve Trousers",
    	feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    	neck="Incanter's Torque",
    	waist="Pythia Sash +1",
    	left_ear="Loquac. Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Kishar Ring",
    	right_ring="Kuchekula Ring",
    	back="Solemnity Cape",}

    sets.midcast.Curaga = sets.midcast.Cure
    
    sets.midcast.Haste = sets.midcast.FastRecast

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear1="Earthcry Earring",waist="Siegel Sash",legs="Shedir seraweels"})

    sets.midcast['Enhancing Magic'] = {ammo="Staunch Tathlum",
    	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
    	body={ name="Telchine Chas.", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
    	legs={ name="Lengo Pants", augments={'INT+2','Mag. Acc.+5',}},
    	feet="Regal Pumps +1",
    	neck="Incanter's Torque",
    	waist="Pythia Sash +1",
    	left_ear="Andoaa Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Kuchekula Ring",
    	back="Fi Follet Cape +1",}

    sets.midcast.Regen = {ammo="Staunch Tathlum",
    	head="Amalric Coif",
    	body={ name="Telchine Chas.", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
    	legs={ name="Lengo Pants", augments={'INT+2','Mag. Acc.+5',}},
    	feet="Regal Pumps +1",
    	neck="Incanter's Torque",
    	waist="Pythia Sash +1",
    	left_ear="Andoaa Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Kuchekula Ring",
    	back="Fi Follet Cape +1",}

    sets.midcast.Aquaveil = {ammo="Staunch Tathlum",
    	head="Amalric Coif",
    	body={ name="Telchine Chas.", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}},
    	hands={ name="Telchine Gloves", augments={'"Fast Cast"+4','Enh. Mag. eff. dur. +7',}},
    	legs={ name="Lengo Pants", augments={'INT+2','Mag. Acc.+5',}},
    	feet="Regal Pumps +1",
    	neck="Incanter's Torque",
    	waist="Pythia Sash +1",
    	left_ear="Andoaa Earring",
    	right_ear="Magnetic Earring",
    	left_ring="Stikini Ring",
    	right_ring="Kuchekula Ring",
    	back="Fi Follet Cape +1",}

    -- sets.midcast.Protect = {ear2="Brachyura Earring", ring1="Sheltered Ring"}

    -- sets.midcast.Shell = {ear2="Brachyura Earring", ring1="Sheltered Ring"}

    sets.midcast['Enfeebling Magic'] = {ammo="Hydrocera",
    	head="Mallquis Chapeau +1",
    	body="Jhakri Robe +2",
    	hands="Mallquis Cuffs +1",
    	legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
    	feet="Mallquis Clogs +2",
    	neck="Erra Pendant",
    	waist="Rumination Sash",
    	right_ear="Barkaro. Earring",
    	left_ear="Gwati Earring",
    	left_ring="Kishar Ring",
    	right_ring="Sangoma Ring",
    	back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {ammo="Hydrocera",
	    head="Mallquis Chapeau +1",
    	body="Jhakri Robe +2",
    	hands="Mallquis Cuffs +1",
    	legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
    	feet="Mallquis Clogs +2",
    	neck="Erra Pendant",
    	waist="Fucho-no-Obi",
    	left_ear="Gwati Earring",
    	right_ear="Barkaro. Earring",
    	left_ring="Kishar Ring",
    	right_ring="Evanescence Ring",
    	back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast.Stun = sets.midcast['Dark Magic']


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {ammo="Seraphic Ampulla",
        head="Mallquis Chapeau +1",
        body="Spae. Coat +1",
        hands="Jhakri Cuffs +1",
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+11','CHR+3','Mag. Acc.+2','"Mag.Atk.Bns."+5',}},
        neck="Baetyl Pendant",
        waist=gear.ElementalObi,
        left_ear="Barkaro. Earring",
        right_ear="Regal Earring",
        left_ring="Jhakri Ring",
        right_ring="Strendu Ring",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

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

    sets.midcast['Elemental Magic'].MidTierNuke = {ammo="Memoria Sachet",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Phys. dmg. taken -1%','INT+1','"Mag.Atk.Bns."+11',}},
        body="Jhakri Robe +2",
        hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Mag. crit. hit dmg. +7%','MND+7',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+6%','Mag. Acc.+15','"Mag.Atk.Bns."+2',}},
        neck="Baetyl Pendant",
        waist=gear.ElementalObi,
        left_ear="Barkaro. Earring",
        right_ear="Friomisi Earring",
        left_ring="Adoulin Ring",
        right_ring="Acumen Ring",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].MidTierNuke.MB = {ammo="Memoria Sachet",
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

    sets.midcast['Elemental Magic'].HighTierNuke = {ammo="Memoria Sachet",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Phys. dmg. taken -1%','INT+1','"Mag.Atk.Bns."+11',}},
        body="Jhakri Robe +2",
        hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Mag. crit. hit dmg. +7%','MND+7',}},
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Magic burst dmg.+6%','Mag. Acc.+15','"Mag.Atk.Bns."+2',}},
        neck="Baetyl Pendant",
        waist=gear.ElementalObi,
        left_ear="Barkaro. Earring",
        right_ear="Friomisi Earring",
        left_ring="Adoulin Ring",
        right_ring="Acumen Ring",
        back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Elemental Magic'].HighTierNuke.MB = {ammo="Memoria Sachet",
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

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    
    -- sets.resting = {}    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {ammo="Staunch Tathlum",
    	head="Befouled Crown",
    	body="Jhakri Robe +2",
    	hands={ name="Merlinic Dastanas", augments={'Attack+4','MND+9','"Refresh"+1',}},
    	legs="Assid. Pants +1",
    	feet={ name="Merlinic Crackows", augments={'Attack+16','INT+7','"Refresh"+1','Accuracy+10 Attack+10',}},
    	neck="Loricate Torque +1",
    	waist="Fucho-no-Obi",
    	left_ear="Genmei Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Defending Ring",
    	right_ring="Purity Ring",
    	back="Solemnity Cape",}

    sets.idle.Death = {}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Wicce Sabots"}

        -- Weaponskill sets
    
    sets.precast.WS['Myrkr'] = {ammo="Impatiens",
        head="Befouled Crown",
        body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
        hands={ name="Telchine Gloves", augments={'Accuracy+9','Weapon Skill Acc.+10',}},
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet="Regal Pumps +1",
        neck="Sanctity Necklace",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Mendi. Earring",
        left_ring="Acumen Ring",
        right_ring="Sangoma Ring",
        back="Fi Follet Cape",}

    -- Engaged sets

    sets.engaged = {ammo="Amar Cluster",
        head="Jhakri Coronal +1",
        body="Jhakri Robe +1",
        hands="Jhakri Cuffs +1",
        legs="Jhakri Slops +1",
        feet="Jhakri Pigaches +1",
        neck="Bathy Choker +1",
        waist="Grunfeld Rope",
        left_ear="Bladeborn Earring",
        right_ear="Steelflash Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Chirich Ring",
        back="Kayapa Cape",}

    sets.engaged.Accuracy = {}

    -- Sets for different modes

    -- sets.Standard = {}

    -- sets.TP = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            equip(sets.TP)
            disable('main','sub','range')
        elseif newValue == 'Level' then
            equip(sets.TP)
            disable('main','sub','range')
        elseif newValue == 'Accuracy' then
            equip(sets.TP)
            disable('main','sub','range')
        else
            equip(sets.Standard)
            enable('main','sub','range')
        end
    end
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
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

function job_precast(spell, action, spellMap, eventArgs)
    refine_nukes(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Refoccilation Stone"
    elseif spell.skill == 'Enfeebling Magic' then
        gear.default.obi_waist = "Luminary Sash"
    elseif spell.skill == 'Healing Magic' then
        gear.default.obi_waist = "Pythia Sash +1"
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
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
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 3)
end