require 'ostruct'

module Ranks
  @@collection = nil
  def self.collection
    @@collection
  end
  def self.load name = 'us-army', storage = FileStorage
    @@collection ||= storage.load(name)
  end

  module FileStorage
    RANK_ROWS_SIZE = 4
    
    def self.load(name)
      file = File.open( File.join('.','ranks',"#{name}.txt"),"r")

      attributes_from(file).map do |attributes|
        Rank.new( attributes )
      end
    end

    private
    def self.attributes_from file
      [].tap do |attributes|
        file.each_slice(RANK_ROWS_SIZE) do |data|
          attributes << extract_from(data)
        end
      end
    end

    #TODO refactoring
    def self.extract_from(data)
      _, title, abbreviation = data[0].match(/^([A-Z].*) \(([A-Z].*)\)/).to_a
      _, addressed_as = data[1].match(/as \"(.*)\"/).to_a

      {
        title:        title,
        abbreviation: abbreviation,
        addressed_as: addressed_as,
        description:  data[2].strip
      }
    end
  end

  class Rank < OpenStruct
  end
end
