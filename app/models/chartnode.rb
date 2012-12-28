class Chartnode < ActiveRecord::Base
  attr_accessible :chart_id, :xaxis, :yaxis

  belongs_to :chart
  paginates_per 10
end
