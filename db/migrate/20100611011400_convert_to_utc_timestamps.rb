class ConvertToUtcTimestamps < ActiveRecord::Migration
  def self.up
    execute "alter table events alter column start_time type timestamp with time zone;"
    execute "alter table events alter column finish_time type timestamp with time zone;"
  end

  def self.down
  end
end
