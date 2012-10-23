INPUT_PATH                = ./submodules/bootstrap
OUTPUT_PATH               = ./result
BOOTSTRAP_LESS            = ./swatchmaker/swatchmaker.less
BOOTSTRAP_RESPONSIVE_LESS = ./swatchmaker/swatchmaker-responsive.less

bootstrap:
	mkdir -p ${OUTPUT_PATH}/img
	mkdir -p ${OUTPUT_PATH}/css
	mkdir -p ${OUTPUT_PATH}/js
	cp ${INPUT_PATH}/img/* ${OUTPUT_PATH}/img/
	recess --compile  ${BOOTSTRAP_LESS} > ${OUTPUT_PATH}/css/bootstrap.css
	recess --compress ${BOOTSTRAP_LESS} > ${OUTPUT_PATH}/css/bootstrap.min.css
	recess --compile  ${BOOTSTRAP_RESPONSIVE_LESS} > ${OUTPUT_PATH}/css/bootstrap-responsive.css
	recess --compress ${BOOTSTRAP_RESPONSIVE_LESS} > ${OUTPUT_PATH}/css/bootstrap-responsive.min.css
	cat ${INPUT_PATH}/js/bootstrap-transition.js \
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
	uglifyjs -nc ${OUTPUT_PATH}/js/bootstrap.js > ${OUTPUT_PATH}/js/bootstrap.min.tmp.js
	echo "/*!\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ${OUTPUT_PATH}/js/copyright.js
	cat ${OUTPUT_PATH}/js/copyright.js ${OUTPUT_PATH}/js/bootstrap.min.tmp.js > ${OUTPUT_PATH}/js/bootstrap.min.js
	rm ${OUTPUT_PATH}/js/copyright.js ${OUTPUT_PATH}/js/bootstrap.min.tmp.js

clean:
	rm -rf ${OUTPUT_PATH}

.PHONY: bootstrap
