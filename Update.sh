sudo rm -rf /opt/piratebox
sudo wget -P /tmp/ https://github.com/MaStr/PirateBoxScripts_Webserver/raw/master/piratebox-ws_0.2.0.tar.gz
cd /tmp/
sudo cp -i piratebox-ws_0.2.0.tar.gz /opt/piratebox
sudo tar xzvf piratebox-ws_0.2.0.tar.gz
cd /tmp/piratebox
sudo cp -rv piratebox /opt
sudo ln -s /opt/piratebox/init.d/piratebox /etc/init.d/piratebox 
sudo chmod 777 /opt/piratebox/chat/cgi-bin/data.pso
wget -P /opt/piratebox/bin https://github.com/terrorbyte/PirateBox-Manager/raw/master/PirateBoxManager.sh
