require('pry')
require_relative('film')
require_relative('ticket')
require_relative('screening')
require_relative('../db/sql_runner')



class Customer
  attr_accessor :funds, :name, :id


def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds'].to_i
end

def save()
  sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
  values = [@name, @funds]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def films()
  sql = "SELECT title FROM films JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1"
  values =[@id]
  result = SqlRunner.run(sql, values)
  return result.map { |film| Film.new(film) }
end

def tickets_bought()
  sql = "SELECT * FROM tickets WHERE customer_id = $1"
  values = [@id]
  result = SqlRunner.run(sql,values)
  return result.count
end

def buying_ticket()
  sql = "SELECT SUM(price) FROM films JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  @funds -= result.values()[0][0].to_i
end



def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

end
