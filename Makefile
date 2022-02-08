all:
	@echo ""
	@echo "available targets:"
	@echo ""
	@echo "server               run the local test server"
	@echo "                     http://localhost:1313/"
	@echo "deploy               generate static content"
	@echo "commit               add all content in public/, static/, content/, and run 'git commit'"
	@echo "cleanlogs            delete old server logs in /tmp"


server:	cleanlogs
	hugo server --debug --gc --log --verboseLog --buildDrafts --buildExpired --buildFuture

deploy:	cleanlogs
	hugo --debug --log --buildDrafts --buildExpired --buildFuture
	git status

commit:
	git add public/ static/ content/ layouts/
	git commit

cleanlogs:
	find /tmp/ -mindepth 1 -maxdepth 1 -type f -mmin +60 -name "hugo*" -print0 | xargs -0 -r rm

.PHONY:	all server deploy cleanlogs
