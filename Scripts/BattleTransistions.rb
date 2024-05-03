=begin
  Different Battle Transitions for VX Ace
  version 3
  
  By: Modrome
  
    Problem: The default battle transition sucks.
             Should be self-explanatory lol
    
    Solution: Use a variable to select which transition
              to use, using file names and an array to
              easily let developers manage them. 
              
              As of v2, this also assigns specific speeds
              to each transition.
              
              Compatibility warning: This overrides
              Scene_Map.perform_battle_transition
            
  COPYRIGHT: Apache License 2.0 
=end

module Battle_Transitions
  
  # Configure this to be a spare variable. 
  # Uses the ID, 0011 would be 11
  TRANSITION_VAR = 201
  
  # Each file is located in Graphics/System/BattleStarts
  # BattleStart_x, where x is the string value
  # and i is the variable value in TRANSITION_VAR
  # along with y, which is the amount of frames it should 
  # take to transition, as seen in i=>["x",y]
  TRANSITION_FILES = {
    0 => ["norm",60],
    1 => ["norm",60],
    2 => ["boss", 30],
    3 => ["boss2", 30]
  } # END OF CONFIGURATION, DO NOT TOUCH ANYTHING PAST THIS
  
  def self.Get_Transition
    if (TRANSITION_VAR.nil?)
      return "Graphics/System/BattleStarts/BattleStart_"+ TRANSITION_FILES[0][0]
    end
    return "Graphics/System/BattleStarts/BattleStart_" + TRANSITION_FILES[$game_variables[TRANSITION_VAR]][0]
  end
  
  def self.Get_Transition_Speed
    if (TRANSITION_VAR.nil?)
      return TRANSITION_FILES[0][1]
    end
    return TRANSITION_FILES[$game_variables[TRANSITION_VAR]][1]
  end
end


class Scene_Map < Scene_Base
  def perform_battle_transition
    Graphics.transition(Battle_Transitions.Get_Transition_Speed, Battle_Transitions.Get_Transition , 100)
    Graphics.freeze
  end
end
