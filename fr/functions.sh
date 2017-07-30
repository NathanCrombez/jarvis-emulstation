#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
jv_pg_emulstation_launch (){
    export DISPLAY=":0.0";
    ${EmulStationPath}emulationstation & 
}

jv_pg_emulstation_game(){
    export DISPLAY=":0.0";
    jeu=$1;
    database=${EmulStationConfigPath}"gamelist.db"; 
    s_rom_filesystemid=`sqlite3 $database 'select fileid,systemid from files where name like "%'$jeu'%"'`;
    IFS='|' read -r -a a_rom_filesystemid <<< "$s_rom_filesystemid"
    rom_name=${a_rom_filesystemid[0]}
    rom_sys=${a_rom_filesystemid[1]}
    emul_cmd_=(`xmllint --xpath "systemList/system[name/text() = '$rom_sys']/command/text()" ${EmulStationConfigPath}es_systems.cfg`);
    rom_path=`xmllint --xpath "systemList/system[name/text() = '$rom_sys']/path/text()" ${EmulStationConfigPath}es_systems.cfg`;
    emul_cmd=${emul_cmd_[0]}

    cmd_cpt=$emul_cmd" \""$rom_path"/"$rom_name\"

    #echo $cmd_cpt
    eval $cmd_cpt > /dev/null 2>&1 & 
}

jv_pg_emulstation_hasardgame(){
    export DISPLAY=":0.0";
    jv_debug "START";
    database=${EmulStationConfigPath}"gamelist.db"; 
    nbsystems=`xmllint --xpath "count(//fullname)" ${EmulStationConfigPath}es_systems.cfg`;
 
    echo $nbsystems "systèmes trouvés :"
    
    systems=`xmllint --xpath "//name" ${EmulStationConfigPath}es_systems.cfg`;
    systems=`echo ${systems} | sed -e 's/[<>]//g'| sed -e 's/name//g'`;
    IFS='/' read -r -a systems <<< "$systems";
    nbsystemsb=`expr $nbsystems - 1`;
    rnd_sys=`shuf -i 0-$nbsystemsb -n 1`;

    echo " -> "${systems[0]}
    echo " -> "${systems[1]}

    echo "système choisie par lana" $rnd_sys
    echo " -> "${systems[$rnd_sys]}

    rom_path=`xmllint --xpath "systemList/system[name/text() = '${systems[$rnd_sys]}']/path/text()";
    ${EmulStationConfigPath}es_systems.cfg`;
    emul_cmd_=(`xmllint --xpath "systemList/system[name/text() = '${systems[$rnd_sys]}']/command/text()" ${EmulStationConfigPath}es_systems.cfg`);
    emul_cmd=${emul_cmd_[0]}
    echo "cmd emul : "$emul_cmd

    nbroms=`sqlite3 $database 'select count(*) from files where systemid is "'${systems[$rnd_sys]}'"'`;
    nbromsb=`expr $nbroms - 1`
    rnd_rom=`shuf -i 0-$nbromsb -n 1`
    rom_name=`sqlite3 $database 'select fileid from files limit 1 offset '$rnd_rom''`;

    echo "nombre de roms possible : "$nbroms
    echo "rnd rom :"$rnd_rom
    echo "rom choisie : "$rom_name
    echo "chement de la rom choisie : "$rom_path

    cmd_cpt=$emul_cmd" \""$rom_path"/"$rom_name\"
    echo "###################################"
    echo "###################################"
    echo "+ LA COMMANDE : "  $cmd_cpt
    echo "###################################"
    echo "###################################"
    
    eval $cmd_cpt > /dev/null 2>&1 & 
}
