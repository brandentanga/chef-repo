#!/usr/bin/ruby
require 'chefspec'

describe "webserver-0.1.0::default" do
  let(:chef_run) { ChefSpec::Runner.new.converge("webserver-0.1.0::default") }

  it "should install nginx" do
    expect(chef_run).to install_package("nginx") 
  end
end


