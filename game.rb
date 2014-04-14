$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'bundler'

Bundler.require

require 'lib/house'
require 'lib/bannerman'
require 'lib/fight'
require 'lib/battle'
require 'lib/war'

module Game
  def self.play
    War.new.tap do |war|
      war.houses.each { |house| puts house }
      war.each do |battle|
        puts "  " + battle.to_s
        battle.each do |fight|
          puts "    " + fight.bannermen.map(&:to_s).join(' vs. ')
          print "      "
          fight.each do |attacker, defender|
            print attacker == fight.bannermen.first ? '-> ' : '<- '
          end
          print "\n"
          puts "      Victor: " + fight.victor.to_s
        end
        puts "  Victor: " + battle.victor.to_s
      end
      puts "Victor: " + war.victor.to_s
      puts "  Bannermen:"
      war.victor.each { |bannerman| puts "    " + bannerman.to_s }
    end
  end
end

Game.play
