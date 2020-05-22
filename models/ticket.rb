require('pry')
require_relative('film')
require_relative('customer')
require_relative('../db/sql_runner')

class Ticket

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id']
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
  values = [@customer_id, @film_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

end
