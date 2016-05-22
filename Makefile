all:
	pulp build --to static/public/main.js

upload:
	appcfg.py update static
