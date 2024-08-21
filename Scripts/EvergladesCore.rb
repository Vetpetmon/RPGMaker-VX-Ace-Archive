=begin

	The Everglades: A national park in Florida.
	A backbone of the state's ecosystem, this 
	land spans ~1.5 million acres and provides
	natural resources for thousands of animals 
	and plants alike.
	
	Of course, this code library is named after
	it; it's soon to be a staple for many scripts
	and sub-libraries.
	
	Features all the necessary variables, which 
	are customizable in the Limestone module.
	
	Functions used in scripts are in the Aquifer
	module. Anything in the Aquifer modules is to
	not be disturbed unless if you know what you 
	are doing!

=end

=begin
	Everything here is either a configurable 
	variable, or a localization string for 
	logging (will need to enable debugging or
	otherwise view the terminal/console)
=end

module Limestone
	
	
	
	# Console messages
	

	CATCHFILEFALLBACK = "Caught a file error; resolved to a fallback file."
	CATCHCLAMPVALUE = "Caught an input error; resolved by clamping to valid output."

	ERRORCODE = "Error code: "
	
	ERRORCODES = {
		:nonil => "-1 (NIL NOT ACCEPTABLE)",
		:badinput => "0 (MALFORMED INPUT)",
		:sanity => "1 (SANITY CHECK)",
		:bignumerator => "2 (NUMERATOR LARGER THAN DENOMINATOR)",
		:missingfile => "404 (FILE NOT FOUND)"
	}
end

=begin
	All code found here is functional, editing 
	this area may break things or make them react
	in undesirable ways.
	
	Each method is neatly commented via a header.
	An example of how to call the method will also
	be provided.
=end
module Aquifer
	
	#====================================
	#	DATA AND EQUATION RESOLVERS
	#====================================

=begin
	Composes a table in the log that effectively lists
	the change in a stat of the enemy (or actor) over 
	their level.
	
	formula: string
	
	
	Example usage: Aquifer.listLeveledStatDelta()
=end
	def listLeveledStatDelta(formula, baseValue, maxLevels, statName)
		value = baseValue
		lvl = 1
		finalValue = RubyVM::AbstractSyntaxTree.parse(formula)
	end
	
	
	
	
	#====================================
	#	RATES, RATIOS, AND PERCENTAGES
	#====================================
	
=begin
	Converts a whole value to a percentage.
	
	Best used with variables that do not exceed
	100 & do not fall below 0.
	
	Example usage: Aquifer.toPercent(Peril::PERILTHRESHHOLD)
=end
	def Aquifer.toPercent(input)
		return input/100.0
	end

=begin
	Returns the rate between two values.
	
	Commonly used to get the value between 
	HP and max_HP, MP and max_MP, and so forth.
	
	Example usage: Aquifer.toRate(hp,maxhp)
=end

	def Aquifer.toRate(numerator, denominator)
		if numerator > denominator
			p Limestone::ERRORCODE + Limestone::ERRORCODES[:bignumerator]
			return 1.0
		end
		return numerator.to_f/denominator
	end
	
end

	#====================================
	#	FUNCTION TESTING IN CONSOLE
	#====================================

p Aquifer.toPercent(25)
p Aquifer.toRate(63,100)