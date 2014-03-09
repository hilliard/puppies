class Adoption < ActiveRecord::Base
  belongs_to :order
  belongs_to :puppy
end