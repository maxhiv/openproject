class FrontendController < ApplicationController
  skip_forgery_protection

  def index
    index_path = Rails.root.join("public", "index.html")
    app_path = Rails.root.join("public", "app", "index.html")
    if File.exist?(index_path)
      render file: index_path, layout: false
    elsif File.exist?(app_path)
      render file: app_path, layout: false
    else
      render html: "<h1>Control Plane</h1><p>Angular frontend not built yet. Run: cd frontend &amp;&amp; npm run build</p>".html_safe
    end
  end
end
