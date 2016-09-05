all:
	elm make src/Main.elm --output=static/public/main.js
	cp static/public/src.css static/public/main.css

deploy: min
	appcfg.py update static

min:
	uglifyjs static/public/main.js --compress --mangle -o static/public/main.js
	uglifycss static/public/src.css > static/public/main.css
