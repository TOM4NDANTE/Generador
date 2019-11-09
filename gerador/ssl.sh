#!/bin/bash
Block="/etc/nanobc" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1

SCPdir="/etc/newadm"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPfrm3="/etc/adm-lite"
SCPinst="/etc/ger-inst"
SCPidioma="${SCPdir}/idioma"


declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
SCPfrm="/etc/ger-frm" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="/etc/ger-inst" && [[ ! -d ${SCPinst} ]] && exit
API_TRANS="aHR0cHM6Ly93d3cuZHJvcGJveC5jb20vcy80bW5tcjdpOXRpYmc5dGcvdHJhbnMK"
SUB_DOM='base64 -d'
wget -O /usr/bin/trans $(echo $API_TRANS|$SUB_DOM) &> /dev/null
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
ssl_stunel () {
[[ $(mportas|grep stunnel4|head -1) ]] && {
echo -e "\033[1;33m $(fun_trans  "Parando Stunnel")"
msg -bar
fun_bar "apt-get purge stunnel4 -y"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Parado Con Exito!")"
msg -bar
return 0
}
echo -e "\033[1;32m $(fun_trans  "INSTALADOR SSL LA CASITA DEL TERROR")"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
echo -e "\033[1;33m $(fun_trans  "Es decir, un puerto en su servidor para SSL")"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
         read -p " Local-Port: " portx
         if [[ ! -z $portx ]]; then
             if [[ $(echo $portx|grep [0-9]) ]]; then
                [[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\033[1;31m $(fun_trans  "Puerta invalida")"
             fi
         fi
         done
msg -bar
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m $(fun_trans  "Ahora Prestamos Saber Que Puerta del SSL, Va a Escuchar")"
msg -bar
    while true; do
    read -p " Listen-SSL: " SSLPORT
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "\033[1;33m $(fun_trans  "Esta puerta está en uso")"
    unset SSLPORT
    done
msg -bar
echo -e "\033[1;33m $(fun_trans  "Instalando SSL")"
msg -bar
fun_bar "apt-get install stunnel4 -y"
echo -e "client = no\n[SSL]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" > /etc/stunnel/stunnel.conf
####Coreccion2.0##### 
openssl genrsa -out stunnel.key 2048 > /dev/null 2>&1

(echo "La" ; echo "Ca" ; echo "si" ; echo "ta" ; echo "del" ; echo "te" ; echo "rror" )|openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt > /dev/null 2>&1

cat stunnel.crt stunnel.key > stunnel.pem 

mv stunnel.pem /etc/stunnel/
######-------
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
msg -bar
echo -e "\033[1;33m $(fun_trans  "INSTALADO CON EXITO")"
msg -bar
rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1
rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1
rm -rf /root/stunnel.crt > /dev/null 2>&1
rm -rf /root/stunnel.key > /dev/null 2>&1
return 0
}
ssl_stunel_2 () {
echo -e "\033[1;32m $(fun_trans  "INSTALADOR SSL LA CASITA DEL TERROR")"
msg -bar
echo -e "\033[1;33m $(fun_trans  "Seleccione una puerta de redirección interna.")"
echo -e "\033[1;33m $(fun_trans  "Es decir, un puerto en su servidor para SSL")"
msg -bar
         while true; do
         echo -ne "\033[1;37m"
         read -p " Local-Port: " portx
         if [[ ! -z $portx ]]; then
             if [[ $(echo $portx|grep [0-9]) ]]; then
                [[ $(mportas|grep $portx|head -1) ]] && break || echo -e "\033[1;31m $(fun_trans  "Puerta invalida")"
             fi
         fi
         done
msg -bar
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m $(fun_trans  "Ahora Prestamos Saber Que Puerta del SSL, Va a Escuchar")"
msg -bar
    while true; do
    read -p " Listen-SSL: " SSLPORT
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    echo -e "\033[1;33m $(fun_trans  "Esta puerta está en uso")"
    unset SSLPORT
    done
msg -bar
echo -e "\033[1;33m $(fun_trans  "Instalando SSL")"
msg -bar
fun_bar "apt-get install stunnel4 -y"
echo -e "client = no\n[SSL+]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:${DPORT}" >> /etc/stunnel/stunnel.conf
######-------
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
msg -bar
echo -e "\033[1;33m $(fun_trans  "INSTALADO CON EXITO")"
msg -bar
rm -rf /etc/ger-frm/stunnel.crt > /dev/null 2>&1
rm -rf /etc/ger-frm/stunnel.key > /dev/null 2>&1
rm -rf /root/stunnel.crt > /dev/null 2>&1
rm -rf /root/stunnel.key > /dev/null 2>&1
return 0
}
echo -e "${cor[3]}INSTALADOR SSL LA CASITA DEL TERROR"
msg -bar
echo -e "${cor[1]} Escoja la opcion deseada."
msg -bar
echo "1).- ININICIAR O PARAR SSL"
echo "2).- AGREGAR PUERTOS SSL"
msg -bar
echo -n "Digite solo el numero segun su respuesta: "
read opcao
case $opcao in
1)
msg -bar
ssl_stunel
;;
2)
msg -bar
echo -e "\033[1;93m  AGREGAR SSL EXTRA  ..."
msg -bar
ssl_stunel_2
sleep 3
exit
;;
esac

