-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

    define_roll_values()

end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal','PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

-- Additional local binds

    state.flurrymode = M{['description'] = 'Flurry Mode'}
    state.flurrymode:options('Flurry','FlurryII')

    state.QDmode = M{['description'] = 'Quick Draw Mode'}
    state.QDmode:options('Normal','Damage')
 
    send_command('bind ^` gs c cycle flurrymode')
    send_command('bind ^z input /ra <t>')
    send_command('bind ^- gs c cycle LuzafRing')
    send_command('bind ^= gs c cycle QDmode')
    determine_haste_group()

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^z')
    send_command('unbind ^-')
    send_command('unbind ^=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

--------------------------------------
-- LET THE GEARSWAPING BEGIN!
--------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--             CORSAIR SPECIFIC JOB ABILITIES                 --
--------------------------------------------------------------------------------------------------------------------------

    sets.precast['Snake Eye'] = {legs={ name="Lanun Trews +2", augments={'Enhances "Snake Eye" effect',}},}
    sets.precast['Wild Card'] = {feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},}
    sets.precast['Random Deal'] = {body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},}
    sets.precast['Fold'] = {hands={ name="Lanun Gants +2", augments={'Enhances "Fold" effect',}},}
    sets.precast['Double-Up'] = {head={ name="Lanun Tricorne +2", augments={'Enhances "Winning Streak" effect',}},
        body="Chasseur's Frac +1",
        hands="Chasseur's Gants +1",
        legs="Chas. Culottes +1",
        feet="Chass. Bottes +1",
        neck="Regal Necklace",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    
    sets.precast.CorsairRoll = {head={ name="Lanun Tricorne +2", augments={'Enhances "Winning Streak" effect',}},
        hands="Chasseur's Gants +1",
        neck="Regal Necklace",
        back={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}
    
    sets.precast["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +1"})
    sets.precast["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast["Tactician\'s Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1",})

    -- IF Luzaf Ring Mode is active it will do a set_combine with the ring. Otherwise does not usually attach.
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

    --This is for your elemental shot builds.

    --Normal is going to be for Store TP to allow you to get more TP when you use your elemental Shots
    sets.precast.CorsairShot = {ammo="Devastating Bullet",
	    head={ name="Herculean Helm", augments={'Accuracy+22','"Store TP"+2','DEX+13','Attack+5',}},
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Malignance Tights",
	    feet="Malignance Boots",
	    neck="Combatant's Torque",
	    waist="Yemaya Belt",
	    left_ear="Telos Earring",
	    right_ear="Digni. Earring",
	    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	    right_ring="Ilabrat Ring",
	    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

    -- If you are needing to do Damage or to use your AF Head and Empyrean Boots here.
    sets.precast.CorsairShot.Damage = {ammo="Living Bullet",
	    head="Chass. Tricorne +1",
	    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
	    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
	    legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
	    feet="Laksa. Bottes +3",
	    neck="Sanctity Necklace",
	    waist=gear.ElementalObi,
	    left_ear="Novio Earring",
	    right_ear="Friomisi Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Dingir Ring",
	    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    -- Magic Accurary build for Light Shot & Dark Shot due to wanting them to land on higher level monsters
    sets.precast.CorsairShot['Light Shot'] = {ammo="Devastating Bullet",
        head="Laksa. Tricorne +3",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="Herculean Gloves", augments={'Attack+15','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        legs={ name="Herculean Trousers", augments={'"Fast Cast"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        feet="Laksa. Boots +3",
        neck="Sanctity Necklace",
        waist=gear.ElementalObi,
        left_ear="Gwati Earring",
        right_ear="Digni. Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

    -- Don't forget that there are specific equipment for Dark Affinity
    sets.precast.CorsairShot['Dark Shot'] = {ammo="Devastating Bullet",
        head="Laksa. Tricorne +3",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="Herculean Gloves", augments={'Attack+15','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        legs={ name="Herculean Trousers", augments={'"Fast Cast"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        feet="Laksa. Boots +3",
        neck="Sanctity Necklace",
        waist=gear.ElementalObi,
        left_ear="Gwati Earring",
        right_ear="Digni. Earring",
        left_ring="Stikini Ring",
        right_ring="Archon Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},}

--------------------------------------------------------------------------------------------------------------------------
--             SUBJOB SPECIFIC JOB ABILITIES                 --
--------------------------------------------------------------------------------------------------------------------------
    
    sets.precast.Waltz = {head="Mummu Bonnet +2",
        body="Passion Jacket",
        hands="Slither Gloves +1",
        legs={ name="Desultor Tassets", augments={'"Waltz" TP cost -5','"Phantom Roll" ability delay -5',}},
        feet="Rawhide Boots",
        neck="Unmoving Collar +1",
        left_ear="Genmei Earring",
        right_ear="Hearty Earring",
        left_ring="Asklepian Ring",
        right_ring="Valseur's Ring",
        back={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}

--------------------------------------------------------------------------------------------------------------------------
--             WEAPONSKILL SETS                 --
--------------------------------------------------------------------------------------------------------------------------

 --Any set that is determined as .Acc will automatically switch to Accuracy when Offensive Mode is in Acc 

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.Obi = {waist="Hachirin-no-Obi"}
    gear.default.obi_waist = "Eschan Stone"

    sets.precast.WS = {head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Caro Necklace",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body="Meg. Cuirie +2",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Mummu Gamash. +2",
        neck="Fotia Gorget",
        waist="Grunfeld Rope",
        left_ear="Mache Earring",
        right_ear="Mache Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    sets.precast.WS['Evisceration'].Acc = sets.precast.WS.Acc

    sets.precast.WS['Exenterator'] = sets.precast.WS
    sets.precast.WS['Exenterator'].Acc = sets.precast.WS.Acc

    sets.precast.WS['Slug Shot'] = {ammo="Chrono Bullet",
        head="Meghanada Visor +2",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Last Stand'] = {ammo="Chrono Bullet",
        head="Meghanada Visor +2",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Last Stand'].Acc = {ammo="Chrono Bullet",
        head="Meghanada Visor +2",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS['Wildfire'] = {ammo="Living Bullet",
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','INT+2','Mag. Acc.+14',}},
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','MND+7','Mag. Acc.+15',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Novio Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},} 

    sets.precast.WS['Wildfire'].Acc = {ammo="Living Bullet",
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','INT+2','Mag. Acc.+14',}},
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','MND+7','Mag. Acc.+15',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Novio Earring",
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},}   
    
    sets.precast.WS['Leaden Salute'] = {ammo="Living Bullet",
        head="Pixie Hairpin +1",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Archon Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Leaden Salute'].Acc = {ammo="Living Bullet",
        head="Pixie Hairpin +1",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Archon Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS['Savage Blade'] = {head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Savage Blade'].Acc = {head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Telos Earring",
        left_ring="Rufescent Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
        
    sets.precast.WS['Requiescat'] = {head="Meghanada Visor +2",
        body="Meg. Cuirie +2",
        hands="Mummu Wrists +2",
        legs="Meg. Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Requiescat'].Acc = {head="Meghanada Visor +2",
        body="Meg. Cuirie +2",
        hands="Mummu Wrists +2",
        legs="Meg. Chausses +2",
        feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Rufescent Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

--------------------------------------------------------------------------------------------------------------------------
--            PRECAST RANGED ABILITIES                 --
--------------------------------------------------------------------------------------------------------------------------

	-- Snapshot caps at 70% & Rapid Shot caps at 99% (as Rapid Shot is a chance for it to proc not a consistant thing)
		-- If a Master Corsair, Snapshot caps at 60%
    sets.precast.RA = {ammo="Devastating Bullet",
        head={ name="Taeon Chapeau", augments={'"Snapshot"+4','"Snapshot"+4',}},
        body="Oshosi Vest",
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs="Laksa. Trews +3",
        feet="Meg. Jam. +2",
        waist="Impulse Belt",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}

    sets.precast.RA.Flurry = {ammo="Devastating Bullet",
        head="Chass. Tricorne +1",
        body="Oshosi Vest",
        hands="Mrigavyadha Gloves",
        legs="Laksa. Trews +3",
        feet="Meg. Jam. +2",
        waist="Yemaya Belt",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}

    sets.precast.RA.FlurryTwo = {ammo="Devastating Bullet",
        head="Chass. Tricorne +1",
        body="Laksa. Frac +3",
        hands="Mrigavyadha Gloves",
        legs="Laksa. Trews +3",
        feet="Meg. Jam. +2",
        waist="Yemaya Belt",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}

--------------------------------------------------------------------------------------------------------------------------
--            MIDCAST RANGED ABILITIES                 --
--------------------------------------------------------------------------------------------------------------------------

    sets.midcast.RA = {ammo="Devastating Bullet",
        head="Meghanada Visor +2",
        body="Malignance Tabard",
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs="Mummu Kecks +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Iskur Gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

    sets.midcast.RA.Acc = {ammo="Devastating Bullet",
        head="Meghanada Visor +2",
        body="Meg. Cuirie +2",
        hands="Mummu Wrists +2",
        legs="Meg. Chausses +2",
        feet="Meg. Jam. +2",
        neck="Iskur Gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

    -- This is wehn you have Aftermath active on Armageddon.
    sets.midcast.RA.Critical = {head="Meghanada Visor +2",
        body="Oshosi Vest",
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs="Mummu Kecks +2",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Iskur Gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

    -- This is when Triple Shot is active, any gear with Triple Shot+ should go here.
    sets.TripleShot = {head="Oshosi Mask",
        body="Oshosi Vest",
        hands="Oshosi Gloves",
        legs="Oshosi Trousers",
        feet="Oshosi Leggings",
        neck="Iskur Gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

    -- This set is for when you have Aftermath up with Armageddon & Triple Shot is active
    sets.TripleShotCritical = {head="Oshosi Mask",
        body="Oshosi Vest",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        feet="Oshosi Leggings",
        neck="Iskur Gorget",
        waist="Yemaya Belt",
        left_ear="Enervating Earring",
        right_ear="Telos Earring",
        left_ring="Dingir Ring",
        right_ring="Regal Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}

--------------------------------------------------------------------------------------------------------------------------
--             MAGIC SECTIONS FOR THAT POTENTIAL SUB RDM/WHM/SCH SETS                 --
--------------------------------------------------------------------------------------------------------------------------

    sets.precast.FC = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+9','Mag. Acc.+5','"Mag.Atk.Bns."+6','"Fast Cast"+1',}},
        legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Baetyl Pendant",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}

    sets.precast.FC.Utsusemi = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Passion Jacket",
        hands={ name="Leyline Gloves", augments={'Accuracy+9','Mag. Acc.+5','"Mag.Atk.Bns."+6','"Fast Cast"+1',}},
        legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
        neck="Magoraga Beads",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}  
    
    
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.Utsusemi = sets.precast.FC

    sets.midcast['Cure'] = {}
    sets.midcast['Cure II'] = sets.midcast['Cure']
    sets.midcast['Cure III'] = sets.midcast['Cure']
    sets.midcast['Cure IV'] = sets.midcast['Cure']
    
--------------------------------------------------------------------------------------------------------------------------
--             ENGAGED SETS                 --
--------------------------------------------------------------------------------------------------------------------------
    
	-- This set is if you have no Buffs up providing you Haste or Delay - 
	-- If /NIN - DW 49
	-- If /DNC - DW 59
    sets.engaged = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.PDT = {head={ name="Dampening Tam", augments={'DEX+7','Accuracy+12','Mag. Acc.+2','Quadruple Attack +1',}},
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Purity Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.Acc = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Sanctity Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Cacoethic Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.Acc.PDT = sets.engaged.PDT

    -- This set is if you have Haste 1
    -- /NIN - DW 42
    -- /DNC - DW 52
    sets.engaged.Haste_15 = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.Haste_15.PDT = sets.engaged.PDT

    sets.engaged.Acc.Haste_15 = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Sanctity Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Cacoethic Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.Acc.Haste_15.PDT = sets.engaged.PDT

    -- This is if you have a combination of Haste 2 or Bard Songs
    -- /NIN - DW 31
    -- /DNC - DW 41
    sets.engaged.Haste_30 = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.Haste_30.PDT = sets.engaged.PDT

    sets.engaged.Acc.Haste_30 = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Sanctity Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Cacoethic Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.Acc.Haste_30.PDT = sets.engaged.PDT

    -- Additional Combinations of Haste & Bard Songs or Dancer Haste Samba
    -- /NIN - DW 25
    -- /DNC - DW 35
    sets.engaged.Haste_35 = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Lissome Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.Haste_35.PDT = sets.engaged.PDT

    sets.engaged.Acc.Haste_35 = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
        neck="Sanctity Necklace",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Cacoethic Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.Acc.Haste_35.PDT = sets.engaged.PDT

    -- This set will be put on if you have Max Haste from all Combinations 
    	-- DO NOT GO MORE THAN THESE NUMBERS ARE YOU WILL HINDER YOUR TP GAIN
    -- /NIN - DW 11
    -- /DNC - DW 21
    sets.engaged.MaxHaste = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Malignance Boots",
        neck="Lissome Necklace",
        waist="Grunfeld Rope",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.MaxHaste.PDT = sets.engaged.PDT

    sets.engaged.Acc.MaxHaste = {head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Malignance Boots",
        neck="Lissome Necklace",
        waist="Grunfeld Rope",
        left_ear="Telos Earring",
        right_ear="Brutal Earring",
        left_ring="Cacoethic Ring +1",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.Acc.MaxHaste.PDT = sets.engaged.PDT

--------------------------------------------------------------------------------------------------------------------------
--             IDLE SETS                 --
--------------------------------------------------------------------------------------------------------------------------

    sets.idle = {head={ name="Dampening Tam", augments={'DEX+7','Accuracy+12','Mag. Acc.+2','Quadruple Attack +1',}},
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Karieyh Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}


    sets.idle.PDT = {head={ name="Dampening Tam", augments={'DEX+7','Accuracy+12','Mag. Acc.+2','Quadruple Attack +1',}},
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Karieyh Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

     sets.idle.Refresh = {head="Rawhide Mask",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Genmei Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Karieyh Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.Kiting = {feet="Hermes' Sandals"}
    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type=="Ranged Attack" then
        if buffactive['Flurry'] and buffactive["Courser's Roll"] then --If both are active, use flurry 2 gear
            add_to_chat(123,'Roll + Flurry')
            equip(sets.precast.RA.FlurryTwo)
            eventArgs.handled = true
        elseif buffactive['Flurry'] then --If only flurry is active, equip gear based on flurrymode
            if state.flurrymode.value == 'FlurryII' then
                equip(sets.precast.RA.FlurryTwo)
                eventArgs.handled = true
            else
                equip(sets.precast.RA.Flurry)
                eventArgs.handled = true
            end
        elseif buffactive["Courser's Roll"] then --If only courser's roll, use flurry1 gear
            add_to_chat(123,'Roll Only')
            equip(sets.precast.RA.Flurry)
            eventArgs.handled = true
        else
            add_to_chat(123,'Nothing');
            equip(sets.precast.RA)
            eventArgs.handled = true
        end
    end
    if spell.type == 'CorsairRoll' and state.LuzafRing.value then
        equip(set_combine(sets.precast.CorsairRoll, sets.precast.LuzafRing))
    elseif spell.english == "Double-Up" then
        equip(sets.precast.DoubleUp)
            if state.LuzafRing.value then
                equip(set_combine(sets.precast.CorsairRoll, sets.precast.LuzafRing))
            end
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
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
				eventArgs.handled = true
            end
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
			eventArgs.handled = true
        end
    end
    if spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            if state.QDmode.value == 'Normal' then
                equip(sets.precast.CorsairShot)
            elseif state.QDmode.value == 'Damage' then
                equip(sets.precast.CorsairShot.Damage)
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
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

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},}
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 8)
end
