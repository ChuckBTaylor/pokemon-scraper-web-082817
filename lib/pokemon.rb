require 'pry'

class Pokemon

  attr_accessor :id, :type, :db, :name, :hp
  def initialize(id:, name:, type:, db:, hp: 60)
    db.execute("CREATE TABLE IF NOT EXISTS pokemon (id INTEGER PRIMARY KEY, name TEXT, type TEXT);")
    @id = :id
    @name = :name
    @type = :type
    @db = :db
  end


  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?)",name,type)
  end

  def self.find(new_id, db)
    poke = db.execute("SELECT * FROM pokemon WHERE pokemon.id = (?)",new_id).flatten
    x = Pokemon.new(:name => poke[1], :type => poke[2], :id => poke[0], :db => db)
    #binding.pry
    x.id = poke[0]
    x.name = poke[1]
    x.type = poke[2]
    x.db = db
    x
  end


end
