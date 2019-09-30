class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    new_student = self.new

    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
  end

  def self.all
    
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    sql = <<-SQL 
    SELECT * FROM students WHERE name = ?; 
    SQL
    student_array = DB[:conn].execute(sql, name)
    sa = student_array[0]
    p Student.new_from_db(sa)
    # return a new instance of the Student class
  end

  def self.all_students_in_grade_9
    sql = <<-SQL 
    SELECT * FROM students WHERE grade = ?; 
    SQL
    p student_array = DB[:conn].execute(sql, 9)
    
  end

  def self.students_below_12th_grade
    sql = <<-SQL 
    SELECT * FROM students WHERE grade < ?; 
    SQL
    student_array = DB[:conn].execute(sql, 12)
    student_array.map {|student| Student.new_from_db(student)}
    
  end

  def self.all
    all = []
    sql = <<-SQL
    SELECT * FROM students
    SQL
    everyone = DB[:conn].execute(sql)
    p everyone.map {|student| Student.new_from_db(student)}
  end

  def self.first_X_students_in_grade_10(num)
    sql = <<-SQL 
    SELECT * FROM students WHERE grade = ?; 
    SQL
    student_array = DB[:conn].execute(sql, 10)
    sorted = student_array.first(num)
    p sorted.map {|student| Student.new_from_db(student)}
    
  end

  def self.first_student_in_grade_10
    sql = <<-SQL 
    SELECT * FROM students WHERE grade = ?; 
    SQL
    student_array = DB[:conn].execute(sql, 10)
    sarray = student_array
    s = sarray.map {|student| Student.new_from_db(student)}
    p s[0]
    
  end

  def self.all_students_in_grade_X(grade)
    sql = <<-SQL 
    SELECT * FROM students WHERE grade = ?; 
    SQL
    p student_array = DB[:conn].execute(sql, grade)
    
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
