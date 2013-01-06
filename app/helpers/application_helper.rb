module ApplicationHelper
  def markdown(text)
    rndr = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false)
    mrkd = Redcarpet::Markdown.new(rndr, autolink: true, space_after_headers: true, no_intra_emphasis: true)
    mrkd.render(text).html_safe
  end
end
