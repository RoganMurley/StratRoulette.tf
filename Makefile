all:
	pulp build --to static/public/main.js

deploy: min
	appcfg.py update static

min:
	uglifyjs static/public/main.js --compress --mangle -o static/public/main.js
	uglifycss static/public/src.css > static/public/main.css
