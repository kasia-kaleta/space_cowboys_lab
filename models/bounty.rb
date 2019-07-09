require('pg')

class Bounty

  attr_accessor :name, :bounty_value, :homeworld, :collected_by
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @homeworld = options['homeworld']
    @collected_by = options['collected_by']
  end

  def save
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO bounties
           (name, bounty_value, homeworld, collected_by)
           VALUES ($1, $2, $3, $4)
           RETURNING id"
    db.prepare('save', sql)
    values = [@name, @bounty_value, @homeworld, @collected_by]
    returned_id = db.exec_prepared('save', values)
    @id = returned_id.first['id']
    db.close
  end

  def update
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "
    UPDATE bounties
    SET (name, bounty_value, homeworld, collected_by)
    = ($1, $2, $3, $4)
    WHERE id = $5"
    db.prepare('update', sql)
    values = [@name, @bounty_value, @homeworld, @collected_by, @id]
    db.exec_prepared('update', values)
    db.close
  end

  def self.delete(id)
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties WHERE id = $1"
    db.prepare('delete', sql)
    db.exec_prepared('delete', [id])
    db.close
  end

  def self.delete_all
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "DELETE FROM bounties"
    db.prepare('delete_all', sql)
    db.exec_prepared('delete_all')
    db.close
  end

  def self.find_by_name(name)
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE name = $1"
    db.prepare('find_by_name', sql)
    return_arr = db.exec_prepared('find_by_name', [name])
    db.close

    if (return_arr.first == nil)
      return nil
    else
      bounty = Bounty.new(return_arr.first)
      return bounty
    end
  end

  def self.find_by_id(id)
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"
    db.prepare('find_by_id', sql)
    return_arr = db.exec_prepared('find_by_id', [id])
    db.close

    if (return_arr.first == nil)
      return nil
    else
      bounty = Bounty.new(return_arr.first)
      return bounty
    end

  end

end
