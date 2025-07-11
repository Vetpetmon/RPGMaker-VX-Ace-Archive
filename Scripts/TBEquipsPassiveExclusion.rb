=begin
  Equipments added to Test Battle [PATCH]
  version 3
  
  By: Modrome
  
  
    Problem: In VX Ace, only consumable items are provided
             when running test battles. This results in a
             populated item inventory, but nothing is in 
             the equipment inventory. This makes equipments
             difficult to test, and the only solution is to
             add in the equipment manually using common
             events, which gets tedious (and very loud if
             you're using an item obtained notification script)

             This assumes you have a script to change 
             equipments mid-battle, which is NOT a provided
             behavior in VX Ace. You will need another script
             for that functionality.
           
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

             In the game database, mark all functional weapons
             and armor with <Gear> (default). You can change 
             this value to whatever is necessary.

             IF THE ITEM DOES NOT CONTAIN THE TAG, IT WILL
             NOT APPEAR IN THE TEST BATTLE INVENTORY!
             
             Equipments without names are skipped, so if you 
             want to be able to test them, name them!

             Version 3: Change "Gear" at Line 60 to 
             whatever tag you are using for non-passive gear.


     Update: Version 3 - Now moves the note lookup value
             to a singular variable in the EquipsInTestBattle
             module; only one line needs to be edited.
             Instructions from version 2 are to be disregarded.

     Update: Version 2 - Looks for weapons with the <Gear> tag. 
             If the <Gear> tag is not found, it will not be added.
             This was added to remove passive skills from the item 
             list, if you're using a passive skills script that uses
             weapon and/or armor items for the effects. This will 
             significantly reduce clutter in item selection in 
             test battles.
            
  COPYRIGHT: Apache License 2.0 
=end

# START CONFIGURATION
=end

module EquipsInTestBattle
  
  # If you wish to use a different tag word, change this value
  tag = "Gear"
  
end

# END CONFIGURATION

class Game_Party < Game_Unit
#--------------------------------------------------------------------------
# Patch: setup_battle_test_items
#--------------------------------------------------------------------------
  alias prior_bt_items setup_battle_test_items
  def setup_battle_test_items
    prior_bt_items 
    
    # WEAPONS
    $data_weapons.each do |weapon|
      if weapon && !weapon.name.empty?
        if weapon.note =~ /<#{EquipsInTestBattle::tag}>/
          gain_item(weapon, max_item_number(weapon)) 
        end
      end
    end
    
    # ARMORS
    $data_armors.each do |armor|
      if armor && !armor.name.empty?
        if armor.note =~ /<#{EquipsInTestBattle::tag}>/
          gain_item(armor, max_item_number(armor)) 
        end
      end
    end
  end
  
end
