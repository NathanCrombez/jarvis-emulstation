<!---
IMPORTANT
=========
This README.md is displayed in the WebStore as well as within Jarvis app
Please do not change the structure of this file
Fill-in Description, Usage & Author sections
Make sure to rename the [en] folder into the language code your plugin is written in (ex: fr, es, de, it...)
For multi-language plugin:
- clone the language directory and translate commands/functions.sh
- optionally write the Description / Usage sections in several languages
-->

## Description
Permet de:
   - Lancer Emulationstation
   - Lancer une rom spécifique (sans ce soucier de l'emulateur etc..)

Pour le moment, jarvis n'utilise que le dernier mot de la commande permettant de lancer une rom
spécifique. Jarvis cherche dans la base données d'EmulationStation, les roms dont le titre contient
ce mot. Si plusieurs roms sont trouvés Jarvis lance le premier de la liste. Des améliorations
arriveront très prochainement.  


NB1: D'autres fonctionnalités viendront au fur et à mesure (votre contribution est la bienvenue)
NB2: * signifie n'importe quel mot à cet endroit

VERSION: V0.1


## Usage
```
Vous: `* LANCE * EMULATIONSTATION *` (Lancer EmulationStation)
Vous: `* JOUER * (*)` (Lancer une rom spécifique)
```
``   

## Author & Contributors
Nathan Crombez (nathan.crombez@gmail.com)
