task :depends do
  sh "bundle install"
end

task :deploy => [:depends] do
  sh "git push heroku"
end

task :launch => [:deploy] do
  sh "heroku open"
end