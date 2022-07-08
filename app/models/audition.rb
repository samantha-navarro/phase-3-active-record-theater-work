class Audition < ActiveRecord::Base
  belongs_to :role

  def callback
    self.update(hired: true)
  end
end