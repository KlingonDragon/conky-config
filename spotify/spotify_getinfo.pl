#!/usr/bin/perl

###
## Version  Date      Author    Description
##----------------------------------------------
## 1.0      31/05/14  Shini31   1.0 stable release
## 1.1      10/05/15  Shini31   1.1 fix version
##
####

use strict;
use warnings;
use Net::DBus;
use LWP::Simple;
use POSIX qw(strftime);


# Global Variables
my (
    $current_track_arturl,
    $current_track_artist,
    $current_track_title,
    $current_artist_list,
    $stored_current_track
);
my $home_directory = "/home/klingondragon";
my $conky_directory = $home_directory."/.conky/spotify/";
my $row;

# Dbus construction
my $bus = Net::DBus->session;
my $spotify = $bus->get_service("org.mpris.MediaPlayer2.spotify");
#my $spotify = $bus->get_service("org.mpris.MediaPlayer2.spotpris");
my $interface = $spotify->get_object("/org/mpris/MediaPlayer2", "org.freedesktop.DBus.Properties");
# Current track status (Paused or Playing)
my $current_track_status = $interface->Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus");
my $current_shuffle_status = $interface->Get("org.mpris.MediaPlayer2.Player", "Shuffle");
my $current_loop_status = $interface->Get("org.mpris.MediaPlayer2.Player", "LoopStatus");

# Current track information (artist, title, artUrl, etc.)
my %metadata = %{ $interface->Get("org.mpris.MediaPlayer2.Player", "Metadata") };
while( my( $key, $value ) = each %metadata ){
    if ($key ne 'mpris:artUrl') {
        #print "$key  \${alignr}  $value\n";
    }
}
$current_track_arturl = $metadata{'mpris:artUrl'};
$current_track_title = $metadata{'xesam:title'};

my @artist_list = @{$metadata{'xesam:artist'}};
my $current_track_artists = join('\n', @artist_list);
# Store the current track
open(FILE,'<'.$conky_directory."stored_track.txt") or die "open: ".$!;
$row = <FILE>;
if (defined($row)) {
    chomp $row;
    $stored_current_track = $row;
}
close(FILE);
# Store the current status
open(FILE,'>'.$conky_directory."status.txt") or die "open: ".$!;
print FILE $current_track_status;
close (FILE);
# update the track information and artwork
if ($stored_current_track ne $current_track_title ) {
    open(FILE,'>'.$conky_directory."stored_track.txt") or die "open: ".$!;
    print FILE $current_track_title;
    close (FILE);

    getstore($current_track_arturl, $conky_directory."current_artwork.jpg");
}
# Print track information on conky
if ($current_track_status eq "Playing") {
    print "\$alignc\${color #00ff00}\${font :pixelsize=20}Spotify\${font :pixelsize=2}\n\$hr\n\$font\$color";
    print "\${alignr}$current_track_title";
    print "\n\${alignr}$current_track_artists";
    print "\n\${alignr}".$metadata{'xesam:album'};
    my $track_pos = $interface->Get("org.mpris.MediaPlayer2.Player", "Position");
    my $track_len = $metadata{'mpris:length'};
    print "\n\${font}".strftime("%T", gmtime($track_pos/1000000))."  \${alignr}  ".strftime("%T", gmtime($track_len/1000000));
    print "\n\${execbar ".$conky_directory."bar.sh $track_pos $track_len}";
    print "\${font :pixelsize=12}\n";
    if ($current_shuffle_status) {
        print "Shuffling Playlist";
    } 
    print "  \${alignr}  ";
    if ($current_loop_status ne "None") {
        print "Looping ".$current_loop_status;
    }
    print "\${color #00ff00}\${font :pixelsize=2}\n\$hr";
} else {
    print $current_track_status;
}
