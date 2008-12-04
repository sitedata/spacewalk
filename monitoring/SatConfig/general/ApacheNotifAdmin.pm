package ApacheNotifAdmin;
use Apache;
@ISA=qw(Apache);

sub addGlobalDirectives
{
	my $self = shift();
	my $apacheConf = Apache->getClassVar('apacheConf'); 
	$apacheConf->add_directive(Port=>'8081');
	$apacheConf->add_directive(DocumentRoot => '"/usr/share/nocpulse/htdocs"');
	my $docroot = $apacheConf->add_section(Directory => '/usr/share/nocpulse/htdocs');
        $docroot->add_directive(Allow => 'from  all');
        $docroot->add_directive(Options => 'Indexes');
	$apacheConf->add_directive(AddHandler => 'cgi-script .cgi');
	$apacheConf->add_directive(ScriptAlias => '/cgi-bin/ "/usr/share/nocpulse/cgi-bin/"');
	$apacheConf->add_directive(ScriptAlias => '/cgi-mod-perl/ "/usr/share/nocpulse/cgi-mod-perl/"');
	my $cgibin= $apacheConf->add_section(Directory => '/usr/share/nocpulse/cgi-bin');
        $cgibin->add_directive(Allow => 'from  all');
        $cgibin->add_directive(Options => 'Indexes ExecCGI');
	my $cgiModPerl = $apacheConf->add('section','Location','/cgi-mod-perl');
	$cgiModPerl->add('directive',SetHandler =>'perl-script' );
	$cgiModPerl->add('directive',PerlHandler => 'Apache::Registry' );
	$cgiModPerl->add('directive',PerlSendHeader => 'on');
	$cgiModPerl->add('directive',Options =>'ExecCGI' );
}

1;
