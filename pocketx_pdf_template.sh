# --verbose 
#ebook-convert PocketX_FixTitleAutoTags.recipe .pdf --debug-pipeline debug --base-font-size 9 --change-justification "justify"
#mv -v PocketX_FixTitleAutoTags.pdf "/Users/magnus/Dropbox/boox/PocketX `date +'%b %d %Y'`.pdf"

# --verbose 
# --debug-pipeline debug
# with pl: Corbel Lato Tahoma Verdana Arial
# does not work: 'Noto Sans' Corbel
ebook-convert PocketX.mobi .pdf --embed-font-family Arial  --base-font-size 9 --change-justification "justify"
cp -v PocketX.pdf "/Users/magnus/Dropbox/boox/PocketX `date +'%b %d %Y #%M'`.pdf"
open PocketX.pdf
