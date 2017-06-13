#!/usr/bin/perl

####################################################################################################
# Table Module
# ModuleNum		0001				// Unique record number 
# Author		BLACKJ				// module author
# OptionalDir						// sometimes there's an extra dir in module path name
# ModuleName		Acme-BLACKJ-Utils		// module name
#
# Table TestStatus
# ModuleNum		0001				// FOREIGN KEY(Module) References Module(ModuleNum)
# Error			Module not found|Disk Error...	// Misc. errors
# BuildLog		Complete|Incomplete|Absent|Null|Pending	// created by cpanm --test-only 
#							// Null = to be tested; Pending = test in progress
# BuildLogPath		smoke/.cpanm/perl-5.24.0/work/1234567890.12345/build.log 
# BuildLogResult	Pass|Fail|Other
# Revision		0.01				// module revision number
# DisabledBy		ANDK|None			// ANDK = Testing disabled by this CPAN ID 
#							// [ANDK, BLUEWIND, current tester's ID, etc.]
#							// None = Testing is enabled
# PerlBuild		5.20.3-thread-debug		// module tested under this Perl build revision
# TestDate		1496440070			// epoch date and time of test
# TestDuration		83				// in seconds
# CpanmReport		Complete|Incomplete|Absent	// created by cpanm-remporter
# CpanmReportPath	smoke/.cpanmreporter/offline/sync/pass.Acme-BLACKJ-Utils_0.01.x86_64-linux-gnu-thread-multi.3.13.0-79-generic.[epoch].rpt]
# CpanmReportSent	Yes|No|Unknown
# ScriptName		Smoker.pl			// Perl script carrying out test
# ScriptRevision	0.30				// test script revision
# ScriptDate		1496300070			// epoch time of test script revision
####################################################################################################

use strict;
use DBI;

my $dbh =
  DBI->connect( "dbi:SQLite:dbname=smoke.sqlite", "", "", { RaiseError => 1 } )
  or die $DBI::errstr;

$dbh->do("DROP TABLE IF EXISTS Module");
$dbh->do("DROP TABLE IF EXISTS TestStatus");

$dbh->do("CREATE TABLE Module(ModuleNum INT PRIMARY KEY,Author TEXT,OptionalDir TEXT,ModuleName TEXT)");

$dbh->do("CREATE TABLE TestStatus\
(Error TEXT,\
Revision TEXT,\
DisabledBy TEXT,\
PerlBuild TEXT,\
TestDate INT,\
TestDuration INT,\
BuildLog TEXT,\
BuildLogResult TEXT,\
CpanmReport TEXT,\
CpanmReportSent TEXT,\
ScriptName TEXT,\
ScriptRevision TEXT,\
ScriptDate INT,\
ModuleNum TEXT,\
FOREIGN KEY(ModuleNum) REFERENCES Module(ModuleNum))");

$dbh->do("INSERT INTO Module VALUES(1,'MSCHWERN','','Carp-Fix')");
$dbh->do("INSERT INTO TestStatus VALUES('',\
'1_25-000001',' ','5.24.0',1495040045,85,\
'complete','pass','absent','unknown',\
'Smoker','1.5',1496433380,1)");
$dbh->do("INSERT INTO TestStatus VALUES('',\
'1_25-000001',' ','5.24.0',1495041930,85,
'complete','pass','absent','unknown',\
'Smoker','1.5',1496433380,1)");

$dbh->do("INSERT INTO Module VALUES(2,'MSCHWERN','','Class-Fields')");
$dbh->do("INSERT INTO TestStatus VALUES('',\
'1_25-000001',' ','5.24.0',1495040045,85,\
'complete','pass','absent','unknown',\
'Smoker','1.5',1496433380,1)");
$dbh->do("INSERT INTO TestStatus VALUES('',\
'1_25-000001',' ','5.24.0',1495041930,85,
'complete','pass','absent','unknown',\
'Smoker','1.5',1496433380,1)");

$dbh->disconnect();
