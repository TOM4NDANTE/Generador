#!/bin/bash
#  GENERADOR MASTER
clear
txt1="GENERADOR MASTER CREADO POR ROCK SOLID"
txt2="INSTALACIONES"
txt3="DISTRIBUIDO POR"
txt4="@Lupislive"
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh apacheon.sh cambiopass.sh Crear-Demo.sh dados.py dados.sh dropbear.sh fai2ban.sh GENERADOR_BIN.sh Gestor.sh gerar.sh htop.sh insta_painel MasterBin.sh menu openvpn.sh Painel.sh paysnd.sh payySND.sh PDirect.py PGet.py POpen.py ports.sh PPriv.py PPub.py Proxy-Privado.sh Proxy-Publico.sh rootpass.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh ssl.sh ssld.sh ssrrmu.sh toolmaster.py ultrahost unddos.py usercodes utils.sh vnc message.txt http-server.py dados.zip painel.zip"
IVAR="/etc/http-instas"
BARRA="\033[1;36m-----------------------------------------------------\033[0m"
echo -e "$BARRA"
cat << EOF

           $txt1
           $txt2: $(cat $IVAR)
           $txt3: $txt4

EOF
SCPT_DIR="/etc/SCRIPT"
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
INSTA_ARQUIVOS="ADMVPS.zip"
DIR="/etc/http-shell"
LIST="coR"
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
mudar_instacao () {
while [[ ${var[$value]} != 0 ]]; do
[[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="ADMbot.sh apacheon.sh cambiopass.sh Crear-Demo.sh dados.py dados.sh dropbear.sh fai2ban.sh GENERADOR_BIN.sh Gestor.sh gerar.sh htop.sh insta_painel MasterBin.sh menu openvpn.sh Painel.sh paysnd.sh payySND.sh PDirect.py PGet.py POpen.py ports.sh PPriv.py PPub.py Proxy-Privado.sh Proxy-Publico.sh rootpass.sh shadowsocks.sh sockspy.sh speed.sh speedtest.py squid.sh ssl.sh ssld.sh ssrrmu.sh toolmaster.py ultrahost unddos.py usercodes utils.sh vnc message.txt http-server.py dados.zip painel.zip"
clear
echo -e $BARRA
echo -e "MENU PARA SELECCIONAR LOS ARCHIVOS A INSTALAR"
echo -e $BARRA
echo "[0] - FINALIZAR PROCEDIMENTO"
i=1
for arqx in `ls ${SCPT_DIR}`; do
[[ $arqx = @(gerar.sh|http-server.py) ]] && continue
[[ $(echo $BASICINST|grep -w "$arqx") ]] && echo "[$i] - [X] - $arqx" || echo "[$i] - [ ] - $arqx"
var[$i]="$arqx"
let i++
done
echo -ne "Seleccione un archivo [Adicionar/Eliminar]: "
read value
[[ -z ${var[$value]} ]] && return
if [[ $(echo $BASICINST|grep -w "${var[$value]}") ]]; then
rm /etc/newadm-instalacao
local BASIC=""
  for INSTS in $(echo $BASICINST); do
  [[ $INSTS = "${var[$value]}" ]] && continue
  BASIC+="$INSTS "
  done
echo $BASIC > /etc/newadm-instalacao
else
echo "$BASICINST ${var[$value]}" > /etc/newadm-instalacao
fi
done
}
fun_list () {
rm ${SCPT_DIR}/*.x.c &> /dev/null
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
echo -e "[b] -> INSTALACION PARA GENERADOR DE KEY"
read -p "Seleccione su instalacion: " readvalue
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS
[[ -z $readvalue ]] && readvalue="b"
read -p "Nombre de usuario ( quien utilazara la key ): " nombrevalue
[[ -z $nombrevalue ]] && nombrevalue="unnamed"
if [[ $readvalue = @(b|B) ]]; then
#ADM BASIC
 arqslist="$BASICINST"
 for arqx in `echo "${arqslist}"`; do
 [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
 cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
 echo "$arqx" >> ${DIR}/${KEY}/${LIST}
 done
else
 for arqx in `echo "${readvalue}"`; do
 #UNE ARQ
 [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 cp ${SCPT_DIR}/${arq_list[$arqx]} ${DIR}/${KEY}/
 echo "${arq_list[$arqx]}" >> ${DIR}/${KEY}/${LIST}
 done
echo "TRUE" >> ${DIR}/${KEY}/FERRAMENTA
fi
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
echo -e "$BARRA"
echo -e "Key Ativa, e Aguardando Instalacao!"
echo -e "$BARRA"
}
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
gerar_key () {
valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
echo -e "KEY: $keyfinal\nGenerada!"
echo -e "$BARRA"
read -p "Enter to Finalizar"
}
att_gen_key () {
i=0
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
keys="$keys $arqs"
let i++
fi
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Escoja cual actualizar[t=todos]: " -e -i 0 value
done
[[ $value = 0 ]] && return
if [[ $value = @(t|T) ]]; then
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
KEYDIR="$DIR/$arqs"
rm $KEYDIR/*.x.c &> /dev/null
 if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then #Keyen Atualiza
 rm ${KEYDIR}/${LIST}
   for arqx in `ls $SCPT_DIR`; do
    cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
    echo "${arqx}" >> ${KEYDIR}/${LIST}
    rm ${SCPT_DIR}/*.x.c &> /dev/null
    rm $KEYDIR/*.x.c &> /dev/null
   done
 arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 fi
let i++
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo -e "$BARRA"
echo -ne "\033[0m" && read -p "Enter"
return 0
fi
KEYDIR="$DIR/${keys[$value]}"
[[ -d "$KEYDIR" ]] && {
rm $KEYDIR/*.x.c &> /dev/null
rm ${KEYDIR}/${LIST}
  for arqx in `ls $SCPT_DIR`; do
  cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
  echo "${arqx}" >> ${KEYDIR}/${LIST}
  rm ${SCPT_DIR}/*.x.c &> /dev/null
  rm $KEYDIR/*.x.c &> /dev/null
  done
 arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
 echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
 read -p "Enter"
 rm ${SCPT_DIR}/*.x.c &> /dev/null
 }
}
remover_key () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
echo "[$i] Retornar"
keys="$keys retorno"
let i++
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
if [[ ! -e ${DIR}/${arqs}/used.date ]]; then
echo -e "\033[1;32m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m (ESPERANDO USO)\033[0m"
else
echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m ($(cat ${DIR}/${arqs}/used.date) IP: $(cat ${DIR}/${arqs}/used))\033[0m"
fi
keys="$keys $arqs"
let i++
done
keys=($keys)
echo -e "$BARRA"
while [[ -z ${keys[$value]} || -z $value ]]; do
read -p "Escoja Cual Remover: " -e -i 0 value
done
[[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* || return
}
remover_key_usada () {
i=0
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
arqsx=$(ofus "$IP:8888/$arqs/$LIST")
 if [[ -e ${DIR}/${arqs}/used.date ]]; then #KEY USADA
  if [[ $(ls -l -c ${DIR}/${arqs}/used.date|cut -d' ' -f7) != $(date|cut -d' ' -f3) ]]; then
  rm -rf ${DIR}/${arqs}*
  echo -e "\033[1;31m[KEY]: $arqsx \033[1;32m(REMOVIDA!)\033[0m" 
  else
  echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(DISPONIBLE!)\033[0m"
  fi
 else
 echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(DISPONIBLE!)\033[0m"
 fi
let i++
done
echo -e "$BARRA"
echo -ne "\033[0m" && read -p "Enter"
}
start_gen () {
PIDGEN=$(ps x|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
# screen -dmS generador /bin/http-server-pass.sh -start
else
killall http-server.sh
# killall http-server-pass.sh
fi
}
message_gen () {
read -p "NEW MESSAGE: " MSGNEW
echo "$MSGNEW" > ${SCPT_DIR}/message.txt
echo -e "$BARRA"
}
rmv_iplib () {
echo -e "SERVIDORES DE KEY ACTIVOS!"
rm /var/www/html/newlib && touch /var/www/html/newlib
rm ${SCPT_DIR}/*.x.c &> /dev/null
[[ -z $(ls $DIR|grep -v "ERROR-KEY") ]] && return
for arqs in `ls $DIR|grep -v "ERROR-KEY"|grep -v ".name"`; do
if [[ $(cat ${DIR}/${arqs}.name|grep GERADOR) ]]; then
var=$(cat ${DIR}/${arqs}.name)
ip=$(cat ${DIR}/${arqs}/keyfixa)
echo -ne "\033[1;31m[USUARIO]:(\033[1;32m${var%%[*}\033[1;31m) \033[1;33m[GERADOR]:\033[1;32m ($ip)\033[0m"
echo "$ip" >> /var/www/html/newlib && echo -e " \033[1;36m[ACTUALIZADO]"
fi
done
echo -e "$BARRA"
read -p "Enter"
}
meu_ip
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31moff" || PID_GEN="\033[1;32monline"
echo -e "$BARRA"
echo -e "Diretorio Dos Arquivos Repassados \033[1;31m${SCPT_DIR}\033[0m"
echo -e "$BARRA"
echo -e "[1] = GENERAR 1 KEY ALEATORIA"
echo -e "[2] = APAGAR/OLHAR KEYS"
echo -e "[3] = LIMPAR KEYS USADAS"
echo -e "[4] = ALTERAR ARQUIVOS KEY BASICA"
echo -e "[5] = START/STOP KEYGEN $PID_GEN\033[0m"
echo -e "[6] = VER LOG"
echo -e "[7] = MUDAR MENSAGEM"
echo -e "[8] = ATUALIZAR GERADOR"
echo -e "[0] = SAIR"
echo -e "$BARRA"
while [[ ${varread} != @([0-8]) ]]; do
read -p "Opcao: " varread
done
echo -e "$BARRA"
if [[ ${varread} = 0 ]]; then
exit
elif [[ ${varread} = 1 ]]; then
gerar_key
elif [[ ${varread} = 2 ]]; then
remover_key
elif [[ ${varread} = 3 ]]; then
remover_key_usada
elif [[ ${varread} = 4 ]]; then
mudar_instacao
elif [[ ${varread} = 5 ]]; then
start_gen
elif [[ ${varread} = 6 ]]; then
echo -ne "\033[1;36m"
cat /etc/gerar-sh-log 2>/dev/null || echo "NENHUM LOG NO MOMENTO"
echo -ne "\033[0m" && read -p "Enter"
elif [[ ${varread} = 7 ]]; then
message_gen
elif [[ ${varread} = 8 ]]; then
apt-get update; apt-get upgrade; wget https://www.dropbox.com/s/179vvhgoipn8t5j/instgerador.sh && chmod +x instgerador.sh && ./instgerador.sh
fi
/usr/bin/gerar.sh

