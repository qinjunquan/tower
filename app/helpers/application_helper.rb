module ApplicationHelper
  WEEK = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
  def event_time_html(time)
    if time.today?
      date = %Q{今}
    elsif time.tomorrow.today?
      date = %Q{昨}
    else
      date = %Q{<span class="date">#{time.month}/#{time.day}</span><span class="day">#{WEEK[time.wday]}</span>}
    end
    %Q{<h4 class="events-day-title">#{date}</h4>}.html_safe
  end
end
