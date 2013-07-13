use strict;
use Irssi;
use POSIX;
use String::ShellQuote qw(shell_quote);
use vars qw($VERSION %IRSSI);

$VERSION = "1.0";
%IRSSI   = (
	authors     => "Mikko \"mickname\" Luodemaa",
	contact     => "mickname @ IRCNet",
	url         => "https://github.com/mickname/irssi-awayxmpp",
	name        => "awayxmpp",
	description => "Send hilightworthy messages via xmpp when you are away",
	license     => "Apache License, version 2.0"
);

#Global variables for settings
my ($sendxmpp_opts, $xmpp_recipient);

sub signal_priv_msg {
	my ($server, $msg, $nick, $address, $target) = @_;

	#messages caught with signal 'message private' come with color codes, strip them
	my $stripped = Irssi::strip_codes($msg);

	if ($server->{usermode_away}) {
		send_msg("<${nick}> ${stripped}\n\@ privmsg");
	}
}

sub signal_print_text {
	my ($dest, $text, $stripped) = @_;
	my $server = $dest->{server};
	my $chan = $dest->{target};

	if ($server->{usermode_away} && $dest->{level} & MSGLEVEL_HILIGHT) {
		send_msg("${stripped}\n\@ ${chan}");
	}
}

sub send_msg {
	my ($msg) = @_;

	#Irssi::print('(echo ' . shell_quote($msg) . ' | sendxmpp' . $sendxmpp_opts . ' ' . shell_quote($xmpp_recipient) . ' > /dev/null 2>&1 )&');
	system('(echo ' . shell_quote($msg) . ' | sendxmpp' . $sendxmpp_opts . ' ' . shell_quote($xmpp_recipient) . ' > /dev/null 2>&1 )&');

}

sub reload_settings {
	$xmpp_recipient = Irssi::settings_get_str($IRSSI{'name'} . '_recipient_address');
	my ($username, $jserver) = split(/@/, Irssi::settings_get_str($IRSSI{'name'} . '_account'));
	my $password = Irssi::settings_get_str($IRSSI{'name'} . '_password');

	if ($xmpp_recipient eq '') {
		Irssi::print("$IRSSI{'name'}: Remember to set xmpp recipient address!", MSGLEVEL_CLIENTCRAP);
	}

	if ($username ne '' && $jserver ne '' && $password ne '') {
		$sendxmpp_opts = ' -u ' . shell_quote($username) . ' -j ' . shell_quote($jserver) . ' -p ' . shell_quote($password);
	} else {
		$sendxmpp_opts = '';
	}
}

Irssi::settings_add_str($IRSSI{'name'}, $IRSSI{'name'} . '_recipient_address', '');
Irssi::settings_add_str($IRSSI{'name'}, $IRSSI{'name'} . '_account',           '');
Irssi::settings_add_str($IRSSI{'name'}, $IRSSI{'name'} . '_password',          '');


Irssi::command_bind('awayxmpp_test', 'send_msg');

Irssi::signal_add('setup changed', 'reload_settings');

Irssi::signal_add_last('message private', 'signal_priv_msg');
Irssi::signal_add_last('print text',      'signal_print_text');

reload_settings();