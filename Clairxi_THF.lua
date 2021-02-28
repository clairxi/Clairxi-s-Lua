-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
	state.Buff['Trick Attack'] = buffactive['trick attack'] or false
	state.Buff['Feint'] = buffactive['feint'] or false
    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

    include('Mote-TreasureHunter')
	
	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.IdleMode:options('Normal')

	-- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')

	select_default_macro_book()

    determine_haste_group()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()

	send_command('unbind !-')
	send_command('unbind !=')
	send_command('unbind ^[')
	send_command('unbind ![')
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.TreasureHunter = {hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    	feet="Skulk. Poulaines +1", waist="Chaac Belt",}

    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1",}
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1",}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1",}
    sets.precast.JA['Despoil'] = {ammo="Barathrum",
    	legs="Skulk. Culottes +1",
    	feet="Skulk. Poulaines +1",}
    sets.precast.JA['Feint'] = {legs={ name="Plun. Culottes +1", augments={'Enhances "Feint" effect',}},}
    sets.precast.JA['Flee'] = {feet="Pill. Poulaines +2",}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +2",}
    sets.precast.JA['Mug'] = {head={ name="Plun. Bonnet +1", augments={'Enhances "Aura Steal" effect',}},}
    sets.precast.JA['Perfect Dodge'] = {hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},}
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Steal'] = {feet="Pill. Poulaines +2",}
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	sets.buff['Sneak Attack'] = {ammo="Qirmiz Tathlum",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Skulk. Armlets +1",
    	legs="Pill. Culottes +2",
    	feet="Malignance Boots",
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	left_ear="Sherida Earring",
    	right_ear="Odr Earring",
    	left_ring="Ilabrat Ring",
    	right_ring="Regal Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}

	sets.buff['Trick Attack'] = {ammo="Qirmiz Tathlum",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Pill. Armlets +2",
    	legs="Mummu Kecks +2",
    	feet="Malignance Boots",
    	neck="Anu Torque",
    	waist="Grunfeld Rope",
    	left_ear="Sherida Earring",
    	right_ear="Odr Earring",
    	left_ring="Ilabrat Ring",
    	right_ring="Regal Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Yamarang",
    	head="Mummu Bonnet +2",
    	body="Passion Jacket",
    	hands="Slither Gloves +1",
    	legs={ name="Desultor Tassets", augments={'"Waltz" TP cost -5','"Phantom Roll" ability delay -5',}},
    	feet="Rawhide Boots",
    	neck="Unmoving Collar +1",
    	left_ring="Valseur's Ring",
    	right_ring="Asklepian Ring",}

	-- Fast cast sets for spells
	sets.precast.FC = {ammo="Sapience Orb",
    	head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','INT+2','Mag. Acc.+14',}},
    	body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    	hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
    	legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    	neck="Baetyl Pendant",
    	left_ear="Loquac. Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Prolix Ring",}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket",neck="Magoraga Beads",})

    sets.precast.RA = {head="Mummu Bonnet +2",
    	body="Mummu Jacket +2",
    	hands="Mummu Wrists +2",
    	legs="Mummu Kecks +2",
    	feet="Mummu Gamash. +2",
    	neck="Sanctity Necklace",
    	waist="Eschan Stone",
    	left_ear="Telos Earring",
    	right_ear="Enervating Earring",
    	left_ring="Cacoethic Ring",
    	right_ring="Cacoethic Ring +1",
    	back="Sacro Mantle",}
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="C. Palug Stone",
    	head="Pill. Bonnet +2",
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Meg. Gloves +2",
    	legs="Pill. Culottes +2",
    	feet="Mummu Gamash. +2",
    	neck="Fotia Gorget",
    	waist="Fotia Belt",
    	left_ear="Ishvara Earring",
    	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Ilabrat Ring",
    	right_ring="Karieyh Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMid version isn't found.
    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
    	head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +4%','INT+2','Mag. Acc.+14',}},
    	body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    	hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    	legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','MND+7','Mag. Acc.+15',}},
    	feet="Skulk. Poulaines +1",
    	neck="Sanctity Necklace",
    	waist="Chaac Belt",
    	left_ear="Novio Earring",
    	right_ear="Friomisi Earring",
    	left_ring="Shiva Ring +1",
    	right_ring="Karieyh Ring",
    	back="Toro Cape",}

	sets.precast.WS['Evisceration'] = {ammo="C. Palug Stone",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body="Pillager's Vest +2",
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs="Pill. Culottes +2",
    	feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
    	neck="Fotia Gorget",
    	waist="Fotia Belt",
    	right_ear="Odr Earring",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Exenterator'] = {ammo="C. Palug Stone",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body="Pillager's Vest +2",
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs="Pill. Culottes +2",
    	feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
    	neck="Fotia Gorget",
    	waist="Fotia Belt",
    	right_ear="Odr Earring",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Mandalic Stab'] = {ammo="C. Palug Stone",
    	head="Pill. Bonnet +2",
    	body={ name="Herculean Vest", augments={'Accuracy+12 Attack+12','Weapon skill damage +4%','STR+3','Accuracy+10','Attack+8',}},
    	hands="Meg. Gloves +2",
    	legs={ name="Herculean Trousers", augments={'Accuracy+22','Weapon skill damage +4%','DEX+10','Attack+7',}},
    	feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	right_ear="Odr Earring",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Karieyh Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Mandalic Stab'].Crit = {ammo="Qirmiz Tathlum",
    	head="Pill. Bonnet +2",
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Skulk. Armlets +1",
    	legs="Pill. Culottes +2",
    	feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	right_ear="Odr Earring",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Karieyh Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    -- sets.precast.WS['Mercy Stroke'] = {}

    -- sets.precast.WS['Mercy Stroke'].Crit = {}

	sets.precast.WS["Rudra's Storm"] = {ammo="Qirmiz Tathlum",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs={ name="Lustratio Subligar", augments={'HP+50','Attack+25','Enmity-5',}},
    	feet="Mummu Gamash. +2",
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	right_ear="Odr Earring",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Ilabrat Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS["Rudra's Storm"].Crit = {ammo="Qirmiz Tathlum",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Pill. Armlets +2",
    	legs="Pill. Culottes +2",
    	feet="Mummu Gamash. +2",
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	right_ear="Odr Earring",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Ilabrat Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

	sets.precast.WS['Shark Bite'] = {ammo="C. Palug Stone",
    	head="Pill. Bonnet +2",
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Meg. Gloves +2",
    	legs="Pill. Culottes +2",
    	feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	left_ear="Ishvara Earring",
    	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Karieyh Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Shark Bite'].Crit = {ammo="Qirmiz Tathlum",
    	head="Pill. Bonnet +2",
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Pill. Armlets +2",
    	legs="Pill. Culottes +2",
    	feet="Mummu Gamash. +2",
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	left_ear="Ishvara Earring",
    	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Karieyh Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Circle Blade'] = sets.precast.WS['Aeolian Edge']

    sets.precast.WS['Savage Blade'] = {ammo="Mantoptera Eye",
    	head={ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+15',}},
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands="Meg. Gloves +2",
    	legs={ name="Herculean Trousers", augments={'Accuracy+23','Weapon skill damage +2%','STR+14',}},
    	feet={ name="Herculean Boots", augments={'Accuracy+24','Weapon skill damage +1%','STR+10','Attack+14',}},
    	neck="Caro Necklace",
    	waist="Grunfeld Rope",
    	left_ear="Ishvara Earring",
    	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Gere Ring",
    	right_ring="Rufescent Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}

    sets.precast.WS['Last Stand'] = {head="Meghanada Visor +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs="Meg. Chausses +2",
    	feet="Meg. Jam. +2",
    	neck="Fotia Gorget",
    	waist="Fotia Belt",
    	left_ear="Telos Earring",
    	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Cacoethic Ring",
    	right_ring="Cacoethic Ring +1",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},}
	
        -- Midcast Sets
	sets.midcast['Sleepga'] = {ammo="Pemphredo Tathlum",
    	head="Mummu Bonnet +2",
    	body="Mummu Jacket +2",
    	hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    	legs="Mummu Kecks +2",
    	feet="Skulk. Poulaines +1",
    	neck="Sanctity Necklace",
    	waist="Chaac Belt",
    	left_ear="Digni. Earring",
    	right_ear="Gwati Earring",
    	left_ring="Stikini Ring",
    	right_ring="Stikini Ring",
    	back="Sacro Mantle",}

    sets.midcast['Sheep Song'] = sets.midcast['Sleepga']
    sets.midcast['Geist Wall'] = sets.midcast['Sleepga']
    sets.midcast['Soporific'] = sets.midcast['Sleepga']
		
	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

 --    sets.midcast.RA = {}

	-- sets.midcast.RA.Acc = sets.midcast.RA
	
	-- Normal melee group
	sets.engaged = {ammo="Yamarang",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	hands="Pill. Armlets +2",
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Eabani Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
   
	sets.engaged.Acc = {}
	
	sets.engaged.PDT = {ammo="Staunch Tathlum",
    	head="Turms Cap",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Mummu Kecks +2",
    	feet="Malignance Boots",
    	neck="Loricate Torque +1",
    	waist="Reiki Yotai",
    	left_ear="Sherida Earring",
    	right_ear="Brutal Earring",
    	left_ring="Defending Ring",
    	right_ring="Moonbeam Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.Acc.PDT = sets.engaged.PDT

    sets.engaged.Haste_15 = {ammo="Yamarang",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	hands="Pill. Armlets +2",
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Sherida Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}        
    
    sets.engaged.Acc.Haste_15 = {ammo="Yamarang",
    	head="Pill. Bonnet +2",
    	body="Pillager's Vest +2",
    	hands="Pill. Armlets +2",
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Eabani Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    sets.engaged.PDT.Haste_15 = sets.engaged.PDT
    sets.engaged.Acc.PDT.Haste_15 = sets.engaged.PDT

    sets.engaged.Haste_30 = {ammo="Yamarang",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Sherida Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}
    
    sets.engaged.Acc.Haste_30 = {ammo="Yamarang",
	    head="Pill. Bonnet +2",
    	body="Pillager's Vest +2",
    	hands="Pill. Armlets +2",
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Reiki Yotai",
    	left_ear="Eabani Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    sets.engaged.PDT.Haste_30 = sets.engaged.PDT
    sets.engaged.Acc.PDT.Haste_30 = sets.engaged.PDT

    sets.engaged.Haste_35 = {ammo="Yamarang",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet="Malignance Boots",
    	neck="Anu Torque",
    	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    	left_ear="Sherida Earring",
    	right_ear="Brutal Earring",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.Acc.Haste_35 = {ammo="Yamarang",
    	head="Pill. Bonnet +2",
    	body="Pillager's Vest +2",
    	hands="Pill. Armlets +2",
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Kentarch Belt +1",
    	left_ear="Eabani Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}

    sets.engaged.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35
    sets.engaged.Acc.PDT.Haste_35 = {ammo="Staunch Tathlum",
    	head="Turms Cap",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Mummu Kecks +2",
    	feet="Malignance Boots",
    	neck="Loricate Torque +1",
    	waist="Reiki Yotai",
    	left_ear="Sherida Earring",
    	right_ear="Brutal Earring",
    	left_ring="Defending Ring",
    	right_ring="Moonbeam Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}

    sets.engaged.MaxHaste = {ammo="Yamarang",
    	head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	body={ name="Plunderer's Vest +3", augments={'Enhances "Ambush" effect',}},
    	hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    	legs="Pill. Culottes +2",
    	feet="Malignance Boots",
    	neck="Anu Torque",
    	waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    	left_ear="Sherida Earring",
    	right_ear="Brutal Earring",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},}        
    
    sets.engaged.Acc.MaxHaste = {ammo="Yamarang",
    	head="Pill. Bonnet +2",
    	body="Pillager's Vest +2",
    	hands="Pill. Armlets +2",
    	legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    	feet={ name="Taeon Boots", augments={'Accuracy+20 Attack+20','"Dual Wield"+4','STR+6 AGI+6',}},
    	neck="Anu Torque",
    	waist="Kentarch Belt +1",
    	left_ear="Eabani Earring",
    	right_ear="Suppanomimi",
    	left_ring="Gere Ring",
    	right_ring="Epona's Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
    sets.engaged.PDT.MaxHaste = sets.engaged.PDT
    sets.engaged.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.Haste_35

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {ammo="Staunch Tathlum",
    	head="Turms Cap",
    	body="Malignance Tabard",
    	hands="Malignance Gloves",
    	legs="Mummu Kecks +2",
    	feet="Jute Boots +1",
    	neck="Loricate Torque +1",
    	waist="Flume Belt +1",
    	left_ear="Sherida Earring",
    	right_ear="Sanare Earring",
    	left_ring="Defending Ring",
    	right_ring="Karieyh Ring",
    	back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}},}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
            if spell.skill == "Rudra's Storm" then
                equip(sets.precast.WS["Rudra's Storm"].Crit)
            end
            if spell.skill == "Mandalic Stab" then
                equip(sets.precast.WS["Mandalic Stab"].Crit)
            end
            if spell.skill == "Shark Bite" then
                equip(sets.precast.WS["Shark Bite"].Crit)
            end
            if spell.skill == "Evisceration" then
                equip(sets.precast.WS["Evisceration"].Crit)

            if spell.skill == "Mercy Stroke" then
                equip(sets.precast.WS["Mercy Stroke"].Crit)
                end
            end
        end
    end
    	if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end

	-- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
	if spell.type == 'WeaponSkill' and not spell.interrupted then
		state.Buff['Sneak Attack'] = false
		state.Buff['Trick Attack'] = false
		state.Buff['Feint'] = false
	end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
	-- If Feint is active, put that gear set on on top of regular gear.
	-- This includes overlaying SATA gear.
	check_buff('Feint', eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode

	if state.Buff['Sneak Attack'] then
		wsmode = 'SA'
	end
	if state.Buff['Trick Attack'] then
		wsmode = (wsmode or '') .. 'TA'
	end

	return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	-- Check that ranged slot is locked, if necessary
	check_range_lock()

	-- Check for SATA when equipping gear.  If either is active, equip
	-- that gear specifically, and block equipping default gear.
	check_buff('Sneak Attack', eventArgs)
	check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.idle.Regen)
	end

	return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for change events.
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

function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	return meleeSet
end


-------------------------------------------------------------------------------------------------------------------
-- Various update events.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	th_update(cmdParams, eventArgs)
end
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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

    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', TH: ' .. state.TreasureMode.value
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
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

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
	if player.equipment.range ~= 'empty' then
		disable('range', 'ammo')
	else
		enable('range', 'ammo')
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 5)
end
