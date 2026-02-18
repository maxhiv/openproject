class FrontendController < ApplicationController
  skip_forgery_protection

  def index
    if File.exist?(Rails.root.join("public", "app", "index.html"))
      render file: Rails.root.join("public", "app", "index.html"), layout: false
    else
      render html: "<h1>Control Plane</h1><p>Angular frontend not built yet. Run: cd frontend &amp;&amp; npm run build</p>".html_safe
    end
  end
end
