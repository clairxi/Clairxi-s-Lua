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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

    state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Normal'}
    update_combat_form()


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Asuran Claws', 'Bilgestorm', 'Bludgeon', 'Body Slam', 'Feather Storm', 'Mandibular Bite', 'Queasyshroom',
        'Power Attack', 'Ram Charge', 'Saurian Slide', 'Screwdriver', 'Sickle Slash', 'Smite of Rage',
        'Spinal Cleave', 'Spiral Spin', 'Sweeping Gouge', 'Terror Touch', 'Battle Dance', 'Bloodrake',
        'Death Scissors', 'Dimensional Death', 'Empty Thrash', 'Quadrastrike', 'Uppercut', 'Tourbillion',
        'Thrashing Assault', 'Vertical Cleave', 'Whirl of Rage', 'Amorphic Spikes', 'Barbed Crescent',
        'Claw Cyclone', 'Disseverment', 'Foot Kick', 'Frenetic Rip', 'Goblin Rush', 'Hysteric Barrage',
        'Paralyzing Triad', 'Seedspray', 'Sinker Drill', 'Vanity Dive', 'Cannonball', 'Delta Thrust',
        'Glutinous Dart', 'Grand Slam', 'Quad. Continuum', 'Benthic Typhoon', 'Helldive',
        'Hydro Shot', 'Jet Stream', 'Pinecone Bomb', 'Wild Oats', 'Heavy Strike'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike',}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Asuran Claws', 'Bilgestorm', 'Battle Dance', 'Bludgeon', 'Bloodrake', 'Death Scissors',
        'Dimensional Death', 'Empty Thrash', 'Quadrastrike', 'Uppercut', 'Tourbillion', 'Sinker Drill',
        'Thrashing Assault', 'Vertical Cleave', 'Whirl of Rage', 'Saurian Slide', 'Sinal Cleave',
        'Paralyzing Triad'}
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes', 'Barbed Crescent', 'Claw Cyclone', 'Disseverment', 'Foot Kick',
        'Frenetic Rip', 'Goblin Rush', 'Hysteric Barrage', 'Seedspray',
        'Vanity Dive'}
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Cannonball', 'Delta Thrust', 'Glutinous Dart', 'Grand Slam', 'Quad. Continuum',
        'Sprout Smack'}
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Acrid Stream', 'Anvil Lightning', 'Crashing Thunder', 'Charged Whisker', 'Droning Whirlwind',
        'Firespit', 'Foul Waters', 'Gates of Hades', 'Leafstorm', 'Molting Plumage', 'Magic Barrier', 'Nectarous Deluge',
        'Polar Roar', 'Regurgitation', 'Rending Deluge', 'Scouring Spate', 'Searing Tempest', 'Silent Storm',
        'Spectral Floe', 'Subduction', 'Sudden Lunge', 'Tem. Upheaval', 'Thermal Pulse', 'Thunderbolt', 'Uproot',
        'Water Bomb', 'Atra. Libations', 'Blood Saber', 'Dark Orb', 'Death Ray', 'Eyes On Me', 'Blazing Bound',
        'Evryone. Grudge', 'Palling Salvo', 'Tenebral Crush', 'Blinding Fulgor', 'Diffusion Ray', 'Ice Break',
        'Magic Hammer', 'Rail Cannon', 'Retinal Glare', 'Embalming Earth', 'Entomb', 'Sandspin', 'Vapor Spray',}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Eyes On Me','Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath', 'Flying Hip Press', 'Final Sting', 'Frost Breath', 'Heat Breath', 'Magnetite Cloud',
        'Poison Breath', 'Radiant Breath', 'Self Destruct', 'Thunder Breath', 'Vapor Spray', 'Wind Breath'}

    -- Stun spells
    blue_magic_maps.Stun = S{'Frypan', 'Head Butt', 'Sudden Lunge', 'Tail slap', 'Sub-zero Smash', 'Sweeping Gouge'}
        
    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'}
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Diamondhide', 'Metallic Body', 'Magic Barrier', 'Atra. Libations',}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Barrier Tusk', 'Cocoon', 'Carcharian Verve', 'Erratic Flutter', 'Harden Shell', 'Orcish Counterstance',
        'Plasma Charge', 'Pyric Bulwark', 'Memento Mori', 'Mighty Guard', 'Nat. Meditation', 'Reactor Cool', 'Saline Coat',
        'Feather Barrier','Refueling','Warm-Up', 'Zephyr Mantle', 'Reactor Cool', 'Plasma Charge', 'Amplification', }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell', 'Mighty Guard', 'Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'}

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')


    -- Additional local binds

    send_command('bind ^` gs c cycle HasteMode')

    select_default_macro_book()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')

