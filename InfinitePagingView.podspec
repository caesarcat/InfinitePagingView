Pod::Spec.new do |s|
  s.name         = "InfinitePagingView"
  s.version      = "0.0.4"
  s.summary      = "InfinitePagingView is a subclass of UIView. It contains an endlessly scrollable UIScrollView."
  s.description  = <<-DESC
                    InfinitePagingView is a subclass of UIView. It contains an endlessly scrollable UIScrollView.on't worry about the indent, we strip it!
                   DESC
  s.homepage     = "https://github.com/caesarcat/InfinitePagingView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "SHIGETA Takuji" => "shigeta@qnote.co.jp" }
  s.source       = { :git => "https://github.com/caesarcat/InfinitePagingView.git", :tag => "0.0.4"}
  s.platform     = :ios

  s.source_files = 'Classes', 'Classes/**/*.{h,m}'

  s.requires_arc = true
end
