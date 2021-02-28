------------------------------------------------------------------------------------------------------------------
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
    state.Buff['Climactic Flourish'] = buffactive['Climactic Flourish'] or false
    state.Buff['Saber Dance'] = buffactive['Saber Dance'] or false
    state.Buff['Fan Dance'] = buffactive['Fan Dance'] or false

    state.SkillchainPending = M(false, 'Skillchain Pending')
    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'PDT')

    state.enmitymode = M{['description'] = 'Enmity Mode'}
    state.enmitymode:options('Minus', 'Plus')
 
    send_command('bind ^` gs c cycle enmitymode')

    select_default_macro_book()
    determine_haste_group()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.precast.JA['Trance'] = {head={ name="Horos Tiara +3", augments={'Enhances "Trance" effect',}},}
    sets.precast.JA['No Foot Rise'] = {body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    -- sets.buff['Saber Dance'] = {legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},}
    sets.buff['Climactic Flourish'] = {head="Maculele Tiara +1",}
    sets.buff['Fan Dance'] = {hands={ name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}},}

    -- Waltz set
    sets.precast.Waltz = {}

    sets.precast.Waltz.Minus = {ammo="Yamarang",
	    head={ name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','Evasion+10','"Store TP"+4',}},
	    body="Maxixi Casaque +3",
	    hands="Slither Gloves +1",
	    legs={ name="Desultor Tassets", augments={'"Waltz" TP cost -5','"Phantom Roll" ability delay -5',}},
	    feet="Maxixi Toeshoes +3",
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Flume Belt +1",
	    left_ear="Hearty Earring",
	    right_ear="Novia Earring",
	    left_ring="Kuchekula Ring",
	    right_ring="Asklepian Ring",
	    back="Solemnity Cape",}
    
    sets.precast.Waltz.Plus = {ammo="Yamarang",
        head={ name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','Evasion+10','"Store TP"+4',}},
        body="Maxixi Casaque +3",
        hands={ name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}},
        legs={ name="Desultor Tassets", augments={'"Waltz" TP cost -5','"Phantom Roll" ability delay -5',}},
        feet="Maxixi Toeshoes +3",
        neck="Unmoving Collar +1",
        waist="Flume Belt +1",
        left_ear="Cryptic Earring",
        right_ear="Roundel Earring",
        left_ring="Valseur's Ring",
        right_ring="Asklepian Ring",
        back={ name="Toetapper Mantle", augments={'"Store TP"+1','"Dual Wield"+3','"Rev. Flourish"+28',}},}


        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {head={ name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','Evasion+10','"Store TP"+4',}},
        body="Maxixi Casaque +3",
        legs={ name="Desultor Tassets", augments={'"Waltz" TP cost -5','"Phantom Roll" ability delay -5',}},}
    
    sets.precast.Samba = {head="Maxixi Tiara +3",
        back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},}

    sets.precast.Jig = {legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
    feet="Maxixi Toeshoes +3",}

    sets.precast.Step = {}

    sets.precast.Step['Quickstep'] = {ammo="C. Palug Stone",
	    head="Maxixi Tiara +3",
	    body="Maxixi Casaque +3",
	    hands="Maxixi Bangles +3",
	    legs="Maxixi Tights +3",
	    feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Kentarch Belt +1",
	    left_ear="Odr Earring",
	    right_ear="Telos Earring",
	    left_ring="Cacoethic Ring +1",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    sets.precast.Step['Box Step'] = sets.precast.Step['Quickstep']
    sets.precast.Step['Stutter Step'] = sets.precast.Step['Quickstep']
    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step['Quickstep'], {feet="Macu. Toeshoes +1",})

    sets.precast.Flourish1 = {}
    --- Requires MAGIC Accuracy to land Stun ability.
    sets.precast.Flourish1['Violent Flourish'] = {ammo="Yamarang",
        head="Mummu Bonnet +2",
        body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
        hands="Malignance Gloves",
        legs="Mummu Kecks +2",
        feet="Malignance Boots",
        neck={ name="Etoile Gorget +1", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Digni. Earring",
        right_ear="Gwati Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back={ name="Senuna's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    --- Requires PHYSICAL Accuracy to land Gravity Ability.
    sets.precast.Flourish1['Desperate Flourish'] = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body="Maxixi Casaque +3",
	    hands="Malignance Gloves",
	    legs="Maxixi Tights +3",
	    feet="Maxixi Toeshoes +3",
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Kentarch Belt +1",
	    left_ear="Odr Earring",
	    right_ear="Telos Earring",
	    left_ring="Cacoethic Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Macu. Bangles +1",
        back={ name="Toetapper Mantle", augments={'"Store TP"+1','"Dual Wield"+3','"Rev. Flourish"+28',}},}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1",}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1",}
    

    sets.precast.JA['Provoke'] = {ammo="Sapience Orb",
	    head={ name="Dampening Tam", augments={'DEX+7','Accuracy+12','Mag. Acc.+2','Quadruple Attack +1',}},
	    body="Passion Jacket",
	    hands={ name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}},
	    legs={ name="Zoar Subligar +1", augments={'Path: A',}},
	    feet="Ahosi Leggings",
	    neck="Unmoving Collar +1",
	    waist="Goading Belt",
	    left_ear="Cryptic Earring",
	    right_ear="Friomisi Earring",
	    left_ring="Petrov Ring",
	    right_ring="Vengeful Ring",
	    back="Mubvum. Mantle",}

    sets.precast.JA['Animated Flourish'] = sets.precast.JA['Provoke']

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
	    head={ name="Herculean Helm", augments={'Accuracy+22','"Store TP"+2','DEX+13','Attack+5',}},
	    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
	    hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
	    legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
	    feet="Malignance Boots",
	    neck="Baetyl Pendant",
	    waist="Flume Belt +1",
	    left_ear="Loquac. Earring",
	    right_ear="Etiolation Earring",
	    left_ring="Prolix Ring",
	    right_ring="Lebeche Ring",
	    back={ name="Senuna's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket", neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Charis Feather",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    hands="Maxixi Bangles +3",
	    legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}

    sets.precast.WS.Acc = {ammo="Yamarang",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body="Malignance Tabard",
	    hands="Maxixi Bangles +3",
	    legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    right_ear="Ishvara Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Multi-Attack Build - STR 40% & DEX 40% - Ftp across all hits
    sets.precast.WS['Pyrrhic Kleos'] = {ammo="Voluspa Tathlum",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
	    neck="Fotia Gorget",
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear="Sherida Earring",
	    right_ear="Cessance Earring",
	    left_ring="Gere Ring",
	    right_ring="Epona's Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.precast.WS['Pyrrhic Kleos'].Acc = {ammo="C. Palug Stone",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs="Meg. Chausses +2",
	    feet="Malignance Boots",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Sherida Earring",
	    right_ear="Mache Earring",
	    left_ring="Gere Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.precast.WS['Pyrrhic Kleos'].Strike = set_combine(sets.precast.WS['Pyrrhic Kleos'], {body="Macu. Casaque +1",})

    -- Critical Attack Build - DEX 50% - Ftp across all hits
    sets.precast.WS['Evisceration'] = {ammo="Charis Feather",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body="Meg. Cuirie +2",
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs="Mummu Kecks +2",
	    feet="Mummu Gamash. +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Odr Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Ilabrat Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.precast.WS['Evisceration'].Acc = {ammo="Charis Feather",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body="Meg. Cuirie +2",
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs="Mummu Kecks +2",
	    feet="Mummu Gamash. +2",
	    neck="Fotia Gorget",
	    waist="Fotia Belt",
	    left_ear="Odr Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Ilabrat Ring",
	    right_ring="Mummu Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},}

    sets.precast.WS['Evisceration'].Clim = set_combine(sets.precast.WS['Evisceration'], {head="Maculele Tiara +1",})

    sets.precast.WS["Rudra's Storm"] = {ammo="C. Palug Stone",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Herculean Vest", augments={'Accuracy+12 Attack+12','Weapon skill damage +4%','STR+3','Accuracy+10','Attack+8',}},
	    hands="Maxixi Bangles +3",
	    legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
	    feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Grunfeld Rope",
	    left_ear="Odr Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Ilabrat Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}

    sets.precast.WS["Rudra's Storm"].Acc = {ammo="C. Palug Stone",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands="Maxixi Bangles +3",
	    legs={ name="Horos Tights +3", augments={'Enhances "Saber Dance" effect',}},
	    feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Grunfeld Rope",
	    left_ear="Odr Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Ilabrat Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}

    sets.precast.WS["Rudra's Storm"].Clim = {ammo="Charis Feather",
	    head="Maculele Tiara +1",
	    body="Meg. Cuirie +2",
	    hands="Maxixi Bangles +3",
	    legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
	    feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Grunfeld Rope",
	    left_ear="Odr Earring",
	    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	    left_ring="Ilabrat Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
	    head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','INT+2','Mag. Acc.+14',}},
	    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
	    hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +3%','STR+14','"Mag.Atk.Bns."+15',}},
	    legs={ name="Herculean Trousers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
	    feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','MND+2','Mag. Acc.+7',}},
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Friomisi Earring",
	    right_ear="Novio Earring",
	    left_ring="Ilabrat Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},}
    
    sets.precast.Skillchain = {hands="Macu. Bangles +1",
	    legs="Maxixi Tights +3",
	    back="Sacro Mantle",}
    
    
    -- Midcast Sets
    sets.midcast['Flash'] = sets.precast.JA['Provoke']
    -- sets.midcast.FastRecast = {}
    -- sets.midcast.Utsusemi = {}


    -- Engaged sets
    -- Normal melee group

    -- 0% Haste - 39 Dual Wield Needed
    sets.engaged = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Reiki Yotai",
	    left_ear="Suppanomimi",
	    right_ear="Brutal Earring",
	    left_ring="Gere Ring",
	    right_ring="Epona's Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    
    sets.engaged.Acc = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Reiki Yotai",
	    left_ear="Suppanomimi",
	    right_ear="Telos Earring",
	    left_ring="Gere Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.DT = {ammo="Staunch Tathlum",
	    head="Turms Cap",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Mummu Kecks +2",
	    feet="Malignance Boots",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Suppanomimi",
	    right_ear="Sanare Earring",
	    left_ring="Defending Ring",
	    right_ring="Moonbeam Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    
    sets.engaged.Acc.DT = sets.engaged.DT

     -- 15% Haste - 32 Dual Wield Needed
    sets.engaged.Haste_15 = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear="Suppanomimi",
	    right_ear="Brutal Earring",
	    left_ring="Gere Ring",
	    right_ring="Epona's Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    
    sets.engaged.Acc.Haste_15 = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Kentarch Belt +1",
	    left_ear="Suppanomimi",
	    right_ear="Telos Earring",
	    left_ring="Gere Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    
    sets.engaged.Haste_15.PDT = sets.engaged.DT

     -- 30% Haste - 21 Dual Wield Needed
    sets.engaged.Haste_30 = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear="Suppanomimi",
	    right_ear="Brutal Earring",
	    left_ring="Gere Ring",
	    right_ring="Epona's Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
    
    sets.engaged.Acc.Haste_30 = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Kentarch Belt +1",
	    left_ear="Suppanomimi",
	    right_ear="Telos Earring",
	    left_ring="Gere Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
    
    sets.engaged.Haste_30.PDT = sets.engaged.DT
    
     -- 35% Haste - 18 Dual Wield Needed
    sets.engaged.Haste_35 = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Gere Ring",
	    right_ring="Epona's Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
   
    sets.engaged.Acc.Haste_35 = {ammo="Yamarang",
	    head="Maxixi Tiara +3",
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Kentarch Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Gere Ring",
	    right_ring="Regal Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
    
    sets.engaged.Haste_35.DT = sets.engaged.DT

    -- MAX Haste - 1 Dual Wield Needed
    sets.engaged.MaxHaste = {ammo="Yamarang",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet={ name="Horos T. Shoes +3", augments={'Enhances "Closed Position" effect',}},
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	    left_ear="Sherida Earring",
	    right_ear="Brutal Earring",
	    left_ring="Gere Ring",
	    right_ring="Epona's Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
    
    sets.engaged.Acc.MaxHaste = {ammo="Yamarang",
	    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    body={ name="Horos Casaque +3", augments={'Enhances "No Foot Rise" effect',}},
	    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
	    feet="Malignance Boots",
	    neck={ name="Etoile Gorget +1", augments={'Path: A',}},
	    waist="Kentarch Belt +1",
	    left_ear="Sherida Earring",
	    right_ear="Telos Earring",
	    left_ring="Gere Ring",
	    right_ring="Moonbeam Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
    
    sets.engaged.MaxHaste.DT = sets.engaged.DT

        -- Idle sets

    sets.idle = {ammo="Staunch Tathlum",
	    head="Turms Cap",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Mummu Kecks +2",
	    feet="Tandava Crackows",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Hearty Earring",
	    right_ear="Sanare Earring",
	    left_ring="Defending Ring",
	    right_ring="Karieyh Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.idle.DT = {ammo="Staunch Tathlum",
	    head="Turms Cap",
	    body="Malignance Tabard",
	    hands="Malignance Gloves",
	    legs="Mummu Kecks +2",
	    feet="Tandava Crackows",
	    neck="Loricate Torque +1",
	    waist="Flume Belt +1",
	    left_ear="Hearty Earring",
	    right_ear="Sanare Earring",
	    left_ring="Defending Ring",
	    right_ring="Moonbeam Ring",
	    back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'Waltz' then
        if state.enmitymode.value == 'Plus' then
            add_to_chat(123,'Enmity Plus Waltz')
            equip(sets.precast.Waltz.Plus)
            eventArgs.handled = true
        elseif state.enmitymode.value == 'Minus' then
            add_to_chat(123,'Emnity Minus Waltz')
            equip(sets.precast.Waltz.Minus)
            eventArgs.handled = true
        end
    end
end


function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
		if spell.english == "Rudra's Storm" and state.Buff['Climactic Flourish'] then
            equip(sets.precast.WS["Rudra's Storm"].Clim)
        end		
		if spell.english == 'Pyrrhic Kleos' and state.Buff['Striking Flourish'] then
            equip(sets.precast.WS['Pyrrhic Kleos'].Strike)
        end
		if spell.english == 'Evisceration' and state.Buff['Climactic Flourish'] then
            equip(sets.precast.WS['Evisceration'].Clim)
        end		
		if spell.english == 'Asuran fists' and state.Buff['Striking Flourish'] then
            equip(sets.precast.WS['Asuran Fists'].Strike)
        end	
        if state.SkillchainPending.value == true then
            equip(sets.precast.Skillchain)
        end
    end
    if spell.type == 'WeaponSkill' then
        if (state.RangedMode == 'Acc' and RangedWeaponskills:contains(spell.english)) then
            equip(sets.precast.WS[spell.english].Acc)
        elseif (state.OffenseMode == 'Acc' and not RangedWeaponskills:contains(spell.english)) then
            equip(setse.precast.WS[spell.english].Acc)
        end
    end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Wild Flourish" then
            state.SkillchainPending:set()
            send_command('wait 5;gs c unset SkillchainPending')
        elseif spell.type:lower() == "weaponskill" then
            state.SkillchainPending:toggle()
            send_command('wait 6;gs c unset SkillchainPending')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' or buff == 'Fan Dance' then
        handle_equipping_gear(player.status)
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end


function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if buffactive['Saber Dance'] then
            meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
        elseif state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        elseif state.Buff['Fan Dance'] then
        	meleeSet = set_combine(meleeSet, sets.buff['Fan Dance'])
    end
    
    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
-- function auto_presto(spell)
--     if spell.type == 'Step' and player.main_job_level >= 77 and player.tp > 99 and player.status == 'Engaged' and under3FMs() then
--         local abil_recasts = windower.ffxi.get_ability_recasts()

--         if abil_recasts[236] < latency and abil_recasts[220] < latency then
--             eventArgs.cancel = true
-- 			windower.chat.input('/ja "Presto" <me>')
-- 			windower.chat.input:schedule(1.1,'/ja "'..spell.english..'" '..spell.target.raw..'')
--         end
--     end
-- end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 2)
end 