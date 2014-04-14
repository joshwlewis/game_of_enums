class Bannerman < Liner.new(:name, :health, :strength)
  include Comparable

  def name
    @name ||= Faker::Name.name
  end

  def health
    @health ||= rand(50) + 50
  end

  def strength
    @strength ||= rand(13) + 12
  end

  def alive?
    health > 0
  end

  def dead?
    !alive?
  end

  def vitality
    alive? ? health * strength : 0
  end

  def <=>(other)
    self.vitality <=> other.vitality
  end

  def to_s
    "#{name} (#{health}/#{strength})"
  end
end
