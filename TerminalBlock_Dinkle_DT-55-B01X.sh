#!/bin/bash

echo 'Generator script for Dinkle Terminal Block DT-55, '

PIN_LIST=$(seq 2 30)
PITCH=10.0

generate_pad() {
  local pin_list=$(seq 0 $(($1-1)))
  local output
  local pin
  local PAD_DRAW
  local PIN_DRAW
  
  for pin in $pin_list;
  do
    local DX=$(bc <<< "scale=2; $pin*$PITCH")

    PAD_DRAW="  (fp_line (start $(bc <<< "scale=2; -4.4+$DX") 7) (end $(bc <<< "scale=2; 4.4+$DX") 7) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -4.4+$DX") 6.5) (end $(bc <<< "scale=2; 4.4+$DX") 6.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -4.4+$DX") 4.4) (end $(bc <<< "scale=2; 4.4+$DX") 4.4) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -4.4+$DX") -6.5) (end $(bc <<< "scale=2; 4.4+$DX") -6.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -4.4+$DX") -4.4) (end $(bc <<< "scale=2; 4.4+$DX") -4.4) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -4.4+$DX") -7) (end $(bc <<< "scale=2; 4.4+$DX") -7) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -0.5+$DX") 2) (end $(bc <<< "scale=2; 0.5+$DX") 2) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -0.5+$DX") -2) (end $(bc <<< "scale=2; 0.5+$DX") -2) (layer F.Fab) (width 0.1))
  (fp_circle (center $(bc <<< "scale=2; $DX") 0) (end $(bc <<< "scale=2; 0.5+$DX") 0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 0.5+$DX") -0.5) (end $(bc <<< "scale=2; 2+$DX") -0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 2+$DX") -0.5) (end $(bc <<< "scale=2; 2+$DX") 0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 2+$DX") 0.5) (end $(bc <<< "scale=2; 0.5+$DX") 0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -0.5+$DX") -0.5) (end $(bc <<< "scale=2; -2+$DX") -0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -2+$DX") -0.5) (end $(bc <<< "scale=2; -2+$DX") 0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -2+$DX") 0.5) (end $(bc <<< "scale=2; -0.5+$DX") 0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 0.5+$DX") 0.5) (end $(bc <<< "scale=2; 0.5+$DX") 4.35) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -0.5+$DX") 0.5) (end $(bc <<< "scale=2; -0.5+$DX") 4.35) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 0.5+$DX") -4.35) (end $(bc <<< "scale=2; 0.5+$DX") -0.5) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -0.5+$DX") -4.35) (end $(bc <<< "scale=2; -0.5+$DX") -0.5) (layer F.Fab) (width 0.1))
  (fp_circle (center $(bc <<< "scale=2; $DX") 0) (end $(bc <<< "scale=2; 4.4+$DX") 0) (layer F.Fab) (width 0.1))"

    if [ $pin -eq $(($1-1)) ]
    then
      PAD_END=""
    else
      PAD_END="  (fp_line (start $(bc <<< "scale=2; 4.4+$DX") -7.75) (end $(bc <<< "scale=2; 4.4+$DX") 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 5.6+$DX") -7.75) (end $(bc <<< "scale=2; 5.6+$DX") 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 4.4+$DX") -7.75) (end $(bc <<< "scale=2; 5.6+$DX") -7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 4.4+$DX") 7.75) (end $(bc <<< "scale=2; 5.6+$DX") 7.75) (layer F.Fab) (width 0.1))"
    fi

    output="$output
$PAD_DRAW
$PAD_END"
  done
  
  echo "$output"
}

generate_pin() {
  local pin_list=$(seq 0 $(($1-1)))
  local output
  local pin
  local PIN_DRAW
  
  for pin in $pin_list;
  do
    local DX=$(bc <<< "scale=2; $pin*$PITCH")

    if [ $pin -eq 0 ]
    then
      PIN_DRAW="  (pad $(($pin+1)) thru_hole rect (at $(bc <<< "scale=2; $DX") 0) (size 3.3 6.6) (drill 2.2) (layers *.Cu *.Mask))"
    else
      PIN_DRAW="  (pad $(($pin+1)) thru_hole oval (at $(bc <<< "scale=2; $DX") 0) (size 3.3 6.6) (drill 2.2) (layers *.Cu *.Mask))"
    fi    

    output="$output
$PIN_DRAW"
  done
  
  echo "$output"
}

