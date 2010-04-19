require 'md5'

class FeedCache

  CONFIG = {
    :storage_dir => "#{RAILS_ROOT}/tmp/feeds",
    :timeout => 5, # seconds
    :retries => 3,
    :retry_wait => 5
  }

  def self.get_live_or_cached(venue)
    url = venue.ical_feed_url
    feed_id = MD5.new(url).to_s
    retries = CONFIG[:retries]

    feed = begin
      Timeout::timeout(CONFIG[:timeout]) do
        logger.info "Fetching #{url}. Timeout: #{CONFIG[:timeout]}, Retries Remaining: #{retries - 1}"
        feed = open(url).read
        write_to_cache(venue, feed_id, feed)
        feed
      end
    rescue Timeout::Error, Errno::ECONNREFUSED => e
      logger.warn "Timed out while fetching feed (#{e.message})."
      if (retries -= 1) > 0
        sleep(CONFIG[:retry_wait]) && retry
      else
        read_from_cache(venue, feed_id)
      end
    end

  end

  private

  def self.write_to_cache(venue, feed_id, feed_data)
    File.open(feed_location(venue, feed_id),'w') do |f|
      f.write(feed_data)
    end
  end

  def self.read_from_cache(venue, feed_id)
    File.read(feed_location(venue, feed_id)) rescue ""
  end

  # To avoid clogging the filesystem, we will store feeds
  # in segmented dirs (i.e. feed named "abcdef12345" goes to ab/cd/abcdef...."
  def self.feed_location(venue, feed_id)
    dir = File.join(CONFIG[:storage_dir], "#{venue.id}_#{venue.name.parameterize.underscore}")
    FileUtils.mkdir_p(dir) # make sure the dir exists
    File.join(dir, feed_id)
  end

  def self.logger; RAILS_DEFAULT_LOGGER; end

end
