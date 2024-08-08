class Routes {
  static String DOWNLOAD_FILE = 'https://gzrscmis.msegs.in/';
  static String BASE_URL = 'http://127.0.0.1:8000/api/';
  // static String BASE_URL = 'https://gzrscmis.msegs.in/api/';
  static String LOGIN = '${BASE_URL}auth/login';
  static String GET_ME = '${BASE_URL}auth/me';
  static String LOGOUT = '${BASE_URL}auth/logout';

  static String GET_PROGRAM = '${BASE_URL}program';
  static String GET_BATCH(int id) => '${BASE_URL}batch/$id';
  static String GET_SUBJECT(int id, int semesterId) =>
      '${BASE_URL}subject/$id/$semesterId';
  static String GET_INTERNAL_EXAM = '${BASE_URL}internal-exam';
  static String FILTER_ATTENDANCE = '${BASE_URL}filtered-attendance';
  static String GET_ATTENDANCE = '${BASE_URL}get-all-attendance';
  static String SUBMIT_ATTENDANCE = '${BASE_URL}submit-attendance';
  static String DELETE_ATTENDANCE = '${BASE_URL}delete-attendance';
  static String UPDATE_ATTENDANCE = '${BASE_URL}update-attendance';
  static String GET_ALL_BATCH = '${BASE_URL}get-all-batch';

  static String FILTER_INTERNAL_MARKS = '${BASE_URL}filter-internal-marks';
  static String SUBMIT_INTERNAL_EXAM_MARKS =
      '${BASE_URL}submit-internal-exam-marks';
  static String GET_INTERNAL_ALL_STUDENTS =
      '${BASE_URL}get-students-internal-marks';
  // static String GET_ALL_PROGRAMME = '${BASE_URL}get-all-programme';
  static String GET_INTERNAL_MARKS_BY_ID =
      '${BASE_URL}get-internal-exam-details';
  static String GET_ALL_BATCH_FILTER = '${BASE_URL}get-all-batch';
  static String GET_ALL_INTERNALS = '${BASE_URL}get-all-internals';
  static String ADD_INTERNAL_EXAM = '${BASE_URL}add-internal-exam';
  static String DELETE_INTERNAL_EXAM = '${BASE_URL}delete-internal-exam';
  static String GET_SEMESTER_EXAM_FEE = '${BASE_URL}get-all-semester-exam-fee';
  static String FILTER_SEMESTER_EXAM_FEE =
      '${BASE_URL}filter-semester-exam-fee';
  static String SAVE_SEMESTER_EXAM_FEE = '${BASE_URL}save-semester-exam-fee';
  static String DELETE_SEMESTER_EXAM_FEE =
      '${BASE_URL}delete-semester-exam-fee';
  static String UPDATE_SEMESTER_AMOUNT = '${BASE_URL}update-amount';

  static String GET_SEMESTER_EXAM_SCORE = '${BASE_URL}get-semester-score';
  static String GET_SEMESTER_SUBJECTS = '${BASE_URL}get-semester-subjects';
  static String SAVE_SEMESTER_GRADE = '${BASE_URL}save-semester-grade';
  static String GET_SEMESTER_MARK_DETAILS =
      '${BASE_URL}get-semester-mark-details';

  //MENTOR
  static String GET_ALL_FACULTY = '${BASE_URL}mentor-get-all-faculty';
  static String GET_MENTOR_ALL_STUDENTS = '${BASE_URL}mentor-all-students';
  static String SUBMIT_STUDENT_MENTOR = '${BASE_URL}submit-student-mentor';
  static String GET_STUDENTS_MENTOR = '${BASE_URL}get-students-mentor';
  static String UPDATE_INFO = '${BASE_URL}update-info';

  //REPOSITORY
  static String GET_ALL_REPOSITORY_CATEGORIES =
      '${BASE_URL}get-all-repository-categories';
  static String DELETE_REPOSITORY_CATEGORIES =
      '${BASE_URL}delete-repository-categories';
  static String SAVE_REPOSITORY_CATEGORIES =
      '${BASE_URL}save-repository-categories';
  static String UPDATE_REPOSITORY_CATEGORIES =
      '${BASE_URL}update-repository-categories';
  static String GET_ALL_REPOSITORIES = '${BASE_URL}get-all-repositories';
  static String GET_ALL_CATEGORIES = '${BASE_URL}get-all-categories';
  static String SAVE_REPOSITORIES = '${BASE_URL}save-repositories';
  static String DELETE_REPOSITORIES = '${BASE_URL}delete-repositories';
  static String UPDATE_REPOSITORIES = '${BASE_URL}update-repositories';

  //HOME
  static String INDEX = '${BASE_URL}index';

  //POST
  static String GET_ALL_POST_CATEGORY = '${BASE_URL}get-all-post-category';
}
