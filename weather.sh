#!/bin/bash
LOCATION="London"
curl "wttr.in/${LOCATION}?format=%l"
echo -n "  \$alignr   "
curl "wttr.in/${LOCATION}?format=%C%20%t"
echo ""
echo -n "\${alignr}Dawn     "
curl "wttr.in/${LOCATION}?format=%D"
echo ""
echo -n "\${alignr}Sunrise  "
curl "wttr.in/${LOCATION}?format=%S"
echo ""
echo -n "\${alignr}Zenith   "
curl "wttr.in/${LOCATION}?format=%z"
echo ""
echo -n "\${alignr}Sunset   "
curl "wttr.in/${LOCATION}?format=%s"
echo ""
echo -n "\${alignr}Dusk     "
curl "wttr.in/${LOCATION}?format=%d"
echo ""