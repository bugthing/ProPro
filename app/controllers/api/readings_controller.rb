class Api::ReadingsController < ApiController

  respond_to :json
    
  def index
    @readings = current_api_user.user_group.readings.all.map do |c|
      c.as_json(except: except_these_columns)
    end
    render json:@readings
  end

  def show
    @reading = current_api_user.user_group.readings.find(params[:id])

    response = { 
      created_at: @reading.created_at,
      read_html: @reading.current_reading_section.read_htmls
    }

    render json: response.to_json
  end

  def create
    chart = current_api_user.user_group.charts.find(params[:chart_id])
    @reading = chart.readings.create
    render json:@reading.to_json(except: except_these_columns)
  end

  def update
    @reading = current_api_user.user_group.readings.find(params[:id])

    # set submitted data and re-output reading (maybe have progressed current reading section)
    submitted_data = params.except(:api_key, :id, :controller, :action)
    @reading.submit_read_data( submitted_data )

    render json:@reading.to_json(except: except_these_columns)
  end

  private

  def except_these_columns
    [:updated_at]
  end

end
