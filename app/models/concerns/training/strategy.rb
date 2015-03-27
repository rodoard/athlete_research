module Training
  module Strategy
    def self.piecewise
      Piecewise
    end  
    def self.improved
      Improved
    end  
    class Piecewise
      def self.rfactor load, days_prior
        if load >= 750
          return RFACTOR["750"][days_prior]
        elsif load >= 250
          return RFACTOR["250"][days_prior]
        elsif load >= 0
          return RFACTOR["0"][days_prior]
        end       
      end 
    end     
      
    class Improved
      def self.rfactor load, days_prior
        if load >= 750
          return RFACTOR["750"][days_prior]
        elsif load >= 250
          return RFACTOR["250"][days_prior] * load/(750.0 - 1)
        elsif load >= 0
          return RFACTOR["0"][days_prior] * load/(250.0 -1)
        end       
      end     
    end
    private
     #residual factor table
     RFACTOR = {
        "750" => [0.40, 0.20, 0.10],
        "250"=> [0.30, 0.15, 0.05],
        "0" => [0.20, 0.10 , 0.00]
      }   
  end  
end     