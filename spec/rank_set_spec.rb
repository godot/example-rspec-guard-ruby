# -*- coding: utf-8 -*-
require 'spec_helper'
require './init'

describe Ranks do
  before do
    described_class::load
  end

  subject { described_class::collection }

  its(:size) { should == 27 }

end
