#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
jv_pg_emulstation_launch (){
    export DISPLAY=":0.0";
    ${EmulStationPath}emulationstation& 
}

jv_pg_emulstation_game(){
    export DISPLAY=":0.0";
    jeu=$1;
    database=${EmulStationConfigPath}"gamelist.db"; 
    rom_fileid=`sqlite3 $database 'select fileid from files where name like "%'$jeu'%"'`
    rom_systemid=`sqlite3 $database 'select systemid from files where name like "%'$jeu'%"'`
    cmd_emul=`xml_grep --text_only --cond "name" --cond "command" "${EmulStationConfigPath}"es_systems.cfg`
    path_emul=`xml_grep --text_only --cond "name" --cond "path" "${EmulStationConfigPath}"es_systems.cfg`
   

    cmd_emul=`echo $cmd_emul |  grep -oP "(?<=("$rom_systemid" ))[^%ROM%]+"`
    path_emul=`echo $path_emul |  grep -oP "(?<=("$rom_systemid" ))[^ ]+"`



    rom_path=$path_emul"/"$rom_fileid

    echo  ${cmd_emul} "${rom_path}"
   # if [ -e ${cmd_emul} ] && [ -e ${rom_path} ] ; then
	echo "Amuse toi bien";
	${cmd_emul} "${rom_path}" &>jv_emulstation.log
    #else
#	echo  "Je ne trouve pas lémulateur ou la rom"; 
 #   fi
}

