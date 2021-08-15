# a secret.sh is a file with config for sending books to Amazon
# polityka_username=ma..
# polityka_passwd=KT..
# mail_username=mag..
# mail_from=mag..
# mail_passwd=xa..
# kindle_mail=mag..
# mail_server=poc..
source secret.sh
#archive
#dev
# rm /Users/magnus/Dropbox/feed.xml # reset feed ;-)
export pocketx_archive=True # not dev does not work at all
rm PocketX.mobi
ebook-convert PocketX.recipe .mobi # --debug-pipeline debug  #; & open Pocket.epub

if test -f "PocketX.mobi"; then
    open PocketX.mobi # check of missing images or problems
    Calibre-smtp -a PocketX.mobi -u $mail_username --password $mail_passwd $mail_from $kindle_mail BODY --encryption-method SSL -r $mail_server
    /usr/local/bin/ebook-viewer PocketX.mobi
    ebook-convert PocketX.mobi .pdf --embed-font-family Arial  --base-font-size 9 --change-justification "justify"
    cp -v PocketX.pdf "/Users/magnus/Dropbox/boox/PocketX `date +'%b %d %Y #%M'`.pdf"
fi

rm polityka.pl.mobi
if test -f "/Users/magnus/Dropbox/feed.xml"; then
    echo 'waiting for feed to be updated...'
    sleep 10
    echo 'polityka: feed exists'
    cat "/Users/magnus/Dropbox/feed.xml"
    if grep -q item "/Users/magnus/Dropbox/feed.xml"; then
	# sleep # wait till feed by pocketx is uploaded
	ebook-convert recipes/polityka.pl.recipe .mobi --debug-pipeline debug --username $mail_username --password $polityka_passwd
	/usr/local/bin/ebook-viewer polityka.pl.mobi
	Calibre-smtp -a polityka.pl.mobi -u $mail_username --password $mail_passwd $mail_from $kindle_mail BODY --encryption-method SSL -v -r $mail_server
	ebook-convert polityka.pl.mobi .pdf --embed-font-family Arial  --base-font-size 9 --change-justification "justify"
	cp -v polityka.pl.pdf "/Users/magnus/Dropbox/boox/polityka.pl.pdf `date +'%b %d %Y #%M'`.pdf"
    else
	echo 'polityka: no items found in the fee'
    fi
else
    echo 'polityka: feed does not exists'
fi
