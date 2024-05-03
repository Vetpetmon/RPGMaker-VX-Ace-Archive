=begin
  YEA Enemy Leveling mode 5 for VX Ace
  
  By: Modrome
  
  
    Problem: Yanfly's Enemy Leveling script is great.
             One small issue: My game disabled party leveling.
             Instead, the game world has a variable that 
             determines the levels that enemies appear at.
             However, because actor leveling is disabled,
             all enemies show up at level 1 to 5.
           
   Solution: This script patches the original formula to
             support a "fifth" mode, one that takes a game 
             variable instead of calculating actor levels.
             Please place this below Yanfly's Enemy Leveling 
             script for it to work properly.
             
             
   Requires: https://yanflychannel.wordpress.com/rmvxa/gameplay-scripts/enemy-levels/
             https://github.com/Archeia/YEARepo/blob/master/Gameplay/Enemy_Levels.rb
   
   Instructions:
             You will need to set DEFAULT_LEVEL_TYPE in 
             YEA-EnemyLevels to 5, as seen here:
             DEFAULT_LEVEL_TYPE = 5
             
             This script MUST be placed somewhere below
             YEA-EnemyLevels on the script list.
             
             Do not forget to configure WORLD_TIER to a 
             spare, reserved variable, and change the value 
             throughout your game as seen necessary
             
            
  COPYRIGHT: Apache License 2.0 
=end


module Enemy_Level_Controls
  
  # Configure this to be a spare variable. 
  #Uses the ID, 0120 would be 120
  WORLD_TIER = 120
  
end

class Game_Party < Game_Unit

  # ====================================
  # Patch: match_party_level(level_type)
  # ====================================
  
  alias og_match_party_level match_party_level
  def match_party_level(level_type)
    case level_type
    when 5; return get_world_tier
    else return og_match_party_level(level_type)
    end
  end
  
  # ====================================
  # New: World Tier
  # ====================================
  def get_world_tier
    if $game_variables[Enemy_Level_Controls::WORLD_TIER].to_i.zero?
      return 1
    else return $game_variables[Enemy_Level_Controls::WORLD_TIER]
    end
  end
  
end
