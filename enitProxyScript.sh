#!/usr/bin/bash

# Add to the apt proxy
aptProxy(){
    # ============================
    # Directory and proxy
    # ----------------------------
    # Apt
    local aptProxyFile='//etc/apt/apt.conf.d/02proxy'
    local aptEnitProxy='Acquire::http::Proxy "http://squid.local.enit.fr:3128";'
    # aptEnitProxy="Acquire::http::Proxy "http://squid.local.enit.fr:3128";"
    
    # System
    local bashFile='//home/duc/.bashrc'
    local enitProxyHttp='export http_proxy="http://squid.local.enit.fr:3128/"'
    local enitProxyHttps='export https_proxy="https://squid.local.enit.fr:3128/"'
    local enitProxyHTTPWget='export HTTP_PROXY="http://squid.local.enit.fr:3128/"'
    local enitProxyHTTPSWget='export HTTPS_PROXY="https://squid.local.enit.fr:3128/"'
    # local noproxy='export no_proxy="*.enit.fr"'
    # local NOPROXYWget='export NO_PROXY="*.enit.fr"'
        


    # ============================
    # Check the state
    # ----------------------------
    read -p "You want to enable or remove the ENIT proxy, type enable:'e' or remove:'r':" taskState

   
    # ============================
    # ENABLE ALL PROXY
    # ----------------------------
    if [ $taskState = "e" ]; then 
        # ----------------------------
        # For apt
        if ! [ -f $aptProxyFile ]; then sudo touch $aptProxyFile; fi           #Create file if not exist
        # echo $aptEnitProxy >> $aptProxyFile
        # grep -Fxq "$aptEnitProxy" "$aptProxyFile"
       
        if ! grep -Fxq "$aptEnitProxy" "$aptProxyFile"; then 
            sudo bash -c "echo '$aptEnitProxy' >> $aptProxyFile"             #Write with permission
        fi


    
        # ----------------------------
        # For terminal system
        if ! [ -f $bashFile ]; then sudo touch "$bashFile"; fi           #Create file if not exist
        
        if ! grep -Fxq "$enitProxyHttp" "$bashFile"; then 
            sudo bash -c "echo '$enitProxyHttp' >> $bashFile"             #Write with permission
        fi

        if ! grep -Fxq "$enitProxyHttps" "$bashFile"; then 
            sudo bash -c "echo '$enitProxyHttps' >> $bashFile"             #Write with permission
        fi

        if ! grep -Fxq "$enitProxyHTTPWget" "$bashFile"; then 
            sudo bash -c "echo '$enitProxyHTTPWget' >> $bashFile"             #Write with permission
        fi

        if ! grep -Fxq "$enitProxyHTTPSWget" "$bashFile"; then 
            sudo bash -c "echo '$enitProxyHTTPSWget' >> $bashFile"             #Write with permission
        fi

        # if ! grep -Fxq "$noproxy" "$bashFile"; then 
        #     sudo bash -c "echo '$noproxy' >> $bashFile"             #Write with permission
        # fi

        # if ! grep -Fxq "$NOPROXYWget" "$bashFile"; then 
        #     sudo bash -c "echo '$NOPROXYWget' >> $bashFile"             #Write with permission
        # fi


        source ~/.bashrc

        # ----------------------------
        # For GUI
        # HTTP_PROXY_HOST="http://squid.local.enit.fr"
        # HTTP_PROXY_PORT=3128
        # HTTPS_PROXY_HOST="https://squid.local.enit.fr"
        # HTTPS_PROXY_PORT=3128

        # gsettings set org.gnome.system.proxy mode 'manual'
        # gsettings set org.gnome.system.proxy.http host "$HTTP_PROXY_HOST"
        # gsettings set org.gnome.system.proxy.http port "$HTTP_PROXY_PORT"
        # gsettings set org.gnome.system.proxy.https host "$HTTPS_PROXY_HOST"
        # gsettings set org.gnome.system.proxy.https port "$HTTPS_PROXY_PORT" 

        
        # export {http,https,ftp}_proxy="http://squid.local.enit.fr:3128"
        # export {HTTP,HTTPS,FTP}_PROXY="http://squid.local.enit.fr:3128"
        # export http_proxy="http://squid.local.enit.fr:3128/"
        # export https_proxy="https://squid.local.enit.fr:3128/"
        # export HTTP_PROXY="http://squid.local.enit.fr:3128/"
        # export HTTPS_PROXY="https://squid.local.enit.fr:3128/"
        # export no_proxy="*.enit.fr"
        # export NO_PROXY="*.enit.fr"


        # source ~/.bashrc
        # ----------------------------
        # For git
        git config --global http.proxy http://squid.local.enit.fr:3128



    # ============================
    # DISABLE ALL PROXY
    # ----------------------------
    elif [ "$taskState" = "r" ]; then
        # -------------------------
        # For apt
        sudo sed -i "\|$aptEnitProxy|d" "$aptProxyFile"

        # -------------------------
        # For terminal system

        # sudo sed -i "\|$noproxy|d" "$bashFile"
        # sudo sed -i "\|$NOPROXYWget|d" "$bashFile"
        sudo sed -i "\|$enitProxyHttp|d" "$bashFile"
        sudo sed -i "\|$enitProxyHttps|d" "$bashFile"
        sudo sed -i "\|$enitProxyHTTPWget|d" "$bashFile"
        sudo sed -i "\|$enitProxyHTTPSWget|d" "$bashFile"
        

        unset {http,https,ftp}_proxy
        unset no_proxy
        unset {HTTP,HTTPS,FTP}_PROXY
        unset NO_PROXY
        source ~/.bashrc
        
        # ---------------------------
        # For git
        git config --global --unset http.proxy



    # ============================
    # Run again
    # ----------------------------
    else
        echo "Please run script again because your values were not appropriate"
    fi

    

}





# =====================================
#           MAIN
# =====================================
main()
{
    aptProxy

}

main
