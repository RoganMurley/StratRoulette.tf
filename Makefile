all:
	elm make src/Main.elm --output=static/public/main.js

deploy: min
	appcfg.py update static

dev: min

install:
	npm install
	bower install

min:
	uglifyjs static/public/main.js --compress --mangle -o static/public/main.js
	uglifycss static/public/src.css > static/public/main.css
