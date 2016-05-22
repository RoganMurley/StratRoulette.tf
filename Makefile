all:
	pulp build --to static/public/main.js

deploy:
	appcfg.py update static
