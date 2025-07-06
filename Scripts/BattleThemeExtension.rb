=begin

  Battle Theme Extension
  version 1
  
  By: Modrome
  By far my largest script.
  
  
    Problem:  I want to have the basic enemy battle theme be 
              based on which party member was the leader at the
              time the battle starts.
           
   Solution:  As long as a flag is true, the battle BGM will be
              changed at the start of the fight. It can be 
              disabled manually, for instance, before a boss
              fight, to keep the epic boss battle music.
              
              Character fight themes are also defined in this
              script. Based on Actor ID. Very handy to do this
              all in a single script.
              
              WARNING: overrides self.play_battle_bgm in BattleManager
              
              To activate, call this:
              $game_system.actorbt = true
              To deactivate, call this:
              $game_system.actorbt = false
              
              
              Additional: you can change the BGM that the game plays
              post-battle through the following script calls in the 
              middle of a troop battle:
              
              [ Just BGM ]
              BattleManager.post_battle_audio(RPG::BGM.new("Field1", 100, 100))
              
              [ BGM + BGS ]
              BattleManager.post_battle_audio(RPG::BGM.new("Field1", 100, 100), RPG::BGS.new("Rain", 100, 100)) 
              
              Furthermore, you can set BGM_CONT to a switch ID.
              If ON, the BGM will not be replaced with the battle theme.
              By default, the switch ID is 405. Edit in config below.

              Comes with debug messages to aid in diagnosing issues.
            
  COPYRIGHT: Apache License 2.0 

=end

module BattleManager
  
  # START OF CONFIGURATION
  
    ACTOR = {
       #class_id => int,
        1 => RPG::BGM.new('Battle1',100,100),
        2 => RPG::BGM.new('Battle3',100,100),
        # etc...
       # Add new lines as you see fit, make sure every acessible actor in your game is defined or you will get a nil error.
    }
    
    BGM_CONT = 405 # Set to spare Switch ID, ON to disable switching to BTM
    
    BGMEXDEBUG = true; # set to false to disable logging.
    
# [===============================]
#       END OF CONFIGURATION
#   DO NOT TOUCH CODE DOWN BELOW!
# [===============================]
    
end


module BattleManager
  
  # WARNING: OVERRIDE
  
    def self.play_battle_bgm
      if $game_system.actorbt == true
        
        p $game_party.all_members[0].id unless !BGMEXDEBUG # Used for debugging
        
        $game_system.battle_bgm=ACTOR[$game_party.all_members[0].id]
      end
      
      # Continue BGM and enter battle if BGM_CONT is true.
      # Otherwise, play battle music.
      $game_system.battle_bgm.play unless $game_switches[BGM_CONT]
      # Used for debugging
      p "Battle theme change may have been skipped because BGM_CONT was set to " + $game_switches[BGM_CONT].to_s unless !BGMEXDEBUG
    end
    
    # BGM/BGS after the battle can be specified
    def self.post_battle_audio(bgm=nil, bgs=nil)
      @map_bgm = bgm.reset_playback  unless bgm.nil?
      @map_bgs = bgs.reset_playback  unless bgs.nil?
    end
    
end


class Game_System
  def actorbt
    @actorbt = true if @actorbt.nil?
    p "$game_system.actorbt returned " + @actorbt.to_s unless !BattleManager::BGMEXDEBUG
    @actorbt
  end
  
  attr_writer :actorbt
end


# Mixin: Audio File (ogg, mp3, wav, etc.)
class RPG::AudioFile
  # New method: Reset playback position to 00:00:00:000
  def reset_playback
    @pos = 0
    self
  end
end
