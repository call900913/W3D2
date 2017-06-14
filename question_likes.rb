require_relative 'questionsdatabase'

class QuestionLikes

  def self.find_by_id(id)
    q_likes = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    QuestionLikes.new(q_likes.first)
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
