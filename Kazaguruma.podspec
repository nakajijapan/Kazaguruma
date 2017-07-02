Pod::Spec.new do |s|
  s.name             = "Kazaguruma"
  s.version          = "0.2.1"
  s.summary          = "Kazaguruma is a loading indicator View that can be multiple display on the screen."
  s.homepage         = "https://github.com/nakajijapan/Kazaguruma"
  s.license          = 'MIT'
  s.author           = { "nakajijapan" => "pp.kupepo.gattyanmo@gmail.com" }
  s.source           = { :git => "https://github.com/nakajijapan/Kazaguruma.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nakajijapan'
  s.platform     = :ios, '9.3'
  s.requires_arc = true

  s.source_files = 'Sources/Classes/**/*'
end
