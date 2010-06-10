class MappSweeper < ActionController::Caching::Sweeper
  observe Event

  def after_save(event)
    expire_mapp_cache
  end

  def after_destroy(event)
    expire_mapp_cache
  end

  protected 
  def expire_mapp_cache
    # Very crude cache expiry method - if any event info changes we need to invalidate
    # all caches. We store separate caches depending on whether its an iphone request
    # and whether it's an editable page, therefore all these caches must be nuked:
    %w(schedule hourly events starred).each do |grouping_type|
      %w(true false).each do |iphone_type|
        %w(true false).each do |editable_type| 
          expire_fragment "mapp/#{grouping_type}/#{iphone_type}/#{editable_type}"
        end
      end
    end
  end
end
