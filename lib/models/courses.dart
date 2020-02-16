class Courses{
  String start;
  String end;
  String course;

  Courses(this.start, this.end, this.course,);

  Map<String, dynamic> toJson() => {
    'startTime' : start,
    'endTime' : end,
    'course' : course,
  };
}

class CourseContent{
  String courseTitle;
  String courseCode;
  String courseContent;

  CourseContent(this.courseTitle, this.courseCode, this.courseContent,);

  Map<String, dynamic> toJson() => {
    'courseCode' : courseCode,
    'courseTitle' : courseTitle,
    'courseContent' : courseContent,
  };
}