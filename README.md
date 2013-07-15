irssi-awayxmpp
==============

Sends irssi hilights and privatemessages to you via xmpp while you are away.

Use with [screen_away.pl](http://scripts.irssi.org/html/screen_away.pl.html) for most convenience.

![xmpp on n900](sample/n900.png)

Dependencies
------------

* sendxmpp
  + http://sendxmpp.hostname.sk/
  + In debian/ubuntu package *sendxmpp*
* Perl library *String::ShellQuote*
  + In debian/ubuntu package *libstring-shellquote-perl*
  + Or install with CPAN

Installation
------------

1. `wget -O ~/.irssi/scripts/awayxmpp.pl https://raw.github.com/mickname/irssi-awayxmpp/master/awayxmpp.pl`  
2. *optional* `ln -s ~/.irssi/scripts/awayxmpp.pl ~/.irssi/scripts/autorun/awayxmpp.pl`  
3. In irssi `/run awayxmpp.pl`

Setup
-----

You need to provide the xmpp address (google talk, for example) you wish to send the awaymessages to, and account information for the account used for sending.

Use `/set awayxmpp_recipient_address` to set the recipient.

You can set the sending account by using a sendxmpp config file or saving the credentials in irssi. The config file way is preferred, as otherwise your password is seen as a plaintext parameter for the process when sending a message. Creating an account for this purpose only is advised either way.

To use the config file, write your account details to file `.sendxmpprc` in your home directory in format `user@xmpp-provider.com password`. The config must be `chmod 600`:ed (only your user has read access). See `man sendxmpp` for details.

If you wish to save your credentials in irssi, `/set` settings `awayxmpp_account` and `awayxmpp_password` accordingly.

You can check that your settings work with `/awayxmpp_test [message]`. No error reporting is implemented, the process goes background and all output is piped to /dev/null.

Known issues
------------
* Hilights are affected by user styles because we are catching them with irssi signal `print text`.
* No text encoding detection stuff. Actually, it might work with other charsets than utf-8 if sendxmpp also uses the terminal encoding. So maybe its not an issue at all, works for me anyways :)
* If your xmpp-provider does not support TLS, remove the `-t` switch from the command
