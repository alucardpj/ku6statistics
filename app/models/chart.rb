class Chart < ActiveRecord::Base
  attr_accessible :name, :charttype

  has_many :chartnodes
  paginates_per 20
end
