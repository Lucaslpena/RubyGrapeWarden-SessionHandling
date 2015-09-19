require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'erb'
require './config/environment.rb'

namespace :grape do
  desc "Condensed API Routes"
  task :routes do
    format = "%46s  %3s %7s %50s %12s:  %s"
    ProtectedService.routes.each do |grape_route|
      info = grape_route.instance_variable_get :@options
      puts format % [
               info[:description] ? info[:description][0..45] : '',
               info[:version],
               info[:method],
               info[:path],
               '# params: ' + info[:params].length.to_s,
               info[:params].first.inspect
           ]
      if info[:params].length > 1
        info[:params].each_with_index do |param_info, index|
          next if index == 0
          puts format % ['','','','','',param_info.inspect]
        end
      end
    end
  end
end
#code taken from https://gist.github.com/oivoodoo/5089237 in no way is it mine!