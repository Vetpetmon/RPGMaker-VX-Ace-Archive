=begin
  Equipments added to Test Battle [PATCH]
  
  By: Modrome
  
  
    Problem: In VX Ace, only consumable items are provided
             when running test battles. This results in a
             populated item inventory, but nothing is in 
             the equipment inventory. This makes equipments
             difficult to test, and the only solution is to
             add in the equipment manually using common
             events, which gets tedious (and very loud if
             you're using an item obtained notification script)
           
   Solution: This script patches the setup_battle_test_items
             function in the Game_Party class to now include
             equipment. These equipment items are now quietly
             added into the inventory like consummables are.
             No common events are needed.
             
             This script works only for Test Battles, where 
             you may want to test equipment easily, or if you
             have a custom equipment system, especially one 
             that lets you switch gear in the middle of battle.
             
   Instructions:
             There are no configuration options, just put this 
             anywhere in your list between main and materials
             
             Equipments without names are skipped, so if you 
             want to be able to test them, name them!
            
  COPYRIGHT: Apache License 2.0 
=end

class Game_Party < Game_Unit
#--------------------------------------------------------------------------
# Patch: setup_battle_test_items
#--------------------------------------------------------------------------
  alias prior_bt_items setup_battle_test_items
  def setup_battle_test_items
    prior_bt_items 
    
    # WEAPONS
    $data_weapons.each do |weapon|
      gain_item(weapon, max_item_number(weapon)) if weapon && !weapon.name.empty?
    end
    
    # ARMORS
    $data_armors.each do |armor|
      gain_item(armor, max_item_number(armor)) if armor && !armor.name.empty?
    end
  end
  
end
