# -*- coding: utf-8 -*-
require 'spec_helper'
require './init'

shared_examples_for :rank do
  let(:attributes) {
    {
      title: 'PRIVATE',
      short: 'PVT/PV2',
      addressed_as: 'Private',
      description: "Lowest rank: a trainee who's starting Basic Combat Training (BCT). Primary role is to carry out orders issued to them to the best of his/her ability. (PVT does not have an insignia)"
    }
  }

  it 'responds to title, short, addressed_as, description' do
    attributes.keys.each do |field|
      subject.should respond_to field
    end
  end
  it 'has valid attributes' do
    attributes.keys.each do |key|
      subject.send(key).should eq( attributes[key] )
    end
  end

  it 'responds correctly ' do
    %w(title short addressed_as description).each do |key|
      subject.should respond_to key
    end
  end
end

describe RankSet, ' when importing '  do
  it ' ::load imports ranks from file' do
    expect {
      RankSet::load
    }.to change(RankSet, :levels).from(nil).to(27)
  end

  context RankSet::Rank do
    before do
      RankSet::load
    end
    subject { RankSer::ranks.first }

    it_behaves_like :rank
  end

end

describe RankSet::Rank do
  subject {
    described_class.new(attributes)
  }

  it_behaves_like :rank

end
