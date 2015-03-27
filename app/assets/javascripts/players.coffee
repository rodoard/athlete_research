class Player
  training_load: ->
    player_id = $('#player_id').val()
    $.getJSON( 
      "/players/#{player_id}/training_load.js"
      (response) ->
        data = [{
          label: "Perceived"
          data:response.perceived_loads
          },
          {
          label: "Observed"
          data:response.observed_loads
          bars: 
            show: true 
          } 
        ]
        options = { xaxis: {
          mode: "time",
          timeformat: "%Y-%m-%d"
        }
        }
        $.plot($("#placeholder"), data, options);
    )
window['Player'] = Player