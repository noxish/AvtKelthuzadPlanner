# Avt Kelthuzad Planner

This is a WoW-Classic addon that will provide help for positioning during the Kel'Thuzad encounter.\
It's a fork of [Wrong Cthun Planner](https://www.curseforge.com/wow/addons/wrong-cthun-planner)

## Why?

The versions forked of does not support WoW-Classic clients other than the english version.\
*WrongCthunPlanner* works for all WoW-Classic clients. #Thanks to Deradon for the Localized Version

You can **drag** and **resize** the screen.\
You can also **reposition players**.

## Installation

### Source

* Download/Clone this repo.
* Copy the `src` directory into your WoW-Classic-Addons directory.
* Rename it to `AvtKelthuzadPlanner`

### Twitch/Curse

no release yet!
~~Install via Twitch-Client or Download from [Curseforge](https://www.curseforge.com/wow/addons/wrong-cthun-planner).~~


## Usage

`/wcp help` Show ingame help

`/wcp show` Show the planner

`/wcp hide` Hide the planner

`/wcp reset` Reset position and scale of the planner

`/wcp refresh` Refresh positions

`/wcp version` Show current version

* For Raid Leads and Assists

`/wcp marks` Set RaidTargetMarkers for Melees

`/wcp check` Check if all raiders have the addon installed

* For Raid Leads

`/wcp share` Displays the planner to your raid

### Macro (For RL/Assist)

If you're a RL or Assist, your might want to have macros like the following.

If you're using DBM some target markers might be reused.
If you want to reapply melee markers, consider using a macro like:

```
# Add /wcp marks into your rotation
# /wcp marks is a "cheap" operation -> No API calls
/cast Sunder Armor
/wcp marks
```

In case one of the melees dies/goes offline infight.

```
# @NOTE: /wcp refresh is an "expensive" operation -> API calls
/wcp refresh
/wcp marks
```

## Contribution

Feel free to do so.
