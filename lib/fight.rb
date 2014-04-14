class Fight < Liner.new(:bannermen)
  include Enumerable

  def attack
    attacker = living.sample
    defender = (living - [attacker]).sample
    defender.health -= attacker.strength
    [attacker, defender]
  end
  
  def living
    bannermen.select(&:alive?)
  end

  def complete?
    living.count <= 1
  end

  def victor
    living.first
  end

  def each
    yield attack until complete?
  end
end
