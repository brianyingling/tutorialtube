require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

before do
  @nav_rows = run_sql("select distinct genre from videos")
end


get '/front' do
  erb :front
end


get '/' do
  sql = "select * from videos"
  @rows = run_sql(sql)
  erb :home
end

get '/new' do
  erb :new
end

post '/new' do
  sql = "insert into videos (title, url, genre, description) values ('#{params['title']}','#{params['url']}','#{params['genre']}','#{params['description']}')"
  run_sql(sql)
  redirect to ('/')
end

get '/videos/:genre' do
  sql = "select * from videos where genre='#{params['genre']}'"
  @rows = run_sql(sql)
  erb :home
end


post '/videos/:id/delete' do
  sql = "delete from videos where id=#{params['id']}"
  run_sql(sql)
  redirect to ('/')
end

post '/videos/:id' do
  sql = "select * from videos where id=#{params['id']}"
  @rows = run_sql(sql)
  @row =@rows.first
  erb :new
end

post '/videos/:id/edit' do
  sql = "update videos set title='#{params['title']}', url='#{params['url']}', genre='#{params['genre']}', description='#{params['description']}' where id=#{params['id']}"
  run_sql(sql)
  redirect to ('/')
end


def run_sql(sql)
  conn = PG.connect(:dbname=>'tutorialtube',:host=>'localhost')
  result = conn.exec(sql)
  conn.close
  result
end