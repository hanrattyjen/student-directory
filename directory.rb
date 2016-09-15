def input_students
  puts "Please enter the names of the students:"
  puts "To finish, just hit enter twice."
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Cohort month:"
    cohort = gets.chomp.to_sym
    # Supplying a default value
    if cohort.empty?
      puts "You haven't entered a value. Please contact us."
      cohort = "NO VALUE"
    end
    # Checking typos
    puts "You have entered:"
    puts "Name: #{name}, Cohort: #{cohort}."
    puts "Is this correct? Y/N"
    response = gets.chomp.downcase
    if response == "n"
      puts "Please re-enter name:"
      name = gets.chomp
      puts "Please re-enter cohort:"
      cohort = gets.chomp.to_sym
    end
    # add the student hash to the array
    students << {name: name, cohort: cohort, age: :age, city_of_birth: :city, language_of_choice: :language, gender: :gender}
    puts "Now we have #{students.count} students."
    puts "Please enter another student, or hit Enter twice to exit."
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  line_width = 50
  counter = 0
  until counter == students.count
    puts "#{counter+1}. #{students[counter][:name]}".ljust(line_width/3) + " | #{students[counter][:cohort].capitalize} cohort".center(line_width/3)
    puts " | #{students[counter][:age]}".center(line_width/2) + " | #{students[counter][:city_of_birth]}".center(line_width/2) +
        " | #{students[counter][:language_of_choice]}".center(line_width/2) + " | #{students[counter][:gender]}".rjust(line_width/2)
    counter += 1
  end
end

def print_footer(names)
  puts "Overall we have #{names.count} great students."
end

students = input_students
print_header
print(students)
print_footer(students)
