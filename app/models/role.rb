class Role < ActiveRecord::Base
    has_many :auditions

    def actors
        # returns an array of names from the actors associated with this role
        self.auditions.map do |audition|
            audition.actor
        end
    end

    def locations
        #returns an array of locations from the auditions associated with this role
        self.auditions.map(&:location) #shorthand for map

        #self.auditions.pluck(:location) 
        #works the same as map
    end

    def lead
        got_hired = self.auditions.find(&:hired)
        #why?
        if(got_hired)
            return got_hired
        else
            return "no actor has been hired for this role"
        end
        # returns the first instance of the audition that was hired for this role or returns a string 'no actor has been hired for this role'
    end

    def understudy
        filtered_auditions = self.auditions.filter do |audition|
            audition.hired
        end

        if (filtered_auditions.length > 1)
            return filtered_auditions.second
        else
            return "no actor has been hired for understudy for this role"
        end
        #returns the second instance of the audition that was hired for this role or returns a string 'no actor has been hired for understudy for this role'
    end
end