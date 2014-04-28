
require 'nokogiri'
require 'open-uri'

class Names 
  attr_accessor :firstname, :lastname

  def initialize(firstname=[],lastname=[])
    firstname = firstname
    lastname = lastname
  end
end

class GetDataFromWeb

	def retrieve_file_output(file)
	  companies = []
	  File.open(file, "r") do |file_handle|
			file_handle.each_line do |company|
				companies << company.strip.gsub(" ","+")
			end
		end
		return companies
	end

	def extract_google_url(companies)
		urls = []
		companies.each do |c| 
			page = Nokogiri::HTML(open('http://www.google.com/search?q=site:https://connect.data.com/directory/company/list+'+c))

			page.css("h3 a").each do |link|
				p link.attr('href')
				if link.attr('href').include? "https://connect.data.com/directory/company/list"

				w = link.attr('href').gsub("/url?q=","").lines.first.chomp
				urls << w
				else
				p "no url found for" + c
				end
			end
		end
		return urls
	end

	def extract_data_results(urls)
		count = 0
		names = []
		columns = []
		name = Names.new
		urls.each do |url|
			page = Nokogiri::HTML(open(url))
			page.css("table#row td").each do |link|
			columns << link.inner_text.gsub("\\r\\n\\t","").gsub(/\s+/, "")
			end
		end

			columns.each do |column|

				if not column == "" and not column == "SignUptoView"
					count = count + 1
					if count == 1
						name.lastname = column.strip
					end
					if count == 2
						name.firstname = column.strip
					end
					if count == 6
						names << name
						count = 0
						name = Names.new
					end
				end		
				
			end
			p names
		return names
	end
end