zstyle -t :omz:themes:dluciv showbattery
sr=$? # 0 for 1/yes/true, 1 for 0/no/false, 2 for undefined style
if [[ $sr != 1 ]]
then
  omz plugin load battery
  _batt_p_pct () { battery_pct_prompt }
else
  _batt_p_pct () { echo '[]' }
fi
