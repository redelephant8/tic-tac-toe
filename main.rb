class Player
    attr_reader :symbol
    def initialize(symbol)
        @symbol = symbol
    end
end

class Board
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
        puts "Do you want to play a 1 player game or a 2 player game? (1/2)"
        @gameType = gets.chomp.to_i
        printBoard()
        while (@state == 0)
            startGame
        end
        puts "Would you like to play again (y/n)"
        @answer = gets.chomp
        if (@answer == 'y')
            @counter += 1
            @games[@counter] = Board.new(@games, @counter, Player.new('x'), Player.new('o'))
        else
            puts "Thank you to Playing!"
        end
    end

    def switchPlayer(error)
        if error == 'invalid'
            puts "\n"
            puts "Invalid Entry"
            puts "\n"
        elsif error == 'full'
            puts "\n"
            puts "Spot already taken"
            puts "\n"
        end
        if @current == 2
            @current = 1
        else
            @current = 2
        end
    end

    def startGame
        switchPlayer(error = 'none')
        puts "----------------------"
        if @gameType == 2 || @current == 1
            puts "Player #{@current} enter a square: "
        end
        if @gameType == 2
            @current == 1 ? getSquare(gets.chomp.to_i, @player1.symbol) : getSquare(gets.chomp.to_i, @player2.symbol)
        else
            @current == 1 ? getSquare(gets.chomp.to_i, @player1.symbol) : computerPlay()
        end
        printBoard()
        if checkWin(@board) == true
            win(@current)
        end
        if @state == 0
            if checkFull == true
                @state = 2
                puts "The game has ended in a tie!"
            end
        end
        if checkTie == true && @state == 0
            @state = 2
            puts "Deadlock. No player can win the game."
        end
    end

    def win(winner)
        puts "Player #{winner} has won the game!"
        @state = 1
    end

    def printBoard()
        sleep(1)
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

    def checkTie
        @tie = false
        temp = Marshal.load(Marshal.dump(@board))
        for i in 0..2
            for j in 0..2
                if @board[i][j].is_a?(Integer) == true
                    temp[i][j] = @player1.symbol
                end
            end
        end
        if checkWin(temp) == false
            @tie = true
        end
        temp = Marshal.load(Marshal.dump(@board))
        for i in 0..2
            for j in 0..2
                if @board[i][j].is_a?(Integer) == true
                    temp[i][j] = @player2.symbol
                end
            end
        end
        if checkWin(temp) == true
            @tie = false
        end
        @tie
    end
    
    def checkFree(square)
        @flag = false
        for i in 0..2
            for j in 0..2
                if square == @board[i][j]
                    @flag = true
                end
            end
        end
        @flag
    end

    def computerPlay
        counter = 0
        for i in 0..2
            for j in 0..2
                @tempBoard = Marshal.load(Marshal.dump(@board))
                if @board[i][j].is_a?(Integer)
                    @squareNum = @board[i][j]
                    @tempBoard[i][j] = @player1.symbol
                        if checkWin(@tempBoard) == true
                        @possiblePlays = @squareNum
                        counter += 1
                        break
                    end
                end
            end
        end

            available = false
            if checkFree(@possiblePlays) == true
                available = true
                @finalPlay = @possiblePlays
            end
        computerFinal(@finalPlay)
    end


    def computerFinal(finalPlay)
        if finalPlay.is_a?(Integer)
            getSquare(finalPlay, 'o')
        else
            available = false
            while (available == false)
                finalPlay = rand(1..9)
                if checkFree(finalPlay) == true
                    available = true
                end
            end
        getSquare(finalPlay, 'o')
        end
        sleep(1)
        puts "The computer has put an 'o' in square #{finalPlay}"
    end

    def getSquare(num, symbol)
        case num
        when 1
            @board[0][0].is_a?(Integer) == true ? @board[0][0] = symbol : squareUnavailable
        when 2
            @board[0][1].is_a?(Integer) == true ? @board[0][1] = symbol : squareUnavailable
        when 3
            @board[0][2].is_a?(Integer) == true ? @board[0][2] = symbol : squareUnavailable
        when 4
            @board[1][0].is_a?(Integer) == true ? @board[1][0] = symbol : squareUnavailable
        when 5
            @board[1][1].is_a?(Integer) == true ? @board[1][1] = symbol : squareUnavailable
        when 6
            @board[1][2].is_a?(Integer) == true ? @board[1][2] = symbol : squareUnavailable
        when 7
            @board[2][0].is_a?(Integer) == true ? @board[2][0] = symbol : squareUnavailable
        when 8
            @board[2][1].is_a?(Integer) == true ? @board[2][1] = symbol : squareUnavailable
        when 9
            @board[2][2].is_a?(Integer) == true ? @board[2][2] = symbol : squareUnavailable
        else
            switchPlayer(error = 'invalid')
        end
    end

    def squareUnavailable
        if (@gameType == 1 && @current == 1) || @gameType == 1
            switchPlayer('full')
        end
    end

    def checkWin(board)
        game_status = false
        for i in 0..2
            for j in 0..2
                if board[i][0] == board[i][1] && board[i][1] == board[i][2]
                    game_status = true
                elsif board[0][j] == board[1][j] && board[1][j] == board[2][j]
                    game_status = true
                elsif board[0][0] == board[1][1] && board[1][1] == board[2][2]
                    game_status = true
                elsif board[0][2] == board[1][1] && board[1][1] == board[2][0]
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