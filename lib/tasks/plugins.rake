require 'rake/testtask'

namespace :db do
  namespace :migrate do
    desc "Run all Slate plugin migrations"
    task :plugins => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      
      version = ENV["VERSION"] ? ENV["VERSION"].to_i    : nil
      name    = ENV['PLUGIN']  ? ENV['PLUGIN'].classify : nil
      
      Slate.plugins.each do |plugin|
        plugin.migrate(version) if plugin.name == name || name.nil?
      end  
    end
  end
end  