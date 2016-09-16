@students = [] # this array is accessible to all methods

def input_students
  puts "Please enter the names of the students:"
  puts "To finish, just hit enter twice."
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Cohort month:"
    cohort = gets.chomp
    puts "Age:"
    age = gets.chomp
    puts "City of birth:"
    city = gets.chomp
    puts "Preferred coding language:"
    language = gets.chomp
    puts "Gender"
    gender = gets.chomp
    # Supplying a default value
    if cohort.empty?
      puts "You haven't entered a value. Please contact us."
      cohort = "NO VALUE"
    end
    # Checking typos
    puts "You have entered:"
    puts "Name: #{name}, Cohort: #{cohort}, Age: #{age}, City of birth: #{city}, Coding language: #{language}, Gender: #{gender}"
    puts "Is this correct? Y/N"
    response = gets.chomp.downcase
    if response == "n"
      puts "Please re-enter name:"
      name = gets.chomp
      puts "Please re-enter cohort:"
      cohort = gets.chomp
      puts "Please re-enter age:"
      age = gets.chomp
      puts "Please re-enter city of birth:"
      city = gets.chomp
      puts "Please re-enter your preferred coding language:"
      language = gets.chomp
      puts "Please re-enter gender:"
      gender = gets.chomp
    end
    # add the student hash to the array
    @students << {name: name, cohort: cohort, age: age, city_of_birth: city, language: language, gender: gender}
    if @students.count == 1
      puts "Overall we have 1 great student."
    else
      puts "Overall we have #{@students.count} great students."
    end
    puts "Please enter another student, or hit Enter twice to exit."
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  # students
  if @students.length == 0
    puts "No student records to print."
    exit
  end
  # students
end

def interactive_menu
  puts "Welcome to student input. Choose an action from the menu below:"
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show students"
  puts "3. Save students to students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit  # this will cause the program to terminate
    else
      puts "I did not understand that. Please try again."
    end
end

def show_students
  print_header
  print_student_list
  print_footer
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

def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]}, (#{student[:cohort]} cohort), #{student[:age]}, #{student[:city_of_birth]}, #{student[:language]}, #{student[:gender]}"
  end
  puts ("-" * 80).center(80)
end

# Sorting students by cohort month
def print_cohort(students)
  puts "Select Students by cohort start month:"
  cohort = gets.chomp.downcase
  students_cohort = @students.map do |student|
    if student[:cohort] == cohort
      puts ("-" * 80).center(80)
      puts student[:cohort].capitalize
      puts "#{student[:name]}, (#{student[:cohort]} Cohort), #{student[:age]}, #{student[:city_of_birth]}, #{student[:language]}, #{student[:gender]}"
    end
  end
end

def print_footer
  puts ("-" * 80).center(80)
  if @students.count == 1
    puts "We have 1 amazing student."
  else
    puts "Overall we have #{@students.count} great students."
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate of the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:age], student[:city_of_birth], student[:language], student[:gender]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu
# print_cohort(students)
