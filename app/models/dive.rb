class Dive < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # Most recent first

  # Tell CarrierWave to associate the uploader with the Micropost.picture attribute
  # TODO create a media set, instead of one picture per dive
  # mount_uploader :picture, PictureUploader
  
  validates :user_id,  presence: true
  validates :location, presence: true
  validate  :valid_dive

  private
  
      def valid_dive
        if depth < 1
            errors.add(:depth, "should be at least 1 meter")
        end
        if duration < 0
          errors.add(:duration, "should be positive")
        end
        # TODO uncomment & fix
        #if starttime > Time.now.tomorrow
            # Max 24 hours from now, because of time zones
        #    errors.add(:starttime, "shouldn't be in the future")
        #end
        if temperature > 50 || temperature < -20
            errors.add(:temperature, "should be between -20°C and 50°C")
        end
        if divenumber < 0
            errors.add(:divenumber, "should be positive")
        end
        if location.strip.empty?
            errors.add(:location, "shouldn't be empty")
        end
        #if country.length 
      end

end
