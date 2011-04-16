task :deploy do
  sh "git push heroku"
end

task :launch => [:deploy] do
  sh "heroku open"
end