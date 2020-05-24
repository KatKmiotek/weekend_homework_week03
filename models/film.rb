require('pry')
require_relative('customer')
require_relative('ticket')
require_relative('screening')
require_relative('../db/sql_runner')

class Film
  attr_reader :id
  attr_accessor :title, :price

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @price = options['price'].to_i
end

def save()
  sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
  values = [@title, @price]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def update()
  sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def customers()
  sql = "SELECT name FROM customers JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
  values = [@id]
  result = SqlRunner.run(sql, values)
  return result.map { |customer| Customer.new(customer).name }
end

def how_many_customers()
    sql = "SELECT * FROM customers JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
   return result.count
end

def self.most_popular()
  sql = "SELECT available_seats FROM screenings JOIN films ON films.id = screenings.film_id ORDER BY available_seats"
  result = SqlRunner.run(sql)
  return result.map { |screening| Screening.new(screening) }.first
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.all_titles()
  sql = "SELECT title FROM films ORDER BY title"
  result = SqlRunner.run(sql)
  return result.map { |film| Film.new(film).title}
end

end
