namespace :import do
  desc "import all images to database"
  task lyrics: :environment do
    lyrics = Dir["public/Lyrics/**/*.jpg"]
  end
end
