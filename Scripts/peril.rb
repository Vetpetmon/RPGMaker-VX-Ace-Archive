=begin
  HP Peril Status for VX Ace
  version 2
  
  By: Modrome
  
    Creates a "peril" status inspired by 
    various RPG games, which will apply 
    when a party member has less than 
    25% of their HP remaining.
    
    Future functionalities, such as skill
    swaps with stronger skills, is planned.
            
  COPYRIGHT: Apache License 2.0 
=end
module Peril
  PERILSTATEID = 29 # Change this to the ID of the status effect.
  
  # VER 2
  # The hp % the actor must fall below in order
  #	for Peril to be applied.
  PERILTHRESHHOLD = 25
end


class Game_Actor
  
  alias og_refresh refresh
  def refresh
    og_refresh
    return unless Peril::PERILSTATEID
    if hp_rate < (Peril::PERILTHRESHHOLD/100)
      add_state(Peril::PERILSTATEID) unless state?(Peril::PERILSTATEID)
    else
      erase_state(Peril::PERILSTATEID) if state?(Peril::PERILSTATEID)
    end
  end
  
end
