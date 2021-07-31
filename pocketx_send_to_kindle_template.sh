function prepare {
ebook-convert PocketX.recipe .mobi # --debug-pipeline debug  #; & open Pocket.epub
}

function sent {
    # a secret.sh is a file with config for sending books to Amazon
    # polityka_username=ma..
    # polityka_passwd=KT..
    # mail_username=mag..
    # mail_from=mag..
    # mail_passwd=xa..
    # kindle_mail=mag..
    # mail_server=poc..
    source secret.sh
    echo 'mail: sending...'
    Calibre-smtp -a PocketX.mobi -u $mail_username --password $mail_passwd $mail_from $kindle_mail BODY --encryption-method SSL -r $mail_server
}

#archive
#dev
# rm /Users/magnus/Dropbox/feed.xml # reset feed ;-)
export pocketx_archive=True # not dev does not work at all
rm PocketX.mobi
prepare
if test -f "PocketX.mobi"; then
    open PocketX.mobi # check of missing images or problems
    sent
    sleep 30
fi

rm polityka.pl.mobi
if test -f "/Users/magnus/Dropbox/feed.xml"; then
    echo 'polityka: feed exists'
    ./polityka.sh
else
    echo 'polityka: feed does not exists'
fi
