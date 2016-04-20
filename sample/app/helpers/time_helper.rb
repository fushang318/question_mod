module TimeHelper
  def human_time_show(time)
    t = Time.new - time
    if t/60/60/24/30/12 >= 1
      return "发布于 1 年前"
    else
      if t/60/60/24/30 >= 1
        a = (t/60/60/24/30).to_i
        num = a.to_s
        return "发布于 "+ num +" 月前"
      else
        if t/60/60/24 >= 1
          a = (t/60/60/24).to_i
          num = a.to_s
          return "发布于 "+ num +" 天前"
        else
          if t/60/60 >= 1
            a = (t/60/60).to_i
            num = a.to_s
            return "发布于 "+ num +" 小时前"
          else
            if t/60 >= 1
              a = (t/60).to_i
              num = a.to_s
              return "发布于 "+ num +" 分钟前"
            else
              return "发布于 1 分钟前"
            end
          end
        end
      end
    end
  end
end
