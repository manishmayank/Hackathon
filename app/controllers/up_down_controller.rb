class UpDownController < ApplicationController
	def ques_upvote
    success = false
    updown_query = UpDown.where(:user_id => params[:user_id], :question_id => params[:question_id]))
    if (updown_query)
      if(updown_query.down)
        updown_query.down = false
        updown_query.up = true
        updown_query.save
        success = true

      else
        success = false
      end

    else
      UpDown.create(user_id:params[:user_id], question_id:params[:question_id], up:true, down:false)
      success = true
    end

    respond_to do |format|
      format.json {render json: {"success": success}}
    end

  end

  def ques_downvote
    success = false
    updown_query = UpDown.where(:user_id => params[:user_id], :question_id => params[:question_id]))
    if (updown_query)
      if(updown_query.up)
        updown_query.up = false
        updown_query.down = true
        updown_query.save
        success = true

      else
        success = false
      end

    else
      UpDown.create(user_id:params[:user_id], question_id:params[:question_id], up:false, down:true)
      success = true
    end

    respond_to do |format|
      format.json {render json: {"success": success}}
    end

  end
end
