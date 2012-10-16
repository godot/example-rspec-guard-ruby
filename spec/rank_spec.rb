# -*- coding: utf-8 -*-
require 'spec_helper'
require './init'

describe Ranks::Rank do

  let(:attributes) {
    {
      title: 'PRIVATE',
      abbreviation: 'PVT/PV2',
      addressed_as: 'Private',
      description: "Lowest rank: a trainee who's starting Basic Combat Training (BCT). Primary role is to carry out orders issued to them to the best of his/her ability. (PVT does not have an insignia)"
    }
  }

  shared_examples_for :rank do
    it 'responds to title, abbreviation, addressed_as, description' do
      attributes.keys.each do |field|
        subject.should respond_to field
      end
    end
    it 'has valid attributes' do
      attributes.keys.each do |key|
        subject.send(key).should eq( attributes[key] )
      end
    end
  end

  context 'if imported from file'  do
    before do
      Ranks::load
    end

    subject { Ranks::collection.first }
    it_behaves_like :rank
  end

  context ' general ' do
    subject {
      described_class.new(attributes)
    }

    it_behaves_like :rank

  end
end
