task :depends do
  sh "bundle install"
  
  begin
    sh "git add Gemfile Gemfile.lock"
    sh 'git commit -m "Rakefile "depends" task: updated Gemfile and/or Gemfile.lock"'
  rescue
    # ignore failure, it should just mean nothing has changed in Gemfile or Gemfile.lock
  end
end

task :deploy => [:depends] do
  sh "git push heroku"
end

task :launch => [:deploy] do
  sh "heroku open"
end