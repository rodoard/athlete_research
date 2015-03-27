module ApplicationHelper
  def load_sparkline(training_loads)
    load_values = training_loads.last(7).map(&:value)
    max_value = load_values.max
    lines = load_values.map { |value|
      percent = (100 * value.to_f / max_value).round
      %Q[<div style="background-color: black; display: inline-block; height: #{percent}%; width: 4px; margin-right: 1px;"></div>]
    }.join('')

    %Q[<div style="height: 30px;">#{lines}</div>].html_safe
  end
end