end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +2",}
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk +1",
        feet="Assim. Charuqs +2",}
    sets.buff.Convergence = {head={ name="Luh. Keffiyeh +2", augments={'Enhances "Convergence" effect',}},}
    sets.buff.Diffusion = {feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},}
    sets.buff.Enchainment = {body={ name="Luhlaza Jubbah +3", augments={'Enhances "Enchainment" effect',}},}
    sets.buff.Efflux = {legs="Hashishin Tayt +1"}
    sets.buff.Assimulation = {legs={ name="Luhlaza Shalwar +1", augments={'Enhances "Assimilation" effect',}},}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands={ name="Luh. Bazubands +1", augments={'Enhances "Azure Lore" effect',}},}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','CHR+4','"Waltz" ability delay -2',}},
        legs={ name="Desultor Tassets", augments={'"Waltz" TP cost -5','"Sic" and "Ready" ability delay -5',}},
        left_ring="Asklepian Ring",
        right_ring="Valseur's Ring",}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = sets.precast.Waltz

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Luhlaza Jubbah +3", augments={'Enhances "Enchainment" effect',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+9','Mag. Acc.+5','"Mag.Atk.Bns."+6','"Fast Cast"+1',}},
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Baetyl Pendant",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Rosmerta's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Spell interruption rate down-10%',}},}
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Falcon Eye",
        head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
        body={ name="Herculean Vest", augments={'Accuracy+30','STR+1','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
        hands={ name="Herculean Gloves", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+11',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet={ name="Herculean Boots", augments={'Accuracy+20','"Mag.Atk.Bns."+15','Quadruple Attack +2','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Mache Earring",
        right_ear="Cessance Earring",
        left_ring="Ilabrat Ring",
        right_ring="Karieyh Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},}
    
    sets.precast.WS.acc = {ammo="Mantoptera Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Karieyh Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Chant du Cygne'] = {ammo="Falcon Eye",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Assim. Jubbah +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Aya. Gambieras +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Brutal Earring",
        right_ear="Mache Earring",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},}

    sets.precast.WS['Chant du Cygne'].Acc = {ammo="Falcon Eye",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Assim. Jubbah +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
        feet="Aya. Gambieras +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Brutal Earring",
        right_ear="Mache Earring",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},}

    sets.precast.WS['Savage Blade'] = {ammo="Mantoptera Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Karieyh Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Savage Blade'] = {ammo="Mantoptera Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Karieyh Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Requiescat'] = {ammo="Hydrocera",
        head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+2%','Mag. Acc.+15','"Mag.Atk.Bns."+14',}},
        body="Assim. Jubbah +2",
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','MND+2','Mag. Acc.+7',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Brutal Earring",
        right_ear="Regal Earring",
        left_ring="Epona's Ring",
        right_ring="Rufescent Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Requiescat'].Acc = {ammo="Hydrocera",
        head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+2%','Mag. Acc.+15','"Mag.Atk.Bns."+14',}},
        body="Assim. Jubbah +2",
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs="Jhakri Slops +2",
        feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','MND+2','Mag. Acc.+7',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Brutal Earring",
        right_ear="Regal Earring",
        left_ring="Epona's Ring",
        right_ring="Rufescent Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +25',}},
        right_ear="Cessance Earring",
        left_ring="Shiva Ring +1",
        right_ring="Karieyh Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Circle Blade'] = {ammo="Falcon Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands="Jhakri Cuffs +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Circle Blade'].Acc = {ammo="Falcon Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands="Jhakri Cuffs +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Regal Earring",
        left_ring="Rufescent Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Expiacion'] = {ammo="Falcon Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands="Jhakri Cuffs +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Expiacion'].Acc = {ammo="Falcon Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands="Jhakri Cuffs +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Regal Earring",
        left_ring="Rufescent Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Regal Earring",
        left_ring="Archon Ring",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

--------------------------------------------------------------------------------------------------------------------------------------
-- CLUB WS --
--------------------------------------------------------------------------------------------------------------------------------------

    sets.precast.WS['Black Halo'] = {ammo="Focal Orb",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands="Jhakri Cuffs +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Regal Earring",
        left_ring="Rufescent Ring",
        right_ring="Apate Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Black Halo'].Acc = sets.precast.WS['Black Halo']

    sets.precast.WS['Realmrazer'] = {ammo="Hydrocera",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Realmrazer'].Acc = sets.precast.WS['Realmrazer']

    sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Regal Earring",
        left_ring="Adoulin Ring",
        right_ring="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}
    
    sets.precast.WS['Flash Nova'].Acc = sets.precast.WS['Flash Nova']

    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens",
        head={ name="Herculean Helm", augments={'Accuracy+22','"Store TP"+2','DEX+13','Attack+5',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Baetyl Pendant",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}
        
    sets.midcast['Blue Magic'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
        back={ name="Cornflower Cape", augments={'MP+25','DEX+1','Accuracy+4','Blue Magic skill +9',}},}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Cheruski Needle",
        head="Jhakri Coronal +2",
        body="Assim. Jubbah +1",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Hashishin Tayt +1",
        feet="Jhakri Pigaches +2",
        neck="Caro Necklace",
        waist="Metalsinger Belt",
        left_ear="Mache Earring",
        right_ear="Cessance Earring",
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back={ name="Cornflower Cape", augments={'MP+25','DEX+1','Accuracy+4','Blue Magic skill +9',}},}

    sets.midcast['Blue Magic'].PhysicalAcc = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalStr = {ammo="Ginsen",
        head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Assim. Jubbah +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Mache Earring",
        right_ear="Odnowa Earring",
        left_ring="Apate Ring",
        right_ring="Rufescent Ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.midcast['Blue Magic'].PhysicalDex = {ammo="Falcon Eye",
        head={ name="Herculean Helm", augments={'Accuracy+22','"Store TP"+2','DEX+13','Attack+5',}},
        body="Assim. Jubbah +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
        feet="Aya. Gambieras +2",
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear="Mache Earring",
        right_ear="Odnowa Earring",
        left_ring="Apate Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.midcast['Blue Magic'].PhysicalVit = {ammo="Ginsen",
    	head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
    	body="Assim. Jubbah +1",
    	hands={ name="Herculean Gloves", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+11',}},
    	legs="Aya. Cosciales +2",
    	feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+1','STR+10','Attack+2',}},
    	neck="Unmoving Collar",
    	waist="Grunfeld Rope",
    	left_ear="Mache Earring",
    	right_ear="Cessance Earring",
    	left_ring="Petrov Ring",
    	right_ring="Supershear Ring",
    	back={ name="Cornflower Cape", augments={'MP+25','DEX+1','Accuracy+4','Blue Magic skill +9',}},}

    sets.midcast['Blue Magic'].PhysicalAgi = sets.midcast['Blue Magic'].PhysicalDex

    sets.midcast['Blue Magic'].PhysicalInt = sets.midcast['Blue Magic'].PhysicalDex

    sets.midcast['Blue Magic'].PhysicalMnd = sets.midcast['Blue Magic'].PhysicalDex

    sets.midcast['Blue Magic'].PhysicalChr = sets.midcast['Blue Magic'].PhysicalDex

    sets.midcast['Blue Magic'].PhysicalHP = sets.midcast['Blue Magic'].PhysicalDex


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Regal Earring",
        left_ring="Shiva Ring +1",
        right_ring="Jhakri Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Blue Magic'].Magical.Resistant = sets.midcast['Blue Magic'].Magical
    
    sets.midcast['Blue Magic'].MagicalMnd = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalChr = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalVit = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicalDex = sets.midcast['Blue Magic'].Magical

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Pemphredo Tathlum",
        head="Assim. Keffiyeh +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet="Jhakri Pigaches +2",
        neck="Erra Pendant",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Blue Magic']['Entomb'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Regal Earring",
        left_ring="Shiva Ring +1",
        right_ring="Jhakri Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Tenebral Crush'] = {ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Baetyl Pendant",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Regal Earring",
        left_ring="Shiva Ring +1",
        right_ring="Archon Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {}

    -- Other Types --

    sets.midcast['Battery Charge'] = {ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +8',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Austerity Belt",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    sets.midcast['Regeneration'] = {ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +8',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Austerity Belt",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}
    
    sets.midcast['Blue Magic'].Stun = {ammo="Pemphredo Tathlum",
        head="Assim. Keffiyeh +2",
        body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+9','Mag. Acc.+5','"Mag.Atk.Bns."+6','"Fast Cast"+1',}},
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet="Jhakri Pigaches +2",
        neck="Erra Pendant",
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Regal Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},}

    sets.midcast['Occultation'] = {ammo="Pemphredo Tathlum",
        head={ name="Luh. Keffiyeh +2", augments={'Enhances "Convergence" effect',}},
        body="Assim. Jubbah +2",
        hands="Hashi. Bazu. +1",
        legs="Hashishin Tayt +1",
        feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},
        neck="Incanter's Torque",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring",
        back="Solemnity Cape",}
        
    sets.midcast['White Wind'] = {ammo="Falcon Eye",
        head={ name="Luh. Keffiyeh +2", augments={'Enhances "Convergence" effect',}},
        body="Assim. Jubbah +2",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs="Assim. Shalwar +2",
        feet={ name="Medium's Sabots", augments={'MP+40','MND+6','"Conserve MP"+5','"Cure" potency +3%',}},
        neck="Sanctity Necklace",
        waist="Porous Rope",
        left_ear="Mendi. Earring",
        right_ear="Odnowa Earring",
        left_ring="Adoulin Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%',}},}

    sets.midcast['Blue Magic'].Healing = {ammo="Hydrocera",
        head="Assim. Keffiyeh +2",
        body="Vedic Coat",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Medium's Sabots", augments={'MP+40','MND+6','"Conserve MP"+5','"Cure" potency +3%',}},
        neck="Incanter's Torque",
        waist="Luminary Sash",
        left_ear="Mendi. Earring",
        right_ear="Regal Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Rosmerta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%',}},}

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Pemphredo Tathlum",
        head={ name="Luh. Keffiyeh +2", augments={'Enhances "Convergence" effect',}},
        body="Assim. Jubbah +2",
        hands="Rawhide Gloves",
        legs="Hashishin Tayt +1",
        feet={ name="Luhlaza Charuqs +1", augments={'Enhances "Diffusion" effect',}},
        neck="Incanter's Torque",
        waist="Witful Belt",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Stikini Ring",
        back="Solemnity Cape",}

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic'].SkillBasedBuff

    sets.midcast['Carcharian Verve'] = {ammo="Pemphredo Tathlum",
        head="Ipoca Beret",
        body="Vedic Coat",
        hands="Shrieker's Cuffs",
        legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Incanter's Torque",
        waist="Austerity Belt",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back="Solemnity Cape",}

    -----------------------
    -- Non-Blue Spells --
    -----------------------
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast['Phalanx'] = {ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +8',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Medium's Sabots", augments={'MP+40','MND+6','"Conserve MP"+5','"Cure" potency +3%',}},
        neck="Incanter's Torque",
        waist="Austerity Belt",
        left_ear="Andoaa Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Perimede Cape",}

    sets.midcast['Aquaveil'] = {ammo="Pemphredo Tathlum",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +8',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Medium's Sabots", augments={'MP+40','MND+6','"Conserve MP"+5','"Cure" potency +3%',}},
        neck="Incanter's Torque",
        waist="Austerity Belt",
        left_ear="Andoaa Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Perimede Cape",}

    
    -- Engaged sets
    
    -- Normal melee group

    sets.engaged = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Asperity Necklace",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head={ name="Dampening Tam", augments={'DEX+7','Accuracy+12','Mag. Acc.+2','Quadruple Attack +1',}},
        body="Ayanmo Corazza +2",
        hands={ name="Herculean Gloves", augments={'Accuracy+18 Attack+18','Crit. hit damage +2%','DEX+9','Attack+12',}},
        legs="Aya. Cosciales +2",
        feet="Ahosi Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back="Solemnity Cape",}

    sets.engaged.Acc = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Telos Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Acc.PDT = sets.engaged.PDT

    sets.engaged.Haste_15 = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Asperity Necklace",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Haste_15.PDT = sets.engaged.PDT

    sets.engaged.Acc.Haste_15 = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Telos Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Acc.Haste_15.PDT = sets.engaged.PDT

    sets.engaged.Haste_30 = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Haste_30.PDT = sets.engaged.PDT

    sets.engaged.Acc.Haste_30 = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Asperity Necklace",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Suppanomimi",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Acc.Haste_30.PDT = sets.engaged.PDT

    sets.engaged.Haste_35 = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Aya. Gambieras +2",
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Haste_35.PDT = sets.engaged.PDT

    sets.engaged.Acc.Haste_35 = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Aya. Gambieras +2",
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Acc.Haste_35.PDT = sets.engaged.PDT

    sets.engaged.MaxHaste = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Aya. Gambieras +2",
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.MaxHaste.PDT = sets.engaged.PDT

    sets.engaged.Acc.MaxHaste = {ammo="Ginsen",
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Aya. Gambieras +2",
        neck="Combatant's Torque",
        waist="Reiki Yotai",
        left_ear="Brutal Earring",
        right_ear="Cessance Earring",
        left_ring="Epona's Ring",
        right_ring="Ilabrat Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},}

    sets.engaged.Acc.MaxHaste.PDT = sets.engaged.PDT
    
    -- Sets to return to when not performing an action.
        -- Idle sets
    sets.idle = {ammo="Staunch Tathlum",
        head="Rawhide Mask",
        body="Jhakri Robe +2",
        hands="Aya. Manopolas +2",
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Ahosi Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back="Solemnity Cape",}

    sets.idle.PDT = {ammo="Staunch Tathlum",
        head={ name="Dampening Tam", augments={'DEX+7','Accuracy+12','Mag. Acc.+2','Quadruple Attack +1',}},
        body="Ayanmo Corazza +2",
        hands={ name="Herculean Gloves", augments={'Accuracy+18 Attack+18','Crit. hit damage +2%','DEX+9','Attack+12',}},
        legs="Aya. Cosciales +2",
        feet="Ahosi Leggings",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back="Solemnity Cape",}

    -- sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    -- sets.defense.PDT = {}

    -- sets.defense.MDT = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
     -- Equip obi if weather/day matches for WS.   
    if spell.type == 'WeaponSkill' then
        if (state.RangedMode == 'Acc' and RangedWeaponskills:contains(spell.english)) then
            equip(sets.precast.WS[spell.english].Acc)
        elseif (state.OffenseMode == 'Acc' and not RangedWeaponskills:contains(spell.english)) then
            equip(setse.precast.WS[spell.english].Acc)
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
             ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
             ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                 ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
           ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
           ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
           ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
               ( buffactive.march == 2 and buffactive['haste samba'] ) or
               ( buffactive[580] and buffactive['haste samba'] ) then 
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
               ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
               ( buffactive[580] ) or  -- geo haste
               ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.HasteMode.value ~= 'Normal' then
        msg = msg .. ', Haste: '..state.HasteMode.current
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


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 10)
end