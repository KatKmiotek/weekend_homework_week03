require('pry')
require_relative('film')
require_relative('customer')
require_relative('screening')

class Screening
attr_reader :id, :film_id, :time

def initialize(options)
  @id = options['id'].to_i if options['id']
  @film_id = options['film_id'].to_i
  @time = options['time'].to_i
end


def save()
  sql = "INSERT INTO screenings (flim_id, time) VALUES ($1, $2) RETURNING id"
  values = [@film_id, @time]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE screenings SET (film_id, time) = ($1, $2) WHERE id = $3"
  values = [@film_id, @time, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM screenings WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM screenings"
  SqlRunner.run(sql)
end

end
