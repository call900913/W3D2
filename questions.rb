require_relative 'questionsdatabase'
require_relative 'users'
require_relative 'replies'
require_relative 'question_follows'

class Questions
  attr_accessor :author_id

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    Questions.new(question.first)
  end

  def self.find_by_author_id(author_id)
    author_question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil if author_question.empty?

    Questions.new(author_question.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        fname, lname
      FROM
        users
      WHERE
        id = @author_id
    SQL

    "#{author.first['fname']} #{author.first['lname']}"
  end

  def replies
    Replies.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end





end
