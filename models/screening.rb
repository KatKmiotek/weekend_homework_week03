require('pry')
require_relative('film')
require_relative('customer')
require_relative('screening')

class Screening
attr_reader :id, :film_id, :time
attr_accessor :available_seats

def initialize(options)
  @id = options['id'].to_i if options['id']
  @film_id = options['film_id'].to_i
  @time = options['time'].to_i
  @available_seats = options['available_seats'].to_i
end


def save()
  sql = "INSERT INTO screenings (film_id, time, available_seats) VALUES ($1, $2, $3) RETURNING id"
  values = [@film_id, @time, @available_seats]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE screenings SET (film_id, time, available_seats) = ($1, $2, $3) WHERE id = $4"
  values = [@film_id, @time, @available_seats, @id]
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
