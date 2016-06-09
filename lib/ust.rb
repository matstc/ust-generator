#!/usr/bin/env ruby
#require 'sonic_pi'

DEFAULT_BPM=40
CHORD_COUNT=48
KEYS = %w(A B♭ B C D♭ D E♭ E F G♭ G A♭)
USTS = {}
USTS["7"] = ["♭9♭13", "♯11", "♯9", "♭5♭9", "♯9♭13", "♭9", "sus4"]
USTS["▵"] = ["♯11", "9"]
USTS["-7"] = ["13", "♭13"]
USTS["-7♭5"] = ["♭13", "11"]
USTS["º"] = ["13", "♯11"]

class Chord
  def initialize root, quality, extensions, comment=nil
    @root = root
    @quality = quality
    @extensions = extensions
    @comment = comment
  end

  def root_for_sonic_pi
    @root.gsub("♭", "b").gsub("♯", "#")
  end

  def to_s
    string = "#{@root}#{@quality} #{@extensions}"
    string += " :#{@comment}" if @comment
    string
  end

  # Examples from SonicPi:
  #(chord :C, '1')
  #(chord :C, '5')
  #(chord :C, '+5')
  #(chord :C, 'm+5')
  #(chord :C, :sus2)
  #(chord :C, :sus4)
  #(chord :C, '6')
  #(chord :C, :m6)
  #(chord :C, '7sus2')
  #(chord :C, '7sus4')
  #(chord :C, '7-5')
  #(chord :C, 'm7-5')
  #(chord :C, '7+5')
  #(chord :C, 'm7+5')
  #(chord :C, '9')
  #(chord :C, :m9)
  #(chord :C, 'm7+9')
  #(chord :C, :maj9)
  #(chord :C, '9sus4')
  #(chord :C, '6*9')
  #(chord :C, 'm6*9')
  #(chord :C, '7-9')
  #(chord :C, 'm7-9')
  #(chord :C, '7-10')
  def quality_for_sonic_pi
    @quality.
      gsub("♭", "-").
      gsub("♯", "+").
      gsub("º","dim").
      sub(/^-/, "m").
      gsub("▵9", "M7").
      gsub("▵", "M7").
      gsub("add13", "").
      gsub("-13","").
      gsub("dim13", "dim7").
      gsub("+11","").
      gsub("♯11", "").
      gsub(/11$/, "").
      gsub(/13$/, "")
  end
end

def generate_usts
  USTS.flat_map {|quality, alternatives|
    alternatives.select{|alternative| !alternative.start_with?("!")}.flat_map {|alternative|
      KEYS.map {|key|
        Chord.new key, quality, alternative
      }
    }
  }
end

def printout chords
  line = 1
  puts
  chords.each_with_index do |chord, index|
    if index == 0
      print line.to_s.rjust(3, ' ') + ' |' + ' '*5
      line += 1
    elsif index % 4 == 0
      puts "\n\n"
      print line.to_s.rjust(3, ' ') + ' |' + ' '*5
      line += 1
    end
    print chord.to_s.ljust(16, " ")
  end
  puts
end

def create_measure chord, bpm=DEFAULT_BPM
  measure =<<EOF
use_synth :piano
use_bpm #{bpm}
play :#{chord.root_for_sonic_pi}2
sleep 1
play chord(:#{chord.root_for_sonic_pi}3, '#{chord.quality_for_sonic_pi}')
sleep 1
play chord(:#{chord.root_for_sonic_pi}3, '#{chord.quality_for_sonic_pi}')
sleep 1
play chord(:#{chord.root_for_sonic_pi}3, '#{chord.quality_for_sonic_pi}')
sleep 1
EOF
measure.gsub("\n",";")
end

def create_count_in bpm=DEFAULT_BPM
  measure =<<EOF
use_bpm #{bpm}
sample :bd_tek
sleep 1
sample :bd_tek
sleep 1
sample :bd_tek
sleep 1
sample :bd_tek
sleep 1
EOF
measure.gsub("\n",";")
end

def generate_backing_track chords
  create_count_in + chords.map {|chord| create_measure(chord)}.join
end

chords = generate_usts
print "There were #{chords.size} USTs in total."
print " Here are #{CHORD_COUNT}:" if CHORD_COUNT < chords.size
puts
chords = chords.shuffle.sample(CHORD_COUNT)
printout chords
#SONIC_PI = SonicPi.new
#SONIC_PI.run generate_backing_track(chords)
#
#trap("SIGINT") do
  #SONIC_PI.stop
  #exit
#end
#$stdin.getc
