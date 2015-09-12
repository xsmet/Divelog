class CreateDives < ActiveRecord::Migration
  def change
    create_table :dives do |t|
      t.decimal   :depth,       default: 0, precision: 5, scale: 2    # optional [meters] Max depth 999.99m
      t.integer   :duration,    default: 0, limit: 2                  # optional [minutes] Max time 999 minutes
      t.datetime  :starttime,   null: true                            # optional [datetime]
      t.decimal   :temperature, default: 0, precision: 3, scale: 1    # optional [celsius] Max temperature 99.9°C
      t.integer   :divenumber,  default: 0, null: true                # optional 
      t.string    :location,    index: true, null: false              # required 
      t.string    :country,     index: true                           # optional
      t.integer   :user_id,     index: true, null: false              # required foreign key (belongs to)
      t.integer   :buddy_id                                           # optional

      t.timestamps null: false
    end
  end
end
