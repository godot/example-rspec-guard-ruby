require 'ostruct'

module Ranking
  @@current = nil

  def self.ranks
    @@current.ranks
  end

  def self.load name = 'us-army'
    @@current = Ranking.new(name)
  end

  def self.levels
    @@current && @@current.levels
  end

  class Ranking
    attr_reader :ranks
    def initialize(name)
      @ranks = []
      filename = "./ranks/#{name}.txt"
      File.open(filename, "r") do |file|
        file.each_slice(4) do |lines|
          @ranks << Rank.new( extract_from(lines) )
        end
      end
    end
    def extract_from(lines)
      _, title, short = lines[0].match(/^([A-Z].*) \(([A-Z].*)\)/).to_a
      _, addressed_as = lines[1].match(/as \"(.*)\"/).to_a
      {
        title:        title,
        short:        short,
        addressed_as: addressed_as,
        description:  lines[2].strip
      }
    end
    def levels
      @ranks.size
    end
  end

  class Rank < OpenStruct
  end
end
