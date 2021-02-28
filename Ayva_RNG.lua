function get_sets()
        mote_include_version = 2
        -- Load and initialize the include file.
        include('Mote-Include.lua')
        include('organizer-lib')
end

-- setup vars that are user-independent.

-- setup vars that are user-dependent.
function user_setup()
        -- Options: Override default values
    state.OffenseMode:options('Normal', 'Melee')
    state.RangedMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.IdleMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')

    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff.Overkill = buffactive.Overkill or false
	state.Buff['Double Shot'] = buffactive['Double Shot'] or false

    state.flurrymode = M{['description'] = 'Flurry Mode'}
    state.flurrymode:options('Flurry','FlurryII')
 
    send_command('bind ^` gs c cycle flurrymode')
	send_command('bind ^q input /ra <t>')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind ^q')
end

function init_gear_sets()
        -- Misc. Job Ability precasts
    sets.precast.JA['Bounty Shot'] = {hands="Amini Glove. +1"}
    sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2",}
    sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2",}
    sets.precast.JA['Velocity Shot'] = {body="Amini Caban +1",}
    sets.precast.JA['Shadowbind'] = {legs="Orion Bracers +1"}
    sets.precast.JA['Scavenge'] = {feet="Orion Socks +2",}
    sets.precast.JA['Unlimited Shot'] = {feet="Amini Bottillons +1"}
    sets.precast.JA['Flashy Shot'] = {hands={ name="Arc. Bracers +2", augments={'Enhances "Flashy Shot" effect',}},}
    sets.precast.JA['Stealth Shot'] = {feet={ name="Arcadian Socks", augments={'Enhances "Stealth Shot" effect',}},}

    sets.buff.Barrage = {head="Meghanada Visor +2",
    	body="Mummu Jacket +2",
    	hands="Orion Bracers +2",
    	legs="Mummu Kecks +2",
    	feet="Mummu Gamash. +2",
    	neck="Iskur Gorget",
    	waist="Kwahu Kachina Belt",
    	left_ear="Telos Earring",
    	right_ear="Enervating Earring",
    	left_ring="Regal Ring",
    	right_ring="Mummu Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},}
        
        -- placeholder until I can get to it

    sets.buff.Camouflage =  {body="Orion Jerkin +2",}

    sets.buff['Double Shot'] = {head="Amini Gapette +1",
    	body="Mummu Jacket +2",
    	hands={ name="Herculean Gloves", augments={'Rng.Acc.+25 Rng.Atk.+25','Crit.hit rate+2','AGI+9','Rng.Acc.+15',}},
    	legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    	feet="Mummu Gamash. +2",
    	neck="Iskur Gorget",
    	waist="Kwahu Kachina Belt",
    	left_ear="Telos Earring",
    	right_ear="Enervating Earring",
    	left_ring="Ilabrat Ring",
    	right_ring="Mummu Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},}

    sets.precast.JA['Eagle Eye Shot'] = {head="Meghanada Visor +2",
    	body="Meg. Cuirie +2",
    	hands="Orion Bracers +2",
    	legs="Meg. Chausses +2",
    	feet="Meg. Jam. +2",
    	neck="Iskur Gorget",
    	waist="Kwahu Kachina Belt",
    	left_ear="Neritic Earring",
    	right_ear="Enervating Earring",
    	left_ring="Regal Ring",
    	right_ring="Cacoethic Ring +1",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},}

	sets.precast.FC = {head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    	body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    	hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
    	legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    	feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
    	neck="Voltsurge Torque",
    	left_ear="Loquac. Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Prolix Ring",
    	right_ring="Weather. Ring",}

    -- sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

        ------------------------------------------------------------------
        -- Preshot / Snapshot sets
        ------------------------------------------------------------------

	sets.precast.RA['Double Shot'] = {head="Amini Gapette +1",} --Just put that special head here, no need to add everything
		
    sets.precast.RA = {head={ name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+4',}},
    	body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs="Orion Braccae +2",
    	feet="Meg. Jam. +2",
    	waist="Impulse Belt",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}

    sets.precast.RA.Flurry = {head="Orion Beret +2",
    	body="Amini Caban +1",
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs="Orion Braccae +2",
    	feet="Meg. Jam. +2",
    	waist="Impulse Belt",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}

    sets.precast.RA.FlurryTwo = {head="Orion Beret +2",
    	body="Amini Caban +1",
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs="Orion Braccae +2",
    	feet={ name="Arcadian Socks +1", augments={'Enhances "Stealth Shot" effect',}},
    	waist="Impulse Belt",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Snapshot"+10',}},}    

             ------------------------------------------------------------------
        -- Default Base Gear Sets for Ranged Attacks. Geared for Gun
        ------------------------------------------------------------------
    sets.midcast.RA = {head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
    	body="Mummu Jacket +2",
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    	feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
    	neck="Iskur Gorget",
    	waist="Kwahu Kachina Belt",
    	left_ear="Telos Earring",
    	right_ear="Enervating Earring",
    	left_ring="Ilabrat Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},}

    sets.midcast.RA.Acc = {head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
    	body="Orion Jerkin +2",
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    	feet="Orion Socks +2",
    	neck="Iskur Gorget",
    	waist="Kwahu Kachina Belt",
    	left_ear="Telos Earring",
    	right_ear="Enervating Earring",
    	left_ring="Ilabrat Ring",
    	right_ring="Regal Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},}

    -- All weaponskills used that are specifically named

    sets.Obi = {waist="Hachirin-no-Obi"}

	sets.precast.WS = {head="Orion Beret +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
    	feet="Meg. Jam. +2",
    	neck="Fotia Gorget",
    	waist="Ponente Sash",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	right_ear="Ishvara Earring",
    	left_ring="Regal Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

        -- WILDFIRE
    sets.precast.WS['Wildfire'] = {ammo="Chrono Bullet",
    	head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','STR+10','Mag. Acc.+11',}},
    	body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+5',}},
    	feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Store TP"+1',}},
    	neck="Sanctity Necklace",
    	waist="Eschan Stone",
    	left_ear="Hecate's Earring",
    	right_ear="Friomisi Earring",
    	left_ring="Ilabrat Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},}

        -- LAST STAND (Damage Varies with TP)
    sets.precast.WS['Last Stand'] = {ammo="Chrono Bullet",
    	head="Orion Beret +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
    	feet="Meg. Jam. +2",
    	neck="Fotia Gorget",
    	waist="Ponente Sash",
    	left_ear="Telos Earring",
    	right_ear="Ishvara Earring",
    	left_ring="Regal Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

        -- Trueflight
    sets.precast.WS['Trueflight'] = {ammo="Chrono Bullet",
    	head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','STR+10','Mag. Acc.+11',}},
    	body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+19','"Mag.Atk.Bns."+12','"Store TP"+5',}},
    	legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+5',}},
    	feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Store TP"+1',}},
    	neck="Sanctity Necklace",
    	waist="Eschan Stone",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	right_ear="Friomisi Earring",
    	left_ring="Weather. Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},}

        -- Go, go Jishnu Johnny!
    sets.precast.WS['Jishnu\'s Radiance'] = {ammo="Chrono Arrow",
    	head="Orion Beret +2",
    	body="Mummu Jacket +2",
    	hands="Meg. Gloves +2",
    	legs="Jokushu Haidate",
    	feet="Mummu Gamash. +2",
    	neck="Fotia Gorget",
    	waist="Kwahu Kachina Belt",
    	left_ear="Telos Earring",
    	right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	left_ring="Regal Ring",
    	right_ring="Mummu Ring",
    	back={ name="Belenus's Cape", augments={'DEX+20','Rng.Acc.+20 Rng.Atk.+20','DEX+10','Crit.hit rate+10',}},}

        --Conorach (Lowered Enmity)
    -- sets.precast.WS["Coronach"] = {}

        --Detonator (Damage Varies with TP)
    sets.precast.WS["Detonator"] = {ammo="Chrono Bullet",
    	head="Orion Beret +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
    	feet="Meg. Jam. +2",
    	neck="Fotia Gorget",
    	waist="Ponente Sash",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	right_ear="Ishvara Earring",
    	left_ring="Regal Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

        --Regulgent Arrow (Damage Varies with TP)
    sets.precast.WS["Refulgent Arrow"] = {ammo="Chrono Arrow",
    	head="Orion Beret +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
    	feet="Meg. Jam. +2",
    	neck="Fotia Gorget",
    	waist="Ponente Sash",
    	left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    	right_ear="Ishvara Earring",
    	left_ring="Regal Ring",
    	right_ring="Apate Ring",
    	back={ name="Belenus's Cape", augments={'STR+20','Rng.Acc.+20 Rng.Atk.+20','STR+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Apex Arrow'] = {ammo="Chrono Arrow",
    	head="Orion Beret +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
    	feet="Meg. Jam. +2",
    	neck="Iskur Gorget",
    	waist="Ponente Sash",
    	left_ear="Telos Earring",
    	right_ear="Ishvara Earring",
    	left_ring="Regal Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

    sets.precast.WS['Empyreal Arrow'] = {ammo="Chrono Arrow",
    	head="Orion Beret +2",
    	body="Meg. Cuirie +2",
    	hands="Meg. Gloves +2",
    	legs={ name="Arc. Braccae +2", augments={'Enhances "Eagle Eye Shot" effect',}},
    	feet="Meg. Jam. +2",
    	neck="Fotia Gorget",
    	waist="Ponente Sash",
    	left_ear="Telos Earring",
    	right_ear="Ishvara Earring",
    	left_ring="Regal Ring",
    	right_ring="Dingir Ring",
    	back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},}

        -- Engaged sets
    sets.engaged =  {head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
    	body="Meg. Cuirie +2",
    	hands="Kurys Gloves",
    	legs="Mummu Kecks +2",
    	feet="Meg. Jam. +2",
    	neck="Loricate Torque +1",
    	waist="Flume Belt",
    	left_ear="Genmei Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Defending Ring",
    	right_ring="Purity Ring",
    	back="Moonbeam Cape",}

	sets.engaged.PDT = {head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
	    body="Meg. Cuirie +2",
    	hands="Kurys Gloves",
    	legs="Mummu Kecks +2",
    	feet="Meg. Jam. +2",
    	neck="Loricate Torque +1",
    	waist="Flume Belt",
    	left_ear="Genmei Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Defending Ring",
    	right_ring="Meghanada Ring",
    	back="Agema Cape",}

        -- sets.engaged.Bow = set_combine(sets.engaged, {})

    sets.engaged.Melee = {head="Mummu Bonnet +1",
    	body="Mummu Jacket +2",
    	hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    	legs={ name="Samnuha Tights", augments={'STR+5','DEX+6','"Dbl.Atk."+2',}},
    	feet="Mummu Gamash. +2",
    	neck="Sanctity Necklace",
    	waist="Kentarch Belt",
    	left_ear="Digni. Earring",
    	right_ear="Sherida Earring",
    	left_ring="Regal Ring",
    	right_ring="Mummu Ring",
    	back="Relucent Cape",}

        -- sets.engaged.Bow.Melee = sets.engaged.Melee

    sets.engaged.Melee.PDT = {head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
	    body="Meg. Cuirie +2",
    	hands="Kurys Gloves",
    	legs="Mummu Kecks +2",
    	feet="Meg. Jam. +2",
    	neck="Loricate Torque +1",
    	waist="Flume Belt",
    	left_ear="Genmei Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Defending Ring",
    	right_ring="Meghanada Ring",
    	back="Agema Cape",}

	sets.engaged.Melee.DW = {head="Mummu Bonnet +1",
    	body="Mummu Jacket +2",
    	hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    	legs={ name="Samnuha Tights", augments={'STR+5','DEX+6','"Dbl.Atk."+2',}},
    	feet="Mummu Gamash. +2",
    	neck="Sanctity Necklace",
    	waist="Kentarch Belt",
    	left_ear="Digni. Earring",
    	right_ear="Sherida Earring",
    	left_ring="Regal Ring",
    	right_ring="Mummu Ring",
    	back="Relucent Cape",}

        -- Resting sets

    sets.idle = {head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
    	body="Meg. Cuirie +2",
    	hands="Kurys Gloves",
    	legs="Mummu Kecks +2",
    	feet="Jute Boots +1",
    	neck="Loricate Torque +1",
    	waist="Flume Belt",
    	left_ear="Genmei Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Defending Ring",
    	right_ring="Purity Ring",
    	back="Moonbeam Cape",}

    sets.idle.PDT = {head={ name="Dampening Tam", augments={'DEX+8','Accuracy+14','Mag. Acc.+13','Quadruple Attack +1',}},
    	body="Meg. Cuirie +2",
    	hands="Kurys Gloves",
    	legs="Mummu Kecks +2",
    	feet="Jute Boots +1",
    	neck="Loricate Torque +1",
    	waist="Flume Belt",
    	left_ear="Genmei Earring",
    	right_ear="Etiolation Earring",
    	left_ring="Defending Ring",
    	right_ring="Purity Ring",
    	back="Moonbeam Cape",}


        -- Defense sets
        -- sets.defense.PDT = set_combine(sets.idle, {})
        -- sets.defense.MDT = set_combine(sets.idle, {})
        --sets.Kiting = {feet="Fajin Boots"}



end

function job_precast(spell, action, spellMap, eventArgs)

    if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        -- Safety checks for weaponskills
    if spell.type:lower() == 'weaponskill' then
            if player.tp < 1000 then
                    eventArgs.cancel = true
                    return
            end
        end

    if spell.action_type=="Ranged Attack" then
	
		ra_set = sets.precast.RA
	
        if buffactive['Flurry'] and buffactive["Courser's Roll"] then --If both are active, use flurry 2 gear
            ra_set = sets.precast.RA.FlurryTwo
        elseif buffactive['Flurry'] then --If only flurry is active, equip gear based on flurrymode
            if state.flurrymode.value == 'FlurryII' then
                ra_set = sets.precast.RA.FlurryTwo
            else
                ra_set = sets.precast.RA.Flurry
            end
        elseif buffactive["Courser's Roll"] then --If only courser's roll, use flurry1 gear
            ra_set = sets.precast.RA.Flurry
        else
            add_to_chat(123,'Nothing');
        end
		
		if buffactive['Double Shot'] then
			ra_set = set_combine(ra_set, sets.precast.RA['Double Shot'])
		end

		equip(ra_set)
		eventArgs.handled = true
    end
	
    -- Equip obi if weather/day matches for WS.
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Trueflight' then
            if world.weather_element == 'Light' or world.day_element == 'Light' then
                equip(sets.Obi)
            end
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Barrage
    if spell.action_type == 'Ranged Attack' then	
	
		if state.Buff['Double Shot'] then
			equip(sets.buff['Double Shot'])
			eventArgs.handled = true
		end
	
		if state.Buff.Barrage then	
			if state.RangedMode.current == 'Mid' then
				equip(sets.buff.Barrage.Mid)
				eventArgs.handled = true
			elseif state.RangedMode.current == 'Acc' then
				equip(sets.buff.Barrage.Acc)
				eventArgs.handled = true
			else
				equip(sets.buff.Barrage)
				eventArgs.handled = true
			end	
		end
    end
	
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end

end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
         state.CombatWeapon:set(player.equipment.range)
    end

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
        if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm:set("DW")
        else
            state.CombatForm:reset()
        end
end

function get_custom_ranged_groups()
        classes.CustomRangedGroups:clear()

end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function use_ra(spell)

    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
         else
             if buffactive["Courser's Roll"] then
                 delay = '0.7' -- MAKE ADJUSTMENT HERE
             elseif buffactive["Flurry II"] or buffactive.Overkill then
                 delay = '0.5'
             else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    else
    -- GUN
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
        else
            if buffactive["Courser's Roll"] then
                delay = '0.7' -- MAKE ADJUSTMENT HERE
            elseif buffactive.Overkill or buffactive['Flurry II'] then
                delay = '0.5'
            else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end

function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 5)
end
