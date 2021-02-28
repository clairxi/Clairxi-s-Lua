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
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar", "Chimera Ripper", "String Clipper", "Cannibal Blade", "Bone Crusher", "String Shredder", "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
     
 
    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
end

---- I know it's Tempting, but DO NOT REMOVE THE TIMERS BELOW ------
--Various timers
Flashbulb_Timer = 45
Strobe_Timer = 30
Strobe_Recast = 0
Flashbulb_Recast = 0
Flashbulb_Time = 0
Strobe_Time = 0

--Seeds the time used to calculate various functions per second
time_start = os.time()
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.IdleMode:options('Normal', 'PDT', 'MP')
    
    state.PetMode = M{['description']='Pet Mode'}
    state.PetMode:options('Normal', 'PetPDT', 'Ranged', 'Heal')
     
    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }
 
    -- update_pet_mode()
    select_default_macro_book()
end
 
 
-- Define sets used by this job file.
function init_gear_sets()

    ---------------------------------------------------------------------------------------------------------------------
    --                                        Job Abillity Equipment                                                   --   
    ---------------------------------------------------------------------------------------------------------------------

    -- Your Auto starts off with Burden, to help reduce the burden equip Overload - gear. Don't forget ambu cape for Lvl+1
    sets.precast.JA['Activate'] = {body="Kara. Farsetto +1",
        hands="Foire Dastanas +2",
        neck="Buffoon's Collar",
        right_ear="Burana Earring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Haste+10','Pet: Damage taken -5%',}},}
    sets.precast.JA['Deus Ex Automata'] = sets.precast.JA['Activate']

    -- Equip Repair + equipment and Pet HP+ to help increase
    sets.precast.JA['Maintenance'] = {legs={ name="Desultor Tassets", augments={'"Repair" potency +10%','"Waltz" TP cost -5',}},
    	feet="Foire Babouches +2",
	    left_ear="Pratik Earring",
	    right_ear="Guignol Earring",}
	sets.precast.JA['Repair'] = sets.precast.JA['Maintenance']

    sets.precast.JA['Overdrive'] = {body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},}
    sets.precast.JA['Role Reversal'] = {feet={ name="Pitre Babouches +3", augments={'Enhances "Role Reversal" effect',}},}
    sets.precast.JA['Tactical Switch'] = {'feet="Karagoz Scarpe +1'}
    sets.precast.JA['Ventriloquy'] = {legs={ name="Pitre Churidars +3", augments={'Enhances "Ventriloquy" effect',}},}

    -- Put on Overload - Equipment
    sets.precast.JA.Maneuver = {main={ name="Midnights", augments={'Pet: Attack+25','Pet: Accuracy+25','Pet: Damage taken -3%',}},
	    body="Kara. Farsetto +1",
	    hands="Foire Dastanas +2",
	    neck="Buffoon's Collar",
	    right_ear="Burana Earring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    sets.precast.Waltz = {body="Passion Jacket",}

    ---------------------------------------------------------------------------------------------------------------------
    --                                      Magic Abillity Equipment                                                   --   
    ---------------------------------------------------------------------------------------------------------------------     

    -- 80% Fast Cast unless /rdm then 65% Fast Cast. 10% Quick Magic
    sets.precast.FC = {head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','STR+10','Mag. Acc.+11',}},
	    body="Zendik Robe",
	    legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
	    feet="Regal Pumps +1",
	    neck="Voltsurge Torque",
	    left_ear="Loquac. Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Prolix Ring",
	    right_ring="Weather. Ring",
	    back={ name="Visucius's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},}

	-- 50% Cure potency
    sets.midcast['Cure'] = {body="Nefer Kalasiris",
	    legs="Gyve Trousers",
	    waist="Pythia Sash +1",
	    right_ear="Mendicant's Earring",
	    back="Solemnity Cape",}
    
    sets.midcast['Cure II'] = sets.midcast['Cure']
    sets.midcast['Cure III'] = sets.midcast['Cure']
    sets.midcast['Cure IV'] = sets.midcast['Cure']
    sets.midcast['Curaga'] = sets.midcast['Cure IV']
    sets.midcast['Curaga II'] = sets.midcast['Cure IV']
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"}) 

    sets.midcast['Refresh'] = {}

    ---------------------------------------------------------------------------------------------------------------------
    --                                        Pet Abillity Equipment                                                   --   
    ---------------------------------------------------------------------------------------------------------------------

    sets.midcast.Pet['Cure'] = {legs="Foire Churidars +2",
    	waist="Ukko Sash",}
 
    sets.midcast.Pet['Elemental Magic'] = {head={ name="Rawhide Mask", augments={'Attack+15','Pet: Mag. Acc.+20','Pet: "Mag.Atk.Bns."+15',}},
	    body="Tali'ah Manteel +2",
	    hands="Tali'ah Gages +2",
	    legs={ name="Pitre Churidars +3", augments={'Enhances "Ventriloquy" effect',}},
	    feet={ name="Pitre Babouches +3", augments={'Enhances "Role Reversal" effect',}},
	    neck={ name="Pup. Collar", augments={'Path: A',}},
	    waist="Ukko Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",}
 
    sets.midcast.Pet['Enfeebling Magic'] ={head="Tali'ah Turban +2",
	    body="Tali'ah Manteel +2",
	    hands="Tali'ah Gages +2",
	    legs={ name="Pitre Churidars +3", augments={'Enhances "Ventriloquy" effect',}},
	    feet={ name="Pitre Babouches +3", augments={'Enhances "Role Reversal" effect',}},
	    neck="Adad Amulet",
	    waist="Ukko Sash",
	    left_ear="Enmerkar Earring",
	    left_ring="C. Palug Ring",}

    sets.midcast.Pet['Dark Magic'] = sets.midcast.Pet['Enfeebling Magic']
    sets.midcast.Pet['Divine Magic'] = sets.midcast.Pet['Enfeebling Magic']
    sets.midcast.Pet['Enhancing Magic'] = sets.midcast.Pet['Enfeebling Magic']

    -- This set is specifically for Strobe & Flashbulb
    sets.Enmity = {left_ear="Domes. Earring",
    	right_ear="Rimeice Earring",}

    ---------------------------------------------------------------------------------------------------------------------
    --                                    Pet Weaponskills Equipment                                                   --   
    ---------------------------------------------------------------------------------------------------------------------

    sets.midcast.Pet.Weaponskill = {head="Karagoz Capello +1",
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands="Karagoz Guanti +1",
	    legs="Kara. Pantaloni +1",
	    feet={ name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}},
	    neck={ name="Pup. Collar", augments={'Path: A',}},
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

	-- 50% VIT - Critical hit rate varies w/ TP
    sets.midcast.Pet.Weaponskill['String Shredder'] = {head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck="Shulmanu Collar",
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    -- 60% VIT - This has additional effect stun, may want magic acc to help with the stun effect
    sets.midcast.Pet.Weaponskill['Bone Crusher'] = {head="Tali'ah Turban +2",
	    body="Tali'ah Manteel +2",
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck="Adad Amulet",
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}
    
    -- 50% DEX - Provides Defense Down, may want magic acc to help it land. TP Bonus to help with duration.
    sets.midcast.Pet.Weaponskill['Armor Shatterer'] = {head="Tali'ah Turban +2",
	    body="Tali'ah Manteel +2",
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck="Adad Amulet",
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    -- 60% DEX - TP Bonus WS - Damage Varies with TP
    sets.midcast.Pet.Weaponskill['Arcuballista'] = {head="Karagoz Capello +1",
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck={ name="Pup. Collar", augments={'Path: A',}},
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

	-- 60% DEX - TP Bonus - Magic Accuracy to help with Additional Effect Stun
    sets.midcast.Pet.Weaponskill['Daze'] = sets.midcast.Pet.Weaponskill['Arcuballista']

    -- 50% STR - TP Bonus
    sets.midcast.Pet.Weaponskill['Chimera Ripper'] = {head="Karagoz Capello +1",
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands="Karagoz Guanti +1",
	    legs="Kara. Pantaloni +1",
	    feet={ name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}},
	    neck={ name="Pup. Collar", augments={'Path: A',}},
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}
 
    ---------------------------------------------------------------------------------------------------------------------
    --                                      Master Weaponskills Equipment                                              --   
    ---------------------------------------------------------------------------------------------------------------------

    sets.precast.WS = {}

    -- 15% STR / 15% VIT - Accuracy varies with TP.
    sets.precast.WS['Asuran Fists'] = sets.precast.WS['Stringing Pummel']

    -- 50% VIT / 20% VIT - Damage varies with TP
    sets.precast.WS['Howling Fist'] = {}

    -- 30% STR / 30% DEX - Damage varies with TP
    sets.precast.WS['Raging Fists'] = {}

    -- 73-85 DEX (Based on # of merits) - Chance of Plague varies w/ TP
    sets.precast.WS['Shijin Spiral'] = {}

    -- 32% STR / 32% VIT - Chance of Critical varies w/ TP (This is the Mythic Weaponskill)
    sets.precast.WS['Stringing Pummel'] = {}
 
 	-- 80% STR - Chance of critical varies w/ TP (This is the Empyrean Weaponskill)
    sets.precast.WS['Victory Smite'] = {head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
        body="Abnoba Kaftan",
        hands={ name="Pitre Dastanas +3", augments={'Enhances "Fine-Tuning" effect',}},
        legs="Hiza. Hizayoroi +2",
        feet={ name="Herculean Boots", augments={'Accuracy+8 Attack+8','"Triple Atk."+4','Quadruple Attack +1','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}},}
              
    ---------------------------------------------------------------------------------------------------------------------
    --                     Attacking! With and Without your Pupppet Active                                            --   
    ---------------------------------------------------------------------------------------------------------------------

    sets.engaged = {head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands={ name="Pitre Dastanas +3", augments={'Enhances "Fine-Tuning" effect',}},
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck="Shulmanu Collar",
	    waist="Moonbow Belt",
	    left_ear="Enmerkar Earring",
	    right_ear="Mache Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    sets.engaged.Acc = {head="Tali'ah Turban +2",
	    body="Tali'ah Manteel +2",
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck="Shulmanu Collar",
	    waist="Moonbow Belt",
	    left_ear="Enmerkar Earring",
	    right_ear="Mache Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    sets.engaged.PDT = {head={ name="Rao Kabuto", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	    body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
	    hands="Kurys Gloves",
	    legs="Tali'ah Sera. +2",
	    feet="Ahosi Leggings",
	    neck="Adad Amulet",
	    waist="Moonbow Belt",
	    left_ear="Enmerkar Earring",
	    right_ear="Sanare Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Defending Ring",
	    back="Moonbeam Cape",}

    sets.engaged.Acc.PDT = sets.engaged.PDT

    ---------------------------------------------------------------------------------------------------------------------
    --                                     Just Chilling w/ Myself                                                     --   
    ---------------------------------------------------------------------------------------------------------------------
    
    sets.idle = {main="Denouements",
	    head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
	    body="Hiza. Haramaki +2",
	    hands={ name="Herculean Gloves", augments={'STR+5','DEX+10','"Refresh"+1','Accuracy+13 Attack+13',}},
	    legs="Assid. Pants +1",
	    feet={ name="Rao Sune-Ate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	    neck="Loricate Torque +1",
	    waist="Moonbow Belt",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Defending Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    sets.idle.PDT = {}

    sets.idle.MP = {main="Denouements",
	    head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
	    body="Hiza. Haramaki +2",
	    hands={ name="Herculean Gloves", augments={'STR+5','DEX+10','"Refresh"+1','Accuracy+13 Attack+13',}},
	    legs="Assid. Pants +1",
	    feet={ name="Rao Sune-Ate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	    neck="Loricate Torque +1",
	    waist="Moonbow Belt",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Defending Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    ---------------------------------------------------------------------------------------------------------------------
    --                                     Just Chilling w/ Myself & I                                                 --   
    ---------------------------------------------------------------------------------------------------------------------

    sets.idle.Pet = {head={ name="Pitre Taj +1", augments={'Enhances "Optimization" effect',}},
        body="Hiza. Haramaki +2",
        hands="Kurys Gloves",
        legs="Tali'ah Sera. +2",
        feet={ name="Rao Sune-Ate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
        neck="Empath Necklace",
        waist="Fotia Belt",
        left_ear="Enmerkar Earring",
        right_ear="Burana Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    ---------------------------------------------------------------------------------------------------------------------
    --                          Attack Mode for Puppet while you stand idly by                                         --   
    ---------------------------------------------------------------------------------------------------------------------

    -- You have to manually toggle through these to determine which PetMode you want to be in.

    sets.idle.Pet.Engaged = {main={ name="Midnights", augments={'Pet: Attack+25','Pet: Accuracy+25','Pet: Damage taken -3%',}},
	    head="Tali'ah Turban +2",
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck="Shulmanu Collar",
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10','Pet: Damage taken -5%',}},}
 
    sets.idle.Pet.Engaged.PetPDT = {main={ name="Midnights", augments={'Pet: Attack+25','Pet: Accuracy+25','Pet: Damage taken -3%',}},
	    head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Accuracy+3','Pet: Haste+5',}},
	    body={ name="Rao Togi", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	    hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
	    legs="Tali'ah Sera. +2",
	    feet={ name="Rao Sune-Ate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	    neck="Shulmanu Collar",
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Handler's Earring +1",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10','Pet: Damage taken -5%',}},}
         
    sets.idle.Pet.Engaged.Ranged = {main={ name="Condemners", augments={'Pet: Damage taken -2%','Pet: Accuracy+22 Pet: Rng. Acc.+22',}},
	    head="Tali'ah Turban +2",
	    body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	    hands="Tali'ah Gages +2",
	    legs="Tali'ah Sera. +2",
	    feet="Tali'ah Crackows +2",
	    neck={ name="Pup. Collar", augments={'Path: A',}},
	    waist="Incarnation Sash",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}

    sets.idle.Pet.Engaged.Heal = {main="Denouements",
	    head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
	    body={ name="Herculean Vest", augments={'INT+14','Rng.Atk.+28','"Refresh"+1',}},
	    hands={ name="Herculean Gloves", augments={'STR+5','DEX+10','"Refresh"+1','Accuracy+13 Attack+13',}},
	    legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
	    feet="Tali'ah Crackows +2",
	    neck="Empath Necklace",
	    waist="Isa Belt",
	    left_ear="Enmerkar Earring",
	    right_ear="Burana Earring",
	    left_ring="C. Palug Ring",
	    right_ring="Varar Ring",
	    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},}
 
    sets.Kiting = {feet="Hermes' Sandals"}
      
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

windower.register_event(
    "incoming text",
    function(original, modified, mode)

        -- Checking timer for enmity sets
        if buffactive["Fire Maneuver"] then
            if original:contains(pet.name) and original:contains("Provoke") then
                Strobe_Time = os.time()
                Strobe_Recast = Strobe_Timer
                handle_equipping_gear(player.status, pet.status)
            end
        end

        if buffactive["Light Maneuver"] then
            if original:contains(pet.name) and original:contains("Flashbulb") then
                Flashbulb_Time = os.time()
                Flashbulb_Recast = Flashbulb_Timer
                handle_equipping_gear(player.status, pet.status)
            end
        end

        return modified, mode
    end
)

function updatePetSkills()
    if not pet.isvalid then
        return 
    end

    --Researching a better way to do this section for now we are doing this old way with concating the different sections
    local pet_skills = ''

    -- Strobe recast   
	    if Strobe_Recast == 0 and (pet.attachments.strobe or pet.attachments["strobe II"]) then
	        if buffactive["Fire Maneuver"] then
	            pet_skills = pet_skills .. "\\cs(125, 125, 125)-\\cr \\cs(125,0,0)Strobe\\cr \n"
	        else
	            pet_skills = pet_skills .. "\\cs(125, 125, 125)- Strobe\\cr \n"
	        end
	    elseif pet.attachments.strobe or pet.attachments["strobe II"] then
	        pet_skills = pet_skills .. "\\cs(125, 125, 125)- Strobe (" .. Strobe_Recast .. ")\\cr \n"
	    end

	    -- Flashbulb recast
	    if Flashbulb_Recast == 0 and pet.attachments.flashbulb then
	        if buffactive["Light Maneuver"] then
	            pet_skills = pet_skills .. "\\cs(125, 125, 125)-\\cr \\cs(255,255,255)Flashbulb\\cr \n"
	        else
	            pet_skills = pet_skills .. "\\cs(125, 125, 125)- Flashbulb\\cr \n"
	        end
	    elseif pet.attachments.flashbulb ~= nil then
	        pet_skills = pet_skills .. "\\cs(125, 125, 125)- Flashbulb (" .. Flashbulb_Recast .. ")\\cr \n"
	    end

	    if not pet.attachments.strobe and not pet.attachments["strobe II"] and not pet.attachments.flashbulb then
	        pet_skills = pet_skills .. "\\cs(125, 125, 125)-No Skills To Track\\cr \n"
	    end
	end

windower.register_event(
    "prerender",
    function()
    if os.time() > time_start then
            time_start = os.time()

    if buffactive["Fire Maneuver"] and (pet.attachments["Strobe"] or pet.attachments["Strobe II"]) then
            if Strobe_Recast <= 2 then
                equip(sets.Enmity)
            end
        end

        if buffactive["Light Maneuver"] and pet.attachments["Flashbulb"] == true then
            if Flashbulb_Recast <= 2 then
                equip(sets.Enmity)
            end
        end
    if Strobe_Recast > 0 then
    	Strobe_Recast = Strobe_Timer - (os.time() - Strobe_Time)
	end

	if Flashbulb_Recast > 0 then
    	Flashbulb_Recast = Flashbulb_Timer - (os.time() - Flashbulb_Time)
	end

		    updatePetSkills()
		    
		end
	end
)

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    -- if newStatus == 'Engaged' then
    --     display_pet_status()
    -- end
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
    handle_equipping_gear(player.status, eventArgs)
    if pet.status =="Engaged" then
        if state.PetMode.value == 'Normal' then
             equip(sets.idle.Pet.Engaged)
             eventArgs.handled = false
        elseif state.PetMode.value == 'PetPDT' then
             equip(sets.idle.Pet.Engaged.PetPDT)
             eventArgs.handled = false
        elseif state.PetMode.value == 'Ranged' then
             equip(sets.idle.Pet.Engaged.Ranged)
             eventArgs.handled = false
        elseif state.PetMode.value == 'Heal' then
             equip(sets.idle.Pet.Engaged.Heal)
             eventArgs.handled = false
        end
    end
    return meleeSet
end
 
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return state.PetMode.value or 'None'
    else
        return 'None'
    end
end
 
-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    -- state.PetMode:set(get_pet_mode())
    update_custom_groups()
end
 
-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
        classes.CustomMeleeGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
         
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
         
        add_to_chat(122,petInfoString)
    end
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 8)
end