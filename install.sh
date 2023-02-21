#!/bin/bash

# Variable for current directory
SHDIR="$(pwd)"

# Run functions.sh
. "$SHDIR"/.functions.sh || exit $?

echo ${B}
clear
# bar
awk '{print}' "$SHDIR/.banner"
# bar2
echo ""
echo "${Y}[*] - Created by: ${B}@raidenkk${N}"
echo "${Y}[*] - Version: ${B}1.0.0${N}"
echo ""


# Check the language of the user
echo "${Y}[*] - What's your language?${N}"
echo ""
echo "${B}[1] ${Y}- PT-BR${N}"
echo "${B}[2] ${Y}- EN${N}"
echo ""
read -r -p ${BG}'Language: '${B} language

# Create a "permanent" language variable
if [[ "$language" == "1" ]]; then
  lang=pt-br
elif [[ "$language" == "2" ]]; then
  lang=en
else
  echo ""
  echo "${R}[!] Invalid option, try again!${N}"
  echo ""
  exit 0
fi

# Check if zip package is installed
if ! command -v zip > /dev/null; then
  # This actually checks the selected language and executes a function according to the variable 
  if [[ "$lang" == "pt-br" ]]; then
    pt_func_zip
  elif [[ "$lang" == "en" ]]; then
    en_func_zip
  fi
else
  true
fi

# Checks the selected language and executes a function according to the variable
if [[ "$lang" == "pt-br" ]]; then
  pt_func_gsi_name
elif [[ "$lang" == "en" ]]; then
  en_func_gsi_name
fi

# Checks the selected language and executes a function according to the variable
if [[ "$lang" == "pt-br" ]]; then
  pt_func_dir
elif [[ "$lang" == "en" ]]; then
  en_func_dir
fi

# Checks if the specified directory exists
if [ -d "$directory" ]; then
  # The directory exists, now check if the gsi files are there
  gsi_files=(system.img vendor.img boot.img)
  for file in "${gsi_files[@]}"; do
    if [ ! -f "$directory/$file" ]; then
      if [[ "$lang" == "pt-br" ]]; then
        pt_func_file
      elif [[ "$lang" == "en" ]]; then
        en_func_file
      fi
    fi
  done
  if [[ "$lang" == "pt-br" ]]; then
    pt_func_file2
  elif [[ "$lang" == "en" ]]; then
    en_func_file2
  fi
else
  if [[ "$lang" == "pt-br" ]]; then
    pt_func_dir_does_not_exist
  elif [[ "$lang" == "en" ]]; then
    en_func_dir_does_not_exist
  fi
fi

if [[ "$lang" == "pt-br" ]]; then
  pt_func_copying_metainf
elif [[ "$lang" == "en" ]]; then
  en_func_copying_metainf
fi

if [[ "$lang" == "pt-br" ]]; then
  pt_func_zipping
elif [[ "$lang" == "en" ]]; then
  en_func_zipping
fi

if [[ -d "$outdir" ]]; then
  mv "../$gsiname-$ctdate.zip" "$outdir"
else
  mkdir "$outdir"
  mv "../$gsiname-$ctdate.zip" "$outdir"
fi

if [[ "$lang" == "pt-br" ]]; then
  pt_func_thats_it
elif [[ "$lang" == "en" ]]; then
  en_func_thats_it
fi
