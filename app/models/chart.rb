class Chart < ActiveRecord::Base
  attr_accessible :name, :charttype

  has_many :chartnodes
end
