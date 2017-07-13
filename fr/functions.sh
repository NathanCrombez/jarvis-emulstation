#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
jv_plugin_emulstation_launch (){
    export DISPLAY=":0.0"
    killall chromium-browser >& /dev/null >1 /dev/null 
    chromium-browser & 
}

