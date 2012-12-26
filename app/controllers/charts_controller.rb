class ChartsController < ApplicationController
  # GET /charts
  # GET /charts.json
  def index
    @charts = Chart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charts }
    end
  end

  # GET /charts/1
  # GET /charts/1.json
  def show
    @chart = Chart.find(params[:id])

    data = @chart.chartnodes.map {|node| [node.xaxis, node.yaxis]}.transpose
    if @chart.charttype == 'column'
      @h1 = LazyHighCharts::HighChart.new('graph') do |f|
        f.title({ :text=> @chart.name})
        f.options[:xAxis][:categories] = data[0]
        f.labels(:items=>[:html=>"refer", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
        f.series(:type=> 'column',:name=> 'Refer',:data=> data[1])
      end
    elsif @chart.charttype == 'pie'
      @h1 = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
        series = {
                 :type=> 'pie',
                 :name=> @chart.name,
                 :data=> data.transpose
                }
        f.series(series)
        f.options[:title][:text] = "Browser share"
        f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
        f.plot_options(:pie=>{
          :allowPointSelect=>true, 
          #:cursor=>"pointer" , 
          :dataLabels=>{
            :enabled=>true,
            :color=>"black",
            :style=>{
              :font=>"13px Trebuchet MS, Verdana, sans-serif"
            }
          }
        })
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chart }
    end
  end

  # GET /charts/new
  # GET /charts/new.json
  def new
    @chart = Chart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chart }
    end
  end

  # GET /charts/1/edit
  def edit
    @chart = Chart.find(params[:id])
  end

  # POST /charts
  # POST /charts.json
  def create
    @chart = Chart.new(params[:chart])

    respond_to do |format|
      if @chart.save
        format.html { redirect_to @chart, notice: 'Chart was successfully created.' }
        format.json { render json: @chart, status: :created, location: @chart }
      else
        format.html { render action: "new" }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charts/1
  # PUT /charts/1.json
  def update
    @chart = Chart.find(params[:id])

    respond_to do |format|
      if @chart.update_attributes(params[:chart])
        format.html { redirect_to @chart, notice: 'Chart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.json
  def destroy
    @chart = Chart.find(params[:id])
    @chart.destroy

    respond_to do |format|
      format.html { redirect_to charts_url }
      format.json { head :no_content }
    end
  end

  def addnodes
    @chart = Chart.find(params[:id])
    if request.put?
      #binding.pry
      params[:chartnodes].each_line do |line|
        linenodes = line.split
        chartnode = Chartnode.new
        chartnode.xaxis = linenodes[0]
        chartnode.yaxis = linenodes[1].to_f
        chartnode.chart = @chart
        chartnode.save
      end
      redirect_to @chart
    end
  end
end
