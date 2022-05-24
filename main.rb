class Player
    attr_reader :symbol
    def initialize(symbol)
        @symbol = symbol
    end
end

class Board < Player
    def initialize(games, counter, player1, player2)
        @player1 = player1
        @player2 = player2
        @counter = counter
        @games = games
        puts "Welcome to Game #{@counter + 1}"
        puts "\n"
        @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        @state = 0
        @current = 2
        gameLoop
    end

    def gameLoop
        while (@state == 0)
            startGame
        end
        puts "Would you like to play again (y/n)"
        @answer = gets.chomp
        if (@answer == 'y')
            @counter += 1
            @games[@counter] = Board.new(@games, @counter, Player.new('x'), Player.new('o'))
        else
            puts "Thanks for Playing!"
        end
    end

    def switchPlayer()
        if @current == 2
            @current = 1
        else
            @current = 2
        end
    end

    def startGame
        printBoard()
        switchPlayer()
        puts "Player #{@current} enter a square: "
        @current == 1 ? getSquare(gets.chomp.to_i, @player1.symbol) : getSquare(gets.chomp.to_i, @player2.symbol)
        if checkWin == true
            win(@current)
        end
        if @state == 0
            if checkFull == true
                @state = 2
                puts "The game has ended in a tie!"
            end
        end
    end

    def win(winner)
        printBoard()
        puts "Player #{winner} has won the game!"
        @state = 1
    end

    def printBoard()
        puts "\n"
        for i in 0..2
            for j in 0..2
                print " #{@board[i][j]} "
                if (j == 0 || j == 1)
                    print "|" 
                else
                    puts ""
                end
            end
        end
        puts "\n"
    end

    def getSquare(num, symbol)
        case num
        when 1
            @board[0][0].is_a?(Integer) == true ? @board[0][0] = symbol : switchPlayer()
        when 2
            @board[0][1].is_a?(Integer) == true ? @board[0][1] = symbol : switchPlayer()
        when 3
            @board[0][2].is_a?(Integer) == true ? @board[0][2] = symbol : switchPlayer()
        when 4
            @board[1][0].is_a?(Integer) == true ? @board[1][0] = symbol : switchPlayer()
        when 5
            @board[1][1].is_a?(Integer) == true ? @board[1][1] = symbol : switchPlayer()
        when 6
            @board[1][2].is_a?(Integer) == true ? @board[1][2] = symbol : switchPlayer()
        when 7
            @board[2][0].is_a?(Integer) == true ? @board[2][0] = symbol : switchPlayer()
        when 8
            @board[2][1].is_a?(Integer) == true ? @board[2][1] = symbol : switchPlayer()
        when 9
            @board[2][2].is_a?(Integer) == true ? @board[2][2] = symbol : switchPlayer()
        else
            puts "Invalid Entry"
            puts "\n"
            switchPlayer
    end
    end

    def checkWin()
        game_status = false
        for i in 0..2
            for j in 0..2
                if @board[i][0] == @board[i][1] && @board[i][1] == @board[i][2]
                    game_status = true
                elsif @board[0][j] == @board[1][j] && @board[1][j] == @board[2][j]
                    game_status = true
                elsif @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]
                    game_status = true
                elsif @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
                    game_status = true
                end
            end
        end
        game_status
    end

    def checkFull()
        flag = true
        for i in 0..2
            for j in 0..2
                if (@board[i][j].is_a? Integer) == true
                    flag = false
                end
            end
        end
        flag
    end
end
puts "Welcome to Tic-Tac-Toe!"
puts "\n"

games = Array.new

player1 = Player.new('x')
player2 = Player.new('o')

games[0] = Board.new(games, 0, player1, player2)