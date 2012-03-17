module VideosHelper
  def get_video_feed(video)
    require 'open-uri'
    video_id = video.video_url.match(/(?<=\d\/|\.be\/|embed\/|[vi][=\/])[-a-zA-Z0-9_]{11,}/i).to_s
    begin
      video_feed = ActiveSupport::JSON.decode(open("http://gdata.youtube.com/feeds/api/videos/" + video_id + "?v=2&alt=jsonc").read)
    rescue
      video_feed = {"apiVersion"=>"2.1", "data"=>{"uploader"=>"", "title"=>"Video wurde nicht gefunden", "description"=>"", "thumbnail"=>{"sqDefault"=>"http://i.ytimg.com/default.jpg"}, "player"=>{"default"=>""}}}
    end
  end
end
