class Api::ChartsController < ApiController

  respond_to :json
    
  def index
    @charts = current_api_user.user_group.charts.all.map do |c|
      c.as_json(except: except_these_columns)
    end
    render json:@charts
  end

  def show
    @chart = current_api_user.user_group.charts.find(params[:id])
    render json:@chart.to_json(except: except_these_columns)
  end

  private

  def except_these_columns
    [:created_at, :updated_at, :user_group_id]
  end

end
