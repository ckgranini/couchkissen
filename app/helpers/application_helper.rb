module ApplicationHelper

  def markdown(text)
    rndr = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    mrkd = Redcarpet::Markdown.new(rndr, autolink: true, space_after_headers: true, no_intra_emphasis: true)
    mrkd.render(text).html_safe
  end

  def redis_scard
    notify_counts = Hash.new
    types = [:events, :forums, :movies, :videos, :polls]
    types.each do |type|
      notify_counts[type] = $redis.scard("user:#{current_user.id}:#{type}")
    end
    notify_counts
  end

end
