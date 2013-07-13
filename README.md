irssi-awayxmpp
==============

Sends irssi hilights and privatemessages to you via xmpp while you are away.

Dependencies
------------

* sendxmpp
  + http://sendxmpp.hostname.sk/
  + In debian/ubuntu package *sendxmpp*
* Perl library *String::ShellQuote*
  + In debian/ubuntu package *libstring-shellquote-perl*
  + Or install with CPAN

Setup
-----

You need to provide the xmpp address (google talk, for example) you wish to send the awaymessages to, and account information for the account used for sending.

Use `/set awayxmpp_recipient_address` to set the recipient.

You can set the sending account by using a sendxmpp config file or saving the credentials in irssi. The config file way is preferred, as otherwise your password is seen as a plaintext parameter for the process when sending a message. Creating an account for this purpose only is advised either way.

To use the config file, write your account details to file `.sendxmpprc` in your home directory in format `user@xmpp-provider.com password`. The config must be `chmod 600`:ed (only your user has read access). See `man sendxmpp` for details.

If you wish to save your credentials in irssi, `/set` settings `awayxmpp_account` and `awayxmpp_password` accordingly.

You can check that your settings work with `/awayxmpp_test [message]`. No error reporting is implemented, the process goes background and all output is piped to /dev/null.
