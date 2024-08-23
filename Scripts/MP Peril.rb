=begin
  Peril Status for VX Ace (MP Edition)
  version 0
  
  By: Modrome
  
    An MP version of the Peril script,
    this applies an effect similar to 
    Peril, but instead of taking HP into
    account, this uses the MP value.

    HP Peril is still included.

    This script allows you to create
    characters who use their MP as their 
    "health" pool, instead of HP.

    Class ID is used to determine which 
    Actor(s) will have this feature.

    Precaution: One or the other.
    Using both scripts will incur a 
    Stack Level Too Deep error.

            
  COPYRIGHT: Apache License 2.0 
=end

# CONFIGURATION START
module Peril
  PERILSTATEID = 29 # Change this to the ID of the status effect.
end

module MPPeril
  MPPERILSTATEID = 80 # Change this to the ID of the status effect.
  MPPERILTHRESHHOLD = 50 # default: 25%
  
  MPPERILCLASSES=[8,] # Add numbers (with comma separators) 
                      # to include more classes
end

# CONFIGURATION END


class Game_Actor
  
  alias og_refresh refresh
  def refresh
    og_refresh

    # MP PERIL
    if MPPeril::MPPERILCLASSES.include?(class_id)
        if mp_rate < (0.25)
        add_state(MPPeril::MPPERILSTATEID) unless state?(MPPeril::MPPERILSTATEID)
      else
        erase_state(MPPeril::MPPERILSTATEID) if state?(MPPeril::MPPERILSTATEID)
      end
    end

    # HP PERIL
    if hp_rate < (0.25)
      add_state(Peril::PERILSTATEID) unless state?(Peril::PERILSTATEID)
    else
      erase_state(Peril::PERILSTATEID) if state?(Peril::PERILSTATEID)
    end
  end
  
end
