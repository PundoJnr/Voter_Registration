#connect to database
use DBI;
$dbh = DBI->connect("DBI:mysql:voter_registration:localhost", "root", "");




my $elector_no;
my $name;
my $id;
my $reg_center;
my $polling;
my $assembly;
my $constituency;
my $county;

my $file_decoration = " -----------------------------------------------------------------------------";

sub registration {

	my @elector_no = ();
	my @name = ();
	my @id = ();
	my @reg_center = ();
	my @polling = ();
	my @assembly = ();
	my @constituency = ();
	my @county = ();

	my $done = "Y";
	print "REGISTER NEW VOTER ? (Y/N): ";
	$done = <STDIN>;
	chomp $done;

	#do (uc $done eq "Y") {
	do {	
		print "NAME: ";
		$name = <STDIN>;
		chomp $name;
  		push @name, $name;

		print "ID NUMBER: ";
		$id = <STDIN>;
		chomp $id;
		push @id, $id;

		print "REGISTRATION CENTER: ";
		$reg_center = <STDIN>;
		chomp $reg_center;
		push @reg_center, $reg_center;

		print "POLLING STATION: ";
		$polling = <STDIN>;
		chomp $polling;
		push @polling, $polling;

		print "ASSEMBLY WARD: ";
		$assembly = <STDIN>;
		chomp $assembly;
		push @assembly, $assembly;

		print "CONSTITUENCY: ";
		$constituency = <STDIN>;
		chomp $constituency;
		push @constituency, $constituency;

		print "COUNTY: ";
		$county = <STDIN>;
		chomp $county;
		push @county, $county;

		print "\n";
		print "\n";



		#Check if user exists in database
		my $query    = "SELECT * FROM Voters WHERE id_number=$id";
        my $sth = $dbh->prepare ($query);
        $sth->execute;
        if($sth->fetchrow_array){
            print "You are already a registered voter!\n";
        }else{
        	print "SUCCESSFULLY REGISTERED \nNAME: \t$name \nID NUMBER: \t$id \nREGISTRATION CENTER: \t$reg_center \n";
			print "POLLING STATION: \t$polling \nASSEMBLY WARD: \t$assembly \nCONSTITUENCY: \t$constituency \nCOUNTY: \t$county \n";



            #Write in database
            my $sth = $dbh->prepare("INSERT INTO voters
                       (name, id_number, reg_center, polling_station, assembly_ward, constituency, county, reg_number )
                         values
                       ('$name', '$id', '$reg_center', '$polling', '$assembly', '$constituency', '$county', '$reg_number')");
			$sth->execute() or die $DBI::errstr;
			$sth->finish();


        }



		print "REGISTER NEW VOTER ? (Y/N): ";
		$done = <STDIN>;
		chomp $done;
	}
	while (uc $done eq "Y" ) 
	}

sub viewVoters{
	my $sth = $dbh->prepare("SELECT id, name, id_number, reg_center, polling_station, assembly_ward, constituency, county, reg_number, dor
                        FROM voters");
	$sth->execute() or die $DBI::errstr;
	print "Number of registered voters :" + $sth->rows;

	print "NO NAME 	ID_NUMBER 	REG_CENTER 		POLLING_STATION 	ASSEMBLY_WARD 	CONSTITUENCY 	COUNTY 		REG_NUMBER 	DATE 	";
	while (my @row = $sth->fetchrow_array()) {
	   my ($id ,$name, $id_number, $reg_center, $polling_station, $assembly_ward, $constituency, $county, $reg_number, $dor ) = @row;
	   print "$id $name $id_number $reg_center $polling_station $assembly_ward $constituency $county $reg_number $dor\n";
	}
	$sth->finish();
}

print "WELCOME TO THE IEBC REGISTRATION\n";
print "1.Registration\n2.View registered Voters\n\n";
$choice = <STDIN>;
chomp $choice;
if($choice eq 1){
	registration($dbh);
	}else{
		viewVoters();
	}



