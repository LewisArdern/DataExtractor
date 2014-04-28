require 'csv'

class Save

	def save_to_file(names)
		p "saving to file"

		File.open('/Users/lewisardern/Documents/DataCrawl/myfile.csv', 'w') do |line|
			line << "firstname, lastname\n"

		names.each do |n|		
			line << "#{n.firstname}, #{n.lastname}\n"
		end
		end
	end
end