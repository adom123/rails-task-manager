class Task < ApplicationRecord
end


  <h1>Edit an existing task</h1>
<%= form_for(@task) do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
<%= link_to "Edit", tasks_path %>

  namespace :tables do
    desc 'Print data size for all tables'
    task :size => :environment do

      database_name = ActiveRecord::Base.connection.instance_variable_get("@config")[:database]
      adapter = ActiveRecord::Base.connection.adapter_name.downcase
      case adapter
      when "mysql"
        sql = "select TABLE_NAME, FORMAT((data_length + index_length), 0) as bytes from information_schema.TABLES where table_schema = '#{database_name}' ORDER BY (data_length + index_length) DESC"
        result = ActiveRecord::Base.connection.execute(sql)
        while (row = result.fetch_hash) do
          puts "#{row['TABLE_NAME']} #{row['bytes']}"
        end
      when "postgres", "postgresql"
        sql = "SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;"
        tables = ActiveRecord::Base.connection.execute(sql)
        tables.each do |table|
          name = table['tablename']
          sql = "SELECT pg_size_pretty(pg_total_relation_size('#{name}'));"
          res = ActiveRecord::Base.connection.execute(sql)
          puts "#{name} #{res[0]['pg_size_pretty']}"
        end
      else
        raise "#{adapter} is not supported"
      end
    end
  end
