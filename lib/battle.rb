class Battle < Liner.new(:houses)
  include Enumerable
  def houses
    @houses.sort! if @houses
  end

  def fight
    Fight.new(houses.reject(&:bent_the_knee?).map {|h| h.living.sample })
  end

  def over?
    houses.any?(&:bent_the_knee?) || 
      houses.first.vitality > (houses.last.vitality * 4)
  end

  def victor
    houses.last
  end

  def loser
    houses.first
  end

  def each
    yield fight until over?
    loser.bend_the_knee_to(victor)
  end

  def to_s
    "#{houses.map(&:to_s).join(' vs. ')}"
  end
end
