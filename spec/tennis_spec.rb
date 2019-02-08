class Tennis 
    def initialize
        @score = "Love-Love"
        @p1_counter = 0
        @p2_counter = 0
        @scores = ["Love", "15", "30", "40"]
    end


    def scored(player= :player_one)
        if player == :player_two
            @p2_counter += 1
        else
            @p1_counter += 1
        end
        @score = "#{@scores[@p1_counter]}-#{@scores[@p2_counter]}" 
        @score = "deuce" if @p1_counter == 3 && @p2_counter == 3
        @score = "Player one wins" if @p1_counter >= 4 && @p2_counter < @p1_counter-1
        @score = "Player two wins" if @p2_counter == 4 && @p1_counter < @p2_counter-1
    end

    def get_score
        @score
    end


end

describe Tennis do
    let(:tennis) { Tennis.new }

    it "returns 0-0 if no one has scored" do
        
        
        expect(tennis.get_score).to eq("Love-Love")
    end

    it "returns 15-0 if player has scored" do
        tennis.scored
        expect(tennis.get_score).to eq("15-Love")
    end

    it "returns 30-0 if the player scores again" do
        2.times{ tennis.scored }
        expect(tennis.get_score).to eq("30-Love")
    end

    it "returns 40-0 if the player scores three times" do
        3.times{ tennis.scored }
        expect(tennis.get_score).to eq("40-Love")
    end

    it "returns 0-15 if player two scores once" do
        tennis.scored(:player_two)
        expect(tennis.get_score).to eq("Love-15")
    end

    it "return 0-30 if player two scores twice" do
        2.times{ tennis.scored(:player_two) }
        expect(tennis.get_score).to eq("Love-30")
    end

    it "returns 0-40 if player two scores 3 times" do
        3.times{ tennis.scored(:player_two) }
        expect(tennis.get_score).to eq("Love-40")
    end

    it "returns deuce if the score is 40-40" do
        3.times{
            tennis.scored(:player_one)
            tennis.scored(:player_two) 
        }
        expect(tennis.get_score).to eq("deuce")
    end

    it "returns player one wins when players one scores 4 times without player two scoring" do
        4.times{ tennis.scored(:player_one) }
        expect(tennis.get_score).to eq("Player one wins")
    end

    it "returns player two wins when player two scores 4 times without player one scoring" do
        4.times{ tennis.scored(:player_two) }
        expect(tennis.get_score).to eq("Player two wins")
    end

    it "returns player one wins when player one scores twice from deuce" do
        3.times{ 
            tennis.scored(:player_one) 
            tennis.scored(:player_two)
        }
        2.times{ tennis.scored(:player_one) }
        expect(tennis.get_score).to eq("Player one wins")
    end
end
