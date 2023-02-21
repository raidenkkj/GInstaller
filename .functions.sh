#!/bin/bash

# Variables
Y=$(tput setaf 3)
G=$(tput setaf 2)
BG=${BOL}${G}
BR=${BOL}${R}
R=$(tput setaf 1)
B=$(tput setaf 4)
BOL=$(tput bold)
BLI=$(tput blink)
N=$(tput sgr0)
ctdate=$(date +%Y%m%d%M%S)
metainf_dir="$(pwd)/.template/GSI_INSTALLER/META-INF/"
outdir="$HOME/storage/downloads/YOURGSIS"
zip_name="$gsiname-$ctdate.zip"

# Function for zip installation if block (Portuguese)
pt_func_zip() {
  echo ""
  echo "${R}[!] O Zip não é reconhecido como um programa instalado.${N}"
  sleep 1
  echo "${G}[*] Instalando zip...${N}"
  echo ""
  pkg install zip
  echo ""
  echo "${G}[*] - Feito, pacote zip instalado.${N}"
}

# Function for zip installation if block (English)
en_func_zip() {
  echo ""
  echo "${R}[!] Zip is not recognized as an installed program.${N}"
  sleep 1
  echo "${G}[*] Installing zip...${N}"
  echo ""
  pkg install zip
  echo ""
  echo "${G}[*] - Done, zip package installed.${N}"
}

# Dir path
pt_func_dir() {
  echo ""
  echo "${G}[*] - Digite o caminho do diretório que contém seus arquivos. "
  echo "${G}[*] - Este diretório deve conter os seguintes arquivos:
  
 ${B}- system.img
 ${B}- vendor.img
 ${B}- boot.img
   ${N}"
  read -r -p ${BG}'Diretório: '${B} directory
}

# Dir path
en_func_dir() {
  echo ""
  echo "${G}[*] - Enter the path directory containing your files. "
  echo "${G}[*] - This directory must contain the following files:
  
 ${B}- system.img
 ${B}- vendor.img
 ${B}- boot.img
   ${N}"
  read -r -p ${BG}'Directory: '${B} directory
}

pt_func_gsi_name() {
  echo ""
  echo "${G}[*] - Digite o nome de sua gsi: "
  echo "${G}[*] - Exemplos:
  
  ${B}- crDroid
  ${B}- ArrowOS
  ${B}- LineageOS
   ${N}"
  read -r -p ${BG}'Nome da gsi: '${B} gsiname
}

en_func_gsi_name() {
  echo ""
  echo "${G}[*] - Enter the name of your gsi: "
  echo "${G}[*] - Examples:
  
  ${B}- crDroid
  ${B}- ArrowOS
  ${B}- LineageOS
   ${N}"
  read -r -p ${BG}'Gsi name '${B} gsiname
}

# File func
pt_func_file() {
  echo ""
  echo "${R}[!] - O arquivo ${B}$file${R} não foi encontrado no diretório ${B}$directory${R}.${N}"
  echo "${R}[!] - Encerrando script.${N}"
  sleep 1
  echo ""
  exit 1
}

en_func_file() {
  echo ""
  echo "${R}[!] - The file ${B}$file${R} was not found in the directory ${B}$directory${R}.${N}"
  echo "${R}[!] - Exiting the script.${N}"
  sleep 1
  echo ""
  exit 1
}

pt_func_file2() {
  echo ""
  echo "${G}[*] - Todos os arquivos foram encontrados no diretório ${B}$directory${G}.${N}"
}
en_func_file2() {
  echo ""
  echo "${G}[*] - All specific files were found in the directory ${B}$directory${G}.${N}"
}

pt_func_dir_does_not_exist() {
  echo ""
  echo "${R}[!] - O diretório ${B}$directory${R} não existe."
  echo "${R}[!] - Encerrando script.${N}"
  echo ""
  exit 1
}
en_func_dir_does_not_exist() {
  echo ""
  echo "${R}[!] - The directory ${B}$directory${R} does not exist.${N}"
  echo "${R}[!] - Exiting the script.${N}"
  echo ""
  exit 1
}

pt_func_copying_metainf() {
  echo ""
  echo "${G}[*] - Movendo META-INF para ${B}$directory${G}.${N}"
  cp -r "$metainf_dir" "$directory/META-INF"
  filename="$directory/META-INF/com/google/android/updater-script"
  sed -i "s/<GSINAME>/$gsiname/g" $filename
  echo ""
  echo "${G}[*] - Agora vamos compactar o instalador em um arquivo zip.${N}"
  echo ""
}

en_func_copying_metainf() {
  echo ""
  echo "${G}[*] - Moving META-INF to ${B}$directory${G}.${N}"
  cp -r "$metainf_dir" "$directory/META-INF"
  filename="$directory/META-INF/com/google/android/updater-script"
  sed -i "s/<GSINAME>/$gsiname/g" $filename
  echo ""
  echo "${G}[*] - Now we will compress the installer into a zip file.${N}"
  echo ""
}

pt_func_zipping() {
  echo "${N}${BOL}Compactando ${BLI}$gsiname-$ctdate..."
  echo ""
  cd "$directory"
  zip -0 -r9 -ll "../$gsiname-$ctdate.zip" . -x '*.sh*' -x '*.bak*'
  rm -rf "$directory/META-INF"
}
en_func_zipping() {
  echo "${N}${BOL}Zipping ${BLI}$gsiname-$ctdate..."
  echo ""
  cd "$directory"
  zip -0 -r9 -ll "../$gsiname-$ctdate.zip" . -x '*.sh*' -x '*.bak*'
  rm -rf "$directory/META-INF"
}

pt_func_thats_it() {
  echo ""
  outdir=$(echo "$outdir" | sed 's/\/data\/data\/com.termux\/files\/home//')
  echo "${G}[*] - Pronto, seu GInstaller foi salvo em ${B}$outdir${G}.${N}"
  echo ""
  exit 0
}
en_func_thats_it() {
  echo ""
  outdir=$(echo "$outdir" | sed 's/\/data\/data\/com.termux\/files\/home//')
  echo "${G}[*] - That's it, your GInstaller is saved in ${B}$outdir${G}.${N}"
  echo ""
  exit 0
}

bar() {
  echo "${Y}=================================================${B}"
}
bar2() {
  echo "${Y}=================================================${N}"
}