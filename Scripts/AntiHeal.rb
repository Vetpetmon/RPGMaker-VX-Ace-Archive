=begin
  Anti-Heal Status for VX Ace
  version 1
  
  By: Modrome
  
    Problem:  You can't set PHA or REC to negative values.
              I want to have a status that reverses heals.
              I also want that status to be overriden if
              a certain status ID is also present.
              If possible, also add a status ID that can
              not be bypassed by a certain staus ID.
    
    Solution: Set up two status IDs, with one more acting 
              as a counter against one of those statuses.
              Multiply heals by -1 if antiheal is possible.
              Done in a way that can also reverse HP drain/
              lifesteal.
            
  COPYRIGHT: Apache License 2.0 
=end

module AntiHealCore
  ANTIHEALSTATUSID = 67
  OTHERANTIHEALSTATUSID = 69
  ANTIANTIHEALSTATUSID = 68 # Will counter-act ANTIHEALSTATUSID, 
                            # but not OTHERANTIHEALSTATUSID.
end # CONFIGURATION END - DO NOT EDIT PAST HERE!

class Game_Battler
  
  def hasAntiHealStatus?
    (state?(AntiHealCore::ANTIHEALSTATUSID) && !state?(AntiHealCore::ANTIANTIHEALSTATUSID)) || (state?(AntiHealCore::OTHERANTIHEALSTATUSID)) 
  end
  
  def antiheal_heal_effects
    if hasAntiHealStatus?
      # reverse drain
      if @result.hp_drain > 0
        @result.hp_damage *= -1 
        @result.hp_drain *= -1
      # reverse heal
      elsif @result.hp_damage < 0
        @result.hp_damage *= -1
      end
    end
  end
  
  alias :og_execute_damage :execute_damage
  def execute_damage(user)
    antiheal_heal_effects 
    # Calculates reversal BEFORE performing 
    # the damage operations.
    og_execute_damage(user)
  end
end
