class PlayerController < ApplicationController
  def training_load
    @player = Player.find params[:player_id]
    respond_to do |format|
      format.html
      format.js do 
        training_loads_to_h = @player.training_loads.to_h
        perceived_loads_with_projection = Training.perceived_loads_with_projection training_loads_to_h
        params = [training_loads_to_h, perceived_loads_with_projection]
        json = { observed_loads:loads_with_timestamp(training_loads_with_projection(*params)),
          perceived_loads:loads_with_timestamp(perceived_loads_with_projection)
        }
        render json: json
      end  
    end  
  end
  def loads_with_timestamp loads
    loads.map {|date, load| [date.to_time.to_i*1000, load]}
  end
  def training_loads_with_projection(training_loads_to_h, perceived_loads_with_projection)
    perceived_loads_with_projection.keys.inject({}) do |results,key| 
      results[key]=training_loads_to_h.fetch(key,0)
      results
    end  
  end   
end
