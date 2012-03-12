class Movie < ActiveRecord::Base

  def self.all_ratings
    self.find(:all, :select => 'rating').map(&:rating).uniq
  end

end
