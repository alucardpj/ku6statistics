class DemoController < ApplicationController
  def index
    @h1 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Refer"})
      f.options[:xAxis][:categories] = "my.ku6.com/search v.ku6.com www.ku6.com so.ku6.com  baidu my.ku6.com/watch  my.ku6.com/ other_ku6 my.ku6.com/videobase  fc2.com top.ku6.com aki.gs  comic.ku6.com my.ku6.com/videos 360.cn  other joke.ku6.com  juchang.com bing.com  my.ku6.com/topic_gift google  edu.ku6.com mv.ku6.com  my.ku6.com/baidu  boke.ku6.com".split
      f.labels(:items=>[:html=>"refer", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
      f.series(:type=> 'column',:name=> 'Refer',:data=> "316125 82873 24676 9711  6523  5489  1561  1223  942 928 786 679 488 472 452 419 382 325 317 314 299 268 259 258 231".split.map(&:to_i))
    end

    @h2 = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      data = [
               "360  sogou qq  chrome  ff  safari  other IE  IE6 IE7 IE8 IE9 maxthon".split,
               "2531 31893 10020 36048 28162 7131  19642 670 69721 47766 159390  38836 5742".split.map(&:to_i)
             ]
      # series = {
      #          :type=> 'pie',
      #          :name=> 'Browser share',
      #          :data=> [
      #             ['360',     2531],
      #             ['sogou',  31893],
      #             {
      #                :name=> 'IE8',    
      #                :y=> 159390,
      #                :sliced=> true,
      #                :selected=> true
      #             },
      #             ['chrome', 36048],
      #             ['ff',     28162],
      #             ['safari',  7131],
      #             ['other',  19642],
      #             ['IE',       670],
      #             ['IE6',    69721],
      #             ['IE7',    47766],
      #             ['qq',     10020],
      #             ['IE9',    38836],
      #             ['maxthon', 5742]
      #          ]
      #         }
      series = {
               :type=> 'pie',
               :name=> 'Browser share',
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

    @h3 = LazyHighCharts::HighChart.new('bar') do |f|
           f.series(:name=>'Correct',:data=> [1, 2, 3, 4, 5])
           f.series(:name=>'Incorrect',:data=> [10, 2, 3, 1, 4] )       
           f.title({ :text=>"clickable bar chart"})
           f.legend({:align => 'right', 
                    :x => -100, 
                    :verticalAlign=>'top',
                    :y=>20,
                    :floating=>"true",
                    :backgroundColor=>'#FFFFFF',
                    :borderColor=>'#CCC',
                    :borderWidth=>1,
                    :shadow=>"false"
                    })
           f.options[:chart][:defaultSeriesType] = "bar"
           f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Time"}, :categories => ["1.1.2011", "2.1.2011", "3.1.2011", "4.1.2011", "5.1.2011"]}
           f.options[:yAxis][:title] = {:text=>"Answers"}
           # f.options[:plot_options][:column] = {:stacking=>'normal', 
           #    :cursor => 'pointer',
           #    :point => {:events => {:click => js_function}}
           # }  
    end
  end
end
