INPUT_PATH                = ./ext/bootstrap
OUTPUT_PATH               = ./result
BOOTSTRAP_LESS            = ./assembler/swatchmaker.less
BOOTSTRAP_RESPONSIVE_LESS = ./assembler/swatchmaker-responsive.less
DATE                      = $(shell date +%I:%M%p)
CHECK                     = \033[32m✔\033[39m
HR                        = "\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#"

build:
	@echo -e "\n${HR}"
	@echo -e "Building Bootstrap..."
	@echo -e "${HR}\n"
	@mkdir -p ${OUTPUT_PATH}/img
	@mkdir -p ${OUTPUT_PATH}/css
	@mkdir -p ${OUTPUT_PATH}/js
	@mkdir -p ${OUTPUT_PATH}/font
	@cp ${INPUT_PATH}/img/* ${OUTPUT_PATH}/img/
	@cp ${INPUT_PATH}/assets/font-awesome/font/* ${OUTPUT_PATH}/font/
	@echo -en "Compiling LESS with Recess..."
	@recess --compile  ${BOOTSTRAP_LESS} > ${OUTPUT_PATH}/css/bootstrap.css
	@recess --compress ${BOOTSTRAP_LESS} > ${OUTPUT_PATH}/css/bootstrap.min.css
	@recess --compile  ${BOOTSTRAP_RESPONSIVE_LESS} > ${OUTPUT_PATH}/css/bootstrap-responsive.css
	@recess --compress ${BOOTSTRAP_RESPONSIVE_LESS} > ${OUTPUT_PATH}/css/bootstrap-responsive.min.css
	@echo -e "               ${CHECK} Done"
	@echo -en "Compiling and minifying javascript..."
	@cat ${INPUT_PATH}/js/bootstrap-transition.js \
		${INPUT_PATH}/js/bootstrap-alert.js \
		${INPUT_PATH}/js/bootstrap-button.js \
		${INPUT_PATH}/js/bootstrap-carousel.js \
		${INPUT_PATH}/js/bootstrap-collapse.js \
		${INPUT_PATH}/js/bootstrap-dropdown.js \
		${INPUT_PATH}/js/bootstrap-modal.js \
		${INPUT_PATH}/js/bootstrap-tooltip.js \
		${INPUT_PATH}/js/bootstrap-popover.js \
		${INPUT_PATH}/js/bootstrap-scrollspy.js \
		${INPUT_PATH}/js/bootstrap-tab.js \
		${INPUT_PATH}/js/bootstrap-typeahead.js \
		${INPUT_PATH}/js/bootstrap-affix.js \
			> ${OUTPUT_PATH}/js/bootstrap.js
	@uglifyjs -nc ${OUTPUT_PATH}/js/bootstrap.js > ${OUTPUT_PATH}/js/bootstrap.min.tmp.js
	@echo "/*!\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ${OUTPUT_PATH}/js/copyright.js
	@cat ${OUTPUT_PATH}/js/copyright.js ${OUTPUT_PATH}/js/bootstrap.min.tmp.js > ${OUTPUT_PATH}/js/bootstrap.min.js
	@echo -e "       ${CHECK} Done"
	@echo -e "\n${HR}"
	@echo -e "Bootstrap successfully built at ${DATE}."
	@echo -e "${HR}\n"
	@rm ${OUTPUT_PATH}/js/copyright.js ${OUTPUT_PATH}/js/bootstrap.min.tmp.js

clean:
	rm -rf ${OUTPUT_PATH}
