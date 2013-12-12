Pod::Spec.new do |s|
  s.name     = 'JCModel'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'A small framework to help with writing model layers in iOS.'
  s.homepage = 'https://github.com/jcon5294/JCModel'
  s.authors  = { 'Joseph Constantakis' => 'm@mattt.me' }
  s.source   = { 
    :git => 'https://github.com/jcon5294/JCModel.git', 
    :tag => "0.0.1"
  }
  s.requires_arc = true

  s.public_header_files = 'JCModel/*.h', 'JCModel/NSObject+Properties/*.h'
  s.source_files = 'JCModel/*', 'JCModel/NSObject+Properties/*'

end