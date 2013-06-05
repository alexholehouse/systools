#!/bin/bash

# function to see if a directory is mounted from a non                           
# local location (i.e. over a network)                                           
function mounted() {                                                                     
    
    # get current directory
    dir=$(pwd)
                                                               
    # recursivly cycle through the directory name                                
    # components checking to see if the full path                                
    # is associated with a line in the /proc/mounts                              
    # file which also contains an ip address
    #
    # I'm not sure if this approach is full proof, but
    # in the contexts I've used it works and seems to
    # be rigerous.
    while [ "$dir" != "/" ]
    do                                                                           
        if grep "[0-255]\.[0-255]" /proc/mounts | grep -qs "$dir""\+ " ;then     
            echo "MOUNTED DIRECTORY"                                             
            return                                                               
        fi                                                                               
        dir=$(dirname $dir)                                                      
    done                                                                        
    echo "LOCAL DIRECTORY"                                                       
}  
