task :depends do
  sh "bundle install"
  sh "git add Gemfile Gemfile.lock"
  sh 'git commit -m "Rakefile "depends" task: updated Gemfile and/or Gemfile.lock"'
end

task :deploy => [:depends] do
  sh "git push heroku"
end

task :launch => [:deploy] do
  sh "heroku open"
end