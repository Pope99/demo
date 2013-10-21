class Event < ActiveRecord::Base
  attr_accessible :capacity, :description, :is_public, :name
  validates_presence_of :name
end
