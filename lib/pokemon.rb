require 'pry'

class Pokemon

  attr_accessor :id, :type, :db, :name, :hp


  def initialize(id:, name:, type:, db:)
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
    # binding.pry
    new_poke = Pokemon.new(:name => poke[1], :type => poke[2], :id => poke[0], :db => db)
    #binding.pry
    new_poke.id = poke[0]
    new_poke.name = poke[1]
    new_poke.type = poke[2]
    new_poke.hp = poke[3]
    new_poke.db = db
    new_poke

  end

  def alter_hp(new_hp, db)
    @hp = new_hp
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE name = ?
    SQL

    db.execute(sql,@hp,self.name)
    # binding.pry
    # "test"
  end


end
