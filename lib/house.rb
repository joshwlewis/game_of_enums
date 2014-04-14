class House < Liner.new(:name, :sigil, :bannermen)
  include Enumerable
  include Comparable

  def name
    @name ||= Faker::Name.last_name
  end

  def sigil
    @sigil ||= Faker::Team.creature
  end

  def bannermen
    @bannermen ||= Array.new(rand 20) { Bannerman.new }
  end

  def each
    bannermen.each do |bannerman|
      block_given? ? block.call(bannerman) : yield(bannerman)
    end
  end

  def bend_the_knee_to(other)
    other.bannermen += bannermen
    self.bannermen = []
  end

  def bent_the_knee?
    living.count == 0
  end

  def living
    select(&:alive?)
  end

  def each
    bannermen.each { |bannerman| yield bannerman }
  end

  def vitality
    reduce(0) { |sum, bannerman| sum + bannerman.vitality }
  end

  def <=>(other)
    self.vitality <=> other.vitality
  end

  def to_s
    "House #{name} - #{sigil} (#{vitality})"
  end
end