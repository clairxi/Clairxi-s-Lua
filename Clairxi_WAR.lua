--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    state.Buff['Defender'] = buffactive['Defender'] or false

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'PDT')

    send_command('bind ^` gs c cycle CombatWeapon')
    
    state.CombatWeapon = M{['description']='Combat Weapon'}
    state.CombatWeapon:options('Normal', 'Fencer', 'DW')

    update_melee_groups()
    determine_haste_group()    
    select_default_macro_book()

end 

function user_unload()
    send_command('unbind ^`')
end
       
-- Define sets and vars used by this job file.
function init_gear_sets()
     --------------------------------------
     -- LET THE GEARSWAPING BEGIN!
     --------------------------------------
     --------------------------------------------------------------------------------------------------------------------------
	 --             JOB ABILITIES                 --
     --------------------------------------------------------------------------------------------------------------------------
     -- Precast sets to enhance JA's upon activation
     sets.precast.JA['Mighty Strikes'] = {hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},}
     sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1",}
     sets.precast.JA['Berserk'] = {body="Pumm. Lorica +3",
        feet={ name="Agoge Calligae +3", augments={'Enhances "Tomahawk" effect',}},
        back={ name="Cichol's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}

     sets.precast.JA['Warcry'] = {head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},}
     sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +3",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},}

     sets.precast.JA['Warrior\'s Charge'] = {legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},}
     sets.precast.JA['Defender']  = {hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},}
     sets.precast.JA['Tomahawk'] = {feet={ name="Agoge Calligae +3", augments={'Enhances "Tomahawk" effect',}},}
     sets.precast.JA['Restraint'] = {hands="Boii Mufflers +1",}
     sets.precast.JA['Retaliation'] = {hands="Pumm. Mufflers +3",
        feet="Boii Calligae +1",}
     
     sets.precast.JA['Provoke'] = {ammo="Sapience Orb",
        head="Pummeler's Mask +3",
        body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands="Pumm. Mufflers +3",
        legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}},
        neck="Unmoving Collar +1",
        waist="Sinew Belt",
        left_ear="Friomisi Earring",
        right_ear="Cryptic Earring",
        left_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        right_ring="Petrov Ring",
        back="Agema Cape",}

     -- Buff sets for while the effect is up, this is a set_combined, only need the gear that enhances these buffs, not full sets.
     sets.buff['Defender'] = {hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},}

     -- Waltz set (chr and vit)
     sets.precast.Waltz = {left_ring="Valseur's Ring",
        right_ring="Asklepian Ring",}

     --------------------------------------------------------------------------------------------------------------------------
	 --             MAGIC                 --
     --------------------------------------------------------------------------------------------------------------------------

     -- Fast cast sets for spells, this is also used for Utsusemi as WAR can not wear the Utsu specific equipment
    sets.precast.FC = {ammo="Sapience Orb",
        head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        body={ name="Odyss. Chestplate", augments={'Mag. Acc.+10 "Mag.Atk.Bns."+10','"Fast Cast"+3','AGI+2','Mag. Acc.+12',}},
        hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
        legs={ name="Odyssean Cuisses", augments={'Attack+30','"Fast Cast"+5','STR+4',}},
        feet={ name="Odyssean Greaves", augments={'Accuracy+17 Attack+17','"Fast Cast"+2','AGI+10','Attack+13',}},
        neck="Baetyl Pendant",
        waist="Flume Belt +1",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Prolix Ring",
        right_ring="Evanescence Ring",
        back={ name="Cichol's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}
            
     -- Specific spells
     sets.midcast['Flash'] = sets.precast.JA['Provoke']
     
     -- Want to make sure your haste is capped for recast, as Haste is an equal value while fast cast is half value.
     sets.midcast.FastRecast = sets.precast.FC

     sets.midcast.Utsusemi = sets.midcast.FastRecast

     --------------------------------------------------------------------------------------------------------------------------
	 --             RANGED                --
     --------------------------------------------------------------------------------------------------------------------------

     -- Ranged for Crossbow or Bow, if you made either Exalted Crossbow or Kaja/Ullr. Remove -- if you are going to use.
     
     -- sets.precast.RA = {}
     -- sets.midcast.RA = {}

     --------------------------------------------------------------------------------------------------------------------------
	 --             WEAPONSKILLS              --
     --------------------------------------------------------------------------------------------------------------------------

    --This is a default set for any non-named specific weaponskills.

    sets.precast.WS = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','STR+12','Accuracy+10',}},
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS.Acc = {}

    sets.Obi = {waist="Hachirin-no-Obi"}
    gear.default.obi_waist = "Eschan Stone"

      -- GREATAXE WEAPONSKILLS
     ------------------------------------------------------------------------------------------------------------------------
    
     -- STR 50% & VIT 50% - Magic Acc needed to land additional effect
    sets.precast.WS['Full Break'] = {ammo="Pemphredo Tathlum",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Digni. Earring",
        left_ring="Flamma Ring",
        right_ring="Etana Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS['Full Break'].Acc = {ammo="Pemphredo Tathlum",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Gwati Earring",
        right_ear="Digni. Earring",
        left_ring="Flamma Ring",
        right_ring="Etana Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},}

    -- STR 60% & VIT 60% - Damage varies with TP - 1.5, 2.5, 4.0
    sets.precast.WS['Steel Cyclone'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Steel Cyclone'].Acc = {}

    -- STR 80% - Chance of Crit varies with TP - 20%, 35%, 55%
    -- While Crit Chance sounds like a nice way to go, it is best to stick with modifiers and multi-attack
    sets.precast.WS['Ukko\'s Fury'] = {ammo="Knobkierrie",
        head="Boii Mask +1",
        body="Hjarrandi Breast.",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Boii Calligae +1",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Ukko\'s Fury'].Acc = {}
        
    -- VIT 73~85% - Damage varies with TP - 1.0, 3.5, 6.5
    sets.precast.WS['Upheaval'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Upheaval'].Acc = {}

    -- STR 80% - Lowers def 20sec, 40sec, 60sec - THIS IS A 1 HIT WeaponSkill
    sets.precast.WS['Metatron Torment'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Metatron Torment'].Acc = {}

    -- STR 50% - Damage varies with TP - 1.0, 3.0, 5.0
    sets.precast.WS['King\'s Justice'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['King\'s Justice'].Acc = {}

	  -- AXE WEAPONSKILLS
	 ------------------------------------------------------------------------------------------------------------------------

    -- STR 40% & MND 40% - Damage Varies with TP - 3.75, 6.70, 8.5 - Magic Attack Bonus & Weaponskill Dmg 
    sets.precast.WS['Cloudsplitter'] = {ammo="Pemphredo Tathlum",
        head={ name="Odyssean Helm", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Dbl.Atk."+1','STR+4','Mag. Acc.+10','"Mag.Atk.Bns."+12',}},
        body={ name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+15','CHR+7','Phalanx +2','Accuracy+13 Attack+13','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
        hands={ name="Odyssean Gauntlets", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +1%','AGI+2','Mag. Acc.+5','"Mag.Atk.Bns."+5',}},
        legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+23','"Dbl.Atk."+2','DEX+8','Mag. Acc.+13',}},
        feet={ name="Odyssean Greaves", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','MND+8','Mag. Acc.+14','"Mag.Atk.Bns."+11',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Friomisi Earring",
        left_ring="Flamma Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS['Cloudsplitter'].Acc = {}

    -- STR 73~85% - Accuracy varies with TP - Currently Unknown value - fTP transfers across all hits.
    sets.precast.WS['Ruinator'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS['Ruinator'].Acc = {}

    -- STR 50% & VIT 50% - Damage varies with TP - 2.5, 6.5, 10.375 - Build like Savage Blade
    sets.precast.WS['Calamity'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}
    
    sets.precast.WS['Calamity'].Acc = {}

    sets.precast.WS['Calamity'].Fencer = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    -- STR 50% - Damage varies with TP - 4.0, 10.5, 13.625 - Build like Savage Blade
    sets.precast.WS['Mistral Axe'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Mistral Axe'].Acc = {}

    sets.precast.WS['Mistral Axe'].Fencer = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    -- STR 50% - Accuracy varies with TP - Currently unknown values - fTP transfers cross all hits
    sets.precast.WS['Decimation'] = {ammo="Knobkierrie",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Flam. Gambieras +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Fotia Belt",
        left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Decimation'].Acc = {}

      -- GREATSWORD WEAPONSKILLS
    ------------------------------------------------------------------------------------------------------------------------
    
    -- STR 73~85% - Damage Varies with TP - .72, 1.5, 2.25 - fTP transfers across all hits.
    sets.precast.WS['Resolution'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Resolution'].Acc = {}

    -- STR 50% & INT 50% - Damage varies with TP - 1.5, 1.75, 3.0
    sets.precast.WS['Ground Strike'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Ground Strike'].Acc = {}

      -- SWORD WEAPONSKILLS
	------------------------------------------------------------------------------------------------------------------------
    
	-- STR 50% & MND 50% - Damage varies with TP - 4.0, 10.25, 13.75
    sets.precast.WS['Savage Blade'] = {ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Sulev. Leggings +2",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Savage Blade'].Acc = {}

    -- MND 73~85% - Attack Power varies with TP - -20%, -10%, -0% - Will want to use attack bonus as non-elemental dmg
    sets.precast.WS['Requiescat'] = {}
    sets.precast.WS['Requiescat'].Acc = {}

    -- MND 50% & STR 30% - Elemental Damage WS Darkness - Amount Drained varies with TP - 50%, 100%, 160%
    sets.precast.WS['Sanguine Blade'] = {}
    sets.precast.WS['Sanguine Blade'].Acc = {}

      -- STAFF WEAPONSKILLS
    ------------------------------------------------------------------------------------------------------------------------
    
    -- MND 50% & STR 30% - Damage varies with TP - 2.0, 2.5, 3.0
    sets.precast.WS['Retribution'] = {}
    sets.precast.WS['Retribution'].Acc = {}

    -- Your INT vs Mobs Mind - Elemental Damage WS Darkness - Damage Varies with TP - 2.75, 4.0, 5.0
    sets.precast.WS['Cataclysm'] = {}
    sets.precast.WS['Cataclysm'].Acc = {}

    -- INT 73-85% - Decreases magic def - 120sec
    sets.precast.WS['Shattersoul'] = {}
    sets.precast.WS['Shattersoul'].Acc = {}

    -- STR 50% - Damage varies with TP - 1.0, 3.0, 5.0
    sets.precast.WS['Full Swing'] = {}
    sets.precast.WS['Full Swing'].Acc = {}

    -- POLEARM WEAPONSKILLS
    ------------------------------------------------------------------------------------------------------------------------
    
    -- STR 100% - Damage varies with TP - 1.0, 3.0, 5.5
    sets.precast.WS['Impulse Drive'] = {}
    sets.precast.WS['Impulse Drive'].Acc = {}

    -- STR 40% & DEX 40% - Damage varies with TP - 3.0, 3.7, 4.5
    sets.precast.WS['Sonic Thrust'] = {}
    sets.precast.WS['Sonic Thrust'].Acc = {}

    -- STR 73~85% - Damage varies with TP - .75, 1.25, 1.75 - fTP transfers across all hits.
    sets.precast.WS['Stardiver'] = {}
    sets.precast.WS['Stardiver'].Acc = {}

      -- HAND-TO-HAND WEAPONSKILLS
    ------------------------------------------------------------------------------------------------------------------------
    
    -- STR 30% & DEX 30% - Damage varies with TP - .975, 2.25, 3.75 - Must be /MNK to obtain this WS
    sets.precast.WS['Ragist Fists'] = {}
    sets.precast.WS['Ragist Fists'].Acc = {}

    -- STR 15% & VIT 15% - Accuracy varies with TP - Currently unknown values
    sets.precast.WS['Asuran Fists'] = {}
    sets.precast.WS['Asuran Fists'].Acc = {}

      -- CLUB WEAPONSKILLS
    ------------------------------------------------------------------------------------------------------------------------

    -- STR 50% & MND 50% - Damage varies with TP - 3.5, 8.75, 12.0 - Build like Savage Blade
    sets.precast.WS['Judgement'] = {}
    sets.precast.WS['Judgement'].Acc = {}

    sets.precast.WS['Judgement'].Fencer = {}

    -- STR 30% & MND 30% - Critical hit chance varies with TP - +10%, ?, 25% - fTP transfers across all hits. - Only gain access w/ Berilliyum Mace
    sets.precast.WS['Hexa Strike'] = {}
    sets.precast.WS['Hexa Strike'].Acc = {}

    -- MND 70% & STR 30% - Damage varies with TP - 3.0, 7.25, 9.75
    sets.precast.WS['Black Halo'] = {}
    sets.precast.WS['Black Halo'].Acc = {}

    sets.precast.WS['Black Halo'].Fencer = {}

    -- STR 50% & MND 50% - Elemental Damage WS Light - Additional Effect: Flash - Current unknown values
    sets.precast.WS['Flash Nova'] = {}
    sets.precast.WS['Flash Nova'].Acc = {}

    -- MND 73~85% - Accuracy varies with TP - Current unknown values - fTP transfers across all hits. - Unlocked w/ Merits
    sets.precast.WS['Realmrazer'] = {}
    sets.precast.WS['Realmrazer'].Acc = {}

      -- DAGGER WEAPONSKILLS
    ------------------------------------------------------------------------------------------------------------------------

    -- DEX 50% - Critical hit rate varies with TP - Current unknown values - fTP transfers across all hits.
    sets.precast.WS['Evisceration'] = {}
    sets.precast.WS['Evisceration'].Acc = {}

    -- DEX 40% & INT 40% - Elemental Damage WS Wind - Damage varies with TP - 2.0, 3.0, 4.5 - Need to be sub NIN, DNC, OR THF to aquire
    sets.precast.WS['Aeolian Edge'] = {}
    sets.precast.WS['Aeolian Edge'].Acc = {}

    -- AGI 73~85% - Decreases Target's Accuracy - 90sec, 135sec, & 180sec - fTP transfers across all hits.
    sets.precast.WS['Excenterator'] = {}
    sets.precast.WS['Excenterator'].Acc = {}

      -- RANGED WEAPONSKILLS - REMOVE -- IN FRONT OF THE SETS.PRECAST IF GOING TO USE
    ------------------------------------------------------------------------------------------------------------------------

    -- AGI 70% - Chance of critical varies with TP - Current unknown values - Obtained through Exalted Crossbow
    -- sets.precast.WS['Heavy Shot'] = {}
    -- sets.precast.WS['Heavy Shot'].Acc = {}

    -- AGI 50% & 20% STR - Damage Varies with TP - 1.5, 2.5, 5.0 - Obatined through Ambuscade Kaja Bow or Ullr
    -- sets.precast.WS['Empyreal Arrow'] = {}
    -- sets.precast.WS['Empyreal Arrow'].Acc = {}


     --------------------------------------------------------------------------------------------------------------------------
	 --             ENGAGED SETS              --
     --------------------------------------------------------------------------------------------------------------------------
    
     --- Non-defined is equipped i.e Used for GreatAxe--- --Current set is a 5-Hit w/ /SAM Delay of 467+, 6-hit for less than that
    sets.engaged = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Flam. Manopolas +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},} 
    
    sets.engaged.Acc = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Flam. Manopolas +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head="Volte Salade",
        body="Volte Haubert",
        hands="Volte Moufles",
        legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet="Sulev. Leggings +2",
        neck="Loricate Torque +1",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Odnowa Earring +1",
        right_ear="Odnowa Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.Acc.PDT = sets.engaged.PDT

    --- Fencer weapon/shield combo is equipped ---

    sets.engaged.Fencer = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Flam. Manopolas +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.Fencer.Acc = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.Fencer.PDT = {ammo="Staunch Tathlum",
        head="Volte Salade",
        body="Volte Haubert",
        hands={ name="Agoge Mufflers +3", augments={'Enhances "Mighty Strikes" effect',}},
        legs="Pumm. Cuisses +3",
        feet="Sulev. Leggings +2",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Odnowa Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.Fencer.Acc.PDT = sets.engaged.Fencer.PDT

    --- Dual Wield weapons are equipped ---
    -- /nin gives T3, /dnc gives T2 ("()" will be DW w/ Haste Samaba), /thf gives 0

    ---------- ZERO HASTE IS GIVEN - /NIN NEEDS 49 DW - /DNC NEEDS 59 (57) DW ----------

    sets.engaged.DW = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    
    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    
    sets.engaged.DW.PDT = {ammo="Staunch Tathlum",
        head="Volte Salade",
        body="Volte Haubert",
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Loricate Torque +1",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    sets.engaged.DW.Acc.PDT = sets.engaged.DW.PDT

    ---------- 15% HASTE IS GIVEN - /NIN NEEDS 42 DW - /DNC NEEDS 52 (45) DW ----------

    sets.engaged.DW.Haste_15 = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Acc.Haste_15 = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Haste_15.PDT = {ammo="Staunch Tathlum",
        head="Volte Salade",
        body="Volte Haubert",
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Loricate Torque +1",
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Acc.Haste_15.PDT = sets.engaged.DW.Haste_15.PDT

    ---------- 30% HASTE IS GIVEN - /NIN NEEDS 31 DW - /DNC NEEDS 41 (35) DW ----------

    sets.engaged.DW.Haste_30 = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Acc.Haste_30 = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Haste_30.PDT = sets.engaged.DW.Haste_15.PDT
    sets.engaged.DW.Acc.Haste_30.PDT = sets.engaged.DW.Haste_15.PDT

    ---------- 35% HASTE IS GIVEN - /NIN NEEDS 28 DW - /DNC NEEDS 38 (32) DW ----------

    sets.engaged.DW.Haste_35 = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Acc.Haste_35 = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Suppanomimi",
        right_ear="Digni. Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Haste_35.PDT = sets.engaged.DW.Haste_15.PDT
    sets.engaged.DW.Acc.Haste_35.PDT = sets.engaged.DW.Haste_15.PDT

    ---------- MAX HASTE IS GIVEN - /NIN NEEDS 11 DW - /DNC NEEDS 21 (9) DW ----------

    sets.engaged.DW.MaxHaste = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Flam. Manopolas +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.Acc.MaxHaste = {ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
        hands="Flam. Manopolas +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist="Ioskeha Belt",
        left_ear="Telos Earring",
        right_ear="Eabani Earring",
        left_ring="Flamma Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DW.MaxHaste.PDT = {ammo="Staunch Tathlum",
        head="Volte Salade",
        body="Volte Haubert",
        hands="Volte Moufles",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    sets.engaged.DW.Acc.MaxHaste.PDT = sets.engaged.DW.Haste_15.PDT

    -------------------------------------------------------------------------------------------------------------------------------
        --- ENGAGED SETS DEALING WITH AFTERMATH REMAS ---
    -------------------------------------------------------------------------------------------------------------------------------
        
    sets.engaged.Conqueror = {}

    sets.engaged.Ukon = {ammo="Ginsen",
        head="Hjarrandi Helm",
        body="Hjarrandi Breast.",
        hands="Flam. Manopolas +2",
        legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        feet="Boii Calligae +1",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Petrov Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    -- This is specifically in PDT Hybrid Mode
    sets.engaged.PDT.Bravura = {ammo="Staunch Tathlum",
        head="Volte Salade",
        body="Volte Haubert",
        hands="Volte Moufles",
        legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet="Pumm. Calligae +3",
        neck={ name="Warrior's Beads", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.Fencer.Farsha = {}

    sets.engaged.DW.Farsha = {}

    sets.engaged.DW.Farsha_15 = {}

    sets.engaged.DW.Farsha_30 = {}

    sets.engaged.DW.Farsha_35 = {}

    sets.engaged.DW.Farsha_Max = {}
 
    --------------------------------------------------------------------------------------------------------------------------
	   --             IDLE SETS              --
    --------------------------------------------------------------------------------------------------------------------------
     
    sets.idle = {ammo="Staunch Tathlum",
        head={ name="Valorous Mask", augments={'Accuracy+21 Attack+21','Crit.hit rate+4','VIT+6','Accuracy+15','Attack+1',}},
        body="Makora Meikogai",
        hands="Volte Moufles",
        legs="Pumm. Cuisses +3",
        feet="Hermes' Sandals",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Karieyh Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}
     
    sets.idle.PDT = {ammo="Staunch Tathlum",
        head={ name="Valorous Mask", augments={'Accuracy+21 Attack+21','Crit.hit rate+4','VIT+6','Accuracy+15','Attack+1',}},
        body="Volte Haubert",
        hands="Volte Moufles",
        legs="Pumm. Cuisses +3",
        feet="Hermes' Sandals",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Odnowa Earring +1",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Moonbeam Ring",
        back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}},}
 
    sets.Kiting = {feet="Hermes' Sandals"}

    
end

--------------------------------------------------------------------------------------------------------------------------
--              RULES!!! NO TOUCHY                 --
--------------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

function job_post_precast(spell, action, spellMap, eventArgs)
     -- Equip obi if weather/day matches for WS.   
    if spell.type == 'WeaponSkill' then
        if (state.RangedMode == 'Acc' and RangedWeaponskills:contains(spell.english)) then
            equip(sets.precast.WS[spell.english].Acc)
        elseif (state.OffenseMode == 'Acc' and not RangedWeaponskills:contains(spell.english)) then
            equip(sets.precast.WS[spell.english].Acc)
        end
        if spell.english == 'Cloudsplitter' then
            if world.weather_element == 'Thunder' or world.day_element == 'Thunder' then
                equip(sets.Obi)
				eventArgs.handled = true
			end
		elseif spell.english == 'Sanguine Blade' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
				eventArgs.handled = true
            end
		elseif spell.english == 'Cataclysm' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
				eventArgs.handled = true
            end
        elseif spell.english == 'Flash Nova' then
            if world.weather_element == 'Light' or world.day_element == 'Light' then
                equip(sets.Obi)
                eventArgs.handled = true
            end
        elseif spell.english == 'Aeolian Edge' then
            if world.weather_element == 'Wind' or world.day_element == 'Wind' then
                equip(sets.Obi)
                eventArgs.handled = true
            end
		end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current
    msg = msg .. ', CombatWeapon: '..state.CombatWeapon.current

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

function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Defender' then
        handle_equipping_gear(player.status)
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if state.CombatWeapon.value ~= 'DW' then
        update_melee_groups()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    elseif state.CombatWeapon.value == 'DW' then
        if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
            determine_haste_group()
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        elseif buff == 'Aftermath: Lv.3' then
            determine_haste_group()
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end

function update_melee_groups()

    if player then
        classes.CustomMeleeGroups:clear()

        if buffactive['Aftermath'] then
            if player.equipment.main == "Bravura" then
                classes.CustomMeleeGroups:append('Bravura')
            end
        elseif buffactive['Aftermath: Lv.3'] then
            if player.equipment.main == "Conqueror" then
                classes.CustomMeleeGroups:append('Conqueror')
            elseif player.equipment.main == "Ukonvasara" then
                classes.CustomMeleeGroups:append('Ukon')
            elseif player.equipment.main == "Farsha" then
                classes.CustomMeleeGroups:append('Farsha')
            end
        end
    end
    return meleeSet
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) is 14.65% (15%)
    -- Haste II (white magic) is 29.98% (30%)
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Honor March is now considered in 'Hi'
    -- Honor March +0/+1/+2/+3/+4            ||  12.30% /13.48% / 14.65% / 15.82% / 16.99%
    -- Victory March +0/+3/+4/+5/+6/+7/+8    ||  15.92% /17.48% / 19.04% / 20.61% / 22.27% / 23.83% / 25.39% / 27.05% / 28.61%
    -- Advancing March +0/+3/+4/+5/+6/+7/+8  ||  10.55% /11.52% / 12.60% / 13.67% / 14.75% / 15.82% / 16.60% / 17.87% / 18.95%
    -- Embrava 30% with 500 enhancing skill
    -- buffactive[580] = geo haste - 30% (does not assume idris since it will not cap on its own w/o rare circumstance i.e /dnc)
    -- buffactive[33] = regular haste - 15%
    -- buffactive[604] = mighty guard - 15%
    -- state.HasteMode = toggle for when you know Haste II is being cast on you as well as 2hr buffs like SV and Bolster
    -- Hi = Haste II and/or H.M. is being cast. This is clunky to use when both haste II and haste I are being cast (default to Hi)
  
    if state.CombatWeapon.value == 'DW' then
        if player.equipment.main == "Farsha" and buffactive['Aftermath: Lv.3'] then
                if state.HasteMode.value == 'Hi' then
                    if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
                         ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
                         ( buffactive.march == 2 and buffactive[604] ) ) then
                        add_to_chat(8, '-------------Aftermath - Max-Haste Mode Enabled--------------')
                        classes.CustomMeleeGroups:append('Farsha_Max')
                    elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
                        add_to_chat(8, '-------------Aftermath - Haste 35%-------------')
                        classes.CustomMeleeGroups:append('Farsha_35')
                    elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                             ( buffactive.march == 1 and buffactive[604] ) ) then
                        add_to_chat(8, '-------------Aftermath - Haste 30%-------------')
                        classes.CustomMeleeGroups:append('Farsha_30')
                    elseif ( buffactive.march == 1 or buffactive[604] ) then
                        add_to_chat(8, '-------------AFtermath - Haste 15%-------------')
                        classes.CustomMeleeGroups:append('Farsha_15')
                    end
                else
                    if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
                       ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
                       ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
                       ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
                        add_to_chat(8, '-------------Aftermath - Max Haste Mode Enabled--------------')
                        classes.CustomMeleeGroups:append('Farsha_Max')
                    elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
                           ( buffactive.march == 2 and buffactive['haste samba'] ) or
                           ( buffactive[580] and buffactive['haste samba'] ) then 
                        add_to_chat(8, '-------------Aftermath - Haste 35%-------------')
                        classes.CustomMeleeGroups:append('Farsha_35')
                    elseif ( buffactive.march == 2 ) or -- two marches from ghorn
                           ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
                           ( buffactive[580] ) or  -- geo haste
                           ( buffactive[33] and buffactive[604] ) then  -- haste with MG
                        add_to_chat(8, '-------------Aftermath - Haste 30%-------------')
                        classes.CustomMeleeGroups:append('Farsha_30')
                    elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
                        add_to_chat(8, '-------------Aftermath - Haste 15%-------------')
                        classes.CustomMeleeGroups:append('Farsha_15')
                    end
                end
        elseif not buffactive['Aftermath: Lv.3'] or player.equipment.main ~= "Farsha" then
            if state.HasteMode.value == 'Hi' then
                if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
                     ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
                     ( buffactive.march == 2 and buffactive[604] ) ) then
                    add_to_chat(8, '------------- Max-Haste Mode Enabled--------------')
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
    end
    if state.CombatWeapon.value ~= 'DW' then
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
    update_melee_groups()
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet) 
    if state.CombatWeapon == 'Fencer' and state.HybridMode == 'PDT' then
        if state.Buff['Defender'] then
        	meleeSet = set_combine(meleeSet, sets.buff['Defender'])
        end
    end

    return meleeSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function select_default_macro_book()
    -- Default macro set/book
set_macro_page(1, 1)
end
