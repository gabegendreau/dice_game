@pocket = 20					# You start with 20 bucks in your pocket
@four_five_six = [4, 5, 6]		# 4, 5, 6 is a winning combo
@one_two_three = [1, 2, 3]		# 1, 2, 3 is a losing combo

def roll
	puts " "
	@dice_results = [rand(6) + 1, rand(6) + 1, rand(6) + 1]			# Rolls three 6-sided dice
end

def win
	@bet = (@bet * 2)					# When you win you get your bet plus the computers
	puts "You win $" + @bet.to_s + "!"
	@pocket += @bet						# Put your winnings in your pocket
end

def lose
	puts "Sorry, you lost!"				# The money's gone, man
end

puts "Welcome to Gabe's Casino, let's play a game of Almost Back-alley Cee-lo. 
You've got 3 dice to roll. Before you roll you place a bet, imagine the computer is 
matching your bet. If you roll 4, 5, 6 or the same number on all dice you win the 
pot, if you roll 1, 2, 3 the computer takes the pot. If you roll a pair the round is 
determined by the score of the third die, low loses and high wins. If you don't roll 
any of those combinations the bet is cleared, no money lost, and you start over."

def play_turn		
	puts "You have $" + @pocket.to_s + ", place a bet and hit enter to roll."		# This is the start of the game and where it repeats after every roll, until you are broke
	@bet = gets.chomp.to_i															# Gets your bet, makes it pretty, and turns it into an integer
	if @bet > @pocket																# Checks to see if the bet is too rich for your blood
		puts "You don't have that much money, place a bet you can cover or kick rocks!"
	else
		@pocket -= @bet						# Throw your money in the pot
		puts roll										# Roll 3 dice
		if @dice_results.sort! == @four_five_six		# 4, 5, 6!
			puts "4, 5, 6!"
			puts win
		elsif @dice_results.sort! == @one_two_three		# 1, 2, 3, not everybody can be a winner...
			puts "Aww... 1, 2, 3... nobody wants to see those numbers."
			puts lose
		elsif
			@dice_results.uniq.length == 1				# Triple! We got a winner!
			@dice_results = @dice_results.first.to_s	# What number is your triple? Make it a string!
			puts "All " + @dice_results + "s!"
			puts win
		elsif
			@dice_results.uniq.length == 2						# We got a pair!
			@score = @dice_results.select{ |e| @dice_results.count(e) == 1 }	# Find the number that is not part of the pair
			puts "You've rolled a pair with a " + @score.first.to_s + "	"		# Determine high or low with pair
			puts " "
			if  
				@score.first.to_s <= "3"						# Low number loses
				puts "Pair with a low number."
				puts lose
			else
				@score.first.to_s >= "4"						# High number wins
				puts "Pair with a high number."
				puts win
			end
		else
			puts "Nada, roll again."							# Keep trying	
			@pocket += @bet										# Money back in your pocket, make another bet					
		end
	end	
end		

while @pocket > 0										# As long as you got money you're spending it here!
	puts play_turn										# Runs through a round of dice
end

if @pocket <= 0											# Checks to see if you have any cash
	puts "You're broke, get outta here!"				# Beat it!
end