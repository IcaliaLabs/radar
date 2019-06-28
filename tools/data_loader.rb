require 'csv'

#= DataLoader
#
# A class I made to load the CSV data into Postgres so I could clean & fix
# incorrect data (a.k.a. doing data quality chores) using postgres. 
class Loader
  def exec
    values = data.map { |row| row_to_values(row) }.join(', ')
    ActiveRecord::Base.transaction do
      conn.execute <<~SQL
        INSERT INTO "radar_data" ("name", "ring", "quadrant", "isNew", "description")
        VALUES #{values}
      SQL
    end
  end

  def conn
    @conn ||= ActiveRecord::Base.connection
  end

  def data
    @data ||= CSV.read(Rails.root.join('db/dumps/sheet.csv'))
  end

  def row_to_values(row)
    <<~SQL
      (#{conn.quote(row[0])}, #{conn.quote(row[1])}, #{conn.quote(row[2])}, #{conn.quote(row[3])}, #{conn.quote(row[4] || '')})
    SQL
  end
end
