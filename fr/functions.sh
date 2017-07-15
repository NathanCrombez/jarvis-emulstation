#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
jv_plugin_emulstation_launch (){
    export DISPLAY=":0.0";
    ${EmulStationPath}emulationstation& 
}

jv_plugin_emulstation_game(){
    jeu=$1;
    echo "Recherche du jeu $jeu dans le dossier ${EmulStationPath}";
    database="/home/pi/.emulationstation/gamelist.db";
    echo 'select name from files where name like "%'$jeu'%"';
    rom_name=`sqlite3 $database 'select name from files where name like "%'$jeu'%"'`
    rom_systemid=`sqlite3 $database 'select systemid from files where name like "%'$jeu'%"'`
    cmd_emul=`xml_grep --text_only --cond "name" --cond "command" /home/pi/.emulationstation/es_systems.cfg`
    cmd_emul=`echo $cmd_emul |  grep -oP "(?<=snes )[^(%ROM%)]+"`

    echo $cmd_emul $rom_name".*"
    $cmd_emul $rom_name".*"
}

