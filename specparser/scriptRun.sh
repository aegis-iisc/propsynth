#/bin/sh
cp specParsermly.bkp specParser.mly
menhir specParser.mly
cp specParser.mly specParsermly.bkp
rm specParser.mly
