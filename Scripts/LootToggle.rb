=begin
  Loot Can be Toggled [FUNCTIONALITY] for VX Ace
  
  By: Modrome
  
  
    Problem: I wanted to have no loot or EXP/gold gain from
             a certain set of battles, sort of like 
             simulations of boss battles. But giving players
             loot from those battles would be OP, and I only
             want them getting those rewards from the actual
             fights in the story.
             
             Another problem I ran into was there being
             existing methods trying to patch the formulas,
             like Yanfly's Enemy Leveling script, for EXP
             and gold aquisition. Overriding these functions
             would result in players not getting rewarded for
             facing higher-level enemies, which was not ideal.
           
   Solution: This script patches many functions to return
             their original code/functionality if a
             configured game switch is toggled off.
             It is written to be compatible with any
             pre-existing modification to the formulas,
             just put this script below those scripts.
             
   Instructions:
             Place this script below ANY scripts that may also
             change loot and EXP drops.
             
             Use a spare, reserved switch for this script. 
             Set it to ON to disable loot.
             Remember to turn it back to OFF when completing
             the fight that should have loot disabled!
             
            
  COPYRIGHT: Apache License 2.0 
=end

module Loot_Controls
  
  # Configure this to be a spare switch. 
  # Using the ID 0011 would be 11 here
  LOOT_DISABLE_SWITCH = 11
  # Configuration ends here
end



class Game_Enemy < Game_Battler
  
#--------------------------------------------------------------------------
# alias method: exp
#--------------------------------------------------------------------------
  alias prior_exp_funct exp
  def exp
    if $game_switches[Loot_Controls::LOOT_DISABLE_SWITCH]
      return 0
    else
      return prior_exp_funct
    end
  end

#--------------------------------------------------------------------------
# alias method: gold
#--------------------------------------------------------------------------
  alias prior_gold_funct gold
  def gold
    if $game_switches[Loot_Controls::LOOT_DISABLE_SWITCH]
      return 0
    else
      return prior_gold_funct
    end
  end
  
#--------------------------------------------------------------------------
# alias method: make_drop_items
#--------------------------------------------------------------------------
  alias prior_item_dropt_funct make_drop_items
  def make_drop_items
    if $game_switches[Loot_Controls::LOOT_DISABLE_SWITCH]
      
      # Ultimately returns nothing by returning an empty
      # array named "r" while not returning nil.
      enemy.drop_items.inject([]) do |r, di|
        r
      end
      
    else
      #If the switch is not on, then run the previous code.
      prior_item_dropt_funct
    end
    
  end
  
end
