  
#!/usr/bin/env ruby
#encoding: UTF-8

# == GenericList
#
#
# See the README for full information
#
# Original Author:: Lewis Ardern (lewisardern@live.co.uk) | (lewis.ardern@randomstorm.com)
# Version:: 0.1
# Copyright:: Copyright(c) 2014, RandomStorm Limited - www.randomstorm.com
# Licence:: Creative Commons Attribution-Share Alike 2.0
#


require 'getoptlong'
require_relative 'retrievedata.rb'
require_relative 'savetocsv.rb'

def usage

  puts 'Data v 0.1 Lewis Ardern (LewisArdern@live.co.uk) <www.randomstorm.com>

   This tool takes companies names and runs it against jigsaw to see if there are any names can be retrieved.

   ./datacrawl.rb -file list.txt > names_retrieved.csv

   All options options are:
   --help -h: show 
   --file -f: input company names into a file e.g RandomStorm
'
  exit
end

opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--file', '-f', GetoptLong::REQUIRED_ARGUMENT ]
)

def run(file)
  web = GetDataFromWeb.new
  get_companies = web.retrieve_file_output(file)
  get_urls = web.extract_google_url(get_companies)
  get_names = web.extract_data_results(get_urls)
  save = Save.new
  save_data = save.save_to_file(get_names)
end

opts.each do |opt, arg|
  case opt
    when '--help'
      usage
    when '--file'   
     run(arg)
           
    when '--config'  
      #do a box count increment to next one
      #create template config file!
      config
    end 
  end



