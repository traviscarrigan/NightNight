# Night Night
A simple grid style shooting game. Shoot the bad guy and save the hostages. 

![NightNightMenu](https://raw.github.com/traviscarrigan/NightNight/master/NightNightMenu.png)

## Background
Night Night is a simple game I started writing for the [Codea Play][codea play url] competition back in February 2012. The goal was to write a complete game using [Codea] [codea url] on the iPad. While still incomplete, I have decided to release it as a work in progress.  

## Story
Night Night is a very simple grid style shooting game. The player is the hero on the rooftop of a building who must kill all the bandits across the street. The bandits have broken into a building occupied by innocent civilians, now hostages. If a bandit enters a room with a hostage, the hero must act quickly before the hostage is executed by the bandit. The game ends when all the bandits are killed and all the hostages escape with their lives. 

## Code
Codea is built on the [Lua][lua url] programming language. And while Codea does support the use of classes, to make it easier to share the code, all classes have been combined into a single .lua script. Anyone who wants to run the game in Codea can simply copy and paste the code directly into the Codea editor as a new project. 

The game currently supports two types of input, *Touch* or *iCade*. If *Touch* is selected then the user drives the crosshairs by dragging them across the iPad's display. If *iCade* has been selected then the user can use the joystick on the iCade to drive the motion of the crosshairs. In either case, once the crosshairs pass over either a bandit or a hostage, the gun will go off. 

Not all methods are currently used. For example, nothing happens when either the bandit or hostage has been shot. It's a work in progress and will be implemented in the future. I should point out that I was learning Lua while writing this game, so some things probably don't make much sense. This will be addressed when I have time to revisit the code.

Below is a brief description of all the classes. 

### Main
* Setup the game including respawn rates and frame rates
* Draw the splash screen and building
* Redraw screen if iPad orientation changed
* Randomly move bandit and hostage
* Move the crosshairs 
* Compute hit or miss
* Monitor iCade motion

### Window Class
* Draws window objects
* Changes color if light is on or off

### Cross Class
* Draws the crosshairs

### Bandit Class
* Draws the bandit
* Redraws the bandit when hit

### Hostage Class
* Draws the hostage
* Redraws the hostage when hit

### Crack Class
* Draws cracking glass

### iCade Class
* Detects motion of iCade joystick
* Special thanks to Bortels for releasing the [iCade class][icade class url] for Codea on the [forums][icade forum comment url].

## In Work
As mentioned earlier, this game is a work in progress. Here are a few things that need to be implemented before a 1.0 release:

* Track number of killed bandits and hostages
* Define "Game Over" scenario
* Complete and implement the crack class
* Redraw bandit and hostage when hit
* Allow bandit to kill hostage
* Button animation in game menu
* Clean up the code

## Credits
* [TwoLivesLeft][twolivesleft url]
* [Codea][codea url]
* [iCade Class][icade class url]


[codea url]: http://twolivesleft.com/Codea/
[twolivesleft url]: http://twolivesleft.com/
[codea play url]: http://twolivesleft.com/Codea/Talk/discussion/629/codea-play
[lua url]: http://www.lua.org/
[icade class url]: http://home.bortels.us/decodea/results/iCade.html
[icade forum comment url]: http://twolivesleft.com/Codea/Talk/discussion/comment/4996#Comment_4996
