include profile.properties

.PHONY: html fix-html data toc ncx opf gen


default: build

SED=sed -i ''

clean:
	@rm -fr .tmp

build: data res ncx opf
	@echo 'Create ebook file by kindlegen ...'
	@kindlegen -dont_append_source -verbose -c2 .tmp/vim-help.opf -o vim-help.azw3
	@mv .tmp/vim-help.azw3 ./
	@echo '  Generate kf8 file: vim-help.azw3'
	@echo 'Build success'

html: clean
	@echo 'Convert text to html ...'
	@find $(DOC_PATH) -name '*.txt' -exec perl $(DOC_PATH)/vim2html.pl $(DOC_PATH)/tags {} \; > /dev/null
	@perl $(DOC_PATH)/vim2html.pl $(DOC_PATH)/tags $(DOC_PATH)/tags > /dev/null
	@mkdir -p .tmp
	@mv *html .tmp
	@mv vim-stylesheet.css .tmp
	@echo "  Generate `ls .tmp | wc -l |tr -d ' '` html files"

fix-html: html
	@echo 'Preparing clean html ...'
	@find .tmp -name '*.html' -exec $(SED) '/<p><i>Generated by vim2html/d' {} \;
	@echo '  Remove vim2html information'
	@find .tmp -name '*.html' -exec $(SED) 's/vim:tw=78:.*:ft=help[a-z=:]*//g' {} \;
	@echo '  Clean useless content'

fix-warn:
	@sed -i '' 

data: fix-html
	@echo 'Search toc data to xml ...'
	@egrep '^(<code class="se|\|)' .tmp/help.html >toc.txt
	@$(SED) 's/"tags#help-tags/"tags.html/g' toc.txt
	@$(SED) 's/^<code class="section">\(.*\)<\/code>/<\/chapter><chapter title="\1">/g' toc.txt
	@$(SED) 's/^|<a href="\(.*\)">\(.*\)<\/a>|\(.*\)/<section title="\2" href="\1" src="\1">\3<\/section>/g' toc.txt
	@$(SED) 's/\( src=".*\)#.*"/\1"/g' toc.txt
	@$(SED) -E 's/[[:space:]]+/ /g' toc.txt
	@$(SED) 's/> />/g' toc.txt
	@$(SED) 's/title="\(.*\) ">/title="\1">/g' toc.txt
	@$(SED) '1 s/^<\/chapter>/<root>/' toc.txt
	@$(SED) -E '1,10 {/"\(iccf|bugs|tutor|copying|www\)"/d;}' toc.txt
	@$(SED) -E '1,6 {/iccf|www/d;}' toc.txt
	@echo '</chapter></root>' >> toc.txt
	@mv toc.txt toc.xml
	@echo '  Generate toc data file'

toc:
	@echo 'Create toc.html ...'
	@xsltproc vim-help.toc.html-template.xsl toc.xml > .tmp/toc.html

opf:
	@echo 'Create vim-help.opf ...'
	@xsltproc vim-help.opf-template.xsl toc.xml > .tmp/vim-help.opf

ncx:
	@echo 'Create vim-help.ncx ...'
	@xsltproc vim-help.toc.ncx-template.xsl toc.xml > .tmp/vim-help.ncx

res:
	@cp -r static/* .tmp

gen: data res ncx opf
	@echo 'Create ebook file by kindlegen ...'
	kindlegen -dont_append_source -verbose .tmp/vim-help.opf -o vim-help.azw3
	@echo '  Generate kf8 file, ok'
