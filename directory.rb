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
    cohort = gets.chomp
    # Supplying a default value
    if cohort.empty?
      puts "You haven't entered a value. Please contact us."
      cohort = "NO VALUE"
    end
    # Checking typos
    puts "You have entered:"
    puts "Name: #{name}, Cohort: #{cohort}"
    puts "Is this correct? Y/N"
    response = gets.chomp.downcase
    if response == "n"
      puts "Please re-enter name:"
      name = gets.chomp
      puts "Please re-enter cohort:"
      cohort = gets.chomp
    end
    # add the student hash to the array
    students << {name: name, cohort: cohort, age: :age, city_of_birth: :city, language_of_choice: :language, gender: :gender}
    if students.count == 1
      puts "Overall we have 1 great student."
    else
      puts "Overall we have #{students.count} great students."
    end
    puts "Please enter another student, or hit Enter twice to exit."
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
  if students.length == 0
    puts "No student records to print."
    exit
  end
  students
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts ("-" * 80).center(80)
end

def print_month(month)
  puts "-------------"
  month.each do |student|
    student.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts "-------------"
  end
end

def print(students)
  counter = 0
  until counter == students.count
    puts "#{counter+1}. #{students[counter][:name]}, (#{students[counter][:cohort]} cohort), #{students[counter][:age]}, #{students[counter][:city_of_birth]}, #{students[counter][:language_of_choice]}, #{students[counter][:gender]}"
    counter += 1
  end
end

# Sorting students by cohort month
def print_cohort(students)
  puts "Select Students by cohort start month:"
  cohort = gets.chomp.downcase
  students_cohort = students.map do |student|
    if student[:cohort] == cohort
      puts ("-" * 80).center(80)
      puts student[:cohort].capitalize
      puts "#{student[:name]}, (#{student[:cohort]} Cohort), #{student[:age]}, #{student[:city_of_birth]}, #{student[:language_of_choice]}, #{student[:gender]}"
    end
  end
end

def print_footer(names)
  puts ("-" * 80).center(80)
  if names.count == 1
    puts "Overall we have 1 great student."
  else
    puts "Overall we have #{names.count} great students."
  end
end

students = input_students
print_header
print(students)
print_cohort(students)
print_footer(students)
