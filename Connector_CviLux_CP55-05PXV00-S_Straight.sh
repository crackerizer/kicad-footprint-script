#!/bin/bash

echo 'Generator script for CviLux CP55-XXPXV00-S Straight Connector'

PIN_LIST=$(seq 2 12)
PITCH=3.0

generate_pad() {
  local pin_list=$(seq 1 $(($1-1)))
  local output
  local pin
  local PAD_DRAW
  
  for pin in $pin_list;
  do
    local DX=$(bc <<< "scale=2; $pin*$PITCH")
    
    PAD_DRAW="  (fp_line (start $(bc <<< "scale=2; -1.27+$DX") -1.27) (end $(bc <<< "scale=2; 1.27+$DX") -1.27) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 1.27+$DX") -1.27) (end $(bc <<< "scale=2; 1.27+$DX") 1.27) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; 1.27+$DX") 1.27) (end $(bc <<< "scale=2; -1.27+$DX") 1.27) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=2; -1.27+$DX") 1.27) (end $(bc <<< "scale=2; -1.27+$DX") -1.27) (layer F.Fab) (width 0.1))"

    output="$output
$PAD_DRAW"
  done
  
  echo "$output"
}

generate_pin() {
  local pin_list=$(seq 1 $(($1-1)))
  local output
  local pin
  local PIN_DRAW
  
  for pin in $pin_list;
  do
    local DX=$(bc <<< "scale=2; $pin*$PITCH")
    
    PIN_DRAW="  (pad $(($pin+1)) thru_hole circle (at $(bc <<< "scale=2; $DX") 0) (size 2.2 2.2) (drill 1.1) (layers *.Cu *.Mask))"

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
  
  local COMMON_DRAW="(module Connector_CviLux_CP55-$(printf %02d $PIN_COUNT)PXV00-S_Straight_P3.00mm (layer F.Cu) (tedit 5A9530E6)
  (descr https://connector.cvilux.com/uploads/drawings/100/883/CP35134S.pdf)
  (tags \"CviLux CP35 - 3.00mm Pitch Straight Header Power Connector\")
  (fp_text reference REF** (at $(bc <<< "scale=2; -1.73+($DX/2)") -4.445) (layer F.SilkS)
    (effects (font (size 1 1) (thickness 0.15)))
  )
  (fp_text value Connector_CviLux_CP55-$(printf %02d $PIN_COUNT)PXV00-S_Straight_P3.00mm (at $(bc <<< "scale=2; -1.73+($DX/2)") 5.08) (layer F.Fab)
    (effects (font (size 1 1) (thickness 0.15)))
  )
  (fp_text user %R (at $(bc <<< "scale=2; -1.73+($DX/2)") -4.445) (layer F.Fab)
    (effects (font (size 1 1) (thickness 0.15)))
  )  
  (fp_circle (center -2.66 0) (end -2.66 -0.4) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -1+$DX") -1.93) (end $(bc <<< "scale=3; -1+$DX") 1.93) (layer F.Fab) (width 0.1))
  (fp_line (start -2 -1.93) (end -2 1.93) (layer F.Fab) (width 0.1))
  (fp_line (start -3.325 1.93) (end $(bc <<< "scale=3; 0.325+$DX") 1.93) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; 0.325+$DX") -1.93) (end $(bc <<< "scale=3; 0.325+$DX") 1.93) (layer F.Fab) (width 0.1))
  (fp_line (start -3.325 -1.93) (end $(bc <<< "scale=3; 0.325+$DX") -1.93) (layer F.Fab) (width 0.1))
  (fp_line (start -3.325 -1.93) (end -3.325 1.93) (layer F.Fab) (width 0.1))
  (fp_line (start -1.27 -1.27) (end 1.27 -1.27) (layer F.Fab) (width 0.1))
  (fp_line (start 1.27 -1.27) (end 1.27 1.27) (layer F.Fab) (width 0.1))
  (fp_line (start 1.27 1.27) (end -1.27 1.27) (layer F.Fab) (width 0.1))
  (fp_line (start -1.27 1.27) (end -1.27 -1.27) (layer F.Fab) (width 0.1))
  (fp_line (start 0.5 -2.43) (end 1 -2.43) (layer F.Fab) (width 0.1))
  (fp_line (start 0.5 -2.43) (end 0.25 -1.93) (layer F.Fab) (width 0.1))
  (fp_line (start 1 -2.43) (end 1.25 -1.93) (layer F.Fab) (width 0.1))
  (fp_line (start -2.1 -2.03) (end $(bc <<< "scale=3; -0.9+$DX") -2.03) (layer F.SilkS) (width 0.12))
  (fp_line (start 0.2 -2.03) (end 0.45 -2.53) (layer F.SilkS) (width 0.12))
  (fp_line (start 0.45 -2.53) (end 1.05 -2.53) (layer F.SilkS) (width 0.12))
  (fp_line (start 1.05 -2.53) (end 1.3 -2.03) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=3; 0.425+$DX") -1.2) (end $(bc <<< "scale=3; 0.425+$DX") 2.03) (layer F.SilkS) (width 0.12))
  (fp_line (start -3.425 2.03) (end $(bc <<< "scale=3; 0.425+$DX") 2.03) (layer F.SilkS) (width 0.12))
  (fp_line (start -3.435 2.03) (end -3.435 -1.2) (layer F.SilkS) (width 0.12))
  (fp_line (start -4.25 -3.21) (end $(bc <<< "scale=3; 1.25+$DX") -3.21) (layer F.CrtYd) (width 0.05))
  (fp_line (start $(bc <<< "scale=3; 1.25+$DX") -3.21) (end $(bc <<< "scale=3; 1.25+$DX") 3.73) (layer F.CrtYd) (width 0.05))
  (fp_line (start $(bc <<< "scale=3; 1.25+$DX") 3.73) (end -4.25 3.73) (layer F.CrtYd) (width 0.05))
  (fp_line (start -4.25 3.73) (end -4.25 -3.21) (layer F.CrtYd) (width 0.05))

  (fp_line (start $(bc <<< "scale=3; -0.05+($DX/2)") 1.93) (end $(bc <<< "scale=3; -0.05+($DX/2)") 3.13) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -2.95+($DX/2)") 3.13) (end $(bc <<< "scale=3; -0.05+($DX/2)") 3.13) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -2.95+($DX/2)") 1.93) (end $(bc <<< "scale=3; -2.95+($DX/2)") 3.13) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -3.5+$DX") -2.43) (end $(bc <<< "scale=3; -3.25+$DX") -1.93) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -4+$DX") -2.43) (end $(bc <<< "scale=3; -3.5+$DX") -2.43) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -4+$DX") -2.43) (end $(bc <<< "scale=3; -4.25+$DX") -1.93) (layer F.Fab) (width 0.1))
  (fp_line (start $(bc <<< "scale=3; -4.3+$DX") -2.03) (end $(bc <<< "scale=3; -4.05+$DX") -2.53) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=3; -4.05+$DX") -2.53) (end $(bc <<< "scale=3; -3.45+$DX") -2.53) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=3; -3.45+$DX") -2.53) (end $(bc <<< "scale=3; -3.2+$DX") -2.03) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=3; 0.05+($DX/2)") 2.03) (end $(bc <<< "scale=3; 0.05+($DX/2)") 3.23) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=3; 0.05+($DX/2)") 3.23) (end $(bc <<< "scale=3; -3.05+($DX/2)") 3.23) (layer F.SilkS) (width 0.12))
  (fp_line (start $(bc <<< "scale=3; -3.05+($DX/2)") 3.23) (end $(bc <<< "scale=3; -3.05+($DX/2)") 2.03) (layer F.SilkS) (width 0.12))  
  $PAD
  (pad \"\" thru_hole circle (at $(bc <<< "scale=3; $DX") -1.96) (size 1.62 1.62) (drill 1.32) (layers *.Cu *.Mask))
  (pad \"\" thru_hole circle (at -3 -1.96) (size 1.62 1.62) (drill 1.32) (layers *.Cu *.Mask))
  (pad 1 thru_hole rect (at 0 0) (size 2.2 2.2) (drill 1.1) (layers *.Cu *.Mask))
  $PIN
  (model ${KISYS3DMOD}/Connector_CviLux.3dshapes/Connector_CviLux_CP55-$(printf %02d $PIN_COUNT)PXV00-S_Straight_P3.00mm.wrl
    (at (xyz 0 0 0))
    (scale (xyz 1 1 1))
    (rotate (xyz 0 0 0))
  )
)"

  echo "$COMMON_DRAW"
}

for PIN_COUNT in $PIN_LIST;
do
  FILE_NAME="Connector_CviLux_CP55-$(printf %02d $PIN_COUNT)PXV00-S_Straight_P3.00mm.kicad_mod"
  DRAW="$(generate_draw $PIN_COUNT)"
  
  echo "Generating $FILE_NAME"
  
  echo "$DRAW" > $FILE_NAME
done
