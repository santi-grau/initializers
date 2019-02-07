#!/bin/sh

# ----------> Setup
echo ┌─────────────────────────┐
echo │ OK! Lets get started... │
echo └─────────────────────────┘
read -p '└─────> Project name : ' varname
echo

if [ -d "$varname" ]; then
  echo 😡 That directory exists!!!
  echo 😔 Sorry, bye
  exit
fi

# ----------> Create root directory
mkdir $varname

# ----------> Welcome :)
npm install --prefix ./$(echo $varname) figlet
echo
{
  echo "var figlet = require( 'figlet' );"
  echo "figlet.fonts( function( err, fonts ) {"
  echo "  var font = fonts[ Math.floor( Math.random( ) * fonts.length ) ];"
  echo "    figlet( 'Start!', { font : font },function( err, data ) {"
  echo "    console.log( data );"
  echo "  });"
  echo "});"
} > $(echo $varname)/welcome.js
echo

node $(echo $varname)/welcome.js
rm -rf $(echo $varname)/*

# Create app dir
mkdir $(echo $varname)/app

# Create views dir
mkdir $(echo $varname)/app/views
{
  echo "doctype"
  echo "html"
  echo "  head"
  echo "    meta(charset='utf-8')"
  echo "    meta(http-equiv='Content-Type',content='text/html; charset=utf-8')"
  echo "    meta(http-equiv='X-UA-Compatible', content='IE=edge')"
  echo "    meta(name='viewport', content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no')"
  echo "    title Project title"
  echo "    link(rel='stylesheet', id='mainStylesheet' href='../css/main.styl')"
  echo "  body"
  echo "    #main"
  echo "    script(src='../js/main.js')"
} > $(echo $varname)/app/views/index.pug

# Create js dir
mkdir $(echo $varname)/app/js
{
  echo "console.log('Welcome')"
} > $(echo $varname)/app/js/main.js

# Create css dir
mkdir $(echo $varname)/app/css
{
  echo "html"
  echo "    height 100%"
  echo "    padding 0"
  echo "    margin 0"
} > $(echo $varname)/app/css/main.styl

# Create package.json
{
  echo '{'
  echo '  "name": "simulator",'
  echo '  "version": "0.0.0",'
  echo '  "description": "",'
  echo '  "main": "index.js",'
  echo '  "scripts": {'
  echo '    "start": "parcel app/views/index.pug --no-hmr",'
  echo '    "build": "rm -rf docs && parcel build app/views/index.pug --out-dir docs"'
  echo '  },'
  echo '  "keywords": [],'
  echo '  "author": "proper-code",'
  echo '  "license": "ISC",'
  echo '  "devDependencies": {'
  echo '    "figlet": "*",'
  echo '    "parcel-bundler": "*"'
  echo '  },'
  echo '  "dependencies": {'
  echo '  }'
  echo '}'
} > $(echo $varname)/package.json

# Create .gitignore
{
  echo ".cache"
  echo "dist"
  echo "node_modules"
  echo "npm-debug.log"
  echo "package-lock.json"
} > $(echo $varname)/.gitignore

# install
npm i --prefix ./$(echo $varname)

# Remove stupid etc dir...
if [ -d $(echo $varname)/etc ]; then
  rm -rf $(echo $varname)/etc
fi

# run
npm start --prefix ./$(echo $varname)

# ----------> End
