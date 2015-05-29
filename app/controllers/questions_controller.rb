class QuestionsController < ApplicationController
  # before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    # TODO :- URL's parent's questions
    # page_num = params[:page_num]
    # url = params[:url]
    # url_search = ActiveRecord::Base.connection.quote(url)
    # @questions = Question.all

    # query = "INSERT INTO companies (name,address) VALUES (#{my_name}, #{my_address})"

    questions = Question.where("url=?",params[:url]).paginate(:page => params[:page_num], :per_page => 10).order('difference DESC').select(:title,:id,:upvotes,:downvotes,:created_at)
    questions_all = Array.new
    questions.each do |question|
      question_map = Hash.new
      question_map['question'] = question
      question_map['create_time'] = (question.created_at.to_f*1000).to_i 
      questions_all << question_map
    end
    # @questions = Question.page(params[:page_num]).order('created_at DESC')
    respond_to do |format|
      # format.html {render 'index'}
      format.json {render json: questions_all}
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    question_id = params[:question_id]

    question = Question.find(question_id)
    answers = question.answers
    comments = question.comments
    all_comments = Array.new
    answer_list = Array.new
    answers.each do |answer|
      answer_map = Hash.new
      answer_map["answer"] = answer
      answer_map["comments"] = answer.comments
      answer_list << answer_map
    end

    tags = question.tags

    actual_tags = Array.new

    tags.each do |tag|
      tag_map = Hash.new
      tag_map["name"] = tag.name
      tag_map["id"] = tag.id
      actual_tags << tag_map
    end

    # answer_map = 

    respond_to do |format|
      format.json {render json: {question: question, tags: actual_tags, create_time: (question.created_at.to_f * 1000).to_i, question_comments: comments, answers: answer_list}}
    end
  end

  # GET /questions/new
  def new
    question = Question.new
    respond_to do |format|
      format.json {render json: question}
    end
  end

  # GET /questions/1/edit
  def edit
    question = Question.find(params[:question_id])
    respond_to do |format|
      format.json {render json: question}
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    question = Question.new(content: params[:content], title: params[:title], url: params[:url], upvotes: 0, downvotes: 0, difference: 0, user_id: params[:user_id])

    respond_to do |format|
      if question.save
        # question.create_time = (question.created_at.to_f*1000).to_i.to_s
        #question.save
        # format.html { redirect_to question, notice: 'Question was successfully created.' }
        format.json { render json: {success: true, question: question, create_time: (question.created_at.to_f * 1000).to_i} }
      else
        #format.html { render :new }
        format.json { render json: {success: false} }
      end
    end

    tag_list = Array.new

    tag_list << params[:tag1]
    tag_list << params[:tag2]
    tag_list << params[:tag3]
    tag_list << params[:tag4]
    tag_list << params[:tag5]

    actual_tag_list = Array.new

    tag_list.each do |tag|
      t = Tag.find_by_name(tag).first
      unless t
        t = Tag.create(tag: tag)
      end
      actual_tag_list << t
     
    end
    question.tags << actual_tag_list
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    question = Question.find(params[:question_id])
    respond_to do |format|
      if question.update(content: params[:content], title: params[:title])
        # question.update_time = (question.updated_at.to_f*1000).to_i.to_s
        question.save
        # format.html { redirect_to question, notice: 'Question was successfully updated.' }
        format.json { render json: {success: true} }
      else
        # format.html { render :edit }
        format.json { render json: {success: false} }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    question = question.find(params[:id])
    question.destroy
    respond_to do |format|
      # format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { render json: {success: true} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question]
    end
end
