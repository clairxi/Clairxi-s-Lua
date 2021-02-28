    -------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'DW', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'PDT')

    brd_daggers = S{'Carnwenhan'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

 --------------------------------------------------------------------------------------------------------------------------
 --             MAGIC PRECAST                --
 --------------------------------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {main="Oranyan",
        sub="Clerisy Strap +1",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Inyanga Jubbah +2",
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs="Aya. Cosciales +2",
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck="Baetyl Pendant",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat", waist="Siegel Sash",})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.BardSong = {range="Gjallarhorn",
        head="Fili Calot +1",
        body="Inyanga Jubbah +2",
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs="Aya. Cosciales +2",
        feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
        neck="Baetyl Pendant",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, {range="Marsyas",})

    sets.precast.Lullaby = sets.precast.FC.BardSong

    sets.precast.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield",})

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
        
    
 --------------------------------------------------------------------------------------------------------------------------
 --             JOB ABILITIES                 --
 --------------------------------------------------------------------------------------------------------------------------
    
    sets.precast.JA['Nightingale'] = {feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},}
    sets.precast.JA['Troubadour'] = {body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},}
    sets.precast.JA['Soul Voice'] = {legs={ name="Bihu Cannions +3", augments={'Enhances "Soul Voice" effect',}},}

    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {range="Gjallarhorn",
    --     head="Nahtirah Hat",
    --     body="Gendewitha Bliaut",hands="Buremte Gloves",
    --     back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
       
 --------------------------------------------------------------------------------------------------------------------------
 --             WEAPONSKILLS                 --
 --------------------------------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {range="Gjallarhorn",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body="Ashera Harness",
        hands="Aya. Manopolas +2",
        legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
        feet="Aya. Gambieras +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Ilabrat Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},}
    
    -- -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = {range="Gjallarhorn",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body="Ashera Harness",
        hands="Aya. Manopolas +2",
        legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
        feet="Aya. Gambieras +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Ilabrat Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Exenterator'] = {range="Gjallarhorn",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body="Ashera Harness",
        hands="Aya. Manopolas +2",
        legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
        feet="Aya. Gambieras +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Ilabrat Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Mordant Rime'] = {range="Gjallarhorn",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body="Ashera Harness",
        hands="Aya. Manopolas +2",
        legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
        feet="Aya. Gambieras +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Ilabrat Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},}
  
    
 --------------------------------------------------------------------------------------------------------------------------
 --             NON-BARD SPECIFIC MIDCAST MAGIC                --
 --------------------------------------------------------------------------------------------------------------------------

    sets.midcast['Cure'] = {main="Daybreak",
        sub="Ammurapi Shield",
        head="Ipoca Beret",
        body="Brioso Justau. +3",
        hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
        legs="Brioso Cannions +3",
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck="Nodens Gorget",
        waist="Luminary Sash",
        left_ear="Calamitous Earring",
        right_ear="Magnetic Earring",
        left_ring="Kuchekula Ring",
        right_ring="Stikini Ring",
        back="Thauma. Cape",}

    sets.midcast['Cure II'] = sets.midcast['Cure']
    sets.midcast['Cure III'] = sets.midcast['Cure']
    sets.midcast['Cure IV'] = sets.midcast['Cure']
        
    sets.midcast.Curaga = sets.midcast.Cure
        
    sets.midcast['Stoneskin'] = {main="Pukulatmuj +1",
        sub="Ammurapi Shield",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands="Inyan. Dastanas +2",
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck="Incanter's Torque",
        waist="Olympus Sash",
        left_ear="Andoaa Earring",
        right_ear="Earthcry Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Fi Follet Cape +1",}

    sets.midcast['Aquaveil'] = {main="Pukulatmuj +1",
        sub="Ammurapi Shield",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands="Inyan. Dastanas +2",
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
        neck="Incanter's Torque",
        waist="Olympus Sash",
        left_ear="Andoaa Earring",
        right_ear="Earthcry Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Fi Follet Cape +1",}
        
    sets.midcast['Haste'] = {main="Pukulatmuj +1",
        sub="Ammurapi Shield",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Andoaa Earring",
        right_ear="Earthcry Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Fi Follet Cape +1",}
    sets.midcast['Flurry'] = sets.midcast['Haste']
        
    sets.midcast['Cursna'] = {main="Sangoma",
        sub="Ammurapi Shield",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Zendik Robe",
        hands="Inyan. Dastanas +2",
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Meili Earring",
        left_ring="Menelaus's Ring",
        right_ring="Haoma's Ring",
        back="Fi Follet Cape +1",}

    sets.midcast['Barfira'] = sets.midcast['Stoneskin']

    sets.midcast['Barstonra'] = sets.midcast['Barfira']
    sets.midcast['Baraera'] = sets.midcast['Barfira']
    sets.midcast['Barwatera'] = sets.midcast['Barfira']
    sets.midcast['Barblizzara'] = sets.midcast['Barfira']
    sets.midcast['Barthundra'] = sets.midcast['Barfira']
    sets.midcast['Barsleepra'] = sets.midcast['Barfira']
    sets.midcast['Barpoisonra'] = sets.midcast['Barfira']
    sets.midcast['Barparalyzra'] = sets.midcast['Barfira']
    sets.midcast['Barblindra'] = sets.midcast['Barfira']
    sets.midcast['Barsilencera'] = sets.midcast['Barfira']
    sets.midcast['Barpetra'] = sets.midcast['Barfira']
    sets.midcast['Barvira'] = sets.midcast['Barfira']

    sets.midcast['Enfeebling Magic'] = {vmain={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast['Dispel'] = sets.midcast['Enfeebling Magic']

    sets.midcast.Dispelga = {main="Daybreak",
        sub="Ammurapi Shield",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}


 --------------------------------------------------------------------------------------------------------------------------
 --             BARD SONGS                 --
 --------------------------------------------------------------------------------------------------------------------------
   -- DO NOT PLACE A INSTRUMENT HERE AS IT WILL MESS UP DUMMY MODE

   -- Minuet Piece: Empyrean Body 
   sets.midcast['Valor Minuet'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast['Valor Minuet II'] = sets.midcast['Valor Minuet']
    sets.midcast['Valor Minuet III'] = sets.midcast['Valor Minuet']
    sets.midcast['Valor Minuet IV'] = sets.midcast['Valor Minuet']
    sets.midcast['Valor Minuet V'] = sets.midcast['Valor Minuet']

    -- Madrigal Piece: Empyrean Head & Ambuscade Back
    sets.midcast['Sword Madrigal'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        head="Fili Calot +1",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast['Blade Madrigal'] = sets.midcast['Sword Madrigal']

    -- March Piece: Empyrean Hands
    sets.midcast['Advancing March'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        hands="Fili Manchettes +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast['Victory March'] = sets.midcast['Advancing March']
    sets.midcast['Honor March'] = set_combine(sets.midcast['Advancing March'], {range="Marsyas"})

    -- Paeon Piece: AF Head
    sets.midcast["Army's Paeon"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        head="Brioso Roundlet +3",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast["Army's Paeon II"] = sets.midcast["Army's Paeon"]
    sets.midcast["Army's Paeon III"] = sets.midcast["Army's Paeon"]
    sets.midcast["Army's Paeon IV"] = sets.midcast["Army's Paeon"]
    sets.midcast["Army's Paeon V"] = sets.midcast["Army's Paeon"]
    sets.midcast["Army's Paeon VI"] = sets.midcast["Army's Paeon"]

    -- Ballad Piece: Empyrean Legs
    sets.midcast["Mage's Ballad"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        hands="Brioso Cuffs +3",
        legs="Fili Rhingrave +1",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast["Mage's Ballad II"] = sets.midcast["Mage's Ballad"]
    sets.midcast["Mage's Ballad III"] = sets.midcast["Mage's Ballad"]

    -- Minne Piece: Su3 Legs
    sets.midcast["Knight's Minne"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        hands="Aya. Manopolas +2",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast["Knight's Minne II"] = sets.midcast["Knight's Minne"]
    sets.midcast["Knight's Minne III"] = sets.midcast["Knight's Minne"]
    sets.midcast["Knight's Minne IV"] = sets.midcast["Knight's Minne"]
    sets.midcast["Knight's Minne V"] = sets.midcast["Knight's Minne"]

    -- Prelude Piece: Ambuscade Back
    sets.midcast["Hunter's Prelude"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast["Archer's Prelude"] = sets.midcast["Hunter's Prelude"]

    -- Mambo Piece: Su3 Feet
    sets.midcast['Sheepfoe Mambo'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast['Dragonfoe Mambo'] = sets.midcast['Sheepfoe Mambo']

    -- Aubade Piece: None
    sets.midcast['Fowl Aubade'] = sets.midcast['Sheepfoe Mambo']
    -- Pastoral Piece: None
    sets.midcast['Herb Pastoral'] = sets.midcast['Sheepfoe Mambo']

    -- Fantasia Piece: None
    sets.midcast['Shining Fantasia'] = sets.midcast['Sheepfoe Mambo']

    -- Operatta Piece: None
    sets.midcast["Scop's Operatta"] = sets.midcast['Sheepfoe Mambo']
    sets.midcast["Puppet's Operetta"] = sets.midcast["Scop's Operatta"]

    -- Capriccio Piece: None
    sets.midcast['Gold Capriccio'] = sets.midcast['Sheepfoe Mambo']

    -- Round Piece: None
    sets.midcast['Warding Round'] = sets.midcast['Sheepfoe Mambo']

    -- Gavotte Piece: None
    sets.midcast['Goblin Gavotte'] = sets.midcast['Sheepfoe Mambo']

    -- Etude Piece: Su3 Head
    sets.midcast['Sinewy Etude'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast['Dextrous Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Vivacious Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Quick Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Learned Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Spirited Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Enchanting Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Herculean Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Uncanny Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Vital Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Swift Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Sage Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Logical Etude'] = sets.midcast['Sinewy Etude']
    sets.midcast['Bewitching Etude'] = sets.midcast['Sinewy Etude']

    -- Carol Piece: Su3 Hands
    sets.midcast['Fire Carol'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        head="Fili Calot +1",
        body="Fili Hongreline +1",
        hands="Fili Manchettes +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}
    sets.midcast['Ice Carol'] = sets.midcast['Fire Carol']
    sets.midcast['Wind Carol'] = sets.midcast['Fire Carol']
    sets.midcast['Earth Carol'] = sets.midcast['Fire Carol']
    sets.midcast['Lightning Carol'] = sets.midcast['Fire Carol']
    sets.midcast['Water Carol'] = sets.midcast['Fire Carol']
    sets.midcast['Light Carol'] = sets.midcast['Fire Carol']
    sets.midcast['Dark Carol'] = sets.midcast['Fire Carol']

    sets.midcast['Fire Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Ice Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Wind Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Earth Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Lightning Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Water Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Light Carol II'] = sets.midcast['Fire Carol']
    sets.midcast['Dark Carol II'] = sets.midcast['Fire Carol']

    -- Hymnus Piece: None - Would only extend duration
    sets.midcast["Goddess's Hymnus"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Daurdabla",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Inyanga Jubbah +2",
        hands="Fili Manchettes +1",
        legs="Fili Rhingrave +1",
        feet="Coalrake Sabots",
        neck="Mnbw. Whistle +1",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Musical Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    -- Mazurka Piece: None - Would only extend duration
    sets.midcast['Chocobo Mazurka'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Daurdabla",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Inyanga Jubbah +2",
        hands="Fili Manchettes +1",
        legs="Fili Rhingrave +1",
        feet="Coalrake Sabots",
        neck="Mnbw. Whistle +1",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Musical Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    -- Sirvente Pieces: None specific - Max Potency is +50%, obtainable w/ All Songs +7 equipment
    sets.midcast['Foe Sirvente'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}

    -- Dirge Pieces: None specific - Max Potency is -50%, obtainable w/ All Songs +7 equipment
    sets.midcast["Adventurer\'s Dirge"] = sets.midcast['Foe Sirvente']

    -- Scherzo Piece: Empyrean Feet
    sets.midcast["Sentinel's Scherzo"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        body="Fili Hongreline +1",
        legs="Inyanga Shalwar +2",
        feet="Fili Cothurnes +1",
        neck="Mnbw. Whistle +1",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",}

    -- Debuffing Songs   
    -- Requiem Piece: None 
    sets.midcast['Foe Requiem'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast['Foe Requiem II'] = sets.midcast['Foe Requiem']
    sets.midcast['Foe Requiem III'] = sets.midcast['Foe Requiem']
    sets.midcast['Foe Requiem IV'] = sets.midcast['Foe Requiem']
    sets.midcast['Foe Requiem V'] = sets.midcast['Foe Requiem']
    sets.midcast['Foe Requiem VI'] = sets.midcast['Foe Requiem']
    sets.midcast['Foe Requiem VII'] = sets.midcast['Foe Requiem']

    -- Lullaby Piece: AF Hands..... 
    --   Single Target Lullaby: Ghorn is BEST for single target. 
    --   AoE Lullaby: Blurred Harp is on par w/ Ghorn for BEST for potency/duration, but lacking skill makes it slightly less accurate.
                 -- Harps (? Yalm Radius) have a larger AoE Radius than Horns (4 Yalm Radius)
    sets.midcast['Foe Lullaby'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast['Foe Lullaby II'] = sets.midcast['Foe Lullaby']

    sets.midcast['Horde Lullaby'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Blurred Harp +1",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast['Horde Lullaby II'] = sets.midcast['Horde Lullaby']

    -- Threnody Piece: Su3 Body
    sets.midcast['Fire Threnody'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast['Ice Threnody'] = sets.midcast['Fire Threnody']
    sets.midcast['Wind Threnody'] = sets.midcast['Fire Threnody']
    sets.midcast['Earth Threnody'] = sets.midcast['Fire Threnody']
    sets.midcast['Ltng. Threnody'] = sets.midcast['Fire Threnody']
    sets.midcast['Water Threnody'] = sets.midcast['Fire Threnody']
    sets.midcast['Light Threnody'] = sets.midcast['Fire Threnody']
    sets.midcast['Dark Threnody'] = sets.midcast['Fire Threnody']
    
    sets.midcast['Fire Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Ice Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Wind Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Earth Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Ltng. Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Water Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Light Threnody II'] = sets.midcast['Fire Threnody']
    sets.midcast['Dark Threnody II'] = sets.midcast['Fire Threnody'] 

    -- Virelai Piece: None - This is only for LOLs, it's charm.
    sets.midcast["Maiden's Virelai"] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    --Finale Piece: None - This is Dispel
    sets.midcast['Magic Finale'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    -- Nocturne Pieces: None - This is Addle (slower casting time)
    sets.midcast['Pining Nocturne'] = {main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Moonbow Whistle +1",
        waist="Luminary Sash",
        left_ear="Regal Earring",
        right_ear="Digni. Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    -- Elegy Piece: None - This is Slow
    sets.midcast['Battlefield Elegy'] = {main={ name="Carnwenhan", augments={'Path: A',}},
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Stikini Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}
    sets.midcast['Carnage Elegy'] = sets.midcast['Battlefield Elegy']

    sets.midcast.Daurdabla = sets.midcast["Goddess's Hymnus"]

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = sets.midcast["Goddess's Hymnus"]

   
 --------------------------------------------------------------------------------------------------------------------------
 --             IDLE SETS                 --
 --------------------------------------------------------------------------------------------------------------------------
    sets.idle = {main="Sangoma",
        sub="Genmei Shield",
        range="Gjallarhorn",
        head="Volte Beret",
        body="Volte Doublet",
        hands={ name="Chironic Gloves", augments={'Mag. Acc.+27','STR+8','"Refresh"+1',}},
        legs={ name="Chironic Hose", augments={'INT+11','"Mag.Atk.Bns."+11','"Refresh"+1','Accuracy+10 Attack+10',}},
        feet="Fili Cothurnes +1",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Hearty Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back="Solemnity Cape",}

    sets.idle.PDT = {main="Sangoma",
        sub="Genmei Shield",
        range="Gjallarhorn",
        head="Aya. Zucchetto +2",
        body="Annoint. Kalasiris",
        hands={ name="Bihu Cuffs +3", augments={'Enhances "Con Brio" effect',}},
        legs="Brioso Cannions +3",
        feet="Fili Cothurnes +1",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Hearty Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back="Solemnity Cape",}

    sets.Kiting = {feet="Fili Cothurnes +1",}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {range="Gjallarhorn",
        head="Aya. Zucchetto +2",
        body="Ashera Harness",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Kentarch Belt",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Ilabrat Ring",
        right_ring="Moonbeam Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}

    sets.engaged.Acc = {range="Gjallarhorn",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Kentarch Belt",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Moonbeam Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}

    -- -- Set if dual-wielding
    sets.engaged.DW = {range="Gjallarhorn",
        head={ name="Chironic Hat", augments={'Accuracy+16 Attack+16','"Dual Wield"+5','INT+5','Attack+15',}},
        body="Ayanmo Corazza +2",
        hands={ name="Chironic Gloves", augments={'Accuracy+10 Attack+10','"Dual Wield"+4','Accuracy+12','Attack+3',}},
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Suppanomimi",
        left_ring="Ilabrat Ring",
        right_ring="Moonbeam Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}

    sets.engaged.DW.Acc = {range="Gjallarhorn",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Kentarch Belt",
        left_ear="Telos Earring",
        right_ear="Cessance Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Moonbeam Ring",
        back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Occ. inc. resist. to stat. ailments+10',}},}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' or newValue == 'DW' or newValue == 'Acc' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
end


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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Terpander' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Moonbow Whistle" then mult = mult + 0.1 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso slippers +2" then mult = mult + 0.11 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1 +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
    if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end


-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)