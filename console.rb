require('pry')
require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/film')
require_relative('models/screening')
require_relative('db/sql_runner')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({
  'name' => 'Tom',
  'funds' => 20
  })

customer2 = Customer.new({
  'name' => 'Jerry',
  'funds' => 30
  })
customer3 = Customer.new({
  'name' => 'Hannah',
  'funds' => 40
  })

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({
  'title' => 'Little Joe',
  'price' => 5
  })
film2 = Film.new({
  'title' => 'Happy as Lazzaro',
  'price' => 6
  })
film3 = Film.new({
  'title' => 'Man bites dog',
  'price' => 7
  })

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })
ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film3.id
  })
ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  })
ticket5 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })
ticket6 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })
ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()

customer1.films()
film1.customers()

#basic extensions
film3.how_many_customers()
#customer1.buying_ticket()
customer1.tickets_bought()

#advanced extensions
screening1 = Screening.new({
  'film_id' => film1.id,
  'time' => '18:00'
  })
screening2 = Screening.new({
  'film_id' => film2.id,
  'time' => '20:00'
  })
screening3 = Screening.new({
  'film_id' => film3.id,
  'time' => '22:00'
  })
screening1.save()
screening2.save()
screening3.save()

film1.most_popular() #SELECT WHERE movies.id =$1

binding.pry
nil
