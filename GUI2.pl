use CGI;
use warnings;
use Tk;
#Database Connection
use DBI;
$dbh = DBI->connect("DBI:mysql:voter_registration:localhost", "root", "");

#Frame positioning and title
my $mainwindow = MainWindow->new();
$mainwindow->geometry("+600+150");
$mainwindow->title("VOTER REGISTRATION");


#Menu bar
my $main_menu= $mainwindow->Menu();
$mainwindow->configure(-menu => $main_menu);
#file
my $file_menu = $main_menu->cascade(-label=>"File",-underline=>0,-tearoff=>0);
	$file_menu->command(-label=>"New", -underline=>0, -command=>sub{exit}, -state=> 'disabled');
		$file_menu->command(-label=>"Exit", -underline=>0, -command=>sub{exit});

#about
$main_menu->command(-label=>"About",-command=>sub{$mainwindow->messageBox(-title=>"About", -message=>"Voter Registration Group Perl", -type=>"OK")});

#text variable
my $label_id;
my $entry_id;
my $label_name;
my $entry_name;
my $label_reg_center;
my $entry_reg_center;
my $label_polling;
my $entry_polling;
my $label_assembly;
my $entry_assembly;
my $label_constituency;
my $entry_constituency;
my $label_county;
my $entry_county;
my $button_REGISTER;
my $button_VIEW_REGISTERED_VOTERS;
my $button_EXIT;

$label_id = $mainwindow->Label(-text=>'ID Number:')->pack (-anchor=> 'nw');
$entry_id = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=> 'n');

$label_name = $mainwindow->Label(-text=>'Name:')->pack(-anchor=>'nw');
$entry_name = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=>'n');

$label_reg_center = $mainwindow->Label(-text=>'Registration Center:')->pack (-anchor=> 'nw');
$entry_reg_center = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=> 'n');

$label_polling = $mainwindow->Label(-text=>'Polling Station:')->pack (-anchor=> 'nw');
$entry_polling = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=> 'n');

$label_assembly = $mainwindow->Label(-text=>'Assembly Ward:')->pack (-anchor=> 'nw');
$entry_assembly = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=> 'n');

$label_constituency = $mainwindow->Label(-text=>'Constituency:')->pack (-anchor=> 'nw');
$entry_constituency = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=> 'n');

$label_county = $mainwindow->Label(-text=>'County:')->pack (-anchor=> 'nw');
$entry_county = $mainwindow->Entry(-width=>35,-text=>'')->pack(-anchor=> 'n');

$button_REGISTER = $mainwindow->Button(-text=>'Register new voter', -command=>sub{registration})->pack(-anchor=>'s');
$button_VIEW_REGISTERED_VOTERS = $mainwindow->Button(-text=>'View Registered Voters', -command=>sub{viewVoters})->pack(-anchor=>'s');

$button_EXIT = $mainwindow->Button(-text=>'Exit', -command=>sub{exit})->pack(-anchor=>'s');
MainLoop;


