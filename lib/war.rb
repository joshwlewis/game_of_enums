class War < Liner.new(:houses)
  include Enumerable

  def houses
    @houses ||= Array.new(7) { House.new }
  end

  def unbent
    houses.reject(&:bent_the_knee?)
  end

  def battle
    Battle.new(houses: unbent.sample(2))
  end

  def over?
    unbent.count <= 1
  end

  def victor
    unbent.sort!.last
  end

  def each
    yield battle until over?
  end

end
