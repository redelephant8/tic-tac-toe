class Player
    attr_reader :symbol
    def initialize(symbol)
        @symbol = symbol
    end
end

class Board < Player
    @@player1 = Player.new('x')
    @@player2 = Player.new('o')
    def initialize(games, counter)
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
            @games[@counter] = Board.new(@games, @counter)
        else
            puts "Thanks for Playing!"
        end
    end

    def startGame
        printBoard()
        if @current == 2
            @current = 1
        else
            @current = 2
        end
        puts "Player #{@current} enter a square: "
        @current == 1 ? getSquare(gets.chomp.to_i, @@player1.symbol) : getSquare(gets.chomp.to_i, @@player2.symbol)
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
    end

    def getSquare(num, symbol)
        case num
        when 1
            (@board[0][0] = symbol)
        when 2
            (@board[0][1] = symbol)
        when 3
            (@board[0][2] = symbol)
        when 4
            (@board[1][0] = symbol)
        when 5
            (@board[1][1] = symbol)
        when 6
            (@board[1][2] = symbol)
        when 7
            (@board[2][0] = symbol)
        when 8
            (@board[2][1] = symbol)
        when 9
            (@board[2][2] = symbol)
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

games[0] = Board.new(games, 0)