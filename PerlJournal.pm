package PerlJournal;

use strict;
use warnings;
use Time::HiRes qw(gettimeofday);

my $filepath = '/opt/prnl/log.txt';

sub Handler()
{
  my %dispatcher = (
                        add => \&Add,
                        get => \&GetOr,
                        getn => \&GetAnd,
                        rmv => \&RemoveOr,
                        rmvn => \&RemoveAnd,
                        list => \&ListKeyWords,
                    );
  Assert(defined $filepath, "Error with filepath");
  Assert($filepath ne "", "Error with filepath");

  my $function = shift @ARGV;
  $dispatcher{$function}->(@ARGV);
}

sub Add(@)
{
  my (@args) = @_;

  Assert(scalar(@args) >= 0, "No additional arguments added\n");

  my $entry = "";
  for my $word (@args)
  {
    $entry .= $word." ";
  }
  open(my $fh, ">>", $filepath);
  Assert(defined($fh), "Error with jrnl oppening");
  print $fh gettimeofday, "   ", $entry."\n";
}

sub GetOr(@)
{
  my (@key_words) = @_;

  Assert(scalar(@key_words) >= 0, "No additional keywords added\n");
  open(my $fh, "<", $filepath);
  Assert(defined($fh), "Error with jrnl oppening");

  while( my $entry = <$fh>)
  {
    for my $key_word (@key_words)
    {
      if(index($entry, $key_word) != -1 )
      {
        print $entry, "\n";
        last;
      }
    }
  }

  close($fh);
}

sub GetAnd(@)
{
  my (@key_words) = @_;

  Assert(scalar(@key_words) >= 0, "No additional keywords added\n");
  open(my $fh, "<", $filepath);
  Assert(defined($fh), "Error with jrnl oppening");

  while( my $entry = <$fh>)
  {
    for my $key_word (@key_words)
    {
      if(index($entry, $key_word) == -1 )
      {
        $entry = "-1";
        last;
      }
    }
    if($entry ne "-1")
    {
      print $entry;
    }
  }
  close($fh);
}

sub RemoveOr(@)
{
  open(my $fh, "<", $filepath);
  my (@key_words) = @_;

  Assert(defined($fh), "Error with jrnl oppening");
  my @entries = <$fh>;
  close($fh);

  open($fh, ">", $filepath);
  Assert(defined($fh), "Error with jrnl oppening");
  my $match = 0;
  for my $entry (@entries)
  {
    $match = 0;
    for my $key_word (@key_words)
    {
        if(index($entry, $key_word) != -1 )
        {
          $match++;
        }
    }
    if($match == 0)
    {
      print $fh $entry."\n";
      last;
    }
  }
  close($fh);
}

sub RemoveAnd(@)
{
  open(my $fh, "<", $filepath);
  my (@key_words) = @_;

  Assert(defined($fh), "Error with jrnl oppening");
  my @entries = <$fh>;
  close($fh);

  open($fh, ">", $filepath);
  Assert(defined($fh), "Error with jrnl oppening");
  for my $entry (@entries)
  {
    for my $key_word (@key_words)
    {
        if(index($entry, $key_word) == -1 )
        {
          print $fh $entry."\n";
          last;
        }
    }
  }
  close($fh);
}

sub ListKeyWords()
{

  open(my $fh, "<", $filepath);
  Assert(defined($fh), "Error with jrnl oppening");

  while( my $entry = <$fh>)
  {
    if($entry =~ /(@[a-zA-Z0-9]*)/ )
    {
      print $1, "\n";
    }
  }

  close($fh);
}

sub Assert($;$)
{
  my ($condition, $message) = @_;

  my $die = 1;

  if(!$condition)
  {

    my $function = (caller(1))[3];
    my $line = (caller(1))[2];
    print "Error in function: $function line: $line message: $message\n";

    if($die == 0)
    {
      return;
    }
    else
    {
      die;
    }
  }
}

1;
