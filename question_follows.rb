require_relative 'questionsdatabase'
require_relative 'users'
require_relative 'questions'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id


  def self.followers_for_question_id(question_id)
    #Return an array user objects
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN question_follows ON question_follows.user_id = users.id
        JOIN questions ON question_follows.question_id = questions.id
        WHERE
          question_id = ?
    SQL

    user_objects = []

    followers.each do |follower|
      user_objects << Users.new(follower)
    end

    user_objects
  end

  def self.followed_questions_for_user_id(user_id)
    followed_questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN question_follows ON question_follows.question_id = questions.id
        JOIN users ON question_follows.user_id = users.id
        WHERE
          user_id = ?
    SQL

    question_objects = []

    followed_questions.each do |question|
      question_objects << Questions.new(question)
    end

    question_objects
  end

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
