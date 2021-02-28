-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
	
	gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
     
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren"}
 
    magicalRagePacts = S{'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Meteorite','Nether Blast',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Night Terror','Level ? Holy','Conflag Strike','Impact',
        'Sonic Buffet','Tornado II','Clarsach Call'}
    
    enticersRagePacts = S{'Impact','Conflag Strike', 'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
	    'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV'}

    physicalEnticersRagePacts = S{'Mountain Buster','Rock Buster','Crescent Fang','Eclipse Bite','Blindside'}

    meritPacts = S{'Heavenly Strike','Wind Blade','Geocrush','Thunderstorm','Meteor Strike','Grand Fall'}

    enticersWardPacts = S{'HealingRuby II','Healing Ruby'}
    healingWardPacts = S{'HealingRuby II','Healing Ruby'}

    hybridPacts = S{'Flaming Crush'}

	FlowPacts = S{
		'Perfect Defense'}

	pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}

    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}

    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'}

    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}

    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby',['Carbuncle']='Pacifying ruby', ['Shiva']='Crystal blessing',['Fenrir']='Heavenward Howl', ['Leviathan']='Soothing current',['Cait Sith']='Raise II',}

    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye',['Carbuncle']='Soothing Ruby' }

    pacts.debuff2 = {['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}

    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}

    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}

    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV',['Fenrir']='Crescent Fang'}

    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
	    ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
	    ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}

    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}

    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

    pacts.bprage1 = {['Fenrir']='Impact',['Ramuh']='Volt Strike',['Cait Sith']='Regal Gash',['Carbuncle']='Poison Nails',['Ifrit']='Conflag Strike',['Titan']='Crag Throw',['Diabolos']='Blindside',['Leviathan']='Tail Whip'}

    pacts.misc1 = {['Ramuh']='Thunderspark',['Fenrir']='Moonlit Charge'}

    pacts.misc2 = {['Diabolos']='Ultimate Terror'}

    -- Wards table for creating custom timers   
		wards = {}
    -- Base duration for ward pacts. 
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Hastega II'] = 180,['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600}
	
    wards.icons = {
		['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
		['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
		['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
		['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']      	= 'spells/00357.png', -- 00357 for Hastega
        ['Hastega II']      = 'spells/00358.png', -- 00358 for Hastega II		
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
		['Fleet Wind']      = 'spells/00301.png', -- 00301 for Garuda
		['Crystal Blessing']= 'spells/00020.png', -- 00020 for TP bonus
		['Soothing Current']= 'spells/00183.png', -- 00183 for Healing Bonus
    }
	
	-- Special rules showing the remaining time of Perfect Defense.
	-- Duration is calculated as follows: [30s + Floor(Summoning Magic Skill/20)s], adjust the time below to reflect your own skill.
	-- Base duration at level 99 with capped skill (417) is 51 seconds, max obtainable time is 60 seconds at 600 skill. (Currently unreachable in game.)
	durations = {}
		durations['Perfect Defense'] = 58

	timer_icons = {}
	timer_icons['Perfect Defense'] = 'spells/00306.png'	-- 00306 for Perfect Defense

    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    
    gear.perp_staff = {name=""}
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head={ name="Glyphic Horn +1", augments={'Enhances "Astral Flow" effect',}},}
    
    sets.precast.JA['Elemental Siphon'] = {main="Chatoyant Staff",
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Baayami Robe",
        hands="Lamassu Mitts +1",
        legs="Beck. Spats +1",
        feet="Beck. Pigaches +1",
        neck="Incanter's Torque",
        waist="Kobo Obi",
        left_ear="Lodurr Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Stikini Ring",
        back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -2',}},}

    sets.precast.JA['Mana Cede'] = {hands="Beck. Bracers +1",}

    -- Pact delay reduction gear 
    -- Blood Pact Delay I - 15s
    -- Blood Pact Delay II - 15s
    -- Blood Pact Delay III - Job Points
    sets.precast.BloodPactWard = {main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head={ name="Glyphic Horn +1", augments={'Enhances "Astral Flow" effect',}},
        body={ name="Glyphic Doublet +3", augments={'Reduces Sp. "Blood Pact" MP cost',}},
        hands={ name="Glyphic Bracers +2", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
        legs={ name="Glyphic Spats +1", augments={'Increases Sp. "Blood Pact" accuracy',}},
        feet={ name="Glyph. Pigaches +2", augments={'Inc. Sp. "Blood Pact" magic crit. dmg.',}},
        waist="Lucidity Sash",
        back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -2',}},}
    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sancus Sachet",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Inyanga Jubbah +2",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet="Regal Pumps +1",
        neck="Baetyl Pendant",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Kishar Ring",
        right_ring="Prolix Ring",
        back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},}
	
    -- sets.precast.Cure = set_combine(sets.precast.FC,{left_ear="Mendicant's earring"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {head="Beckoner's Horn +1",
        body="Beck. Doublet +1",
        hands="Beck. Bracers +1",
        legs="Beck. Spats +1",
        feet="Beck. Pigaches +1",
        neck="Sanctity Necklace",
        waist="Luminary Sash",
        left_ear="Evans Earring",
        right_ear="Etiolation Earring",
        left_ring="Bifrost Ring",
        right_ring="Mephitas's Ring",
        back="Thauma. Cape",}

    sets.precast.WS['Garland of Bliss'] = {ammo="Pemphredo Tathlum",
	    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+15','"Mag.Atk.Bns."+12',}},
	    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25',}},
	    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
	    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+2','Mag. Acc.+14',}},
	    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Occult Acumen"+4','MND+3','Mag. Acc.+15','"Mag.Atk.Bns."+4',}},
	    neck="Sanctity Necklace",
	    waist="Eschan Stone",
	    left_ear="Malignance Earring",
	    right_ear="Friomisi Earring",
	    left_ring="Shiva Ring +1",
	    right_ring="Freke Ring",
	    back="Toro Cape",}
		
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- sets.midcast.FastRecast = {}

    sets.midcast.Cure = {head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body="Inyanga Jubbah +2",
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
        feet={ name="Medium's Sabots", augments={'MP+40','MND+6','"Conserve MP"+5','"Cure" potency +3%',}},
        neck="Nodens Gorget",
        waist="Austerity Belt",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Menelaus's Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",}

    sets.midcast['Enhancing Magic'] = {head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Pet: "Regen"+1','Enh. Mag. eff. dur. +8',}},
        hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'DEF+8','Pet: "Regen"+2','Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Andoaa Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Solemnity Cape",}
	
    sets.midcast['Stoneskin'] = set_combine(sets.precast['Enhancing Magic'], {waist="Siegel Sash",
        right_ear="Earthcry Earring",})	

    -- sets.midcast['Elemental Magic'] = {}

    -- sets.midcast['Dark Magic'] = {}

    -- Avatar pact sets.  All pacts are Ability type.
    -- Perfect Defense -- you will want Summoning Magic Skill --
    sets.midcast.Pet.Alexander = {main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Baayami Robe",
        hands="Lamassu Mitts +1",
        legs="Beck. Spats +1",
        neck="Incanter's Torque",
        waist="Kobo Obi",
        left_ear="Lodurr Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Stikini Ring",
        back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -2',}},}

    sets.midcast.Pet.Odin = sets.midcast.Pet.Alexander
	
	--- This is for buffing type Blood Pacts, you will want Summoning Magic here ---

	sets.midcast.Pet.BloodPactWard = {main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Baayami Robe",
        hands="Lamassu Mitts +1",
        legs="Beck. Spats +1",
        feet="Tali'ah Crackows +2",
        neck="Incanter's Torque",
        waist="Kobo Obi",
        left_ear="Lodurr Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Stikini Ring",
        back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -2',}},}		

    --- This is for your debuffing Blood Pacts aka Magic Accuracy for Pets needed ----

    sets.midcast.Pet.DebuffBloodPactWard = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+20','DMG:+11',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Con. Doublet +3",
        hands="Convo. Bracers +3",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Adad Amulet",
        waist="Incarnation Sash",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Evoker's Ring",
        right_ring="Stikini Ring",
        back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
	
	---- This is for dual property blood pacts, things that are both Physical & Magical ---

	sets.midcast.Pet.HybridBloodPactRage = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+20','DMG:+11',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        body="Con. Doublet +3",
        hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Blood Pact Dmg.+9','Pet: DEX+6','Pet: "Mag.Atk.Bns."+6',}},
        legs={ name="Apogee Slacks", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}},
        feet="Convo. Pigaches +3",
        neck="Adad Amulet",
        waist="Regal Belt",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
	
	---- This is for Physical only Blood Pacts ---- 

    sets.midcast.Pet.PhysicalBloodPactRage = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head="Tali'ah Turban +2",
        body="Con. Doublet +3",
        hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Blood Pact Dmg.+9','Pet: DEX+6','Pet: "Mag.Atk.Bns."+6',}},
        legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+20','DMG:+11',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+10','Pet: INT+5','Pet: Mag. Acc.+13',}},
        legs={ name="Apogee Slacks", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}},
        feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        neck="Adad Amulet",
        waist="Regal Belt",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},}


    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage 

    sets.midcast.Pet.TPMagicalBloodPactRage = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+20','DMG:+11',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+10','Pet: INT+5','Pet: Mag. Acc.+13',}},
        legs={ name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}},
        feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        neck="Adad Amulet",
        waist="Regal Belt",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','"Fast Cast"+10',}},}

    sets.midcast.Pet.TPMagicalBloodPactRage.Acc = sets.midcast.Pet.TPMagicalBloodPactRage

    sets.midcast.Pet.IfritMagicalBloodPactRage = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+7','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+20','DMG:+11',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        body="Con. Doublet +3",
        hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Blood Pact Dmg.+9','Pet: DEX+6','Pet: "Mag.Atk.Bns."+6',}},
        legs={ name="Apogee Slacks", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}},
        feet="Convo. Pigaches +3",
        neck="Adad Amulet",
        waist="Regal Belt",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    sets.midcast.Pet.IfritMagicalBloodPactRage.Acc = sets.midcast.Pet.IfritMagicalBloodPactRage

    sets.midcast.Pet.HealingWard = {main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Lamassu Mitts +1",
        legs={ name="Apogee Slacks", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}},
        feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        neck="Incanter's Torque",
        waist="Kobo Obi",
        left_ear="Lodurr Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Stikini Ring",
        back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Blood Pact Dmg.+4','Blood Pact ab. del. II -2',}},}

    sets.midcast.Pet.TPBloodPactWard = sets.midcast.Pet.DebuffBloodPactWard
	

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    -- sets.midcast.Pet.WhiteMagic = {ring1="Sheltered ring",legs="Glyphic Spats +1"}
    
    -- sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {body="Shomonjijoe +1",legs="Glyphic Spats +1"})

    -- sets.midcast.Pet['Elemental Magic'].Resistant = {}
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Idle sets
    sets.idle = {main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Tali'ah Sera. +2",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Regal Belt",
        left_ear="Evans Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
		
    sets.idle.PDT = sets.idle

    -- perp costs:
    -- spirits: 5
    -- carby/Cait Sith: 6 
    -- fenrir: 9
    -- others: 13
    -- favor: 5
    
	sets.idle.Avatar = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Evans Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    sets.idle.Carbuncle = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Hearty Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}


    sets.idle.PDT.Avatar = sets.idle.Avatar

    sets.idle.Spirit = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Beck. Pigaches +1",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Evans Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    -- Favor uses Caller's Horn instead of Con. Horn +1 for refresh
    sets.idle.Avatar.Favor = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Elan Strap",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Evans Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

	sets.idle.Avatar.Melee = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    sets.idle.Avatar.FavorMelee = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
		
    sets.perp = {}
    -- -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- -- Carbuncle and Cait Sith have a lower perpetuation cost than other avatars, so items can be adjusted for Regen/Refresh and movement speed gear.
    
    sets.perp.Carbuncle = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Hearty Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    sets.perp.Carbuncle.Favor = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Hearty Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
		
    sets.perp.Carbuncle.FavorMelee = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
	
    sets.CaitSith = {}	
    sets.perp['Cait Sith'] = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Lamassu Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Hearty Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}

    sets.CaitSith.Favor = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Lamassu Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Caller's Pendant",
        waist="Incarnation Sash",
        left_ear="Hearty Earring",
        right_ear="C. Palug Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
		
    sets.CaitSith.FavorMelee = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Lugalbanda Earring",
        right_ear="Enmerkar Earring",
        left_ring="Evoker's Ring",
        right_ring="Defending Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}},}
    
    -- Defense sets


    sets.Kiting = {feet="Herald's Gaiters"}
    
    sets.latent_refresh = {waist="Fucho-no-obi"}
    

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +2",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Telos Earring",
        right_ear="Enmerkar Earring",
        left_ring="Cacoethic Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},}

    sets.engaged.Avatar = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +2",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Telos Earring",
        right_ear="Enmerkar Earring",
        left_ring="Cacoethic Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},}

    sets.engaged.Avatar.PDT = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +2",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Telos Earring",
        right_ear="Enmerkar Earring",
        left_ring="Cacoethic Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},}

    sets.engaged.Spirit = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +2",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Telos Earring",
        right_ear="Enmerkar Earring",
        left_ring="Cacoethic Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},}

    -- Favor uses Caller's Horn instead of Con. Horn +1 for refresh
    sets.engaged.Avatar.Favor = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Beckoner's Horn +1",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +2",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Telos Earring",
        right_ear="Enmerkar Earring",
        left_ring="Cacoethic Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},}

	sets.engaged.Avatar.Melee = {main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +3",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +2",
        legs="Convo. Spats +3",
        feet="Convo. Pigaches +3",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Telos Earring",
        right_ear="Enmerkar Earring",
        left_ring="Cacoethic Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Accuracy+10','Pet: Haste+10',}},}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end
	

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
	end

		if (spell.english=="Ecliptic Howl") then
                if (world.moon_pct>89) then
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 25 - Evasion 1")
                elseif (world.moon_pct>74) then
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 21 - Evasion 5")
                elseif (world.moon_pct>59) then
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 17 - Evasion 9")
                elseif (world.moon_pct>39) then
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 13 - Evasion 13")
                elseif (world.moon_pct>24) then
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 9 - Evasion 17")
                elseif (world.moon_pct>9) then
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 5 - Evasion 21")
                else
                        add_to_chat(104,"[Ecliptic Howl] Accuracy 1 - Evasion 25")
                end
        elseif (spell.english=="Ecliptic Growl") then
                if (world.moon_pct>89) then
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 7 - INT/MND/CHR/AGI 1")
                elseif (world.moon_pct>74) then
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 6 - INT/MND/CHR/AGI 2")
                elseif (world.moon_pct>59) then
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 5 - INT/MND/CHR/AGI 3")
                elseif (world.moon_pct>39) then
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 4 - INT/MND/CHR/AGI 4")
                elseif (world.moon_pct>24) then
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 3 - INT/MND/CHR/AGI 5")
                elseif (world.moon_pct>9) then
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 2 - INT/MND/CHR/AGI 6")
                else
                        add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 1 - INT/MND/CHR/AGI 7")
                end
        elseif (spell.english=="Lunar Cry") then
                if (world.moon_pct>89) then
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 31 - Enemy Eva Down 1")
                elseif (world.moon_pct>74) then
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 26 - Enemy Eva Down 6")
                elseif (world.moon_pct>59) then
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 21 - Enemy Eva Down 11")
                elseif (world.moon_pct>39) then
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 16 - Enemy Eva Down 16")
                elseif (world.moon_pct>24) then
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 11 - Enemy Eva Down 21")
                elseif (world.moon_pct>9) then
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 6 - Enemy Eva Down 26")
                else
                        add_to_chat(104,"[Lunar Cry] Enemy Acc Down 1 - Enemy Eva Down 31")
                end
        elseif (spell.english=="Dream Shroud") then
                if (world.time >= 0 and world.time < 1*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 13 - MDB 1")
                elseif (world.time >= 1*60 and world.time < 2*60) or (world.time >= 23*60 and world.time <= 23*60+59) then
                        add_to_chat(104,"[Dream Shroud] MAB 12 - MDB 2")
                elseif (world.time >= 2*60 and world.time < 3*60) or (world.time >= 22*60 and world.time < 23*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 11 - MDB 3")
                elseif (world.time >= 3*60 and world.time < 4*60) or (world.time >= 21*60 and world.time < 22*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 10 - MDB 4")
                elseif (world.time >= 4*60 and world.time < 5*60) or (world.time >= 20*60 and world.time < 21*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 9 - MDB 5")
                elseif (world.time >= 5*60 and world.time < 6*60) or (world.time >= 19*60 and world.time < 20*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 8 - MDB 6")
                elseif (world.time >= 6*60 and world.time < 7*60) or (world.time >= 18*60 and world.time < 19*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 7 - MDB 7")
                elseif (world.time >= 7*60 and world.time < 8*60) or (world.time >= 17*60 and world.time < 18*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 6 - MDB 8")
                elseif (world.time >= 8*60 and world.time < 9*60) or (world.time >= 16*60 and world.time < 17*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 5 - MDB 9")
                elseif (world.time >= 9*60 and world.time < 10*60) or (world.time >= 15*60 and world.time < 16*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 4 - MDB 10")
                elseif (world.time >= 10*60 and world.time < 11*60) or (world.time >= 14*60 and world.time < 15*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 3 - MDB 11")
                elseif (world.time >= 11*60 and world.time < 12*60) or (world.time >= 13*60 and world.time < 14*60) then
                        add_to_chat(104,"[Dream Shroud] MAB 2 - MDB 12")
                else
                        add_to_chat(104,"[Dream Shroud] MAB 1 - MDB 13")
        end
	end

	if not spell.interrupted then
		-- Create custom timers for Perfect Defense.
		if durations[spell.english] then
			local timer_cmd = 'timers c "'..spell.english..'" '..tostring(durations[spell.english])..' down'

			if timer_icons[spell.english] then
				timer_cmd = timer_cmd..' '..timer_icons[spell.english]
			end

			send_command(timer_cmd)
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
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        select_default_macro_book('reset')
    end
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
function job_get_spell_map(spell)
	--print(pet.tp)
	--print(pet_tp)
	spellMapMod = ""
	-- if state.bpmagicacc.current=='on' then
	-- 	spellMapMod = "Acc"
	-- end
	if spell.type == 'BloodPactRage' then
		if spell.english == "Impact" and state.impactmode.value==true then
			return 'DebuffBloodPactWard'
		elseif spell.english == "Tail Whip" then
			return 'DebuffBloodPactWard'
		elseif meritPacts:contains(spell.english) then
			return 'TPMagicalBloodPactRage'..spellMapMod
		elseif (enticersRagePacts:contains(spell.english) and pet_tp < 2350) then
			--elseif enticersRagePacts:contains(spell.english) and spell.english ~= 'Impact' then
			return 'TPMagicalBloodPactRage'..spellMapMod
			--return 'MagicalBloodPactRage'
		elseif (physicalEnticersRagePacts:contains(spell.english) and pet_tp < 2350) then
			return 'TPPhysicalBloodPactRage'..spellMapMod
		elseif hybridPacts:contains(spell.english) then
			return 'HybridBloodPactRage'..spellMapMod
		elseif magicalRagePacts:contains(spell.english) and pet.name=="Ifrit" then
			return 'IfritMagicalBloodPactRage'..spellMapMod
		elseif magicalRagePacts:contains(spell.english) then
			return 'MagicalBloodPactRage'..spellMapMod
		else
			return 'PhysicalBloodPactRage'..spellMapMod
		end
	elseif spell.type=='BloodPactWard' and healingWardPacts:contains(spell.english) then
		return 'HealingWard'
	elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
		return 'DebuffBloodPactWard'
    elseif spell.type=='BloodPactWard' and enticersWardPacts:contains(spell.english) then
	    return 'TPBloodPactWard'
    end
	if spell.skill=="Enhancing Magic" then
		return 'Enhancing Magic'
	end
    if spell.english:contains('Refresh') and spell.target.name == player.name then
		return 'RefreshSelf'
	end
    if spell.english:startswith('Cure') and spell.target.name == player.name and buffactive['Aurorastorm'] then
		return 'CureSelfAurora'
    end
    if spell.english:startswith('Cure') and spell.target.name == player.name then
		return 'CureSelf'
    end
    if buffactive['Aurorastorm'] then
		return 'CureAurora'
    end
    if spell.english:contains('Cursna') and spell.target.name == player.name then
		return 'CursnaSelf'
    end
    --log_data_structure(buffactive)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            if pet.name == "Carbuncle" then
				idleSet = sets.perp.Carbuncle.Favor
			elseif pet.name == "Cait Sith" then
				idleSet = sets.CaitSith.Favor
			else
				idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
			end
        end
        if pet.status == 'Engaged' then
			if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
				if pet.name == "Carbuncle" then
					idleSet = sets.perp.Carbuncle.FavorMelee
				elseif pet.name == "Cait Sith" then
					idleSet = sets.CaitSith.FavorMelee
				else
					idleSet = set_combine(idleSet, sets.idle.Avatar.FavorMelee)
				end
			else
				idleSet = set_combine(idleSet, sets.idle.Avatar.FavorMelee)
			end
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
	if wards[spell_name] then
		local ward_duration = wards[spell_name]
		end
	end
       
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
       
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end
 
        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 6)
end