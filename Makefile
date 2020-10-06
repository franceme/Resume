# region Settings
.PHONY: clean
MAKEFLAGS += --silent
# endregion
# region Variables
SRC=*.tex
PyGen=Gentex.py
Info=Info.json

Website=./_data/

LUA=lualatex
XE=xelatex
# endregion

default::compile
# region Install
install:
	@echo Checking for sudo access
	@sudo -v

	@echo Installing the packages
	@sudo apt install texlive-full texlive-luatex python3 python3-pip python3-yaml -y
# endregion
# region Buiilders
gen: $(PyGen)
	@echo Generating file ${file}.tex
	./$(PyGen) $(Info) ${file}.tex ${file}_AUTO.tex

build:
	@echo Building the file ${file}
	@echo Build 1
	@${tool} ${file}_AUTO.tex ${file}.pdf > ${file}_AUTO_build.log
	@echo Build 2
	@${tool} ${file}_AUTO.tex ${file}.pdf > ${file}_AUTO_build.log

XEBuild: 
	@echo Generating ${file}
	@make file="${file}" gen
	@echo Building the report
	@make tool="${XE}" file="${file}" build
	#@tectonic ${file}_AUTO.tex
	@mv ${file}_AUTO.pdf ${file}.pdf

LUABuild:
	@echo Generating ${file}
	@make file="${file}" gen
	@echo Building the report
	@make tool="${LUA}" file="${file}" build
	@mv ${file}_AUTO.pdf ${file}.pdf
# endregion
# region Documents
cv: CV.tex
	@make XEBuild file="CV"

oldcv: CV_bak.tex
	@make XEBuild file="CV_bak"

cover: CoverLetter.tex
	@make XEBuild file="CoverLetter"

resume: Resume.tex
	@make LUABuild file="Resume"

website: $(PyGen)
	@echo Website
	@-mkdir $(Website)
	@./$(PyGen) $(Info) $(Website)

encode: $(Info)
	@echo Creating the base64 encodded json
	@-rm $(Info).base64
	@base64 $(Info) > $(Info).base64
	#@tr -d '\n' <$(Info).base64
	@sed -e :a -e '$!N;s/\n//;ta' $(Info).base64 > $(Info).base64.tmp
	@mv $(Info).base64.tmp $(Info).base64
# endregion
# region Builder
release:
	@mkdir Release
	@mv *.pdf Release/
compile: clean cv resume website #cover release
	@make soft
# endregion
# region Cleaners
soft:
	@echo SoftClean
	@-rm *.log
	@-rm *.out
	@-rm *.xwm
	@-rm *.aux
	@-rm *_AUTO*
	
clean: soft
	@echo Clean
	@-rm -r $(Website)
	@-rm -r Release/
# endregion
