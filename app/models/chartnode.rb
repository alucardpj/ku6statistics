class Chartnode < ActiveRecord::Base
  attr_accessible :chart_id, :xaxis, :yaxis

  belongs_to :chart
end
