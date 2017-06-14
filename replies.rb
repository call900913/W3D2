require_relative 'questionsdatabase'
require_relative 'questions'

class Replies

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    #Place that solution in this place
    replies.each do |reply|
      Replies.new(reply)
    end
    
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    replies.each do |reply|
      Replies.new(reply)
    end
  end


  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply = options['parent_reply']
    @user_id = options['user_id']
    @body = options['body']
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
      SELECT
        fname, lname
      FROM
        users
      WHERE
        id = @user_id
    SQL

    "#{author.first['fname']} #{author.first['lname']}"
  end

  def question
    Questions.find_by_id(@question_id )
  end

  def parent_reply
    @parent_reply
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply = @id
    SQL

    replies.each do |reply|
      Replies.new(reply)
    end

  end



end
