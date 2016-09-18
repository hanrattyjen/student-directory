require 'csv'

@students = [] # this array is accessible to all methods
@name = String.new
@cohort = String.new
@age = String.new
@city_of_birth = String.new
@gender = String.new

def input_students
  puts "Please enter the name of the student. To finish, hit 'enter' twice."
  @name = STDIN.gets.chomp
  while !@name.empty? do # if empty, exit to menu
    student_questions
    if @cohort.empty?
      puts "You haven't entered a value. Please contact us."
      @cohort = "NO VALUE" # default value
    end
  confirm_details
  end
end

def confirm_details
  print_confirm_student_information
  response = STDIN.gets.chomp.downcase
  if response == "n"
    puts "Please re-enter name:"
    @name = STDIN.gets.chomp
    student_questions
  elsif response == "y"
    puts "Student details confirmed."
    print_line_separator
  else
    puts "I did not understand that. Please try again."
    print_line_separator
    puts "Please re-enter name:"
    @name = STDIN.gets.chomp
    student_questions
  end
  students_into_hash
  student_counter
  input_students
end

def print_confirm_student_information
  puts "You have entered:"
  puts "Name: #{@name}, Cohort: #{@cohort}, Age: #{@age}, City of birth: #{@city_of_birth}, Coding language: #{@language}, Gender: #{@gender}"
  puts "Is this correct? Y/N"
end

def student_questions
  puts "Cohort month:"
  @cohort = STDIN.gets.chomp
  puts "Age:"
  @age = STDIN.gets.chomp
  puts "City of birth:"
  @city_of_birth = STDIN.gets.chomp
  puts "Preferred coding language:"
  @language = STDIN.gets.chomp
  puts "Gender:"
  @gender = STDIN.gets.chomp
end

def students_into_hash
  @students << {name: @name, cohort: @cohort, age: @age, city_of_birth: @city_of_birth, language: @language, gender: @gender}
end

def interactive_menu
  print_line_separator
  puts "Welcome to student input. Choose an action from the menu below:"
  print_line_separator
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show students"
  puts "3. Save students to a file"
  puts "4. Load students from a file"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      puts "You have selected to input a new student"
      input_students
    when "2"
      puts "Printing current student list:"
      show_students
    when "3"
      puts "Saving inputted students to file"
      save_students
    when "4"
      puts "Loading saved students from file"
      load_students
    when "9"
      puts "Exiting..."
      exit
    else
      puts "I did not understand that. Please try again."
    end
end

def show_students
  if @students.length == 0
    puts "No student records to print."
    exit
  end
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(80)
  print_line_separator
end

def print_student_list
  @students.each_with_index do |s, i|
    puts "#{i+1}. #{s[:name]}, (#{s[:cohort]} cohort), #{s[:age]}, #{s[:city_of_birth]}, #{s[:language]}, #{s[:gender]}"
  end
end

def print_footer
  print_line_separator
  student_counter
  print_line_separator
end

def load_students
  puts "Which file would you like to open?"
  file_to_open = STDIN.gets.chomp
  if File.exists?(file_to_open)
    file = CSV.read("#{file_to_open}")
    CSV.foreach("#{file_to_open}") do |row|
      # The CSV data from file is an array.
      array_to_string = row.join(",") # converting array to a String
      # creating hash from the array/string
      new_student_hash = Hash[*([:name, :cohort, :age, :city_of_birth, :language, :gender].zip(array_to_string.split(',')).flatten)]
      @students << new_student_hash
    end
  elsif file_to_open.empty?
    puts "No file name entered."
    print_line_separator
  else
    puts "File does not exist."
    print_line_separator
  end
end

def try_load_students
   filename = ARGV.first # first argument from the command line
   if filename.nil?
     load_students("students.csv") # load as default if no argument given
   elsif File.exists?(filename)
     load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
   else
     puts "Sorry, #{filename} does not exist."
     exit
   end
end

def save_students
  puts "Which file would you like to save in?"
  file_to_save = STDIN.gets.chomp
  if !File.exists?(file_to_save)
    puts "File does not exist. Would you like to create #{file_to_save}? Y/N"
    response = STDIN.gets.chomp
    if response == "y"
      saving_to_file(file_to_save)
    elsif response == "n"
      puts "Going back to menu"
    else
      puts "Sorry, I did not understand that. Please try again."
    end
  else
    puts "This file currently exists. We will overwrite student data to this file."
    saving_to_file(file_to_save)
  end
end

def saving_to_file(file_to_save)
  CSV.open("#{file_to_save}", "w") do |csv_object|
    @students.each do |student|
      # need to change this to an array of strings
      student_data_to_array = []
      student.each do |k,v|
        student_data_to_array << v
      end
      csv_object << student_data_to_array #appends our student data array to the CSV file
    end
  end
end

def student_counter
  if @students.count == 1
    puts "We have 1 amazing student."
  else
    puts "Overall we have #{@students.count} great students."
  end
end

def print_line_separator
  puts ("-" * 80).center(80)
end

# try_load_students
interactive_menu