generate_draw() {
  local PIN_COUNT=$1
  
  local DX=$(bc <<< "scale=2; $PIN_COUNT*$PITCH")
  
  local PAD=$(generate_pad $1)
  local PIN=$(generate_pin $1)
  
  local COMMON_DRAW="(module TerminalBlock_Dinkle_DT-55-B01X-$(printf %02d $PIN_COUNT)_P10.00mm (layer F.Cu) (tedit 5A78168A)
  (descr \"Dinkle DT-55-B01X Terminal Block  pitch 10.00mm https://www.dinkle.com/en/terminal/DT-55-B01W-XX\")
  (tags \"Dinkle DT-55-B01X Terminal Block  pitch 10.00mm\")
  (fp_text reference REF** (at $(bc <<< "scale=2; -4.92+($DX/2)") -10.16) (layer F.SilkS)
    (effects (font (size 1 1) (thickness 0.15)))
  )
  (fp_text value TerminalBlock_Dinkle_DT-55-B01X-$(printf %02d $PIN_COUNT)_P10.00mm (at $(bc <<< "scale=2; -4.92+($DX/2)") 10.16) (layer F.Fab)
    (effects (font (size 1 1) (thickness 0.15)))
  )
  (fp_line (start -4.4 -7.75) (end -6 -6.15) (layer F.Fab) (width 0.1))
  (fp_line (start -6 7.75) (end -4.4 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -5.6+$DX") 7.75) (end $(bc <<< "scale=2; -4+$DX") 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -5.6+$DX") -7.75) (end $(bc <<< "scale=2; -4+$DX") -7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -5.6+$DX") -7.75) (end $(bc <<< "scale=2; -5.6+$DX") 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start -4.4 -7.75) (end -4.4 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start -6 -7.75) (end -4.4 -7.75) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -4+$DX") -7.75) (end $(bc <<< "scale=2; -4+$DX") 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start -6 -7.75) (end -6 7.75) (layer F.Fab) (width 0.1))
  (fp_line (start -6.35 -8.1) (end -3.85 -8.1) (layer F.SilkS) (width 0.12))
  (fp_line (start -6.35 -5.6) (end -6.35 -8.1) (layer F.SilkS) (width 0.12))
  (fp_line (start -6.1 -7.85) (end $(bc <<< "scale=2; -3.9+$DX") -7.85) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=2; -3.9+$DX") -7.85) (end $(bc <<< "scale=2; -3.9+$DX") 7.85) (layer F.SilkS) (width 0.12))
  (fp_line (start -6.1 7.85) (end $(bc <<< "scale=2; -3.9+$DX") 7.85) (layer F.SilkS) (width 0.12))
  (fp_line (start -6.1 7.85) (end -6.1 -7.85) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=2; -3.4+$DX") -8.35) (end $(bc <<< "scale=2; -3.4+$DX") 8.35) (layer F.CrtYd) (width 0.05))
  (fp_line (start -6.6 8.35) (end $(bc <<< "scale=2; -3.4+$DX") 8.35) (layer F.CrtYd) (width 0.05))
  (fp_line (start -6.6 8.35) (end -6.6 -8.35) (layer F.CrtYd) (width 0.05))
  (fp_line (start -6.6 -8.35) (end $(bc <<< "scale=2; -3.4+$DX") -8.35) (layer F.CrtYd) (width 0.05))
  $PAD
  (fp_text user %R (at $(bc <<< "scale=2; -4.92+($DX/2)") -10.16) (layer F.Fab)
    (effects (font (size 1 1) (thickness 0.15)))
  )
  $PIN
  (model \${KISYS3DMOD}/TerminalBlock_Dinkle.3dshapes/TerminalBlock_Dinkle_DT-55-B01X-$(printf %02d $PIN_COUNT)_P10.00mm.wrl
    (at (xyz 0 0 0))
    (scale (xyz 1 1 1))
    (rotate (xyz 0 0 0))
  )
)"
  
  echo "$COMMON_DRAW"
}

for PIN_COUNT in $PIN_LIST;
do
  FILE_NAME="TerminalBlock_Dinkle_DT-55-B01X-$(printf %02d $PIN_COUNT)_P10.00mm.kicad_mod"
  DRAW="$(generate_draw $PIN_COUNT)"
  
  echo "Generating $FILE_NAME"
  
  echo "$DRAW" > $FILE_NAME
done
