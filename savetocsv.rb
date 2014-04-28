require 'csv'
ROOT_DIR = File.dirname(__FILE__)
class Save

	def save_to_file(names)
		p "saving to file"

		File.open('#{ROOT_DIR}/myfile.csv', 'w') do |line|
			line << "firstname, lastname\n"

		names.each do |n|		
			line << "#{n.firstname}, #{n.lastname}\n"
		end
		end
	end
end
