#!/bin/bash
LOCATION="Purfleet-On-Thames"
curl "wttr.in/${LOCATION}?format=%l" -s
echo -n "  \$alignr   "
curl "wttr.in/${LOCATION}?format=%C%20%t" -s
echo ""
echo -n "\${alignr}Dawn     "
curl "wttr.in/${LOCATION}?format=%D" -s
echo ""
echo -n "\${alignr}Sunrise  "
curl "wttr.in/${LOCATION}?format=%S" -s
echo ""
echo -n "\${alignr}Zenith   "
curl "wttr.in/${LOCATION}?format=%z" -s
echo ""
echo -n "\${alignr}Sunset   "
curl "wttr.in/${LOCATION}?format=%s" -s
echo ""
echo -n "\${alignr}Dusk     "
curl "wttr.in/${LOCATION}?format=%d" -s
echo ""
