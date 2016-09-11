#!/bin/bash
ENDPATH="$HOME/games/rubyrpg"
echo "Installing RubyRPG to $ENDPATH ..."
# if [ -d "$ENDPATH" ]; then
    mkdir -p "$ENDPATH"
# fi
mkdir $ENDPATH/lib &> /dev/null
cp -rf lib $ENDPATH &> /dev/null
cp -f CHANGELOG.md $ENDPATH/CHANGELOG.md &> /dev/null
cp -f LICENSE.txt $ENDPATH/LICENSE.txt &> /dev/null
cp -f README.md $ENDPATH/README.md &> /dev/null
cp -f rubyrpg $ENDPATH/rubyrpg &> /dev/null
echo "Installed successfully."
echo "You can launch the game by typing:"
echo "    $ENDPATH/rubyrpg"
