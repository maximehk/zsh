_soma() {
  local -a commands
  commands=(
    '7soul130:Seven Inch Soul' 'bagel64:BAGeL Radio' 'beatblender130:Beat Blender' 'bootliquor130:Boot Liquor'
    'brfm130:Black Rock FM' 'cliqhop130:cliqhop idm' 'covers64:Covers' 'deepspaceone130:Deep Space One'
    'defcon130:DEF CON Radio' 'digitalis130:Digitalis' 'doomed64:Doomed' 'dronezone130:Drone Zone'
    'dubstep64:Dub Step Beyond' 'earwaves130:Earwaves' 'fluid130:Fluid' 'folkfwd130:Folk Forward'
    'groovesalad130:Groove Salad' 'illstreet130:Illinois Street Lounge' 'indiepop130:Indie Pop Rocks!'
    'lush130:Lush' 'metal130:Metal Detector' 'missioncontrol64:Mission Control' 'poptron64:PopTron'
    'secretagent130:Secret Agent' 'seventies130:Left Coast 70s' 'sf103364:SF 10-33' 'silent130:The Silent Channel'
    'sonicuniverse64:Sonic Universe' 'spacestation130:Space Station Soma' 'suburbsofgoa130:Suburbs of Goa'
    'thetrip64:The Trip' 'thistle130:ThistleRadio' 'u80s130:Underground 80s')
  
  if (( CURRENT == 2 )); then
    _describe -t commands 'commands' commands
  fi

  return 0
}

soma() {
  # sudo apt-get install mplayer2
  typeset station="$1"
  echo "Launching station: '$station'"
  mplayer -playlist "http://somafm.com/${station}.pls"
}

compdef _soma soma

# cat | python << 'eof'
# from bs4 import BeautifulSoup
# import re
# import requests
# doc = BeautifulSoup(requests.get('http://somafm.com/listen').text)
# for li in doc.find_all('li'):
#   title = li.find('h3')
#   if not title:
#     continue

#   for nobr in li.find_all('nobr'):
#     if nobr.text.startswith('AAC'):
#       playlist_href = nobr.find('a').get('href')
#       m = re.search('/(.*)\.pls', playlist_href)
#       if m:
#         playlist = m.group(1)
#         print("'{}:{}'".format(playlist, title.text))
# eof
