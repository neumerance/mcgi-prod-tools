namespace :import do
  desc "import all images to database"
  task lyrics: :environment do
    lyrics = Dir["public/src/Lyrics/**/*.jpg"]

    lyrics.each do |lyric|
      puts "process: #{lyric}"
      cue = Cue.find_or_initialize_by(name: File.basename(lyric))
      cue.update(path: URI.encode(lyric.gsub!('public', '')))
    end
  end
end
